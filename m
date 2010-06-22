From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update] Re: [RFC][PATCH] PM: Avoid losing wakeup
	events during suspend
Date: Tue, 22 Jun 2010 23:41:15 +0200
Message-ID: <201006222341.15605.rjw__18540.9550824717$1277243123$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006221623130.1322-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006221623130.1322-100000@iolanthe.rowland.org>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 22, 2010, Alan Stern wrote:
> On Tue, 22 Jun 2010, Rafael J. Wysocki wrote:
> 
> > Anyway, below's an update that addresses this particular case.
> > 
> > It adds two more functions, pm_wakeup_begin() and pm_wakeup_end()
> > that play similar roles to suspend_block() and suspend_unblock(), but they
> > don't operate on suspend blocker objects.  Instead, the first of them increases
> > a counter of events in progress and the other one decreases this counter.
> > Together they have the same effect as pm_wakeup_event(), but the counter
> > of wakeup events in progress they operate on is also checked by
> > pm_check_wakeup_events().
> > 
> > Thus there are two ways kernel subsystems can signal wakeup events.  First,
> > if the event is not explicitly handed over to user space and "instantaneous",
> > they can simply call pm_wakeup_event() and be done with it.  Second, if the
> > event is going to be delivered to user space, the subsystem that processes
> > the event can call pm_wakeup_begin() right when the event is detected and
> > pm_wakeup_end() when it's been handed over to user space.
> 
> Or if the event is going to be handled entirely in the kernel but over
> a prolonged period of time.
> 
> > Please tell me what you think.
> 
> I like it a lot.  It addresses the main weakness in the earlier 
> version.  With this, you could essentially duplicate the in-kernel part 
> of the wakelocks/suspend blockers stuff.  All except the timed 
> wakelocks -- you might want to consider adding a 
> pm_wakeup_begin_timeout() convenience routine.

That may be added in future quite easily if it really turns out to be necessary.
IIRC Arve said Android only used timeouts in user space wakelocks, not in the
kernel ones.

> Here's another possible enhancement (if you can figure out a way to do
> it without too much effort): After a suspend begins, keep track of the
> first wakeup event you get.  Then when the suspend is aborted, print a
> log message saying why and indicating which device was responsible for
> the wakeup.

Good idea, but I'd prefer to add it in a separate patch not to complicate
things too much to start with.

> One little thing: You have the PCI subsystem call pm_wakeup_event().  
> If the driver then wants to call pm_wakeup_begin(), the event will get 
> counted twice.  I guess this doesn't matter much, but it does seem 
> peculiar.

Knowing that the PCI core has increased the wakeup count of its device, a
PCI driver may simply use pm_wakeup_begin(NULL) and that will only cause
the main counter to be increased in the end.  Which kind of makes sense,
because in that case there really is a sequence of events.  First, the PCI core
detects a wakeup signal and requests wakeup so that the driver has a chance
to access the device and get the event information from it (although at this
point it is not known whether or not the driver will need to do that).  Second,
the driver requests that the system stay in the working state, because it needs
time to process the event data and (presumably) hand it over to user space.
The device has only signaled wakeup once, though, and that should be recorded.

BTW, I thought I would make pm_get_wakeup_count() and pm_save_wakeup_count()
fail if they are called when events_in_progress is nonzero.  For
pm_save_wakeup_count() that's pretty obvious (I think) and it also kind of
makes sense for pm_get_wakeup_count(), because that will tell the reader of
/sys/power/wakeup_count that the value is going to change immediately so it
should really try again.

Rafael
