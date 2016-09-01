From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/5] clk: add support for runtime pm
Date: Thu, 01 Sep 2016 15:45:47 +0200
Message-ID: <1472737551-15272-2-git-send-email-m.szyprowski@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
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
register access (like calculating/chaning clock rates) will be done with clock
controller in active runtime state.

Special handling of the case when runtime pm is disabled for clock controller's
device is needed to let this feature work properly also during system sleep
suspend/resume operations (runtime pm is first disabled before entering sleep
state's, but controller is usually still operational until its suspend pm
callback is called).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/clk.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 820a939fb6bb..a1934e9b4e95 100644
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
@@ -87,6 +89,42 @@ struct clk {
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
+	if (pm_runtime_enabled(core->dev)) {
+		ret = pm_runtime_get_sync(core->dev);
+	} else {
+		if (!pm_runtime_status_suspended(core->dev))
+			pm_runtime_get_noresume(core->dev);
+	}
+	return ret < 0 ? ret : 0;
+}
+
+static void clk_pm_runtime_put(struct clk_core *core)
+{
+	if (!core->dev)
+		return;
+
+	if (pm_runtime_enabled(core->dev))
+		pm_runtime_put(core->dev);
+	else
+		pm_runtime_put_noidle(core->dev);
+}
+
+static bool clk_pm_runtime_suspended(struct clk_core *core)
+{
+	if (!core->dev)
+		return 0;
+
+	return pm_runtime_suspended(core->dev);
+}
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -150,6 +188,9 @@ static void clk_enable_unlock(unsigned long flags)
 
 static bool clk_core_is_prepared(struct clk_core *core)
 {
+	if (clk_pm_runtime_suspended(core))
+		return false;
+
 	/*
 	 * .is_prepared is optional for clocks that can prepare
 	 * fall back to software usage counter if it is missing
@@ -162,6 +203,9 @@ static bool clk_core_is_prepared(struct clk_core *core)
 
 static bool clk_core_is_enabled(struct clk_core *core)
 {
+	if (clk_pm_runtime_suspended(core))
+		return false;
+
 	/*
 	 * .is_enabled is only mandatory for clocks that gate
 	 * fall back to software usage counter if .is_enabled is missing
@@ -489,6 +533,8 @@ static void clk_core_unprepare(struct clk_core *core)
 	if (core->ops->unprepare)
 		core->ops->unprepare(core->hw);
 
+	clk_pm_runtime_put(core);
+
 	trace_clk_unprepare_complete(core);
 	clk_core_unprepare(core->parent);
 }
@@ -530,10 +576,14 @@ static int clk_core_prepare(struct clk_core *core)
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
@@ -541,15 +591,18 @@ static int clk_core_prepare(struct clk_core *core)
 
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
@@ -1563,6 +1616,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 {
 	struct clk_core *top, *fail_clk;
 	unsigned long rate = req_rate;
+	int ret = 0;
 
 	if (!core)
 		return 0;
@@ -1579,21 +1633,28 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
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
@@ -1824,12 +1885,16 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
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
@@ -1842,6 +1907,8 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
 		__clk_recalc_accuracies(core);
 	}
 
+runtime_put:
+	clk_pm_runtime_put(core);
 out:
 	clk_prepare_unlock();
 
@@ -2546,6 +2613,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 		goto fail_name;
 	}
 	core->ops = hw->init->ops;
+	core->dev = dev;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
-- 
1.9.1
