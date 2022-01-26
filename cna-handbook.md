# CVE Numbering Authority tasks

- [CNA-trained Security Response Committee members](#cna-trained-security-response-committee-members)
- [References](#references)
- [Common CNA tasks](#common-cna-tasks)
  - [Track CVE ID status](#track-cve-id-status)
  - [Requesting CVE IDs](#requesting-cve-ids)
  - [Assign a CVE ID to vulnerability](#assign-a-cve-id-to-vulnerability)
  - [Populate CVE details](#populate-cve-details)
  - [Reject unused CVEs](#reject-unused-cves)
- [Uncommon tasks](#uncommon-tasks)
  - [Splitting, merging, amending CVEs](#splitting-merging-amending-cves)

## CNA-trained Security Response Committee members

The following members of the Security Response Committee have completed CNA training and can request/assign/publish CVEs for the Kubernetes CNA:

- Joel Smith (**[@joelsmith](https://github.com/joelsmith)**) `<joelsmith@redhat.com>`
- Micah Hausler (**[@micahhausler](https://github.com/micahhausler)**) `<mhausler@amazon.com>`
- Tim Allclair (**[@tallclair](https://github.com/tallclair)**) `<timallclair@gmail.com>`

## References

CNA documents are hosted by MITRE at https://cve.mitre.org/about/documents.html#cna, notably:

* CNA onboarding guides: https://cveproject.github.io/docs/cna/onboarding/index.html
    * Also available in video form: https://www.youtube.com/playlist?list=PLWfD9RQVdJ6c4eMkdqbOKqF7zPCqXkgX3
* CNA Rules: https://cve.mitre.org/cve/cna/rules.html

A walkthrough of this handbook is also available in [video form](https://youtu.be/pcmAaEP7HD4).

## Common CNA tasks

### Track CVE ID status

CVE IDs allocated to the Kubernetes project are accessible to the Security Response Committee [here](https://docs.google.com/spreadsheets/d/178eqxFxShR0I2BeoZ-YUynYnl0fo_0oU0VfmVfBpAQ0/edit)

### Requesting CVE IDs

If a new CVE ID is needed to assign to a new issue, and reserved IDs for the current year are exhausted, request a new block at https://cveform.mitre.org/:

* Request type: "Request a block of IDs (For CNAs only)"
* Email address: security@kubernetes.io
* Number of CVE IDs needed: estimate number needed for the remainder of the year
  * if you don't get enough, it's easy to get more
  * if you request too many, we have to update/reject them after the year ends
* Additional information: Indicate the request is for the Kubernetes CNA

Once the block of CVE IDs is received, add them to the [tracking sheet] as unassigned IDs for future assignment.

### Assign a CVE ID to vulnerability

When a vulnerability report is received, follow the [CNA decision tree](https://cve.mitre.org/cve/cna/rules.html#Appendix_C)
to determine if this is a valid vulnerability, in scope for the Kubernetes CNA, that has not yet been assigned a CVE ID,
and if so, how many distinct vulnerabilities exist in the report.

Assign a reserved ID to the issue, and add at least the following information in the [tracking sheet]:
* Date reserved
* Description
* Link to the tracking issue in https://github.com/kubernetes-security/security-disclosures/issues (created as part of [on-call workflow](src-oncall.md#incident-response-workflow))

### Populate CVE details

Ensure there is a Kubernetes github issue labeled `area/security` whose title contains the CVE ID.
This will appear in the issue query linked from https://kubernetes.io/cve.

Once a vulnerability is made public, populate the CVE details in https://github.com/CVEProject/cvelist.
This should be done as soon as reasonably possible after the vulnerability is made public (ideally, O(days)).

See https://github.com/CVEProject/cvelist/pull/3176/files as an example.

https://vulnogram.github.io/#editor is a useful tool for editing the CVE details,
but should only be used once the vulnerability has been made public.

Fill in or update the relevant fields, including:
* State: `PUBLIC`
* Assigner: `security@kubernetes.io`
* Title: `Kubernetes <component> <vulnerability>`
* Affects: List historical minor versions affected and "prior to 1.x.y" patch versions affected
* Credit: The vulnerability reporter's name
* Description: `The Kubernetes <component> command/component in versions <affected versions> <vulnerability>`
* Impact: CVSS impact
* Problem type: Select a problem type from https://cwe.mitre.org/data/definitions/699.html if applicable
* References: Link to the Kubernetes github issue(s) (with type CONFIRM) and mailing list announcement (with type MLIST)
* Source: Link to the Kubernetes github issue(s) and indicate if it was discovered internally or by a user
* Workaround: indicate workaround steps, if applicable

Commit, push to your branch, create a pull request to
https://github.com/kubernetes-security/cvelist-public master, and link the pull request in the
[tracking sheet]. Review any errors from the PR validation, and request a review from a CNA-approved
SRC member.

Once the PR to our fork has merged, a CNA approved member should open a PR to sync the upstream
cvelist with our fork:
https://github.com/CVEProject/cvelist/compare/master...kubernetes-security:master


Once the upstream pull request is merged, indicate in the tracking sheet that the CVE has been
populated.

### Reject unused CVEs

Once a calendar year has completed, all untriaged reports from that year have been resolved,
and no new CVE assignments for that year will be made, update any reserved but unassigned CVE IDs
for that calendar year to indicate they were rejected and unused.

1. Update the CVE details in github (see https://github.com/CVEProject/cvelist/pull/3175 as an example)
2. Update the [tracking sheet] to indicate those CVEs were rejected (see CVE-2019-11256 through CVE-2019-11267 as an example)

## Uncommon tasks

### Splitting, merging, amending CVEs

This is rarely required, but if later inspection reveals a single CVE was actually two separate vulnerabilities, or two separate CVEs were actually a single vulnerability, CVEs can be split or merged following the process described at https://cve.mitre.org/cve/cna/rules.html#Appendix_E

[tracking sheet]: https://github.com/kubernetes-security/security-disclosures#cna-tracker
