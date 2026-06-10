# gsuite-to-o365-migration-toolkit
# Google Workspace to Microsoft 365 Migration Toolkit 🔄☁️

## Overview
This repository provides a comprehensive workflow, architectural guidelines, and automation scripts for migrating an enterprise environment from Google Workspace (G Suite) to Microsoft 365. 

The strategy ensures zero data loss and maintains seamless internal communication during the transition phase.

## Migration Phases & Strategy

### 1. Pre-Migration (Assessment & Provisioning)
* **Domain Verification:** Adding and verifying the routing domain (e.g., `company.onmicrosoft.com`) and the primary domain in the M365 Admin Center.
* **User Provisioning:** Creating user accounts in M365 without assigning Exchange licenses initially to prevent premature mailbox creation.

### 2. Coexistence & Mail Routing (Crucial Phase)
To ensure users on Google Workspace and M365 can email each other seamlessly during the migration:
* Set the M365 domain to **Internal Relay**.
* Configure **Outbound Connectors** in M365 targeting Google Workspace's MX records for unresolved mailboxes.
* Configure **Dual Delivery / Split Delivery** in Google Workspace routing rules to forward emails to the migrated users in M365.

### 3. Data Migration (Exchange Admin Center)
* **Endpoint Creation:** Setting up the Google Workspace migration endpoint in M365 using a Google Service Account with appropriate API scopes (Gmail, Calendar, Contacts).
* **Batch Migrations:** Creating migration batches via CSV files to sync data in the background while users continue working on Google Workspace.

### 4. Cutover (Go-Live)
* **DNS Update:** Pointing the primary MX records to Microsoft 365 (e.g., `company-com.mail.protection.outlook.com`).
* **License Assignment:** Running automated PowerShell scripts to bulk-assign proper M365 licenses to the migrated users.
* **Final Sync:** Running the migration batches one last time to catch any delta emails received during the DNS propagation.

## Automation Tools Included
* `Assign-M365Licenses.ps1`: A PowerShell script to bulk assign specific Office 365 licenses to users from a CSV file post-migration.
