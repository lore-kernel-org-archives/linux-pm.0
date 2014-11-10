From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Fix initial default state of the need_restore flag
Date: Mon, 10 Nov 2014 10:24:38 +0100
Message-ID: <1415611478-20906-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The initial state of the device's need_restore flag should'nt depend on
the current state of the PM domain. For example it should be perfectly
valid to attach an inactive device to a powered PM domain.

The pm_genpd_dev_need_restore() API allow us to update the need_restore
flag to somewhat cope with such scenarios. Typically that should have
been done from drivers/buses ->probe() since it's those that put the
requirements on the value of the need_restore flag.

Until recently, the Exynos SOCs were the only user of the
pm_genpd_dev_need_restore() API, though invoking it from a centralized
location while adding devices to their PM domains.

Due to that Exynos now have swithed to the generic OF-based PM domain
look-up, it's no longer possible to invoke the API from a centralized
location. The reason is because devices are now added to their PM
domains during the probe sequence.

Commit "ARM: exynos: Move to generic PM domain DT bindings"
did the switch for Exynos to the generic OF-based PM domain look-up,
but it also removed the call to pm_genpd_dev_need_restore(). This
caused a regression for some of the Exynos drivers.

To handle things more properly in the generic PM domain, let's change
the default initial value of the need_restore flag to reflect that the
state is unknown. As soon as some of the runtime PM callbacks gets
invoked, update the initial value accordingly.

Moreover, since the generic PM domain is verifying that all device's
are both runtime PM enabled and suspended, using pm_runtime_suspended()
while pm_genpd_poweroff() is invoked from the scheduled work, we can be
sure of that the PM domain won't be powering off while having active
devices.

Do note that, the generic PM domain can still only know about active
devices which has been activated through invoking its runtime PM resume
callback. In other words, buses/drivers using pm_runtime_set_active()
during ->probe() will still suffer from a race condition, potentially
probing a device without having its PM domain being powered. That issue
will have to be solved using a different approach.

This a log from the boot regression for Exynos5, which is being fixed in
this patch.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 308 at ../drivers/clk/clk.c:851 clk_disable+0x24/0x30()
Modules linked in:
CPU: 0 PID: 308 Comm: kworker/0:1 Not tainted 3.18.0-rc3-00569-gbd9449f-dirty #10
Workqueue: pm pm_runtime_work
[<c0013c64>] (unwind_backtrace) from [<c0010dec>] (show_stack+0x10/0x14)
[<c0010dec>] (show_stack) from [<c03ee4cc>] (dump_stack+0x70/0xbc)
[<c03ee4cc>] (dump_stack) from [<c0020d34>] (warn_slowpath_common+0x64/0x88)
[<c0020d34>] (warn_slowpath_common) from [<c0020d74>] (warn_slowpath_null+0x1c/0x24)
[<c0020d74>] (warn_slowpath_null) from [<c03107b0>] (clk_disable+0x24/0x30)
[<c03107b0>] (clk_disable) from [<c02cc834>] (gsc_runtime_suspend+0x128/0x160)
[<c02cc834>] (gsc_runtime_suspend) from [<c0249024>] (pm_generic_runtime_suspend+0x2c/0x38)
[<c0249024>] (pm_generic_runtime_suspend) from [<c024f44c>] (pm_genpd_default_save_state+0x2c/0x8c)
[<c024f44c>] (pm_genpd_default_save_state) from [<c024ff2c>] (pm_genpd_poweroff+0x224/0x3ec)
[<c024ff2c>] (pm_genpd_poweroff) from [<c02501b4>] (pm_genpd_runtime_suspend+0x9c/0xcc)
[<c02501b4>] (pm_genpd_runtime_suspend) from [<c024a4f8>] (__rpm_callback+0x2c/0x60)
[<c024a4f8>] (__rpm_callback) from [<c024a54c>] (rpm_callback+0x20/0x74)
[<c024a54c>] (rpm_callback) from [<c024a930>] (rpm_suspend+0xd4/0x43c)
[<c024a930>] (rpm_suspend) from [<c024bbcc>] (pm_runtime_work+0x80/0x90)
[<c024bbcc>] (pm_runtime_work) from [<c0032a9c>] (process_one_work+0x12c/0x314)
[<c0032a9c>] (process_one_work) from [<c0032cf4>] (worker_thread+0x3c/0x4b0)
[<c0032cf4>] (worker_thread) from [<c003747c>] (kthread+0xcc/0xe8)
[<c003747c>] (kthread) from [<c000e738>] (ret_from_fork+0x14/0x3c)
---[ end trace 40cd58bcd6988f12 ]---

