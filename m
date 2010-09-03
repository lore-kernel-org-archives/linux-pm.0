From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Thu, 2 Sep 2010 18:54:23 -0700
Message-ID: <AANLkTikug=+ztLCJbxYiyx1U_whLkQ9zsYvEMbV9JyJi__16707.3879660622$1283552289$gmane$org@mail.gmail.com>
References: <AANLkTim7UM80MrwKoAz3hUFrqL2Fbyw6XS=X89PXRc2Q@mail.gmail.com>
	<201009030109.40816.rjw@sisk.pl>
	<AANLkTinbgShA+m3sdXrYAvW7ctCExp+fZv5EMuYSMLiE@mail.gmail.com>
	<201009030235.00270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009030235.00270.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 2, 2010 at 5:35 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, September 03, 2010, Colin Cross wrote:
>> On Thu, Sep 2, 2010 at 4:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Friday, September 03, 2010, Colin Cross wrote:
>> >> On Thu, Sep 2, 2010 at 2:34 PM, Alan Stern <stern@rowland.harvard.edu=
> wrote:
>> >> > On Thu, 2 Sep 2010, Colin Cross wrote:
>> >> >
>> >> >> That would work, but I still don't see why it's better. =A0With ei=
ther
>> >> >> of your changes, the power.completion variable is storing state, a=
nd
>> >> >> not just used for notification. =A0However, the exact meaning of t=
hat
>> >> >> state is unclear, especially during the transition from an aborted
>> >> >> suspend to resume, and the state is duplicating power.status. =A0S=
etting
>> >> >> it to complete in dpm_prepare is especially confusing, because at =
that
>> >> >> point nothing is completed, it hasn't even been started.
>> >> >
>> >> > The state being waited for varies from time to time and is only
>> >> > partially related to power.status. =A0Instead of using a completion=
 I
>> >> > suppose we could have used a new "transition_complete" variable
>> >> > together with a waitqueue. =A0Would you prefer that? =A0It's effect=
ively
>> >> > the same thing as a completion, but without the nice packaging alre=
ady
>> >> > provided by the kernel.
>> >> No, that doesn't change anything. =A0What I'd prefer to see is a
>> >> wait_for_condition on the desired state of the parent. =A0As is,
>> >> power.completion means one thing during suspend (the device has
>> >> started, but not finished, suspending), and a different thing during
>> >> resume (the device has not finished resuming, and may not have started
>> >> resuming). =A0That difference is exactly what caused the bug - the
>> >> completion has to be set on init so that it is set before the device
>> >> starts suspend.
>> >
>> > Not really. =A0The bug is there, because my analysis of the suspend er=
ror code
>> > path was wrong. =A0Sorry about that, but it has nothing to do with the=
 "different
>> > meaning" of the completions during suspend and resume.
>> >
>> > The completions here are simply used to enforce a specific ordering of
>> > operations, nothing more. =A0They have no meaning beyond that.
>>
>> The completion variable maintains state.
>
> So what? =A0Locks also maintain state.
>
>> It has meaning whether or not you want it to. =A0Leaving it as a complet=
ion
>> variable requires that you manage that state, which is difficult conside=
ring
>> there is no documentation and no clear idea in the code of exactly when =
that
>> state is set or clear.
>
> Please run "git show 5af84b82701a96be4b033aaa51d86c72e2ded061" and read t=
he
> changelog. =A0It's described in there quite clearly (I think).
Yes, that is very clear, sorry I didn't see it before.  A simple
description closer to the code would have helped me.

>> It would be much cleaner to use a wait queue, and use
>> wait_on_condition to wait for the device to be in the desired state.
>
> Well, in fact that was used in one version of the patchset that introduced
> asynchronous suspend-resume, but it was rejected by Linus, because it was
> based on non-standard synchronization. =A0The Linus' argument, that I agr=
eed
> with, was that standard snychronization constructs, such as locks or
> completions, were guaranteed to work accross different architectures and =
thus
> were simply _safer_ to use than open-coded synchronization that you seem =
to be
> preferring.
If I'm reading the right thread, that was using rwlocks, not
conditions.  wait_on_condition looks just as cross-architecture as
completions, and is almost as simple.

I look at it like this:  Are you waiting for something to complete, or
are you waiting for something to be in a specific state?  Completion
works great if you know that you will only want to wait after it
starts.  That's not true for an aborted suspend - you may call
dpm_wait on a device that has never started resuming, because it never
suspended.  You can use a completion, and make sure it's state is
right for all the corner cases, but at the end of the day that's not
what you mean.  What you mean is "wait on the device to be resumed",
and that's a condition, not a simple completion event.

> Completions simply allowed us to get the desired behavior with the least
> effort and that's why we used them.
I'm happy with the end result, but I may submit a patch that converts
the completions to conditions for discussion.
