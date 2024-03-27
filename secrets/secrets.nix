let
  marco = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGj6IP5XfAYYuHBzJwQHmRhL1ViwJNvlm7ggXDE/Kp9";
in
{
  "restic/env.age".publicKeys = [ marco ];
  "restic/repo.age".publicKeys = [ marco ];
  "restic/password.age".publicKeys = [ marco ];
}
