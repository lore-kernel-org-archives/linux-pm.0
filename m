From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 1/5] clk: add support for runtime pm
Date: Mon, 24 Oct 2016 14:12:06 +0200
Message-ID: <1477311130-6534-2-git-send-email-m.szyprowski@samsung.com>
References: <1477311130-6534-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161024121226eucas1p15f985a5780ea27bde4ec77db0054ec92@eucas1p1.samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <1477311130-6534-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Registers for some clocks might be located in the SOC area, which are under the
power domain. To enable access to those registers respective domain has to be
turned on. Additionally, registers for such clocks will usually loose its
contents when power domain is turned off, so additional saving and restoring of
them might be needed in the clock controller driver.

This patch adds basic infrastructure in the clocks core to allow implementing
driver for such clocks under power domains. Clock provider can supply a
struct device pointer, which is the used by clock core for tracking and managing
clock's controller runtime pm state. Each clk_prepare() operation
will first call pm_runtime_get_sync() on the supplied device, while
clk_unprepare() will do pm_runtime_put() at the end.

Additional calls to pm_runtime_get/put functions are required to ensure that any
register access (like calculating/changing clock rates and unpreparing/disabling
unused clocks on boot) will be done with clock controller in runtime resumend
state.

When one wants to register clock controller, which make use of this feature, he
has to:
1. Provide a struct device to the core when registering the provider.
2. Ensure to enable runtime PM for that device before registering clocks.
3. Make sure that the runtime PM status of the controller device reflects
   the HW state.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/clk.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0fb39fe217d1..3cf202ccf5a9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/pm_runtime.h>
 #include <linux/sched.h>
 #include <linux/clkdev.h>
 
@@ -46,6 +47,7 @@ struct clk_core {
 	const struct clk_ops	*ops;
 	struct clk_hw		*hw;
 	struct module		*owner;
+	struct device		*dev;
 	struct clk_core		*parent;
 	const char		**parent_names;
 	struct clk_core		**parents;
@@ -87,6 +89,26 @@ struct clk {
 	struct hlist_node clks_node;
 };
 
+/***           runtime pm          ***/
+static int clk_pm_runtime_get(struct clk_core *core)
+{
+	int ret = 0;
+
+	if (!core->dev)
+		return 0;
+
+	ret = pm_runtime_get_sync(core->dev);
+	return ret < 0 ? ret : 0;
+}
+
+static void clk_pm_runtime_put(struct clk_core *core)
+{
+	if (!core->dev)
+		return;
+
+	pm_runtime_put(core->dev);
+}
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -150,6 +172,8 @@ static void clk_enable_unlock(unsigned long flags)
 
 static bool clk_core_is_prepared(struct clk_core *core)
 {
+	bool status;
+
 	/*
 	 * .is_prepared is optional for clocks that can prepare
 	 * fall back to software usage counter if it is missing
@@ -157,11 +181,20 @@ static bool clk_core_is_prepared(struct clk_core *core)
 	if (!core->ops->is_prepared)
 		return core->prepare_count;
 
-	return core->ops->is_prepared(core->hw);
+	if (clk_pm_runtime_get(core) == 0) {
+		status = core->ops->is_prepared(core->hw);
+		clk_pm_runtime_put(core);
+	} else {
+		status = false;
+	}
+
+	return status;
 }
 
 static bool clk_core_is_enabled(struct clk_core *core)
 {
+	bool status;
+
 	/*
 	 * .is_enabled is only mandatory for clocks that gate
 	 * fall back to software usage counter if .is_enabled is missing
@@ -169,7 +202,30 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	if (!core->ops->is_enabled)
 		return core->enable_count;
 
-	return core->ops->is_enabled(core->hw);
+	/*
+	 * Check if clock controller's device is runtime active before
+	 * calling .is_enabled callback. If not, assume that clock is
+	 * disabled, because we might be called from atomic context, from
+	 * which pm_runtime_get() is not allowed.
+	 * This function is called mainly from clk_disable_unused_subtree,
+	 * which ensures proper runtime pm activation of controller before
+	 * taking enable spinlock, but the below check is needed if one tries
+	 * to call it from other places.
+	 */
+	if (core->dev) {
+		pm_runtime_get_noresume(core->dev);
+		if (!pm_runtime_active(core->dev)) {
+			status = false;
+			goto done;
+		}
+	}
+
+	status = core->ops->is_enabled(core->hw);
+done:
+	if (core->dev)
+		pm_runtime_put(core->dev);
+
+	return status;
 }
 
 /***    helper functions   ***/
@@ -489,6 +545,8 @@ static void clk_core_unprepare(struct clk_core *core)
 	if (core->ops->unprepare)
 		core->ops->unprepare(core->hw);
 
+	clk_pm_runtime_put(core);
+
 	trace_clk_unprepare_complete(core);
 	clk_core_unprepare(core->parent);
 }
