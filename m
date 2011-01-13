From: Daniel Drake <dsd@laptop.org>
Subject: Re: Trying to understand new wakeup events architecture
Date: Thu, 13 Jan 2011 20:41:54 +0000
Message-ID: <1294951314.2228.19.camel@polyethylene>
References: <Pine.LNX.4.44L0.1101131526400.2022-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1101131526400.2022-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-01-13 at 15:31 -0500, Alan Stern wrote:
> On Thu, 13 Jan 2011, Daniel Drake wrote:
> 
> > On Thu, 2011-01-13 at 20:34 +0100, Rafael J. Wysocki wrote:
> > > It looks like Daniel wants the wakeup events framework to store the last
> > > active wakeup source information somewhere (eg. in a file in /sys/power).
> > > I'm a little bit worried about that, because potentially there may be many
> > > wakeup events occuring at run time, in which case it would be a significant
> > > performance overhead to update the "last active wakeup source" info every
> > > time (and a scalability issue, because every code path handling a wakeup
> > > source would want to update the same sysfs file).  Also, collecting that
> > > information at run time doesn't seem to be particularly useful.
> > 
> > This was one thing that confused me reading about the wakeup events
> > architecture, and I'm still not entirely clear.
> > 
> > Your definition of "wakeup event" is an event that happens, during
> > regular system operation, that should prevent the system from going to
> > sleep. Is that accurate?
> 
> My understanding (which probably isn't exactly the same as Rafael's) is
> that a "wakeup event" is any event which should either prevent the
> system from going to sleep or should wake up the system if it is
> already asleep.  After all, these are the same events (user typing,
> network packet arriving, alarm firing) -- the only difference is what
> state the system is in when they occur.

OK, that makes it clearer.

> > When I refer to "wakeup event" I'm referring exclusively to events that
> > happen when the system is suspended, that cause it to wake up and resume
> > operation.
> > 
> > > It may be useful to know what device has actually woken up the system from
> > > suspend.  To that end, I think the only really valid approach is to retrieve
> > > this information from the platform firmware early during resume and export
> > > it through a sysfs attribute afterwards.  We can develop a generic helper
> > > code for that second part, but the first one has to be platform-specific.
> > > 
> > > Daniel, what exactly does your user space use this information for?
> > 
> > We're talking the same language here. I'd welcome a generic helper.
> > 
> > There are several different cases, but here is one example that should
> > be illustrative:
> > 
> > 1) System is idle, hence it goes to sleep with display on, with rtcwake
> > timer for 5 minutes in the future, as well as various other wakeup
> > sources active (keyboard, mouse, network, ...)
> > 
> > 2) 5 minutes passes and system resumes. Userspace determines that the
> > wakeup source was the RTC alarm. In other words, the system is still
> > idle. Since the user doesn't seem to be doing anything and might not
> > even be watching, we dim the screen a bit to save some power. Then we go
> > back to sleep.
> > 
> > 3) A few minutes later, the user starts typing. The system resumes.
> > Userspace checks the wakeup reason, notes that it was woken up due to
> > local user activity. So the display is restored to normal brightness.
> > The idle-check timer is started again, ready to go to sleep a minute or
> > so after user inactivity.
> 
> What happens when the system wakes up because more than one event 
> happened?  For example, what if the user starts typing at exactly the 
> same moment as the 5-minute RTC alarm fires? 

I think there is some guarantee that the wakeup source is identifiable.
One of those things has to have happened first, even if they were very
close in time. If it was the keyboard waking up in #2, the keyboard is
presented as the wakeup reason, and the system decides to keep running
for a while, restarting its user inactivity timer for the next suspend
(where we go back to #1).

If the RTC alarm wakes the system but then there is a keypress during
resume, this will get caught by a userspace daemon, returning the system
to "normal state" with the user inactivity timer. If it happens as the
system is going into suspend, the system will go into suspend then will
cause a new immediate system resume with the keyboard identified as the
wakeup source.

There may be some race conditions here, which Rafael's recent
infrastructure work may be on the road to fixing.

Daniel
