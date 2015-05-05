From: Bastien Nocera <hadess@hadess.net>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 05 May 2015 12:46:40 +0200
Message-ID: <1430822800.7954.5.camel@hadess.net>
References: <1413881397.30379.7.camel@hadess.net>
	 <CAOesGMg6UBuF=OJ-JdAUx-sD5MnLL8+Ag=xeJFmr-Dxezti2YA@mail.gmail.com>
	 <CAJFHJrp8R+Na73W2Jx6BJ+JnHTGZfd61d+EracgehS+ZQoZOcg@mail.gmail.com>
	 <286173531.vzKW1UoxJJ@vostro.rjw.lan>
	 <CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37798 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbEEKqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 06:46:45 -0400
In-Reply-To: <CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chirantan Ekbote <chirantan@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Mon, 2015-05-04 at 16:30 -0700, Chirantan Ekbote wrote:
> 
<snip>
> In the interest of brevity, I didn't go into the design of suspend /
> resume in userspace in my last email but it seems like there's no way
> around it.
> 
> Ignoring lucid sleep for a moment, here is how a regular suspend 
> works
> in the power manager.  The power manager sees a suspend request 
> either
> because the user has been idle for X amount of time (usually 15
> minutes) or the user explicitly requested it by closing the lid.  The
> power manager reads the value of /sys/power/wakeup_count and then
> announces an imminent suspend to the rest of the system via DBus.
> Interested applications (like the network manager and Chrome) will
> have registered with the power manager to be informed about this when
> they started up.  For example, this is when Chrome would freeze its
> renderer processes.  The power manager will now wait for them to
> report back their readiness to suspend.  Once all applications have
> reported ready (or the maximum timeout occurs), the power manager
> performs some final preparations (like setting the resume brightness
> for the display).

logind in systemd also does this, using block or delay inhibitors over
D-Bus:
http://www.freedesktop.org/wiki/Software/systemd/inhibit/

>   The last thing the power manager does, right before
> writing "mem" to /sys/power/state, is write the wakeup_count that it
> read earlier to /sys/power/wakeup_count.  If the write fails, the
> power manager considers the suspend attempt failed, reads the new
> wakeup_count, and starts a timer (usually 10 seconds) to retry the
> suspend.  The same thing happens if the write to /sys/power/state
> fails.

Is this something that logind should do as well?

> It may be the case that the event that incremented the count happened
> because a user was trying to cancel the suspend.  The user could have
> pressed some keys on the keyboard, touched the trackpad, opened the
> lid, pressed the power button, etc, etc.  For the keyboard and
> trackpad these events make their way up to Chrome, which sends a user
> activity message to the power manager.  This is a message that Chrome
> sends to the power manager even during regular activity, up to five
> times a second, to prevent the idle timeout from occuring.  When the
> power manager sees this user activity message while waiting to retry
> the suspend, it cancels the retry and sends out a DBus signal
> informing the system that the suspend is now complete.  For events
> like opening the lid or pressing the power button, the power manager
> monitors those events in /dev/input and simulates a user activity
> message from chrome if any of them fire.
> 
> 
> Ok so now I can talk about how lucid sleep fits into all of this. 
>  The
> power manager only considers a suspend attempt successful if the 
> write
> to /sys/power/state was successful.  If the suspend was successful,
> the power manager then reads another sysfs file
> (/sys/power/wakeup_type in our kernel) to determine if the wakeup
> event was user-triggered.

This is where your lucid sleep implementation matches up with what I
had in mind for that wishlist.

>   If the event was user-triggered it sends
> out a DBus signal announcing the end of the suspend, Chrome thaws its
> renderer processes, the full UI comes back up, and the user can start
> working.  If the event was _not_ user-triggred (if it was the RTC or
> NIC), the power manager sends out a different DBus signal announcing
> that the system is in lucid sleep and will re-suspend soon.  It will
> then wait for all registered applications to report readiness to
> suspend or for the max timeout to expire.
> 
> If it so happens that a user interacts with the system while it is in
> this state, the power manager detects it via the user activity 
> message
> that Chrome sends.  This could be real (keyboard, trackpad) or
> simulated (lid, power button).  Either way, the power manager 
> responds
> the same way: it announces the end of the suspend, Chrome thaws its
> renderers, the full UI comes back up, and the user starts working. 
>  If
> there is no user activity and all applications report ready, the 
> power
> manager gets ready to suspend the system again.  Since the NIC is now
> a wakeup source, the power manager doesn't read the wakeup_count 
> until
> after all applications have reported ready because accessing the
> network could increment the wakeup_count and cause false positives.
> 
> If either the write to /sys/power/wakeup_count or /sys/power/state
> fails from lucid sleep, the power manager re-announces that the 
> system
> is in lucid sleep and will re-suspend soon.  It's actually a little
> smart about this: it will only re-announce lucid sleep if there was a
> wakeup_count mismatch or if the write to /sys/power/state returned
> EBUSY.  Other failures only trigger a simple retry and no DBus 
> signal.
> We do this because these wakeup events may legitimately trigger lucid
> sleep.  For example, more packets may arrive from the network or the
> RTC may go off and applications don't perform work until they hear
> from the power manager that the system is in lucid sleep.  At this
> point the power manager is back to waiting for applications to report
> ready (or for the retry timer to fire).  This process may repeat
> multiple times if we keep getting wakeup events right as the system
> tries to re-suspend.
> 
> 
> So that was a little long-winded but hopefully I've addressed all 
> your
> concerns about potential race conditions in this code.  I simplified 
> a
> few bits because would just complicate the discussion but for the 
> most
> part this is how the feature works now.  Having the kernel emit a
> uevent with the wakeup event type would take the place of the power
> manager reading from /sys/power/wakeup_type in this system but
> wouldn't really affect anything else.

Could you or Tomeu explain the driver changes that are necessary? Do
only drivers that we want to be usable as wakeup sources need to be
changed? Do you have examples of such a patch?

Cheers

