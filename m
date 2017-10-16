From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 04/10] PM / Domain: Allow genpd users to specify default active wakeup behavior
Date: Mon, 16 Oct 2017 15:55:10 +0200
Message-ID: <1508162116-5043-5-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58696 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbdJPNz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 09:55:28 -0400
In-Reply-To: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

It is quite common for PM Domains to require slave devices to be kept
active during system suspend if they are to be used as wakeup sources.
To enable this, currently each PM Domain or driver has to provide its
own gpd_dev_ops.active_wakeup() callback.

Introduce a new flag GENPD_FLAG_ACTIVE_WAKEUP to consolidate this.
If specified, a default callback that always returns true will be
installed in gpd_dev_ops.active_wakeup().

PM Domains that need more fine-grained controls can still provide their
own callbacks, as before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/domain.c | 8 ++++++++
 include/linux/pm_domain.h   | 7 ++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e8ca5e2cf1e51e5a..d9670e7752e92994 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1168,6 +1168,11 @@ static void pm_genpd_complete(struct device *dev)
 	genpd_unlock(genpd);
 }
 
+static bool pm_genpd_active_wakeup_true(struct device *dev)
+{
+	return true;
+}
+
 /**
  * genpd_syscore_switch - Switch power during system core suspend or resume.
  * @dev: Device that normally is marked as "always on" to switch power for.
@@ -1214,6 +1219,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #define pm_genpd_poweroff_noirq		NULL
 #define pm_genpd_restore_noirq		NULL
 #define pm_genpd_complete		NULL
+#define pm_genpd_active_wakeup_true	NULL
 
 #endif /* CONFIG_PM_SLEEP */
 
@@ -1587,6 +1593,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.stop = pm_clk_suspend;
 		genpd->dev_ops.start = pm_clk_resume;
 	}
+	if (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
+		genpd->dev_ops.active_wakeup = pm_genpd_active_wakeup_true;
 
 	/* Always-on domains must be powered on at initialization. */
 	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 84f423d5633ee996..a6688efb29ee5406 100644
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
