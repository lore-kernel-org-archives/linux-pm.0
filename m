From: Pavel Machek <pavel@ucw.cz>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 12 May 2015 00:12:30 +0200
Message-ID: <20150511221230.GE4434@amd>
References: <1413881397.30379.7.camel@hadess.net>
 <286173531.vzKW1UoxJJ@vostro.rjw.lan>
 <CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
 <3237283.HPYFlah0t8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3237283.HPYFlah0t8@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chirantan Ekbote <chirantan@chromium.org>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > If the event was user-triggered it sends
> > out a DBus signal announcing the end of the suspend, Chrome thaws its
> > renderer processes, the full UI comes back up, and the user can start
> > working.  If the event was _not_ user-triggred (if it was the RTC or
> > NIC), the power manager sends out a different DBus signal announcing
> > that the system is in lucid sleep and will re-suspend soon.  It will
> > then wait for all registered applications to report readiness to
> > suspend or for the max timeout to expire.
> 
> First let me say that the "user-triggered" vs "non-user-triggered" distinction
> seems somewhat artificial to me.  All boils down to having a special class
> of wakeup events that are supposed to make the power manager behave differently
> after resuming.  Whether or not they are actually triggered by the user
> doesn't really matter technically.
...
> > So that was a little long-winded but hopefully I've addressed all your
> > concerns about potential race conditions in this code.  I simplified a
> > few bits because would just complicate the discussion but for the most
> > part this is how the feature works now.  Having the kernel emit a
> > uevent with the wakeup event type would take the place of the power
> > manager reading from /sys/power/wakeup_type in this system but
> > wouldn't really affect anything else.
> 
> Which loops back to my previous remark: Things may get ugly if /sys/power/wakeup_type
> doesn't do the right thing (the uevent mechanics you'd like to replace it with
> will really need to do the same, so I'm not quite sure it's worth the effort).
> 
> Namely, it really has to cover all events that might have woken you up and
> happened before stuff has started to be added to the input buffers that Chrome
> cares about.  It is difficult to identify the exact point where that takes place
> in the resume sequence, but it should be somewhere in dpm_resume_end().  Why so?
> Because it really doesn't matter why exactly the system is waking up.  What
> matters is whether or not an event that you should react to by bringing up the
> UI happens *at* *any* *time* between (and including) the actual wakeup and the
> point when you can rely on the input buffers to contain any useful information
> consumable by Chrome.
> 
> This pretty much means that /sys/power/wakeup_type needs to behave almost like
> /sys/power/wakeup_count, but is limited to a subset of wakeup sources.  That's
> why I was talking about splitting the wakeup count.
> 
> So instead of adding an entirely new mechanics for that, why don't you add
> something like "priority" or "weight" to struct wakeup_source and assign
> higher values of that to the wakeup sources associated with the events
> you want to bring up the UI after resume?  And make those "higher-priority"
> wakeup sources use a separate wakeup counter, so you can easily verify if
> any of them has triggered by reading that or making it trigger a uevent if
> you want to?

Does it do all we want? What if one device wants to generate both
"normal" and "higher-priority" wakeup events? (*)

Should not we have normal interface for keyboard (and similar devices)
where we could ask "did something interesting happen while we were
sleeping"? Actually.. maybe the device can queue the events
that happened during sleep, and deliver them after wakeup? If user
pressed key during sleep, you should have key event waiting on
/dev/input/event3...

									Pavel
(*) Ethernet card might be an example. If machine received wake-on-lan
packet, it will want to wake up with screen on. If machine received
normal packet, it might want to process the packet and get back to sleep.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
