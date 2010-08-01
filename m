From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 01:02:24 +0200
Message-ID: <201008020102.24674.rjw@sisk.pl>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100801204026.GH31324@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ted Ts'o <tytso@mit.edu>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, August 01, 2010, Ted Ts'o wrote:
> On Sun, Aug 01, 2010 at 12:12:28PM -0700, Paul E. McKenney wrote:
> > 
> > I understand that you would prefer that we group applications into
> > "good" and "bad" categories, but then again, I suspect that most of us
> > understood that before you posted this message.  Given your significant
> > and well-appreciated contributions to power efficiency over the past
> > several years, I must confess to be quite disappointed that you failed
> > to do more than to simply restate your preference.
> 
> Paul, I very much agree with what you stated later, with respect to
> doubting whether the whack-a-mole approach to application fixups is
> workable.  Given how many applications screw up using fsync()
> correctly, to the extent that XFS, ext4, and btrfs all had to agree on
> a common hueristics to deal with the fact that application programmers
> are aggressively ignorant, and outnumber the file system developers, I
> too doubt the general strategy of relying only on application
> programmers to do the right thing.  That's not to say that we
> shouldn't give up on trying to influence application programmers ---
> but relying on that as the only strategy seems to depart from the path
> of wisdom.
> 
> There is however a much bigger point, which is that it's unfortunately
> black and white to talk about applications being "good" and "bad".  In
> fact, it's a continuing point of concern I have with the whole qos
> approach to power management.  In fact, power is often something that
> needs to trade off against performance.  For example, an application
> could aggressively prefetch e-mail messages or web pages that a user
> _might_ view --- or it could aggressively pre-resolve DNS queries,
> etc, which might make perfect sense when the device is hooked up to AC
> mains, but which I might not want to do on when I only have 800mWh
> worth of battery --- however, if I'm using a laptop with 94,000mWh,
> maybe I'd be happy if the application was a bit more profligate.
> 
> So for Arjan to claim that all applications will be held to the same
> standard, whether they are hooked up to the AC mains, or are limited
> to 800mWh of battery, or 94,000 mWh worth of power, is vastly
> oversimplifying the problem.  Of *course* if I'm writing an
> application that will be running in a cloud data center, I'm going to
> care about power.  But I may have different tradeoffs about what might
> considered acceptible when considering the qualify of user experience
> I'm delivering to the end-user when I'm connected to AC mains, versus
> a cell phone battery, versus a 6-cell laptop battery.
> 
> This brings me back to a major problem I have with the pm_qos approach
> to power management.  It assumes that applications know best, and that
> they should be free to tell pm_qos subsystem whether they need 0ms
> latency for wireless.  Right now, I can't even query the pm_qos
> subsystem to see which application is responsible for keeping the
> wireless on 100% of the time!  And even if I could find out, maybe
> some power management framework should be allowed to give a override
> to the application's wishes.

I agree with that.

Generally speaking, you can divide applications into the ones that will be
allowed to influence ths system's behavior with respect to power management
and the others that won't be allowed to do it.  The latter may be forcibly
"frozen" (this way or another) when the "trused" ones collectively decide it's
a good idea to enter a deeper "energy saving" state.  However, it is not a
given that specific applications will always be in the same group.  They may
be "trusted" on some systems and they may not be "trusted" on some other
system, depending on the configuration etc.  That even may change over time
on the same system.

Thanks,
Rafael
