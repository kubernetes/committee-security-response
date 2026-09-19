We’re incredibly grateful for security researchers and users that report vulnerabilities to the Kubernetes Open Source Community. All reports are thoroughly investigated by a set of community volunteers.

# Response Targets
Cloud Native Computing Foundation will make a best effort to meet the following response targets for hackers participating in our program:

* Time to first response (from report submitted) - 1 business day
* Time to triage (from report submitted) - 10 business days
* Time to bounty (from triage) - 10 business days

We’ll try to keep you informed about our progress throughout the process.

# Disclosure Policy
* A public disclosure date is negotiated by the Kubernetes Security Response Committee and the bug submitter. We prefer to fully disclose the bug as soon as possible once user mitigation is available. It is reasonable to delay disclosure when the bug or the fix is not yet fully understood, the solution is not well-tested, or for vendor coordination. The timeframe for disclosure is very dependent on the context of the bug and varies from immediate for publicly known issues to months for bugs requiring breaking changes.


# Program Rules
* https://github.com/kubernetes/security/blob/master/security-release-process.md
* Please provide detailed reports with reproducible steps. If the report is not detailed enough to reproduce the issue, the issue will not be eligible for a reward.
* Submit one vulnerability per report, unless you need to chain vulnerabilities to provide impact.
* When duplicates occur, we only award the first report that was received (provided that it can be fully reproduced).
* Multiple vulnerabilities caused by one underlying issue will be awarded one bounty.
* Social engineering (e.g. phishing, vishing, smishing) is prohibited.
* Make a good faith effort to avoid privacy violations, destruction of data, and interruption or degradation of live user production services. Only interact with accounts you own or with the explicit permission of the account holder.
* Please limit security scanner QPS against kubernetes domains to 5 QPS

When Should I Report a Vulnerability?
* You think you discovered a potential security vulnerability in Kubernetes
* You are unsure how a vulnerability affects Kubernetes


When Should I NOT Report a Vulnerability?
* You need help tuning Kubernetes components for security
* You need help applying security-related updates
* Your issue is not security-related

### If you think you discovered a vulnerability in another project that Kubernetes depends on, and that project has their own vulnerability reporting and disclosure process, please report it directly there.

