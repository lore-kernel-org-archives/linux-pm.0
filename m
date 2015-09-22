From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH v2] clk: readd refcounting for struct clk instances
Date: Wed, 23 Sep 2015 01:55:47 +0200
Message-ID: <6257096.h7pub3XnDQ@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With the split into struct clk and struct clk_core, clocks lost the
ability for nested __clk_get clkdev calls. While it stays possible to
call __clk_get, the first call to (__)clk_put will clear the struct clk,
making subsequent clk_put calls run into a NULL pointer dereference.

One prime example of this sits in the generic power domain code, where it
is possible to add the clocks both by name and by passing in a struct clk
via pm_clk_add_clk(). __pm_clk_add() in turn then calls __clk_get to
increase the refcount, so that the original code can put the clock again.

A possible call-path looks like
clk = of_clk_get();
pm_clk_add_clk(dev, clk);
clk_put(clk);

with pm_clk_add_clk() => __pm_clk_add() then calling __clk_get on the clk
and later clk_put when the pm clock list gets destroyed, thus creating
a NULL pointer deref, as the struct clk doesn't exist anymore.

So add a separate refcounting for struct clk instances and only clean up
once the refcount reaches zero. This makes it possible again to hand off
a clock reference to common code without needing to track it further.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---

While it may be nice to do the actual handling of the clock references
only in the calling code, in this current use case it would create
a big additional overhead.

It looks like this so called synchronous reset on power-domain state-
changes, requiring device clocks to be turned on, is not that uncommon
or rockchip-specific.
For this Kevin requested that we read the clocks from the actual consumer
devices and not double-list them in the power-domain node as well.

So when expecting pm_clk_add_clk() to work, the current powerdomain code
can simply do when adding a device to a domain in rockchip_pd_attach_dev():
    while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
	dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
	error = pm_clk_add_clk(dev, clk);
	clk_put(clk);
    }

The clock gets handed off to the generic pm clock handling and thus
clk_put in there.


On the other hand when only the rockchip power-domain code is expected
to get and put the clock, we would require a lot of new overhead, as now
the code would also need to track which devices got added to what
domain and also all clock-references until the device gets detached
again. So this would essentially duplicate a big part of what the
genpd-code does (per-domain device-list and per-device clock-list).

As this seems to be not uncommon, future powerdomain drivers
might need that too and would also need to duplicate that handling.

When allowing multiple __clk_get and __clk_put calls on the other
hand, the overhead for the regular case comes down to one atomic_inc,
atomic_sub_and_test and the function call to the new separate release
function ;-) .


changes in v2: removed double parentheses found by Stephen Boyd

 drivers/clk/clk.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 43e2c3a..7aab1a4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -85,6 +85,7 @@ struct clk {
 	unsigned long min_rate;
 	unsigned long max_rate;
 	struct hlist_node clks_node;
+	struct kref ref;
 };
 
 /***           locking             ***/
@@ -2590,7 +2591,7 @@ fail_out:
 EXPORT_SYMBOL_GPL(clk_register);
 
 /* Free memory allocated for a clock. */
-static void __clk_release(struct kref *ref)
+static void __clk_core_release(struct kref *ref)
 {
 	struct clk_core *core = container_of(ref, struct clk_core, ref);
 	int i = core->num_parents;
@@ -2606,6 +2607,18 @@ static void __clk_release(struct kref *ref)
 	kfree(core);
 }
 
+static void __clk_release(struct kref *ref)
+{
+	struct clk *clk = container_of(ref, struct clk, ref);
+
+	hlist_del(&clk->clks_node);
+	if (clk->min_rate > clk->core->req_rate ||
+	    clk->max_rate < clk->core->req_rate)
+		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
+
+	kfree(clk);
+}
+
 /*
  * Empty clk_ops for unregistered clocks. These are used temporarily
  * after clk_unregister() was called on a clock and until last clock
@@ -2684,7 +2697,7 @@ void clk_unregister(struct clk *clk)
 	if (clk->core->prepare_count)
 		pr_warn("%s: unregistering prepared clock: %s\n",
 					__func__, clk->core->name);
-	kref_put(&clk->core->ref, __clk_release);
+	kref_put(&clk->core->ref, __clk_core_release);
 
 	clk_prepare_unlock();
 }
@@ -2759,12 +2772,14 @@ int __clk_get(struct clk *clk)
 			return 0;
 
 		kref_get(&core->ref);
+		kref_get(&clk->ref);
 	}
 	return 1;
 }
 
 void __clk_put(struct clk *clk)
 {
+	struct clk_core *core;
 	struct module *owner;
 
 	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
@@ -2772,19 +2787,15 @@ void __clk_put(struct clk *clk)
 
 	clk_prepare_lock();
 
-	hlist_del(&clk->clks_node);
-	if (clk->min_rate > clk->core->req_rate ||
-	    clk->max_rate < clk->core->req_rate)
-		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
+	core = clk->core;
+	owner = core->owner;
 
-	owner = clk->core->owner;
-	kref_put(&clk->core->ref, __clk_release);
+	kref_put(&clk->ref, __clk_release);
+	kref_put(&core->ref, __clk_core_release);
 
 	clk_prepare_unlock();
 
 	module_put(owner);
-
-	kfree(clk);
 }
 
 /***        clk rate change notifiers        ***/
-- 
2.5.1


