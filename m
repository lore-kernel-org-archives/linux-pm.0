From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Mon, 6 Aug 2007 13:38:08 -0700
Message-ID: <200708061338.08561.david-b@pacbell.net>
References: <200708061111.03407.david-b@pacbell.net>
	<20070806200446.GD3360@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070806200446.GD3360@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 August 2007, Russell King wrote:
> On Mon, Aug 06, 2007 at 11:11:03AM -0700, David Brownell wrote:
> > This patch adds a clk_must_disable() operation, exposing the clock constraints
> > which often distinguish system power states.  Systems with such constraints
> > include ones using ARM-based AT91, OMAP, and PXA chips.  The new operation
> > lets driver methods check those constraints.
> > 
> > A common benefit to leaving some device clocks enabled is that a suspended
> > device may then be able to issue system wakeup events.  RS232, USB, Ethernet,
> > and other drivers can use driver model wakeup flags as userspace directions
> > about how to trade off between the lowest power "full off" states and more
> > functional wakeup-enabled ones.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Andrew,
> 
> David sent these without giving me a chance to respond to them. 

Not at all true.  You've seen them at least two other times since they
were first posted last year against 2.6.17-rc4.  Let's see:

 16-May-2006	http://marc.info/?l=linux-kernel&m=114782690922167&w=2
 22-March-2007	http://marc.info/?l=linux-kernel&m=117458718812017&w=2

And you didn't say a word then.  That's well over a year that you
have been silent.


> For 
> your record, below are my comments.  As you can see, I'm of the opinion
> that they're not suitable at present.

I've responded to these on their original list, but to re-cap:


> Message 1:
> ...
> 
> + * This routine returns true only if the upcoming system state requires
> + * disabling the specified clock.
> ...
> +int clk_must_disable(struct clk *clk);
> 
> It isn't clear how such a function decides whether the clock is available
> in this "upcoming system state".  Some SoCs have multiple power states
> which they can enter, so without knowledge of what this "upcoming
> system state" is, how can this function decide?
> 
> Shouldn't it be passed something representing this "upcoming system state" ?

pm_ops.set_target_state() does that now; pm_ops.prepare() used to
do it before that was redefined to make ACPI happier.


> Also "clk_must_disable" is a horrible function name - it seems far too
> ambiguous.  "clk_must_suspend()" would be a better hint at what it's
> trying to do.

If the relevant action were the non-existent clk_suspend() call I'd
agree.  But instead, it's the same old clk_disable() call that's in
question.  So ... no, that response makes no sense.

 
> Message 2:
> On Mon, Aug 06, 2007 at 11:25:56AM -0700, David Brownell wrote:
> > I've sent the two patches to Andrew, with a "please expedite,
> > this is a build fix" comment.
> 
> Given that there's some concerns about it, please provide only a minimal
> fix - in other words the function prototype necessary to fix the build
> issue.

The preceding times this specific API has come up, *NOBODY* ever
mentioned even one concern beyond "when will this patch merge".


> Please don't wrap up unreviewed patches as "important build fixes".

>From my perspective, they've been reviewed for well over a year and
have just been waiting for me to get off my butt and be extremely
explicit that they need to merge.  (That is, not expect anyone to
just pick them up and merge.)

And since you asked for a build fix ... I have a hard time thinking
that anything else could really be the "right fix".

- Dave
