# Security and Responsible Use

## Sensitive Information

Do not commit any of the following to this repository:

- REDCap API tokens
- API credentials
- PHI
- PII
- Patient-level data
- Production REDCap URLs containing sensitive information
- Firewall paths containing organizational information
- Production report identifiers
- Screenshots containing sensitive information
- Data exports from production REDCap projects

## Token Management

API credentials should be stored using an approved organizational mechanism.

The example code demonstrates reading a token from a local protected file. This is an example implementation and should be evaluated against the organization's security architecture.

## Data Minimization

When sensitive healthcare data are involved, the reporting dataset should contain only the information necessary for the intended analytical purpose.

A REDCap report can be used as an additional control point for defining the fields available to downstream reporting systems.

## Production Use

These examples should undergo appropriate institutional security, privacy, and governance review before being used with real patient, research, or other sensitive data.

## Reporting a Security Issue

Please do not submit sensitive credentials, PHI, PII, or other confidential information through GitHub Issues or pull requests.

Security concerns involving a deployed implementation should be reported through the appropriate organizational security process.
