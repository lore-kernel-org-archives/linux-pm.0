From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Fri, 08 May 2015 01:19:03 +0200
Message-ID: <2402538.bT0K8AQd1i@vostro.rjw.lan>
References: <1413881397.30379.7.camel@hadess.net> <3237283.HPYFlah0t8@vostro.rjw.lan> <CAJFHJrrdk07AvXz=UFL+LhuaSucBXfLCrcCR3ZLYWzgNfLTDmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63123 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751068AbbEGWx7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 18:53:59 -0400
In-Reply-To: <CAJFHJrrdk07AvXz=UFL+LhuaSucBXfLCrcCR3ZLYWzgNfLTDmw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chirantan Ekbote <chirantan@chromium.org>
Cc: John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, May 06, 2015 10:40:53 AM Chirantan Ekbote wrote:
> On Tue, May 5, 2015 at 4:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, May 04, 2015 04:30:00 PM Chirantan Ekbote wrote:
> >
> > <snip>
> >
> >> Ok so now I can talk about how lucid sleep fits into all of this.  The
> >> power manager only considers a suspend attempt successful if the write
> >> to /sys/power/state was successful.  If the suspend was successful,
> >> the power manager then reads another sysfs file
> >> (/sys/power/wakeup_type in our kernel) to determine if the wakeup
> >> event was user-triggered.
> >
> > Well, that's where things are likely to get ugly depending on how the
> > /sys/power/wakeup_type attribute works (more below).
> >
> >> If the event was user-triggered it sends
> >> out a DBus signal announcing the end of the suspend, Chrome thaws its
> >> renderer processes, the full UI comes back up, and the user can start
> >> working.  If the event was _not_ user-triggred (if it was the RTC or
> >> NIC), the power manager sends out a different DBus signal announcing
> >> that the system is in lucid sleep and will re-suspend soon.  It will
> >> then wait for all registered applications to report readiness to
> >> suspend or for the max timeout to expire.
> >
> > First let me say that the "user-triggered" vs "non-user-triggered" distinction
> > seems somewhat artificial to me.  All boils down to having a special class
> > of wakeup events that are supposed to make the power manager behave differently
> > after resuming.  Whether or not they are actually triggered by the user
> > doesn't really matter technically.
> >
> 
> This is true.  It's just easier to talk about them as user-triggered
> or not.  For reference, [1] and [2] are the patches that implement
> wakeup_type in our kernel.
> 
> >> If it so happens that a user interacts with the system while it is in
> >> this state, the power manager detects it via the user activity message
> >> that Chrome sends.  This could be real (keyboard, trackpad) or
> >> simulated (lid, power button).  Either way, the power manager responds
> >> the same way: it announces the end of the suspend, Chrome thaws its
> >> renderers, the full UI comes back up, and the user starts working.  If
> >> there is no user activity and all applications report ready, the power
> >> manager gets ready to suspend the system again.  Since the NIC is now
> >> a wakeup source, the power manager doesn't read the wakeup_count until
> >> after all applications have reported ready because accessing the
> >> network could increment the wakeup_count and cause false positives.
> >>
> >> If either the write to /sys/power/wakeup_count or /sys/power/state
> >> fails from lucid sleep, the power manager re-announces that the system
> >> is in lucid sleep and will re-suspend soon.  It's actually a little
> >> smart about this: it will only re-announce lucid sleep if there was a
> >> wakeup_count mismatch or if the write to /sys/power/state returned
> >> EBUSY.  Other failures only trigger a simple retry and no DBus signal.
> >> We do this because these wakeup events may legitimately trigger lucid
> >> sleep.  For example, more packets may arrive from the network or the
> >> RTC may go off and applications don't perform work until they hear
> >> from the power manager that the system is in lucid sleep.  At this
> >> point the power manager is back to waiting for applications to report
> >> ready (or for the retry timer to fire).  This process may repeat
> >> multiple times if we keep getting wakeup events right as the system
> >> tries to re-suspend.
> >>
> >>
> >> So that was a little long-winded but hopefully I've addressed all your
> >> concerns about potential race conditions in this code.  I simplified a
> >> few bits because would just complicate the discussion but for the most
> >> part this is how the feature works now.  Having the kernel emit a
> >> uevent with the wakeup event type would take the place of the power
> >> manager reading from /sys/power/wakeup_type in this system but
> >> wouldn't really affect anything else.
> >
> > Which loops back to my previous remark: Things may get ugly if /sys/power/wakeup_type
> > doesn't do the right thing (the uevent mechanics you'd like to replace it with
> > will really need to do the same, so I'm not quite sure it's worth the effort).
> >
> > Namely, it really has to cover all events that might have woken you up and
> > happened before stuff has started to be added to the input buffers that Chrome
> > cares about.  It is difficult to identify the exact point where that takes place
> > in the resume sequence, but it should be somewhere in dpm_resume_end().  Why so?
> > Because it really doesn't matter why exactly the system is waking up.  What
> > matters is whether or not an event that you should react to by bringing up the
> > UI happens *at* *any* *time* between (and including) the actual wakeup and the
> > point when you can rely on the input buffers to contain any useful information
> > consumable by Chrome.
> >
> 
> So this is something that we don't catch right now.  Our
> implementation queries the firmware via an ACPI call to get the wakeup
> source and I was assuming that any events after that *would*
> eventually make their way up to Chrome or userspace.  But based on
> what you are saying, it seems like we do drop any events that occur
> between the wakeup and the time when the input buffers contain useful
> information.
> 
> I'm guessing that this window is pretty small though and when we do
> end up missing an event, we can consider ourselves lucky because the
> typical user reaction when their computer doesn't wake up is to start
> pressing random keys on the keyboard and we would definitely catch
> those.

That is, provided that the "user" actually is a human at the keyboard which
need not be the case in the general situation.

> > This pretty much means that /sys/power/wakeup_type needs to behave almost like
> > /sys/power/wakeup_count, but is limited to a subset of wakeup sources.  That's
> > why I was talking about splitting the wakeup count.
> >
> > So instead of adding an entirely new mechanics for that, why don't you add
> > something like "priority" or "weight" to struct wakeup_source and assign
> > higher values of that to the wakeup sources associated with the events
> > you want to bring up the UI after resume?  And make those "higher-priority"
> > wakeup sources use a separate wakeup counter, so you can easily verify if
> > any of them has triggered by reading that or making it trigger a uevent if
> > you want to?
> >
> >
> 
> Sounds good to me.

OK

So I can prototype high-level support for that in the wakeup sources framework.

In addition to that we would need to ensure that the wakeup sources would be
activated in response to the wakeup interrupts handled by the IRQ core between
suspendind and resuming device IRQs.  That is slightly less straightforward
than one might think, but should be doable.

Would you be interested in that?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
