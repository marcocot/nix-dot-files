{ pkgs,... }:
let
 vars = {
  common_env = {
    PUID = "1000";
    PGID = "100";
    TZ = "Europe/Rome";
  };

  mounts = [
    "/mnt/media/downloads:/downloads"
    "/mnt/media/library/movies:/movies"
    "/mnt/media/library/tv:/tv"
    "/mnt/media/library/books:/books"
    "/mnt/media/library/comics:/comics"
  ];

  services = [
    "prowlarr"
    "radarr"
    "sonarr"
    "bazarr"
    "calibre-web"
    "kavita"
    "heimdall"
    "tautulli"
  ];

  fullList = pkgs.lib.genAttrs vars.services (service: {
    image = "lscr.io/linuxserver/${service}";
    environment = vars.common_env;
    volumes = vars.mounts ++ [
      "/mnt/media/config/${service}:/config"
    ];
    labels = {
      "traefik.enable" = "true";
    };
  });
 };
 in
{
  virtualisation.oci-containers =  {
    backend = "docker";
    containers = {
      watchtower = {
        image = "containrrr/watchtower";
        environment = {
          WATCHTOWER_CLEANUP = "true";
        };
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "/etc/localtime:/etc/localtime:ro"
        ];
      };

      transmission = {
        image = "lscr.io/linuxserver/transmission:latest";
        environment = vars.common_env;
        ports = [
          "51413:51413"
          "51413:51413/udp"
        ];
        volumes = [
          "/mnt/media/config/transmission:/config"
          "/mnt/media/downloads:/downloads"
          "/mnt/media/downloads/watch:/watch"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.services.transmission.loadbalancer.server.port" = "9091";
        };
      };

      actual = {
        image = "actualbudget/actual-server:24.7.0"; # we want to pin the version
        volumes = [
          "/mnt/media/config/actual:/data"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.actual.entrypoints" = "websecure";
          "traefik.http.routers.actual.tls.certresolver" = "myresolver";
        };
      };

      vaultwarden = {
        image = "vaultwarden/server:latest";
        environment = {
          SIGNUPS_ALLOWED = "false";
          SHOW_PASSWORD_HINT = "false";
        };
        volumes = [
          "/mnt/media/config/vaultwarden:/data"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.vaultwarden.entrypoints" = "websecure";
          "traefik.http.routers.vaultwarden.tls.certresolver" = "myresolver";
        };
      };
    } // vars.fullList;
  };
}
