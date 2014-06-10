From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 12/24] PM / Domains: Remove pm_genpd_syscore_switch() API
Date: Tue, 10 Jun 2014 12:51:25 +0200
Message-ID: <1402397497-26737-13-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:60008 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaFJKwe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:34 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so3788524lab.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:33 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

The pm_genpd_syscore_poweroff() API and pm_genpd_syscore_poweron() API
makes the pm_genpd_syscore_switch() API redundant.

Moreover, since there are no active users, let's just remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |   17 ++++++++++++++---
 include/linux/pm_domain.h   |   16 ++++------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3b29477..2d20766 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1293,13 +1293,13 @@ static void pm_genpd_complete(struct device *dev)
 }
 
 /**
- * pm_genpd_syscore_switch - Switch power during system core suspend or resume.
+ * genpd_syscore_switch - Switch power during system core suspend or resume.
  * @dev: Device that normally is marked as "always on" to switch power for.
  *
  * This routine may only be called during the system core (syscore) suspend or
  * resume phase for devices whose "always on" flags are set.
  */
-void pm_genpd_syscore_switch(struct device *dev, bool suspend)
+static void genpd_syscore_switch(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
 
@@ -1315,7 +1315,18 @@ void pm_genpd_syscore_switch(struct device *dev, bool suspend)
 		genpd->suspended_count--;
 	}
 }
-EXPORT_SYMBOL_GPL(pm_genpd_syscore_switch);
+
+void pm_genpd_syscore_poweroff(struct device *dev)
+{
+	genpd_syscore_switch(dev, true);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweroff);
+
+void pm_genpd_syscore_poweron(struct device *dev)
+{
+	genpd_syscore_switch(dev, false);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #else
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 0e6205e..eacf6a1 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -249,21 +249,13 @@ static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-extern void pm_genpd_syscore_switch(struct device *dev, bool suspend);
+extern void pm_genpd_syscore_poweroff(struct device *dev);
+extern void pm_genpd_syscore_poweron(struct device *dev);
 #else
-static inline void pm_genpd_syscore_switch(struct device *dev, bool suspend) {}
+static inline void pm_genpd_syscore_poweroff(struct device *dev) {}
+static inline void pm_genpd_syscore_poweron(struct device *dev) {}
 #endif
 
-static inline void pm_genpd_syscore_poweroff(struct device *dev)
-{
-	pm_genpd_syscore_switch(dev, true);
-}
-
-static inline void pm_genpd_syscore_poweron(struct device *dev)
-{
-	pm_genpd_syscore_switch(dev, false);
-}
-
 /* OF power domain providers */
 struct of_device_id;
 
-- 
1.7.9.5