@@ -530,10 +588,14 @@ static int clk_core_prepare(struct clk_core *core)
 		return 0;
 
 	if (core->prepare_count == 0) {
-		ret = clk_core_prepare(core->parent);
+		ret = clk_pm_runtime_get(core);
 		if (ret)
 			return ret;
 
+		ret = clk_core_prepare(core->parent);
+		if (ret)
+			goto runtime_put;
+
 		trace_clk_prepare(core);
 
 		if (core->ops->prepare)
@@ -541,15 +603,18 @@ static int clk_core_prepare(struct clk_core *core)
 
 		trace_clk_prepare_complete(core);
 
-		if (ret) {
-			clk_core_unprepare(core->parent);
-			return ret;
-		}
+		if (ret)
+			goto unprepare;
 	}
 
 	core->prepare_count++;
 
 	return 0;
+unprepare:
+	clk_core_unprepare(core->parent);
+runtime_put:
+	clk_pm_runtime_put(core);
+	return ret;
 }
 
 static int clk_core_prepare_lock(struct clk_core *core)
@@ -745,6 +810,9 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
 	if (core->flags & CLK_IGNORE_UNUSED)
 		return;
 
+	if (clk_pm_runtime_get(core))
+		return;
+
 	if (clk_core_is_prepared(core)) {
 		trace_clk_unprepare(core);
 		if (core->ops->unprepare_unused)
@@ -753,6 +821,8 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
 			core->ops->unprepare(core->hw);
 		trace_clk_unprepare_complete(core);
 	}
+
+	clk_pm_runtime_put(core);
 }
 
 static void clk_disable_unused_subtree(struct clk_core *core)
@@ -768,6 +838,9 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
 
+	if (clk_pm_runtime_get(core))
+		goto unprepare_out;
+
 	flags = clk_enable_lock();
 
 	if (core->enable_count)
@@ -792,6 +865,8 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 
 unlock_out:
 	clk_enable_unlock(flags);
+	clk_pm_runtime_put(core);
+unprepare_out:
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_disable_unprepare(core->parent);
 }
@@ -1563,6 +1638,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 {
 	struct clk_core *top, *fail_clk;
 	unsigned long rate = req_rate;
+	int ret = 0;
 
 	if (!core)
 		return 0;
@@ -1579,21 +1655,28 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (!top)
 		return -EINVAL;
 
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		return ret;
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
 		pr_debug("%s: failed to set %s rate\n", __func__,
 				fail_clk->name);
 		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	/* change the rates */
 	clk_change_rate(top);
 
 	core->req_rate = req_rate;
+err:
+	clk_pm_runtime_put(core);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1824,12 +1907,16 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
 		p_rate = parent->rate;
 	}
 
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		goto out;
+
 	/* propagate PRE_RATE_CHANGE notifications */
 	ret = __clk_speculate_rates(core, p_rate);
 
 	/* abort if a driver objects */
 	if (ret & NOTIFY_STOP_MASK)
-		goto out;
+		goto runtime_put;
 
 	/* do the re-parent */
 	ret = __clk_set_parent(core, parent, p_index);
@@ -1842,6 +1929,8 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
 		__clk_recalc_accuracies(core);
 	}
 
+runtime_put:
+	clk_pm_runtime_put(core);
 out:
 	clk_prepare_unlock();
 
@@ -2549,6 +2638,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 		goto fail_name;
 	}
 	core->ops = hw->init->ops;
+	if (dev && pm_runtime_enabled(dev))
+		core->dev = dev;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
-- 
1.9.1

