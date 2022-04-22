# Security Release Process

Kubernetes is a large growing community of volunteers, users, and vendors. The Kubernetes community has adopted this security disclosures and response policy to ensure we responsibly handle critical issues.

<!-- toc -->
- [Security Response Committee (SRC)](#security-response-committee-src)
  - [Security Response Committee Membership](#security-response-committee-membership)
    - [Joining](#joining)
      - [SRC Lazy Consensus Selection](#src-lazy-consensus-selection)
    - [Stepping Down](#stepping-down)
    - [Responsibilities](#responsibilities)
      - [Incident Commander](#incident-commander)
      - [Triage](#triage)
      - [Associate](#associate)
    - [SIG Release Roles](#sig-release-roles)
- [Disclosures](#disclosures)
  - [Private Disclosure Processes](#private-disclosure-processes)
  - [Public Disclosure Processes](#public-disclosure-processes)
- [Patch, Release, and Public Communication](#patch-release-and-public-communication)
  - [Fix Team Organization](#fix-team-organization)
  - [Fix Development Process](#fix-development-process)
  - [Fix Disclosure Process](#fix-disclosure-process)
- [Private Distributors List](#private-distributors-list)
- [Retrospective](#retrospective)
- [Severity](#severity)
<!-- /toc -->

## Security Response Committee (SRC)

Security vulnerabilities should be handled quickly and sometimes privately. The primary goal of this process is to reduce the total time users are vulnerable to publicly known exploits.

The [Security Response Committee (SRC)](README.md#security-response-committee-src) is responsible for organizing the entire response including internal communication and external disclosure but will need help from relevant developers and release managers to successfully run this process.

### Security Response Committee Membership

#### Joining

New potential members to the SRC will first fill a minimum of a 3 month rotation in the [Associate](#Associate) role.

These individuals will be nominated by individuals on steering committee, SRC, or release manager lead and patch release manager.

The SRC has a goal to have at least 7 members.

To encourage diversity members will also abide by a 1/2 maximal representation from any one company at any time. If representation changes due to job shifts or mergers, then members are encouraged to grow the team or replace themselves through mentoring new members. Being overlimit should not continue for longer than 12 months to give time to identify and mentor new members.

##### SRC Lazy Consensus Selection

Selection of new members from the associates will be done by lazy consensus, and defaults to the longest-standing associate.

Selection of new associates is done by nomination and full consensus of current SRC members.

#### Stepping Down

Members may step down at anytime.

#### Responsibilities

- Members should remain active and responsive, and participate in the [oncall rotation](src-oncall.md).
- Members going on extended leave for up to 3 months (1-2 rotations) may pause their oncall duties, but should coordinate with other members to ensure the role is adequately staffed during the leave.
- Longer leaves of absense should be discussed on a case-by-case basis, and may include an associate temporarily onboarding.
- Members of a role should remove any other members that have not communicated a leave of absence and either cannot be reached for more than 2 months or are not fulfilling their documented responsibilities for more than 2 months. This may be done through a super-majority vote of members.

##### Incident Commander

One of the primary responsibilities of the SRC is to coordinate incident response when a
vulnerability is discovered. The incident commander is responsible for coordinating all the
different parts of the security release process (but not handling all those responsibilities
themselves), and seeing the incident through to the end (or handing off).

The incident commander defaults to the current oncall, but may be handed off to other SRC or Kubernetes maintainers.

##### Triage

The current oncall is responsible for triaging incoming vulnerability reports (both through the bug
bounty and email). For more details on the triage process, see [oncall
workflow](SRC-oncall.md).

##### Associate

A role for those wishing to join the SRC. They should not currently be a member
of security@kubernetes.io.

Their rotation will involve the following:

- lead disclosures that are publicly disclosed or explicitly designated as low sensitivity (through
    the security-disclosures-low tracker) (often done because of reporter request, a low CVSS score,
    or design issue that requires long-term refactoring).
- assisting in process improvements, bug bounty administration, audits, or other non-disclosure activities

#### SIG Release Roles

Included on the [private Release Managers list](https://groups.google.com/a/kubernetes.io/forum/#!forum/release-managers-private)
are the following members:

- [Release Managers](https://git.k8s.io/sig-release/release-managers.md#release-managers)
(manage build and release aspects when a security fix must be delivered)
- [SIG Release Chairs](https://git.k8s.io/sig-release/release-managers.md#sig-release-chairs)

It is the responsibility of the [SIG Release Chairs](https://git.k8s.io/sig-release/release-managers.md#sig-release-chairs)
to curate and maintain the various release role access controls across release cycles.

The [Build Admins](https://git.k8s.io/sig-release/release-managers.md#build-admins)
(Googlers with access to build/publish Kubernetes deb/rpm packages) are not
explicitly part of the private security release team, but are also involved in
delivery and must abide by the private disclosure process.

## Disclosures

### Private Disclosure Processes

The Kubernetes Community asks that all suspected vulnerabilities be privately and responsibly disclosed via the Private Disclosure process available at [https://kubernetes.io/security](https://kubernetes.io/security).

### Public Disclosure Processes

If you know of a publicly disclosed security vulnerability please IMMEDIATELY email [security@kubernetes.io](mailto:security@kubernetes.io) to inform the Security Response Committee (SRC) about the vulnerability so they may start the patch, release, and communication process.

If possible the SRC will ask the person making the public report if the issue can be handled via a private disclosure process. If the reporter denies the request, the SRC will move swiftly with the fix and release process. In extreme cases you can ask GitHub to delete the issue but this generally isn't necessary and is unlikely to make a public disclosure less damaging.

## Patch, Release, and Public Communication

For each vulnerability a member of the SRC will volunteer to lead coordination
with the Fix Team and Release Managers, and is responsible for sending disclosure
emails to the rest of the community. This lead will be referred to as the Fix Lead.

The role of Fix Lead should rotate round-robin across the SRC.

All of the timelines below are suggestions and assume a Private Disclosure.
The Fix Lead drives the schedule using their best judgment based on severity,
development time, and release manager feedback. If the Fix Lead is dealing with
a Public Disclosure all timelines become ASAP. If the fix relies on another
upstream project's disclosure timeline, that will adjust the process as well.
We will work with the upstream project to fit their timeline and best protect
our users.

### Fix Team Organization

These steps should be completed within the first 24 hours of Disclosure.

- The Fix Lead will work quickly to identify relevant engineers from the affected projects and packages and CC those engineers into the disclosure thread. This selected developers are the Fix Team. A best guess is to invite all assignees in the OWNERS file from the affected packages.
- The Fix Lead may get the Fix Team access to private security repos in the kubernetes-security GitHub org to develop the fix as required.

Note: The kubernetes-security GitHub org is co-owned and viewable by the SRC and Kubernetes Release Managers. Management of the org is done by SIG Contributor Experience's [GitHub management subproject](https://git.k8s.io/community/github-management).

### Fix Development Process

These steps should be completed within the 1-7 days of Disclosure.

- The Fix Lead and the Fix Team will create a [CVSS](https://www.first.org/cvss/specification-document) score using the [CVSS Calculator](https://www.first.org/cvss/calculator/3.0). They will also use the [Severity Thresholds - How We Do Vulnerability Scoring](#severity-thresholds---how-we-do-vulnerability-scoring) to determine the effect and severity of the bug. The Fix Lead makes the final call on the calculated risk; it is better to move quickly than make the perfect assessment.
- The Fix Lead will request a CVE from the [Kubernetes CVE Numbering Authority](cve-requests.md).
- The Fix Team will notify the Fix Lead that work on the fix branch is complete once there are LGTMs on all commits in the private repo from one or more relevant assignees in the relevant OWNERS file.

If the CVSS score is under ~4.0
([a low severity score](https://www.first.org/cvss/specification-document#i5))
or the assessed risk is low the Fix Team can decide to slow the release process
down in the face of holidays, developer bandwidth, etc. These decisions must be
discussed on the security@kubernetes.io mailing list.

If the CVSS score is under ~7.0 (a medium severity score), the Fix Lead may
choose to carry out the fix semi-publicly. This means that PRs are made directly
in the public kubernetes/kubernetes repo, while restricting discussion of the
security aspects to private channels. The fix lead will make the determination
whether there would be user harm in handling the fix publicly that outweighs the
benefits of open engagement with the community.

Critical and High severity vulnerability fixes will typically receive an out-of-band release. Medium and Low severity vulnerability fixes will be released as part of the next Kubernetes [patch release](https://github.com/kubernetes/sig-release/blob/master/releases/patch-releases.md).

Note: CVSS is convenient but imperfect. Ultimately, the Fix Lead has discretion
on classifying the severity of a vulnerability.

No matter the CVSS score, if the vulnerability requires
[User Interaction](https://www.first.org/cvss/user-guide#5-4-User-Interaction),
especially in client components like kubectl, or otherwise has a
straightforward, non-disruptive mitigation, the Fix Lead may choose to disclose
the vulnerability before a fix is developed if they determine that users would
be better off being warned against a specific interaction.

### Fix Disclosure Process

With the Fix Development underway the Fix Lead needs to come up with an overall communication plan for the wider community. This Disclosure process should begin after the Fix Team has developed a Fix or mitigation so that a realistic timeline can be communicated to users. Emergency releases for critical and high severity issues or fixes for issues already made public may affect the below timelines for how quickly or far in advance notifications will occur.

**Advance Vulnerability Disclosure to Private Distributors List** (Completed within 1-4 weeks prior to public disclosure):

- The [Private Distributors List](#private-distributors-list) will be given advance notification of any vulnerability that is assigned a CVE, at least 7 days before the planned public disclosure date. The notification will include all information that can be reasonably provided at the time of the notification. This may include patches or links to PRs, proofs of concept or instructions to reproduce the vulnerability, known mitigations, and timelines for public disclosure. Distributors should read about the [Private Distributors List](#private-distributors-list) to find out the requirements for being added to this list.
- **What if a vendor breaks embargo?** The SRC will assess the damage. The Fix Lead will make the call to release earlier or continue with the plan. When in doubt push forward and go public ASAP.

**Fix Release Day**

Release process:
- The Fix Lead will cherry-pick the patches onto the master branch and all relevant release branches. The Fix Team will `/lgtm` and `/approve`.
- The Release Managers will merge these PRs as quickly as possible. Changes shouldn't be made to the commits at this point, to prevent potential conflicts with the patches sent to distributors, and conflicts as the fix is cherry-picked around branches.
- The Release Managers will ensure all the binaries are built, publicly available, and functional.
- The Fix Lead will remove the Fix Team from the private security repo once it is no longer needed.

Communications process:
- The [Private Distributors List](#private-distributors-list) will be notified at least 24 hours in
  advance of a pending release containing security vulnerability fixes with the public messaging,
  date, and time of the announcement.
- The Fix Lead will announce the new releases, the CVE number, severity, and impact, and the
  location of the binaries to get wide distribution and user action. As much as possible this
  announcement should be actionable, and include any mitigating steps users can take prior to
  upgrading to a fixed version. The recommended target time is 4pm UTC on a non-Friday weekday. This
  means the announcement will be seen morning Pacific, early evening Europe, and late evening Asia.
  The announcement will be sent via the following channels:
  - General announcement email ([template](comms-templates/vulnerability-announcement-email.md)) to
    multiple Kubernetes lists
  - OSS-Security announcement email
    ([template](comms-templates/vulnerability-announcement-email.md)) to
    `oss-security@lists.openwall.com`
  - `#announcements` slack channel ([template](comms-templates/vulnerability-announcement-slack.md))
  - [discuss.kubernetes.io](https://discuss.kubernetes.io/c/announcements) forum (this should be
    posted automatically using the general announcement email template)
  - Tracking issue opened in https://github.com/kubernetes/kubernetes/issues
    ([template](comms-templates/vulnerability-announcement-issue.md)) and prefixed with the
    associated CVE ID (if applicable)
  - Medium and Low severity vulnerability fixes that will be released as part of the next Kubernetes
    [patch release](https://github.com/kubernetes/sig-release/blob/master/releases/patch-releases.md)
    will have the fix details included in the patch release notes. Any public announcement sent for
    these fixes will link to the release notes.

## Private Distributors List

This list is used to provide actionable information to multiple distribution
vendors at once.

See the [private distributor list doc](private-distributors-list.md) for more information.

## Retrospective

These steps should be completed 1-3 days after the Release Date. The retrospective process [should be blameless](https://landing.google.com/sre/book/chapters/postmortem-culture.html).

- The Fix Lead will send a retrospective of the process to kubernetes-dev@googlegroups.com including details on everyone involved, the timeline of the process, links to relevant PRs that introduced the issue, if relevant, and any critiques of the response and release process.
- The Release Managers and Fix Team are also encouraged to send their own feedback on the process to kubernetes-dev@googlegroups.com. Honest critique is the only way we are going to get good at this as a community.

## Severity

Severity is evaluated on a case-by-case basis, guided by [CVSS 3.1](https://www.first.org/cvss/v3.1/specification-document).

TODO(#147): Document a guide to interpretting CVSS for Kubernetes.
