From: david singleton <dsingleton@mvista.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Sun, 13 Aug 2006 20:37:50 -0700
Message-ID: <639639c86947b32632c5bb9868d25240@mvista.com>
References: <44D8D40F.50005@mvista.com>
	<bb52214749a48f317fba09eb522537bb@nomadgs.com>
	<5da81756733c335565f969bab0c9b934@mvista.com>
	<26d93dc005e384544d9ea702baa4a4af@nomadgs.com>
	<acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
	<ea3ff079538ac1f02dd4c7ec48953146@nomadgs.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <ea3ff079538ac1f02dd4c7ec48953146@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Aug 12, 2006, at 4:14 PM, Matthew Locke wrote:

>
> On Aug 12, 2006, at 1:07 AM, Vitaly Wool wrote:
>> May I disagree? Having an alternative implementation is never a bad
>> thing, unless the sides are unable to co-operate ;)
>> Let's try to compare implementations and their concepts, and benefit =

>> from both.
>
> What are you disagreeing with?  Re-read my statement below.   I don't =

> see the reason for another implementation.  Rather than guess,  I =

> would prefer that Dave tell us why he is submitting a different =

> powerop interface.  There must be something driving him to do so.

Okay, let me see if I can clarify a bit.  I presented the alternative
implementation to compare and contrast ideas, and because I believe this
implementation is a better solution for the following reasons:

I believe this interface between the kernel and user space is cleaner.  =

The
system presents the list of supported operating points to the user and =

the
user invokes them by their name.

/sys/power/state is used for setting and displaying the current =

operating point
and /sys/power/supported_states presents the names of the supported =

operating
points to the user.  That's the entire user interface.

I believe the moving of policies, classes and governors out of the =

kernel
and into user space is a better solution.  The user, or power manager =

daemon,
should make the decisions about when and what operating point to set, =

and
which devices to suspend or resume.

The user does not pass in information needed to construct an operating =

point
and let the kernel try and validate the data and protect against =

incorrect
or malicious data that would hang the system.  Operating points are =

constructed
from the hardware vendor supplied data sheets and validated, just like =

cpufreqs,
and tested before the code is integrated into the mainstream.

I believe the architecture independent interface between the kernel and
powerop framework is better and I believe the architecture =

dependent/board
specific interface  is better because:

The entire design revolves around operating points and operating points
can be encapsulated into two data structures and three functions.  The =

powerop
structure contains the architecture independent data and function =

pointers
to the platform dependent routines to transition to the operating point.
The md_data pointer in the powerop structure points to any kind of =

platform
specific data needed by the transition routines.

The platform dependent interface not only lets each platform have its =

own
information and functions for operating state transition, but it also =

lets
individual operating points on the same platform have operating point
specific data and functions.

By encapsulating an operating point into two data structures new =

operating
points can easily be constructed.

Lets consider for a moment the case where Intel creates a new revision =

of the
pxa27x processor for the mainstone.  To implement support for the new =

processor
one would only have to create a set of powerop structures and md_opt =

structures
that contain the information for the new processor's operating points.

The next step would be to insert the new processor identification into
the case statement where the system deteremines the processor id and the
new operating points would be linked into the system you'd be done
implementing a new set of operating points for a new processor.

This would take a matter of hours to create and test new operating =

points
instead of days or weeks.  And with the dynamic on-the-fly loadable =

module
for an operating points creation and testing of new processors would
take a very short time, something the SoC manufacturers might like.

And by doing the mainstone patch wthout having to change any of the =

framework
or interfaces I've convinced myself that the concept, framework and =

interfaces
will work across different architectures and platforms.

Its simple but enormously flexible.


David



>
>>> Is there
>>> something specific missing or wrong with the patches we submitted =

>>> that
>>> required another set of patches to be developed?  By joining in the
>>> discussion, I mean that you should let us know this information.  If
>>> patches are your method for doing so, then at least provide a
>>> description of what your patches address that ours does not.  Right
>>> now, its just unclear why there are two different powerop patchsets.
>>>
>
> Matt
>
