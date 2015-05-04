From: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Mon, 4 May 2015 16:30:00 -0700
Message-ID: <CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
References: <1413881397.30379.7.camel@hadess.net>
	<CAOesGMg6UBuF=OJ-JdAUx-sD5MnLL8+Ag=xeJFmr-Dxezti2YA@mail.gmail.com>
	<CAJFHJrp8R+Na73W2Jx6BJ+JnHTGZfd61d+EracgehS+ZQoZOcg@mail.gmail.com>
	<286173531.vzKW1UoxJJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:35733 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbEDXaB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 19:30:01 -0400
Received: by qcbgu10 with SMTP id gu10so39832875qcb.2
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2015 16:30:01 -0700 (PDT)
In-Reply-To: <286173531.vzKW1UoxJJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Mon, May 4, 2015 at 3:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, April 30, 2015 11:54:51 AM Chirantan Ekbote wrote:
>> On Thu, Apr 30, 2015 at 10:23 AM, Olof Johansson <olof@lixom.net> wrote:
>> > Hi,
>> >
>> > On Thu, Apr 30, 2015 at 10:10 AM, John Stultz <john.stultz@linaro.org> wrote:
>> >> On Thu, Apr 30, 2015 at 9:25 AM, Bastien Nocera <hadess@hadess.net> wrote:
>> >>> On Tue, 2014-10-21 at 10:04 -0700, John Stultz wrote:
>
> Thanks for CCin me, John!
>
> Let's also CC linux-pm as the people on that list may be generally interested
> in this thread.
>
>> >>>> On Tue, Oct 21, 2014 at 1:49 AM, Bastien Nocera <hadess@hadess.net>
>> >>>> wrote:
>> >>>> > Hey,
>> >>>> >
>> >>>> > GNOME has had discussions with kernel developers in the past, and,
>> >>>> > fortunately, in some cases we were able to make headway.
>> >>>> >
>> >>>> > There are however a number of items that we still don't have
>> >>>> > solutions
>> >>>> > for, items that kernel developers might not realise we'd like to
>> >>>> > rely
>> >>>> > on, or don't know that we'd make use of if merged.
>> >>>> >
>> >>>> > I've posted this list at:
>> >>>> > https://wiki.gnome.org/BastienNocera/KernelWishlist
>> >>>> >
>> >>>> > Let me know on-list or off-list if you have any comments about
>> >>>> > those, so
>> >>>> > I can update the list.
>> >>>>
>> >>>> As for: 'Export of "wake reason" when the system wakes up (rtc alarm,
>> >>>> lid open, etc.) and wakealarm (/sys/class/rtc/foo/wakealarm)
>> >>>> documentation'
>> >>>>
>> >>>> Can you expand more on the rational for the need here? Is this for UI
>> >>>> for power debugging, or something else?
>> >>>
>> >>> This is pretty much what I had in mind:
>> >>> https://www.chromium.org/chromium-os/chromiumos-design-docs/lucid-sleep
>> >>>
>> >>> I guess I didn't make myself understood.
>> >>
>> >> My, admittedly quick skim, of that design document seems to suggest
>> >> that lucid sleep would be a new kernel state. That would keep the
>> >> kernel in charge of determining the state transitions (ie:
>> >> SUSPEND-(alarm)->LUCID-(wakelock
>> >> release)->SUSPEND-(alarm)->LUCID-(power-button)->AWAKE). Then it seems
>> >> userspace would be able to query the current state. This avoids some
>> >> of the races I was concerned with trying to detect which irq woke us
>> >> from suspend from userspace.
>> >>
>>
>> Tomeu has been working on making things so that we don't need a new
>> kernel state.
>
> Which is good, because adding a new kernel state like that to the mainline is
> out of the question as far as I'm concerned.
>
>>  Adding him on cc so he can correct me if I say
>> something wrong.  The current idea is to have userspace runtime
>> suspend any unneeded devices before starting a suspend.  This way the
>> kernel will leave them alone at resume.  This behavior already exists
>> in the mainline kernel.  Getting the wakeup reason can be accomplished
>> by having the kernel emit a uevent with the wakeup reason.  This is
>> the only change that would be necessary.
>
> Well, that needs to be thought through carefully in my view, or it will
> always be racy.
>
> You cannot really only rely on wakeup events that have already happened,
> because something requiring you to bring up the full UI may happen at
> any time.  In particular, it may happen when you're about to suspend again.
>
> For this reason, it looks like you need something along the lines of
> the wakeup_count interface, but acting on subsets of devices.
>
> It actually shouldn't be too difficult to split the existing wakeup
> counter into a number of subcounters each tracking a subset of wakeup
> sources and one of them might be used as the "full UI wakeup" condition
> trigger in principle.
>

In the interest of brevity, I didn't go into the design of suspend /
resume in userspace in my last email but it seems like there's no way
around it.

Ignoring lucid sleep for a moment, here is how a regular suspend works
in the power manager.  The power manager sees a suspend request either
because the user has been idle for X amount of time (usually 15
minutes) or the user explicitly requested it by closing the lid.  The
power manager reads the value of /sys/power/wakeup_count and then
announces an imminent suspend to the rest of the system via DBus.
Interested applications (like the network manager and Chrome) will
have registered with the power manager to be informed about this when
they started up.  For example, this is when Chrome would freeze its
renderer processes.  The power manager will now wait for them to
report back their readiness to suspend.  Once all applications have
reported ready (or the maximum timeout occurs), the power manager
performs some final preparations (like setting the resume brightness
for the display).  The last thing the power manager does, right before
writing "mem" to /sys/power/state, is write the wakeup_count that it
read earlier to /sys/power/wakeup_count.  If the write fails, the
power manager considers the suspend attempt failed, reads the new
wakeup_count, and starts a timer (usually 10 seconds) to retry the
suspend.  The same thing happens if the write to /sys/power/state
fails.

