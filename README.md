# Automate a Daily System Backup Script (Using Bash Script)

## Objective:
Create a Bash script to perform automated daily system backups. This script should include the following features:
- Backup a specified directory (e.g., `/var/www`, `/etc`, or configurable via a variable).
- Store backups in a compressed format (`.tar.gz`) in a backup directory.
- Option to retain a configurable number of daily backups (e.g., keep the last 7 days).
- Implement log rotation to avoid unlimited log growth (e.g., keep the last 5 logs).
- Send an email alert on failure (using Postfix for email alerts).
- Schedule the script to run daily using a cron job.

---

## Requirements

1. **Backup Logic:**
   - Back up a specified directory (e.g., `/var/www`, `/etc`, etc.).
   - Store backups in a compressed `.tar.gz` format in a backup directory.
   - Retain a configurable number of daily backups (default: 7).

2. **Log Rotation:**
   - Implement logging for each backup run.
   - Rotate logs to avoid unlimited growth (default: keep last 5 logs).

3. **Alerting on Failures:**
   - If any part of the backup process fails, send an email alert using **Postfix** (local mail system). This will not use external SMTP services.
   - The email subject should clearly state the error.

4. **Scheduling:**
   - Set up a cron job to run the script daily.

---

## Deliverables

- Upload the code and cron job setup details to a GitHub repository.
- Include a `README.md` with the following sections:
  - How to run and test the script
  - How to configure paths and retention settings
  - How to test failure alerts

---

## Setup Instructions

### Prerequisites:

- **Postfix** (for local email alerts): You must have Postfix installed and configured on your server to send emails.

    Install Postfix on Ubuntu:
    ```bash
    sudo apt update
    sudo apt install postfix
    ```

    Follow the configuration prompts to set up Postfix for local mail delivery.

- **Directory to Backup**: Make sure the directory you want to back up (e.g., `/var/www`, `/etc`) is accessible.

- **Permissions**: The script should have appropriate permissions to read from the directory being backed up and write to the backup destination.

### 1. **Download the Script:**

Clone the repository containing the backup script:
```bash
git clone https://github.com/username/repository-name.git
cd repository-name
