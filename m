From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
Date: Fri, 26 Apr 2019 21:38:14 +0000
Message-ID: <68ccb5a90d1d2a596e7ed94ba3245171f013c781.1556313614.git.leonard.crestez@nxp.com>
References: <cover.1556313614.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1556313614.git.leonard.crestez@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

This is for power domains which can only be powered off for suspend but
not as part of runtime PM.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/base/power/domain.c | 8 ++++++--
 include/linux/pm_domain.h   | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 189d7e14c611..f502218a0ddb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -126,10 +126,11 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_status_on(genpd)		(genpd->status == GPD_STATE_ACTIVE)
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
+#define genpd_is_no_runtime_off(genpd)	(genpd->flags & GENPD_FLAG_NO_RUNTIME_OFF)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
 {
 	bool ret;
@@ -513,11 +514,13 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	/*
 	 * Abort power off for the PM domain in the following situations:
 	 * (1) The domain is configured as always on.
 	 * (2) When the domain has a subdomain being powered on.
 	 */
-	if (genpd_is_always_on(genpd) || atomic_read(&genpd->sd_count) > 0)
+	if (genpd_is_always_on(genpd) ||
+			genpd_is_no_runtime_off(genpd) ||
+			atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
 		enum pm_qos_flags_status stat;
 
@@ -1813,11 +1816,12 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.stop = pm_clk_suspend;
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
 	/* Always-on domains must be powered on at initialization. */
-	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
+	if ((genpd_is_always_on(genpd) || genpd_is_no_runtime_off(genpd)) &&
+			!genpd_status_on(genpd))
 		return -EINVAL;
 
 	if (genpd_is_cpu_domain(genpd) &&
 	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
 		return -ENOMEM;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bc82e74560ee..c9f3137e2c00 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -51,16 +51,20 @@
  *				deploy idle power management support for CPUs
  *				and groups of CPUs. Note that, the backend
  *				driver must then comply with the so called,
  *				last-man-standing algorithm, for the CPUs in the
  *				PM domain.
+ *
+ * GENPD_FLAG_NO_RUNTIME_OFF:	Instructs genpd to always keep the PM domain
+ *				powered on except for system suspend.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
 #define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
+#define GENPD_FLAG_NO_RUNTIME_OFF (1U << 5) /* Never powered off by RPM */
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
 	GPD_STATE_POWER_OFF,	/* PM domain is off */
 };
-- 
2.17.1