Fixes: a4a8c2c4962bb655 (ARM: exynos: Move to generic PM domain DT bindings)
Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Applied some Reviewed|Tested-by tags.
	Added some newlines. (Kevin)
	Checking for the sign instead of for a specific value. (Rafael)


This patch is intended as fix for 3.18 rc[n] due to the regression for Exynos
SOCs.

I would also like to call for help in getting this thoroughly tested.

I have tested this on Arndale Dual, Exynos 5250. According the log attached in
the commit message as well.

I have tested this on UX500, which support for the generic PM domain is about
to be queued for 3.19. Since UX500 uses the AMBA bus/drivers, which uses
pm_runtime_set_active() instead of pm_runtime_get_sync() during ->probe(), I
could also verify that this behavior is maintained.

Finally I have also tested this patchset on UX500 and using the below patchset
to make sure the approach is suitable long term wise as well.
[PATCH v3 0/9] PM / Domains: Fix race conditions during boot
http://www.spinics.net/lists/arm-kernel/msg369409.html

---
 drivers/base/power/domain.c | 38 ++++++++++++++++++++++++++++++++------
 include/linux/pm_domain.h   |  2 +-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b520687..df41c69 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -361,9 +361,19 @@ static int __pm_genpd_save_device(struct pm_domain_data *pdd,
 	struct device *dev = pdd->dev;
 	int ret = 0;
 
-	if (gpd_data->need_restore)
+	if (gpd_data->need_restore > 0)
 		return 0;
 
+	/*
+	 * If the value of the need_restore flag is still unknown at this point,
+	 * we trust that pm_genpd_poweroff() has verified that the device is
+	 * already runtime PM suspended.
+	 */
+	if (gpd_data->need_restore < 0) {
+		gpd_data->need_restore = 1;
+		return 0;
+	}
+
 	mutex_unlock(&genpd->lock);
 
 	genpd_start_dev(genpd, dev);
@@ -373,7 +383,7 @@ static int __pm_genpd_save_device(struct pm_domain_data *pdd,
 	mutex_lock(&genpd->lock);
 
 	if (!ret)
-		gpd_data->need_restore = true;
+		gpd_data->need_restore = 1;
 
 	return ret;
 }
@@ -389,12 +399,17 @@ static void __pm_genpd_restore_device(struct pm_domain_data *pdd,
 {
 	struct generic_pm_domain_data *gpd_data = to_gpd_data(pdd);
 	struct device *dev = pdd->dev;
-	bool need_restore = gpd_data->need_restore;
+	int need_restore = gpd_data->need_restore;
 
-	gpd_data->need_restore = false;
+	gpd_data->need_restore = 0;
 	mutex_unlock(&genpd->lock);
 
 	genpd_start_dev(genpd, dev);
+
+	/*
+	 * Make sure to also restore those devices which we until now, didn't
+	 * know the state for.
+	 */
 	if (need_restore)
 		genpd_restore_dev(genpd, dev);
 
@@ -603,6 +618,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 static int pm_genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	struct generic_pm_domain_data *gpd_data;
 	bool (*stop_ok)(struct device *__dev);
 	int ret;
 
@@ -628,6 +644,16 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	mutex_lock(&genpd->lock);
+
+	/*
+	 * If we have an unknown state of the need_restore flag, it means none
+	 * of the runtime PM callbacks has been invoked yet. Let's update the
+	 * flag to reflect that the current state is active.
+	 */
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+	if (gpd_data->need_restore < 0)
+		gpd_data->need_restore = 0;
+
 	genpd->in_progress++;
 	pm_genpd_poweroff(genpd);
 	genpd->in_progress--;
@@ -1442,7 +1468,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	mutex_lock(&gpd_data->lock);
 	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
-	gpd_data->need_restore = genpd->status == GPD_STATE_POWER_OFF;
+	gpd_data->need_restore = -1;
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	mutex_unlock(&gpd_data->lock);
@@ -1546,7 +1572,7 @@ void pm_genpd_dev_need_restore(struct device *dev, bool val)
 
 	psd = dev_to_psd(dev);
 	if (psd && psd->domain_data)
-		to_gpd_data(psd->domain_data)->need_restore = val;
+		to_gpd_data(psd->domain_data)->need_restore = val ? 1 : 0;
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b3ed776..2e0e06d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -106,7 +106,7 @@ struct generic_pm_domain_data {
 	struct notifier_block nb;
 	struct mutex lock;
 	unsigned int refcount;
-	bool need_restore;
+	int need_restore;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
1.9.1
