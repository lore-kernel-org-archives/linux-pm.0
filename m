From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 01:38:30 +0200
Message-ID: <201006050138.30859.rjw__34681.2208802023$1275694712$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275644619.27810.39462.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 04 June 2010, Peter Zijlstra wrote:
> On Fri, 2010-06-04 at 01:23 +0200, Ingo Molnar wrote:
> > Btw., i'd like to summarize the scheduler based suspend scheme proposed by
> > Thomas Gleixner, Peter Zijlstra and myself. I found no good summary of it in
> > the big thread, and there are also new elements of the proposal:
> 
> Just to clarify, my proposition doesn't go much further than treating
> 'suspend' as a genuine idle state (on suitable hardware, which x86 isn't).
> 
> > - Create a 'deep idle' mode that suspends. This, if all constraints
> >    are met, is triggered by the scheduler automatically: just like the other
> >    idle modes are triggered currently. This approach fixes the wakeup
> >    races because an incoming wakeup event will set need_resched() and
> >    abort the suspend.
> >
> 
> Right, so 'suspend' as idle seems (at least on UP/arm) a very sensible
> idea.  On SMP current suspend hot-unplugs all but the boot cpu, I'm not
> sure we need to do that, since if the system is genuinely idle, what races
> are there?
> 
> And if its not idle...
> 
> >   ( This mode can even use the existing suspend code to bring stuff down,
> >      therefore it also solves the pending timer problem and works even on
> >      PC style x86. )
> 
> You cannot solve the pending timer issue from idle, unless you allow idle
> to stop clock_monotonic, which would change idle semantics, and that is not
> something I can say is a good idea.
> 
> You want all idle states to have the same semantics, otherwise things just
> get way too confusing.
> 
> > - Solve crappy app confinement via the scheduler:
> >
> >    A first proposal was to use the existing cgroup mechanism,
> 
> I still believe containment is a cgroup problem.

I kind of agree here, so I'd like to focus a bit on that.

Here's my idea in the very general terms:

(1) Use the cgroup freezer to "suspend" the "untrusted" apps (ie. the ones
    that don't use suspend blockers aka wakelocks in the Android world) at the
    point Android would normally start opportunistic suspend.

(2) Allow the cpuidle framework to put CPUs into low-power states after the
    "trusted" apps (ie. the ones that use suspend blockers in the Android
    world) have gone idle.

(3) Teach the cpuidle framework to schedule runtime suspend of I/O devices
    before idling the last CPU (*).

(4) Design a mechanism to resume the I/O devices suspended in (3) so that
    they are not powered up unnecessarily (that's going to be difficult as far
    as I can see).

This way, in principle, we should be able to save (at least almost) as much
energy as the opportunistic suspend currently used by Android, provided that
things will be capable of staying idle for extended periods of time.

(*) That may require per-device PM QoS requirements to be used, in which case
    devices may even be suspended earlier if the PM QoS requirements of all
    of their users are met.

I wonder what people think.  Is this realistic and if so, would it be difficult
to implement?

Rafael
