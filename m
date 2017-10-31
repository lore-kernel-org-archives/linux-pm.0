From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/5] PM / Domains: Allow genpd users to specify default active wakeup behavior
Date: Tue, 31 Oct 2017 19:11:30 +0100
Message-ID: <1509473494-19740-2-git-send-email-geert+renesas@glider.be>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

It is quite common for PM Domains to require slave devices to be kept
active during system suspend if they are to be used as wakeup sources.
To enable this, currently each PM Domain or driver has to provide its
own gpd_dev_ops.active_wakeup() callback.

Introduce a new flag GENPD_FLAG_ACTIVE_WAKEUP to consolidate this.
If specified, all slave devices configured as wakeup sources will be
kept active during system suspend.

PM Domains that need more fine-grained controls, based on the slave
device, can still provide their own callbacks, as before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use the flag in se instead of setting up an "always true" callback.
---
 drivers/base/power/domain.c | 3 +++
 include/linux/pm_domain.h   | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7eaee557aa615dbc..c5172d70b742f288 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -124,6 +124,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_status_on(genpd)		(genpd->status == GPD_STATE_ACTIVE)
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
+#define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -866,6 +867,8 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 static bool genpd_dev_active_wakeup(const struct generic_pm_domain *genpd,
 				    struct device *dev)
 {
+	if (genpd_is_active_wakeup(genpd))
+		return true;
 	return GENPD_DEV_CALLBACK(genpd, bool, active_wakeup, dev);
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9af0356bd69c1597..28c24c58d479e3b4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -18,9 +18,10 @@
 #include <linux/spinlock.h>
 
 /* Defines used for the flags field in the struct generic_pm_domain */
-#define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
-#define GENPD_FLAG_IRQ_SAFE	(1U << 1) /* PM domain operates in atomic */
-#define GENPD_FLAG_ALWAYS_ON	(1U << 2) /* PM domain is always powered on */
+#define GENPD_FLAG_PM_CLK	 (1U << 0) /* PM domain uses PM clk */
+#define GENPD_FLAG_IRQ_SAFE	 (1U << 1) /* PM domain operates in atomic */
+#define GENPD_FLAG_ALWAYS_ON	 (1U << 2) /* PM domain is always powered on */
+#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3) /* Keep devices active if wakeup */
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-- 
2.7.4
