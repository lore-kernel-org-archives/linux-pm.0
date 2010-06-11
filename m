From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: suspend blockers & Android integration
Date: Fri, 11 Jun 2010 16:04:35 -0500
Message-ID: <1276290275.2862.152.camel__27176.2524535463$1276290555$gmane$org@mulgrave.site>
References: <Pine.LNX.4.44L0.1006111638040.19894-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006111638040.19894-100000@netrider.rowland.org>
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
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-06-11 at 16:48 -0400, Alan Stern wrote:
> On Fri, 11 Jun 2010, Mark Brown wrote:
> 
> > On Fri, Jun 11, 2010 at 10:46:27AM -0400, Alan Stern wrote:
> > > On Fri, 11 Jun 2010, James Bottomley wrote:
> > 
> > > > The one thing that does look difficult is that these power constraints
> > > > are device (and sometimes SoC) specific.  Expressing them in a generic
> > > > way for the cpu govenors to make sense of might be hard.
> > 
> > > Doesn't the clock framework already handle this sort of thing?
> > 
> > The clock framework is implemented independantly for each CPU.
> 
> That's not an impediment, since drivers' requirements regarding which 
> clocks remain running in which power states are necessarily 
> platform-dependent also.
> 
> 
> On Fri, 11 Jun 2010, James Bottomley wrote:
> 
> > Well, there are two elements to "this sort of thing":
> > 
> >      1. Allow a driver to request that a given clock not be turned off.
> >      2. Make the cpuidle governors aware of a pending "don't turn off X
> >         clock source" so they can keep the system in a state where the
> >         clock doesn't get powered down.
> > 
> > As far as I can tell from the code, neither currently exists at the
> > moment.
> 
> Well then, can (or should) the clock framework interact with the
> pm-qos subsystem so that drivers don't have to worry about it?

So the implementation of this seems to be a bit complex:  We could have
clockevents_register() do a per clock pm_qos variable but then the
cpuidle governors need to know which to listen for so they don't
transition to a state too low for them to be active if pm_qos says keep
them running.  Even if that gets sorted out, how would USB know which
platform specific clock source is driving the wakeup events on its bus?

How complex can SoC clocksources be?  If it's just a simple binary
do/don't potentially stop all clocks, I think it's easy.  If SoC's have
a hierarchical shutdown sequence, and they really need this to save
power, then expressing that generically becomes rather problematic.

James
