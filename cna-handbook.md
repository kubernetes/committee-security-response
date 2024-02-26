# CVE Numbering Authority tasks

<!-- toc -->
- [CVE Numbering Authority tasks](#cve-numbering-authority-tasks)
  - [CNA-trained Security Response Committee members](#cna-trained-security-response-committee-members)
  - [References](#references)
  - [Common CNA tasks](#common-cna-tasks)
    - [Track CVE ID status](#track-cve-id-status)
    - [Requesting CVE IDs](#requesting-cve-ids)
    - [cvelib](#cvelib)
      - [Setup](#setup)
      - [User admin](#user-admin)
    - [Assign a CVE ID to vulnerability](#assign-a-cve-id-to-vulnerability)
    - [Populate CVE details](#populate-cve-details)
    - [Reject unused CVEs](#reject-unused-cves)
  - [Uncommon tasks](#uncommon-tasks)
    - [Splitting, merging, amending CVEs](#splitting-merging-amending-cves)
<!-- /toc -->

## CNA-trained Security Response Committee members

The following members of the Security Response Committee have completed CNA training and can request/assign/publish CVEs for the Kubernetes CNA:

- CJ Cullen (**[@cjcullen](https://github.com/cjcullen)**) `<cjcullen@google.com>`
- Craig Ingram (**[@cji](https://github.com/cji)**) `<cjingram@google.com>`
- Joel Smith (**[@joelsmith](https://github.com/joelsmith)**) `<joelsmith@redhat.com>`
- Micah Hausler (**[@micahhausler](https://github.com/micahhausler)**) `<mhausler@amazon.com>`
- Mo Khan (**[@enj](https://github.com/enj)**) `<i@monis.app>`
- Rita Zhang (**[@ritazh](https://github.com/ritazh)**) `rita.z.zhang@gmail.com`
- Sri Saran Balaji (**[@SaranBalaji90](https://github.com/SaranBalaji90)**) `<srajakum@amazon.com>`
- Tabitha Sable (**[@tabbysable](https://github.com/tabbysable)**) `<tabitha.c.sable@gmail.com>`

## References

CNA documents are hosted by MITRE at https://cve.mitre.org/about/documents.html#cna, notably:

* CNA onboarding guides: https://cveproject.github.io/docs/cna/onboarding/index.html
    * Also available in video form: https://www.youtube.com/playlist?list=PLWfD9RQVdJ6c4eMkdqbOKqF7zPCqXkgX3
* CNA Rules: https://cve.mitre.org/cve/cna/rules.html

A walkthrough of this handbook is also available in [video form](https://youtu.be/pcmAaEP7HD4).

## Common CNA tasks

### Track CVE ID status

As of 2022, CVE IDs are dynamcally reserved from MITRE's CVE API. CNA-trained SRC members can use an open-source CLI to reserve new CVE IDs as they are needed. Newly reserved CVE IDs and those previously allocated the Kubernetes project are accessible to the Security Response Committee [here](https://docs.google.com/spreadsheets/d/178eqxFxShR0I2BeoZ-YUynYnl0fo_0oU0VfmVfBpAQ0/edit)

### Requesting CVE IDs

If a new CVE ID is needed to assign to a new issue, and reserved IDs for the current year are exhausted, you can use the command line client [cvelib][cvelib].

[cvelib]: https://github.com/RedHatProductSecurity/cvelib

Once the CVE ID is received, add it to the [tracking sheet] as unassigned IDs for future assignment.

### cvelib

#### Setup

If you want to run cvelib in a container, use the following

```bash
# Don't quote the values
echo << EOF > env.txt
CVE_USER=${YOUR_EMAIL}
CVE_ORG=kubernetes
CVE_API_KEY=${YOUR_API_KEY}
EOF

cat << EOF > Dockerfile
FROM python:3-slim

RUN pip install cvelib

ENTRYPOINT ["/usr/local/bin/cve"]
EOF

docker build -t $USER/cvelib:latest .
docker run --env-file=env.txt -it --rm $USER/cvelib:latest
```

By not specifying any arguments, the help output will be displayed. You can then explore the various sub arguments in the CLI. To see the arguments for reserving a single CVE, you can run the following command:

```bash
docker run --env-file=env.txt -it --rm $USER/cvelib:latest reserve -h
```

#### User admin

To see help output on resetting your own API key, you can run the following command:

```bash
docker run --env-file=env.txt -it --rm $USER/cvelib:latest user reset-key -h
```

To see help output on creating a new CNA admin user, you can run the following command:
```bash
docker run --env-file=env.txt -it --rm $USER/cvelib:latest user create -h
```

### Assign a CVE ID to the vulnerability

When a vulnerability report is received, follow the [CNA decision tree](https://cve.mitre.org/cve/cna/rules.html#Appendix_C)
to determine if this is a valid vulnerability, in scope for the Kubernetes CNA, that has not yet been assigned a CVE ID,
and if so, how many distinct vulnerabilities exist in the report.

If a reserved ID is not available, run the following to reserve a new CVE ID or a batch of IDs:

```bash
docker run --env-file=env.txt -it --rm $USER/cvelib:latest reserve -h
```

Assign a reserved ID to the issue, and add at least the following information in the [tracking sheet]:
* Date reserved
* Description
* Link to the tracking issue in https://github.com/kubernetes-security/security-disclosures/issues (created as part of [on-call workflow](src-oncall.md#incident-response-workflow))

### Populate CVE Details after Public Disclosure 

1. Ensure there is a Kubernetes github issue labeled `area/security` whose title contains the CVE ID.
This will appear in the issue query linked from https://kubernetes.io/cve.
1. Once a vulnerability is made public, populate the CVE details in https://github.com/CVEProject/cvelist. This should be done as soon as reasonably possible after the vulnerability is made public (ideally, O(days)).
1. Generate the CVElist json file

    * See https://github.com/CVEProject/cvelist/blob/master/2023/2xxx/CVE-2023-2727.json as an example.

    * https://vulnogram.github.io/#editor is a useful tool for generating the CVE details, but should only be used once the vulnerability has been made public.

    Fill in or update the relevant fields, including:
    * State: `PUBLIC`
    * Assigner: `security@kubernetes.io`
    * Affects: List historical minor versions affected and "prior to 1.x.y" patch versions affected
    * Credits: The vulnerability reporter's name
    * Description: `The Kubernetes <component> command/component in versions <affected versions> <vulnerability>`
    * Impact: CVSS impact
    * Problem type: Select a problem type from https://cwe.mitre.org/data/definitions/699.html if applicable
    * References: Link to the Kubernetes github issue(s) (with type `issue-tracking`) and mailing list announcement (with type `mailing-list`)
    * Source: Link to the Kubernetes github issue(s) and indicate if it was discovered internally or externally
    * Work around: indicate workaround steps, if applicable

1. Once the cvelist json file is generated, request a review from a CNA-approved SRC member.
1. Once the json file is reviewed, a CNA approved member should run the following to push the update
    ```bash
    docker run --env-file=env.txt -v ${PWD}/CVE-xxxx-xxxx.json:/tmp/CVE-xxxx-xxxx.json  -it --rm $USER/cvelib:latest publish CVE-xxxx-xxxx  -f /tmp/CVE-xxxx-xxxx.json
    ```
1. Once the cvelist json file in https://github.com/CVEProject/cvelist is updated, indicate in the [tracking sheet] that the CVE has been populated.

### Reject unused CVEs

Once a calendar year has completed, all untriaged reports from that year have been resolved,
and no new CVE assignments for that year will be made, update any reserved but unassigned CVE IDs
for that calendar year to indicate they were rejected and unused.

1. Run the following:

    ```bash
    docker run --env-file=env.txt -it --rm $USER/cvelib:latest reject -h
    ```

1. Update the [tracking sheet] to indicate those CVEs were rejected (see CVE-2019-11256 through CVE-2019-11267 as an example)

## Uncommon tasks

### Splitting, merging, amending CVEs

This is rarely required, but if later inspection reveals a single CVE was actually two separate vulnerabilities, or two separate CVEs were actually a single vulnerability, CVEs can be split or merged following the process described at https://cve.mitre.org/cve/cna/rules.html#Appendix_E

[tracking sheet]: https://github.com/kubernetes-security/security-disclosures#cna-tracker