# Severity Thresholds - How We Do Vulnerability Scoring
For details, please refer to the [Github Kubernetes Security Release](https://github.com/kubernetes/security/blob/master/security-release-process.md#severity-thresholds---how-we-do-vulnerability-scoring)

***
# Rewards
Our rewards are based on severity per CVSS (the Common Vulnerability Scoring Standard). Please note these are general guidelines, and reward decisions are up to the discretion of Cloud Native Computing Foundation and adjustments to the Severity Thresholds described below. `kubectl` vulnerabilities requiring user-interaction will be awarded at a lower-tier (e.g. a critical will be awarded as a high).

# Reward Eligibility
The following groups of people are ineligible for awards but may still submit reports if the conflict is mentioned within the report:
- CNCF staff
- Kubernetes Security Response Committee and associates
- HackerOne’s program team
- Project maintainers, for the vulnerable (sub)project
- Authors & reviewers of the vulnerable code

### Tier 1: Core Kubernetes
Tier 1 includes:
- GA & Beta features of core Kubernetes (e.g. k8s.io/kubernetes & staging) or Kubernetes-owned core dependencies (e.g. k8s.io/klog), as well as core addons (kube-proxy)
- The ability to alter source code without OWNER approval, or modify release artifacts.
- DoS attacks on release artifacts, including k8s.gcr.io, dl.k8s.io, and packages.k8s.io

### Tier 2: 
Tier 2 includes:
- GA & Beta features of non-core GA components (e.g. CSI drivers, k8s.io/dashboard, kube-adm)

### Tier 3:
Tier 3 includes:
- Kubernetes infrastructure (e.g. k8s.io, prow, documentation)
Note: Kubernetes infrastructure compromise leading to code/artifact modification falls under Tier 1.
- Alpha features of core Kubernetes


***


#Getting Started 
We've included a few links for anyone who would like an overview of Kubernetes. 

**Hardening guides**
* Kubernetes.io: https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/

**Frameworks**
* CIS benchmarks: https://www.cisecurity.org/benchmark/kubernetes/
* NIST 800-190: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-190.pdf

**Talks**
* Shipping in pirate-infested waters (KubeCon NA 2017): https://www.youtube.com/watch?v=ohTq0no0ZVU
* Hacking and Hardening Kubernetes clusters by example (KubeCon NA 2017): https://www.youtube.com/watch?v=vTgQLzeBfRU
* Securing Kubernetes (BSidesSF 2017): https://www.youtube.com/watch?v=BER8uridVIs
* Kubernetes Practical Attack and Defense (BlueHat Seattle 2019) https://www.youtube.com/watch?v=XmP9Rcn5fZo

**Training**
* Kubernetes Acadamy: https://kubernetes.academy

***
# Scope  
## Cluster Attacks:

*Attacks against Beta & GA features unless explicitly excluded below*
* Privilege escalation due to bugs in RBAC, ABAC, pod security policies
* Authentication bugs in the in-tree authentication handlers
* Including: OIDC, x509 certificates, service accounts, webhook authenticator, bearer token, etc.
* Privilege escalation through the kubelet APIs
* Remote code execution in kubelet, api server
* Unauthorized etcd access via the Kubernetes API
* Path traversal attacks in API, namespaces, etcd
* Info leak (e.g. workload names) from publicly accessible unauthenticated endpoints
* Excluding intentionally disclosed info, such as Kubernetes version & enabled APIs
* Reliable suppression of audit logs for privileged actions
* Unexpected editing, removal, or permission changes of files on the host filesystems from Kubernetes components (e.g. kubelet)
* Persistent DoS from within a cluster by an unprivileged container or user.

## Supply Chain: (excluding social engineering attacks against maintainers)
* Unauthorized code commit to any Kubernetes org repository
* Including: github.com/kubernetes{,-client,-csi,-incubator,-retired,-security,-sigs}/*
* Unauthorized access to github.com/kubernetes-security
* Publishing of unauthorized artifacts
* Unauthorized modification of github data
* CI/CD Credential Leaks
* Execution inside the CI/CD infrastructure
* Unauthorized push, update or delete of container images in any kubernetes-owned repository
* Including: k8s.gcr.io, gcr.io/kubernetes-ci-images

## Components:
* Attacks against a stable & supported Kubernetes release (most recent 3 releases)
* Community maintained stable cloud platform plugins
* Vulnerabilities in other cloud platform plugins should be reported through the associated provider
* In-tree (k8s.io/kubernetes) stable volume plugins

# In scope but not eligible for bounty

**The following items are but not eligible for rewards.** While we still welcome vulnerability reports in these areas, they are not (currently) eligible to receive a bounty.
* Kubernetes running on Windows or other non-Linux operating systems
* Non-Kubernetes binaries distributed as cluster addons
* Please report vulnerabilities in these components through the appropriate channel for the upstream component
* Container escalations and escapes to the host, unless the attack path traverses a Kubernetes process (e.g. kubelet).
* Attacks against containers from the host they are running on
* Attacks relying on insecure configurations (subject to the Security Response Committee's opinion), such as clusters not utilizing mutual authentication or encryption between Kubernetes components.
* Attacks relying on or against deprecated components (e.g. gitrepo volumes)
* Broken link hijacking to 3rd party content in Kubernetes documentation.  
* Community management tooling - Including email lists, Google docs, community meetings, slack channels, etc.
    * Exceptions: reading messages in *-private@kubernetes.io, security@kubernetes.io, distributors-announce@kubernetes.io
    * Kubernetes is a community run open source project. Most of our communications and plans are public, and we welcome anyone to join the conversations.
    * Email spoofing protections are known [1](https://groups.google.com/d/msg/kubernetes-security-discuss/EEQEaGQucSA/rLSxT7EDCgAJ) [2](https://groups.google.com/d/topic/kubernetes-wg-k8s-infra/b3gB8ft0beA/discussion), and we've chosen to stick with the current configuration.

# Out of scope - please report to the corresponding project directly
* Vulnerabilities in etcd
    * Please report these through [etcd's disclosure process](https://github.com/etcd-io/etcd/tree/master/security#report-a-vulnerability)
* Vulnerabilities in CoreDNS
    * Please report these through [CoreDNS's disclosure process](https://github.com/coredns/coredns#security)
* Vulnerabilities specific to a hosted Kubernetes setup
    * Please report these through the associated provider
* Vulnerabilities in hosted vendor tools, including Google docs, Slack, Discourse, Zoom
    * Please report these to the vendor directly.
* Linux Vulnerabilities
    * Please report these through security@kernel.org
* Vulnerabilities in ingress and gateway controllers
    * High quality reports may be rewarded with a bonus on a case by case basis

# Miscellaneous notes:
* Much of our infrastructure is managed in public through GitOps and declarative config. As such, **configuration disclosures** and **path disclosures** are typically _not_ considered vulnerabilities.
    * If reporting one of these issues, please include proof of credential leakage, or demonstrate an attack with the leaked information.
* We have some dummy credentials in test data. Such values should typically have a comment indicating that they are not sensitive. When reporting leaked credentials, please check to ensure it's not just test data.
* Our community is very open, and most calendars (including Zoom PINs), mailing lists, meeting notes and other administrative resources are intended to be public. Exceptions: *-private@kubernetes.io, security@kubernetes.io, distributors-announce@kubernetes.io

***
# Safe Harbor
Any activities conducted in a manner consistent with this policy will be considered authorized conduct and we will not initiate legal action against you **under applicable
computer use laws on the basis of such activities**. We cannot bind or authorize any activities taken in relation to networks,
systems, information, applications, products, or services of any third
parties. If legal action is initiated by a third party against you in connection with activities conducted under this policy, we will take steps to make it known that your actions were conducted in compliance with this policy.

Thank you for helping keep Cloud Native Computing Foundation and our users safe!
