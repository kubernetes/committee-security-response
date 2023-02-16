# Severity Ratings

The Security Response Committee evaluates vulnerability severity on a case-by-case basis, guided by
[CVSS 3.1](https://www.first.org/cvss/v3.1/specification-document). If you have questions about why
a vulnerability is rated the way it is, please feel free to comment on the associated GitHub
tracking issue.

## Severity Thresholds - Heuristics

The content presented below outlines basic heuristics for  considering the effect
of bugs disclosed to the Security Response Committee and their severity. These apply
mostly to items in "core" Kubernetes but could be abstractly applied to those in other
components as well.

### Server

The "server" pertains to any "server-side components" (see below) we distribute,
but you can specifically think of `kube-apiserver` and `kubelet` being the main ones.

"Server-side components" pertains to:

- Components built from source in the `kubernetes` github organization and
  [all current organizations in use](https://git.k8s.io/community/github-management/README.md#actively-used-github-organizations)
- Container images under the `k8s.gcr.io` and `registry.k8s.io` repositories
- Containers included in the [core addons directory](https://git.k8s.io/kubernetes/cluster/addons)

The server classification is usually not appropriate when user interaction
is part of the exploitation process, those should fall under the
[client](#client) classifications as "client" implies user interaction with a
client.
If a "Critical" vulnerability exists only on server
components, and is exploited in a way that requires user interaction and results
in the compromise of the server, the severity may be reduced from "Critical" to
"High" in accordance with the data definition of extensive user
interaction presented at the start of the client severity pivot.

#### Critical

Network worms or _unavoidable_ cases where the server is "compromised."

##### Elevation of privilege

The ability to either execute arbitrary code or obtain more privilege than
authorized.

- [Remote Anonymous User](#remote-anonymous-user)
    - Unauthorized access. Examples:
        - read, write, or delete access to sensitive API objects
        - arbitrary writing/deletion to the file system or anywhere in the
          cluster that should not typically be modifiable
        - getting data from the server or server components
    - Execution of arbitrary code (remote code execution in the server)

This includes all write access violations.

##### Information disclosure (targeted)

Cases where an unprivileged user can locate and read highly sensitive
information from anywhere on the system, including system information that was
not intended or designed to be exposed.

- [Remote Anonymous User](#remote-anonymous-user)
    - Unauthorized access. Examples:
        - Personally identifiable information (PII) disclosure
          (email addresses, cloud provider credentials)
        - Attacker can collect private data without user consent or in a covert fashion
        - Secrets data
        - System credentials

#### High

"Critical" attacks are downgraded to "High" when requiring
[adjacent network access](#adjacent-network-access).

Non-default (or non-typical) critical scenarios or cases where
mitigations exist that can help prevent critical scenarios.

##### Denial of service

Must be "easy to exploit" by sending a small amount of data or be otherwise
quickly induced.

- [Remote Anonymous User](#remote-anonymous-user)
    - Persistent DoS. Examples:
        - Sending a single malicious request results in
          [service failure](#service-failure)
        - Sending a small number of requests that causes a
          [service failure](#service-failure)
    - Temporary DoS. Examples:
        - Sending a small number of requests that causes the system to be
          unusable for a period of time
        - Server being down for a minute or longer
        - A single remote client consuming all available resources
          (sessions, memory) on a server by establishing sessions and keeping them open

- [Authenticated User](#authenticated-user)
    - Persistent DoS against a [high value asset](#high-value-asset). Example:
        - Sending a small number of requests that causes a
          [service failure](#service-failure) for a
          [high value asset](#high-value-asset)

##### Elevation of privilege

The ability to either execute arbitrary code or obtain more privilege than
authorized. This includes all write access violations.

- [Authenticated User](#authenticated-user)
    - Unauthorized access. Examples:
        - arbitrary writing to the file system or server components like etcd,
          where the user should not have the ability to write
        - reading or writing to API objects where the user should not be able
          to
        - getting data from the server or server components, where the user
          should not have the ability to read
        - execution of arbitrary code (like creating a pod or remote code execution
          attacks)

Breaking or bypassing any security feature provided. A vulnerability in a
security feature is rated “High” by default, but the rating may be adjusted
based on other considerations as documented here.

Examples:
- Disabling or bypassing a `NetworkPolicy` or `PodSecurityPolicy` without
informing users or gaining consent
- Reconfiguring a `NetworkPolicy` and allowing connections to other processes
without consent

An entity (computer, server, user, process) is able to masquerade as a
specific entity (user or computer) of his/her choice.

Examples:
- Service masquerades as the API server for the cluster and effectively
  man-in-the-middle's the real API server.
- API server uses client certificate authentication (SSL) improperly to allow
  an attacker to be identified as any user of his/her choice
- RBAC bug that allows a malicious remote user to be seen as a different user
  of his or her choice


##### Information disclosure (targeted)

Cases where an anonymous user can easily read sensitive information on the
system from specific locations, including system information that was not
intended/designed to be exposed.

Examples:

- Targeted disclosure of the existence of an arbitrary file
- Arbitrary filesystem or application data that should not typically be accessed
- Arbitrary API resources that should not typically be accessed
- Workload & namespace names or identifying metadata
- System & workload logs that are not typically exposed
- Workload or user-created metrics

#### Medium

"High" attacks are downgraded to "Medium" when requiring [local
access](#local-access) or when there is a straight-forward mitigation.

##### Information disclosure (targeted)

Cases where an anonymous user can easily read anonymous (non-sensitive)
information on the system, including system metrics that were not intended to be
exposed.

Examples:

- System metrics common to most Kubernetes installs that were not intended to be
  public
- Non-identifying workload metadata (e.g. UIDs, creationTimestamps,
  resourceVersions)

#### Low

"Medium" attacks are downgraded to "Low" when there is a straight-forward
mitigation and the attack requires quite a few non-default or very untypical
scenarios to trigger.

##### Tampering

Temporary modification of data in a specific scenario that does not persist.

### Client

"User interaction" can only happen in client-driven scenario.

Using `kubectl` or a client library are considered user interaction.

The target is a user or user's computer in these scenarios.

The effect of user interaction is not one level reduction in severity,
but is a reduction in severity in certain circumstances where user interaction
is required.

The distinction exists to help differentiate
fast-spreading and wormable attacks from those where because
the user interacts, the attack is slowed down.

#### Critical

Network worms or _unavoidable_ cases where the client is "compromised" without
warnings or prompts.

##### Elevation of privilege

The ability to either execute arbitrary code or obtain more privilege than
authorized. This includes all write access violations.

- [Remote Anonymous User](#remote-anonymous-user)
    - Unauthorized access. Examples:
        - read, write, and delete access to sensitive API objects
        - arbitrary writing/reading/deletion to/from the file system
    - Execution of arbitrary code (remote code execution on the client's system)

##### Information disclosure (targeted)

Cases where the attacker can locate and read information from anywhere on the
system, including system information that was not intended or designed to be
exposed.

- [Remote Anonymous User](#remote-anonymous-user)
    - Unauthorized access. Examples:
        - Personally identifiable information (PII) disclosure (email addresses, local data)
        - Client "phone-ing home" without permission

#### High

Non-default critical scenarios or cases where mitigations exist that can help
prevent critical scenarios.

##### Denial of service

System corruption DoS requires re-installation of system and/or components.

Examples:

- Calling a `kubectl` command makes the local machine unbootable.

##### Elevation of privilege

The ability to either execute arbitrary code or obtain more privilege than
authorized. This includes all write access violations.

- [Authenticated User](#authenticated-user)
    - Unauthorized access. Examples:
        - arbitrary writing/deletion on the file system,
          where the user should not have the ability to do so
        - reading or writing to API objects where the user should not be able
          to
        - local low privilege user can elevate themselves to another user,
          administrator, or local system.
    - Execution of arbitrary code (remote code execution via the client)

Breaking or bypassing any security feature provided. A vulnerability in a
security feature is rated “High” by default, but the rating may be adjusted
based on other considerations as documented here.

Examples:
- Disabling or bypassing a RBAC without informing users or gaining consent
- Reconfiguring RBAC without consent

##### Tampering

Modification of any user data or data used to make trust decisions
in a common or default scenario where the modification persists.
This includes permanent or persistent modification of any user or system data
used in a common or default scenario.

Examples:

- Modification of application data files such as `~/.kube` in a specific
  scenario
- Modification of cluster or objects without user consent in a specific scenario

#### Medium

##### Tampering

Modification of any user data or data used to make trust decisions
in a specific scenario where the modification persists.
This includes permanent or persistent modification of any user or system data
used in a specific scenario.

Examples:

- Modification of application data files such as `~/.kube` in a specific scenario
- Modification of cluster or objects without user consent in a specific scenario

#### Low

##### Denial of service

Temporary DoS requires restart of the client application.

Example:

- Running a `kubectl` command crashes itself or the API server in a way that is
  recoverable.

##### Tampering

Temporary modification of data in a specific scenario that does not persist.

### Glossary

#### Adjacent Network Access

On the private network. They can access internal IP addresses.

#### Authenticated User

An authenticated user can be:

- Unprivileged: authenticated, but with no privileges
- Privileged: authenticated, with some privileges

#### Local Access

On the same physical host (or VM).

#### Remote Anonymous User

Remote implies from an arbitrary network location. The attacker can only access
externally exposed, public facing IP addresses.

Anonymous implies the attacker requires no credentials or Authentication.

#### High Value Asset

A mission critical component such that if/when it has failed the entire cluster
is unusable. For example, if the master services/nodes are
unreachable or in a failure mode, the entire cluster is basically unusable.

#### Service Failure

Failure in such a way that the system/service requires intervention from
a human operator to recover.
