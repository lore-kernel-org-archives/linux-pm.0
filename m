From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Mon, 6 Aug 2007 21:04:46 +0100
Message-ID: <20070806200446.GD3360@flint.arm.linux.org.uk>
References: <200708061111.03407.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708061111.03407.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Victor <andrew@sanpeople.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 06, 2007 at 11:11:03AM -0700, David Brownell wrote:
> This patch adds a clk_must_disable() operation, exposing the clock constraints
> which often distinguish system power states.  Systems with such constraints
> include ones using ARM-based AT91, OMAP, and PXA chips.  The new operation
> lets driver methods check those constraints.
> 
> A common benefit to leaving some device clocks enabled is that a suspended
> device may then be able to issue system wakeup events.  RS232, USB, Ethernet,
> and other drivers can use driver model wakeup flags as userspace directions
> about how to trade off between the lowest power "full off" states and more
> functional wakeup-enabled ones.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Andrew,

David sent these without giving me a chance to respond to them.  For
your record, below are my comments.  As you can see, I'm of the opinion
that they're not suitable at present.

Message 1:
On Mon, Aug 06, 2007 at 10:23:21AM -0700, David Brownell wrote:
> A better fix is to recognize that the clock API is missing PM hooks;
> some drivers should stay partially active in sleep states that don't
> actually require them to turn off their clocks, and that's not at all
> unique to AT91 hardware.
>
>   https://lists.linux-foundation.org/pipermail/linux-pm/2007-March/011495.html>   https://lists.linux-foundation.org/pipermail/linux-pm/2007-March/011496.html>
> Presumably I should just get those into the MM queue ... I've been
> scrubbing other patches out, it's time for those also.

+ * This routine returns true only if the upcoming system state requires
+ * disabling the specified clock.
...
+int clk_must_disable(struct clk *clk);

It isn't clear how such a function decides whether the clock is available
in this "upcoming system state".  Some SoCs have multiple power states
which they can enter, so without knowledge of what this "upcoming
system state" is, how can this function decide?

Shouldn't it be passed something representing this "upcoming system state" ?

Also "clk_must_disable" is a horrible function name - it seems far too
ambiguous.  "clk_must_suspend()" would be a better hint at what it's
trying to do.

Message 2:
On Mon, Aug 06, 2007 at 11:25:56AM -0700, David Brownell wrote:
> I've sent the two patches to Andrew, with a "please expedite,
> this is a build fix" comment.

Given that there's some concerns about it, please provide only a minimal
fix - in other words the function prototype necessary to fix the build
issue.

Please don't wrap up unreviewed patches as "important build fixes".


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
