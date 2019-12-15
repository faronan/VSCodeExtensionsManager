# VSCode Extensions Manager

## Requirement
- Docker

## Usage
- `script/install.sh`
  - Install extensions for `extensions.yml`.
- `script/restore.sh`
  - Restore extensions for backup text.
- `script/uninstall.sh`
  - Uninstall all extensions and backup.

### extensions.yml
- Describe extensions for each purpose
- Optionally comment on details
- Regularly update from cloudSettings gist by Github Action
  - `EMAIL`, `NAME` and `GIST_URL` add repositories Secrets