It may be the case that the event that incremented the count happened
because a user was trying to cancel the suspend.  The user could have
pressed some keys on the keyboard, touched the trackpad, opened the
lid, pressed the power button, etc, etc.  For the keyboard and
trackpad these events make their way up to Chrome, which sends a user
activity message to the power manager.  This is a message that Chrome
sends to the power manager even during regular activity, up to five
times a second, to prevent the idle timeout from occuring.  When the
power manager sees this user activity message while waiting to retry
the suspend, it cancels the retry and sends out a DBus signal
informing the system that the suspend is now complete.  For events
like opening the lid or pressing the power button, the power manager
monitors those events in /dev/input and simulates a user activity
message from chrome if any of them fire.


Ok so now I can talk about how lucid sleep fits into all of this.  The
power manager only considers a suspend attempt successful if the write
to /sys/power/state was successful.  If the suspend was successful,
the power manager then reads another sysfs file
(/sys/power/wakeup_type in our kernel) to determine if the wakeup
event was user-triggered.  If the event was user-triggered it sends
out a DBus signal announcing the end of the suspend, Chrome thaws its
renderer processes, the full UI comes back up, and the user can start
working.  If the event was _not_ user-triggred (if it was the RTC or
NIC), the power manager sends out a different DBus signal announcing
that the system is in lucid sleep and will re-suspend soon.  It will
then wait for all registered applications to report readiness to
suspend or for the max timeout to expire.

If it so happens that a user interacts with the system while it is in
this state, the power manager detects it via the user activity message
that Chrome sends.  This could be real (keyboard, trackpad) or
simulated (lid, power button).  Either way, the power manager responds
the same way: it announces the end of the suspend, Chrome thaws its
renderers, the full UI comes back up, and the user starts working.  If
there is no user activity and all applications report ready, the power
manager gets ready to suspend the system again.  Since the NIC is now
a wakeup source, the power manager doesn't read the wakeup_count until
after all applications have reported ready because accessing the
network could increment the wakeup_count and cause false positives.

If either the write to /sys/power/wakeup_count or /sys/power/state
fails from lucid sleep, the power manager re-announces that the system
is in lucid sleep and will re-suspend soon.  It's actually a little
smart about this: it will only re-announce lucid sleep if there was a
wakeup_count mismatch or if the write to /sys/power/state returned
EBUSY.  Other failures only trigger a simple retry and no DBus signal.
We do this because these wakeup events may legitimately trigger lucid
sleep.  For example, more packets may arrive from the network or the
RTC may go off and applications don't perform work until they hear
from the power manager that the system is in lucid sleep.  At this
point the power manager is back to waiting for applications to report
ready (or for the retry timer to fire).  This process may repeat
multiple times if we keep getting wakeup events right as the system
tries to re-suspend.


So that was a little long-winded but hopefully I've addressed all your
concerns about potential race conditions in this code.  I simplified a
few bits because would just complicate the discussion but for the most
part this is how the feature works now.  Having the kernel emit a
uevent with the wakeup event type would take the place of the power
manager reading from /sys/power/wakeup_type in this system but
wouldn't really affect anything else.


>> >> That said, the Power Manager section in that document sounds a little
>> >> racy as it seems to rely on asking userspace if suspend is ok, rather
>> >> then using userspace wakelocks, so I'm not sure how well baked this
>> >> doc is.
>
> You cannot be "a little" racy.  Either you are racy, or you aren't.  If you
> are, it's only a matter of time until someone hits the race.  How often
> that will happen depends on how hard the race is to trigger and how many
> users of the feature there are.  Given enough users, quite a number of them
> may be unhappy.
>
>> I'm not sure I understand what you are saying here.  If you're saying
>> that the kernel is asking userspace if suspend is ok, then I can say
>> that that's definitely not the case.  Currently from the kernel's
>> perspective a lucid sleep resume isn't really different from a regular
>> resume.  We have a hack in each driver that we care about that
>> basically boils down to an if statement that skips re-initialization
>> if we are entering lucid sleep.  If userspace tries to access that
>> device in lucid sleep, it just gets an error.  This has actually
>> caused us some headache (see the GPU process section of the doc),
>> which is why we'd like to switch to using the runtime suspend approach
>> I mentioned above.
>
> That's a good plan, because that's the only way you can satisfy all of the
> dependencies that may be involved.
>
>> If instead you're saying that the power manager needs to ask the rest
>> of userspace whether suspend is ok, you can think of the current
>> mechanism as a sort of timed wake lock.  Daemons that care about lucid
>> sleep register with the power manager when they start up.  The power
>> manager then waits for these daemons to report readiness while in
>> lucid sleep before starting another suspend.  So each daemon
>> effectively acquires a wake lock when the system enters lucid sleep
>> and releases the wake lock when it reports readiness to the power
>> manager or the timeout occurs.
>
> I think what John meant was exactly what I said above: You need a race
> free mechanism to verify whether or not it is OK to suspend again (ie.
> whether or not there are any unhandled events that would have woken you up
> had they happened while suspended) when you're about to.  You *also* need
> to be able to determine (in a race free way) whether or not any of them
> require you to bring up the UI.
>
> It looks like your use case is actually more complex than the Android's one. :-)
>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
