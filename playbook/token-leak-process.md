# GitHub Token Leak Response Process

The SRC may become aware that a Kubernetes Org member has leaked a GitHub token. Because Org membership can confer privileges, it is important to ensure leaked GitHub tokens are revoked. This process describes how to do so.

## Investigate

* Thank the reporter -- they have done us a kindness by letting us know about the problem
* If you can, get the first few characters of the leaked token in case GitHub support needs it for revocation
* Check to see if the user is an OWNER - an OWNER token leak would be more severe than that of an ordinary Org member
    * https://cs.k8s.io/?i=fosho&files=OWNERS&q=the-user-name-goes-here

## Contact

* Contact the user via email, letting them know about the token leak
>Dear `USER`,
>
>We were recently notified that a personal GitHub token has been leaked (say a little about how the token was leaked, if possible. e.g. "via CI logs visible on https://example.net/ci-logs").
>
>Please revoke the leaked GitHub token, to protect yourself and your projects. Let us know if you need any further information.
>
>Best,
>
>`YOUR NAME HERE`  
>Kubernetes SRC
* If the user is an OWNER or might have other privileged roles in the project, contact a ContribEx chair or Steering to discuss whether further incident response is needed
* Contact a GitHub admin to submit a support ticket asking for the token to be revoked. They should cc our contacts there, who will escalate with the term “3rd party revocation”
## Followup
* Perform any necessary incident response as identified with the SRC, ContribEx, and Steering
