From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 10:44:15 +0200
Message-ID: <20100528104415.1403541a__14417.2779786915$1275036309$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
	<20100527173118.GE2468@srcf.ucam.org>
	<alpine.LFD.2.00.1005271959450.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005271959450.3032@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 20:05:39 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 27 May 2010, Matthew Garrett wrote:
> 
> > On Thu, May 27, 2010 at 07:24:02PM +0200, Thomas Gleixner wrote:
> > 
> > > Oh no. They paper over a short coming. If there is a pending event,
> > > the kernel knows that. It just does not make use of this
> > > information. Blockers just paper over this by sprinkling
> > > do_not_suspend() calls all over the place. What a sensible solution.
> > 
> > Even if we could use suspend-via-deep-idle-state on PCs, we still need 
> > to be able to enter suspend while the system isn't idle. There's two 
> > ways to do that:
> > 
> > 1) Force the system to be idle. Doing this race-free is difficult.
> > 
> > 2) Enter suspend even though the system isn't idle. Since we can't rely 
> > on the scheduler, we need drivers to know whether userspace has consumed 
> > all wakeup events before allowing the transition to occur. Doing so 
> > requires either in-kernel suspend blockers or something that's almost 
> > identical.
> 
> You're just not getting it. If user space has consumed the event is
> not relevant at all.
> 
> What's relevant is whether the app has processed the event and reacted
> accordingly. That's all that matters.
> 
> Emptying your input queue is just the wrong indicator.
> 
> And as I explained several times now: It does _NOT_ matter when the
> app goes back in to blocked/idle state. You have to spend the CPU
> cycles and power for that anyway.
> 
> And for the apps which do not use the user space blockers the queue
> empty indicator is just bullshit, because after emptying the queue the
> kernel can go into suspend w/o any guarantee that the event has been
> processed.
> 
> The whole concept sucks, as it does not solve anything. Burning power
> now or in 100ms is the same thing power consumption wise.
> 
> Thanks,
> 
> 	tglx

Thomas,
do you really have a problem with the actual concept? Or do you just
don't like the way it is done?

IMO, the whole concept is defining 2 modes of operation: 

1. user interacts with the device (at least one suspend block active)
2. user doesn't interact with the device (zero suspend block active)

In case 1. the device wants _everything_ sheduled as normal (and save
maximum possible power, i.e. runtime pm with every technology available
now).

In case 2. we want nothing sheduled (and save maximum possible power,
i.e. suspend)

And now, every application and every kernel driver annotates (on behalve
of the user) if it (possibly) interacts with the user. 

(Is this really the problematic bit, that userspace is giving
the kernel hints? Or is it that the hints are called "blocker"?)

We can only enter mode 2, if _nothing_ (claims) to interact with the
user.

To integrate this with the current way of doing things, i gathered it 
needs to be implemented as an idle-state that does the suspend()-call?

Attributes of the idle states could be smth like this:

c3
	cost-to-transition-to-this-state: X 
	powersavings-per-time: Y
	expected time we stay in this state: relative short, there is a
		timer sheduled
	suspend-blockers: ignored

suspend 
	cost-to-transition-to-this-state: depends, how much drivers to
	suspend, how much processes to freeze, how much state to save
	powersavings-per-time: Y
	expected time we stay in this state: long, independent of
		sheduled timers
	suspend-blockers: must not be activated


Now all transitions and opportunistic suspend could be handled by the
same algorithms.

Would this work?


Cheers,
Flo
