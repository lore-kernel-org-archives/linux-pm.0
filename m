From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] clk: readd refcounting for struct clk instances
Date: Tue, 15 Sep 2015 16:50:38 +0200
Message-ID: <1878691.zhVxsBBBGg@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
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
once the refcount reaches zero.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
I stumbled upon this while applying the new Rockchip power-domain driver,
but I guess the underlying issue is universal and probably present since
the original clk/clk_core split, so this probably counts as fix.

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
+	if ((clk->min_rate > clk->core->req_rate ||
+	     clk->max_rate < clk->core->req_rate))
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
