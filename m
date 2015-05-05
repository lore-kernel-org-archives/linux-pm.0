From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 5 May 2015 10:39:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505051027110.1639-100000@iolanthe.rowland.org>
References: <CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chirantan Ekbote <chirantan@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 4 May 2015, Chirantan Ekbote wrote:

> Ok so now I can talk about how lucid sleep fits into all of this.  The
> power manager only considers a suspend attempt successful if the write
> to /sys/power/state was successful.  If the suspend was successful,
> the power manager then reads another sysfs file
> (/sys/power/wakeup_type in our kernel) to determine if the wakeup
> event was user-triggered.  If the event was user-triggered it sends
> out a DBus signal announcing the end of the suspend, Chrome thaws its
> renderer processes, the full UI comes back up, and the user can start
> working.  If the event was _not_ user-triggred (if it was the RTC or
> NIC), the power manager sends out a different DBus signal announcing
> that the system is in lucid sleep and will re-suspend soon.  It will
> then wait for all registered applications to report readiness to
> suspend or for the max timeout to expire.
> 
> If it so happens that a user interacts with the system while it is in
> this state, the power manager detects it via the user activity message
> that Chrome sends.  This could be real (keyboard, trackpad) or
> simulated (lid, power button).  Either way, the power manager responds
> the same way: it announces the end of the suspend, Chrome thaws its
> renderers, the full UI comes back up, and the user starts working.  If
> there is no user activity and all applications report ready, the power
> manager gets ready to suspend the system again.  Since the NIC is now
> a wakeup source, the power manager doesn't read the wakeup_count until
> after all applications have reported ready because accessing the
> network could increment the wakeup_count and cause false positives.

This gives only an implicit description of the difference between
"lucid sleep" and normal resume.  I gather that "lucid sleep" means you
avoid reactivating some parts of the hardware (in particular the parts
used by the renderers), and perhaps also you shorten the inactivity
delay before the next suspend.

Is that right?  The main point of "lucid sleep" is to allow the system 
to do a partial resume, in which some of the most power-hungry parts 
remain suspended?

If that's true then some of the recent work on "direct-complete" may be 
sufficient to do what you want.  See commit f71495f3f0c5 (PM / sleep: 
Update device PM documentation to cover direct_complete) and the 
preceding commits.  The idea is that under some circumstances, devices 
that were in runtime-suspend before a system sleep can remain in 
runtime-suspend when the system wakes up.

If you can force the rendering hardware to go into runtime-suspend when
starting a system suspend, it can remain powered down when the system
wakes up.  Then if it isn't needed for anything (because you suspend
the system again before doing any UI activity), it can remain powered
down the entire time.  No need for a separate "lucid sleep" state.

Alan Stern
