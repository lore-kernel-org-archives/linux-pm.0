From: Daniel Drake <dsd@laptop.org>
Subject: Re: Trying to understand new wakeup events architecture
Date: Thu, 13 Jan 2011 20:01:48 +0000
Message-ID: <1294948908.2228.11.camel@polyethylene>
References: <Pine.LNX.4.44L0.1101131154350.2022-100000@iolanthe.rowland.org>
	<201101132034.49522.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101132034.49522.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-01-13 at 20:34 +0100, Rafael J. Wysocki wrote:
> It looks like Daniel wants the wakeup events framework to store the last
> active wakeup source information somewhere (eg. in a file in /sys/power).
> I'm a little bit worried about that, because potentially there may be many
> wakeup events occuring at run time, in which case it would be a significant
> performance overhead to update the "last active wakeup source" info every
> time (and a scalability issue, because every code path handling a wakeup
> source would want to update the same sysfs file).  Also, collecting that
> information at run time doesn't seem to be particularly useful.

This was one thing that confused me reading about the wakeup events
architecture, and I'm still not entirely clear.

Your definition of "wakeup event" is an event that happens, during
regular system operation, that should prevent the system from going to
sleep. Is that accurate?

When I refer to "wakeup event" I'm referring exclusively to events that
happen when the system is suspended, that cause it to wake up and resume
operation.

> It may be useful to know what device has actually woken up the system from
> suspend.  To that end, I think the only really valid approach is to retrieve
> this information from the platform firmware early during resume and export
> it through a sysfs attribute afterwards.  We can develop a generic helper
> code for that second part, but the first one has to be platform-specific.
> 
> Daniel, what exactly does your user space use this information for?

We're talking the same language here. I'd welcome a generic helper.

There are several different cases, but here is one example that should
be illustrative:

1) System is idle, hence it goes to sleep with display on, with rtcwake
timer for 5 minutes in the future, as well as various other wakeup
sources active (keyboard, mouse, network, ...)

2) 5 minutes passes and system resumes. Userspace determines that the
wakeup source was the RTC alarm. In other words, the system is still
idle. Since the user doesn't seem to be doing anything and might not
even be watching, we dim the screen a bit to save some power. Then we go
back to sleep.

3) A few minutes later, the user starts typing. The system resumes.
Userspace checks the wakeup reason, notes that it was woken up due to
local user activity. So the display is restored to normal brightness.
The idle-check timer is started again, ready to go to sleep a minute or
so after user inactivity.




an alternative case for #3 is:

3b) A few minutes later, a network packet is received for the system.
The system resumes. Userspace checks the wakeup reason, notes that it
was woken up due to network activity. The brightness is *not* changed,
since if it were, it would appear very strange to anyone watching. The
system goes back to sleep within a few seconds, assuming that the user
is not present means that theres no need to sit around a long time
waiting for input.


Daniel
