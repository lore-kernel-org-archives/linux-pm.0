From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Tue, 7 Aug 2007 10:21:06 -0700
Message-ID: <20070807102106.58c8191f.akpm@linux-foundation.org>
References: <200708061111.03407.david-b@pacbell.net>
	<200708061338.08561.david-b@pacbell.net>
	<20070806214805.GE3360@flint.arm.linux.org.uk>
	<200708061646.41835.david-b@pacbell.net>
	<20070806222351.090dc035.akpm@linux-foundation.org>
	<20070807125054.GC2833@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070807125054.GC2833@flint.arm.linux.org.uk>
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
Cc: Andrew Victor <andrew@sanpeople.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 7 Aug 2007 13:50:54 +0100 Russell King <rmk@arm.linux.org.uk> wrote:

> I do not think that the clk_must_disable() API is well enough thought out
> for the following reasons:
> 
> 1. the name sucks - it tells you nothing about it's purpose, which as
>    the name currently stands can be interpreted in as many ways as there
>    are species of animals on this planet.
> 
>    While the comments around the prototype help interpret its semantics,
>    it is no subsitute for having a good name for the function.
> 
> 2. it's unclear how this function obtains information about the "upcoming
>    system state" and therefore decides whether the particular clock may
>    be available.
> 
> 3. due to the negative semantics, code such as the following is difficult
>    to interpret and work out whether it's correct due to the double
>    negative:
> 
>   +     if (device_may_wakeup(&pdev->dev)
>   +                     && !clk_must_disable(atmel_port->clk))
>                 enable_irq_wake(port->irq);
> 
> 4. the description of the function implies that this function may be
>    called when we are not suspending:
> 
>   + * On platforms that support reduced functionality operating states, the
>   + * constraint may also need to be tested during resume() and probe() calls.
> 
>    With SoCs with multiple power states affecting which clocks are
>    available, and the need in point (2) for the architecture code to
>    record which PM mode we're entering via the pm_ops set_target method,
>    calling clk_must_disable() outside of the suspend methods results in
>    this function essentially returning undefined values at driver probe
>    time.  Note: there is no locking between driver probing and the
>    set_target method.
> 
>    Moreover, if used in a driver probe() path, the return value could
>    well depend on the _last_ system suspend state entered, and would be
>    undefined for a system which hasn't been suspended from boot.
> 
> Changing the function name to "clk_available_in_suspend()" addresses at
> least two of these points.  The other two points are addressed by
> providing a way for the method to be passed the desired system suspend
> state, which may be resolved by expanding pm_message_t to contain that
> information.

I see, thanks.  clk_available_in_suspend() sure is a better name.

> Finally, concerning merging this during the -rc phase, I'd much rather
> see the one liner simple build fix of adding the missing function
> prototype going into the -rc kernels, and then a similar patch to this
> going in during the next merge window.

Here's where confusion sets in.  I have this:

--- at91.orig/include/linux/clk.h	2007-02-16 08:47:11.000000000 -0800
+++ at91/include/linux/clk.h	2007-02-16 08:47:17.000000000 -0800
@@ -121,4 +121,24 @@ int clk_set_parent(struct clk *clk, stru
  */
 struct clk *clk_get_parent(struct clk *clk);
 
+/**
+ * clk_must_disable - report whether a clock's users must disable it
+ * @clk: one node in the clock tree
+ *
+ * This routine returns true only if the upcoming system state requires
+ * disabling the specified clock.
+ *
+ * It's common for platform power states to constrain certain clocks (and
+ * their descendants) to be unavailable, while other states allow that
+ * clock to be active.  A platform's power states often include an "all on"
+ * mode; system wide sleep states like "standby" and "suspend-to-RAM"; and
+ * operating states which sacrifice functionality for lower power usage.
+ *
+ * The constraint value is commonly tested in device driver suspend(), to
+ * leave clocks active if they are needed for features like wakeup events.
+ * On platforms that support reduced functionality operating states, the
+ * constraint may also need to be tested during resume() and probe() calls.
+ */
+int clk_must_disable(struct clk *clk);
+
 #endif

but it's a prototype for a function which doesn't exist.  You must
be referring to a different patch.
