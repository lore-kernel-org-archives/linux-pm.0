From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 09/27] PM / Domains: Attempt runtime suspend of IRQ safe parent domain
Date: Tue, 17 Nov 2015 15:37:33 -0700
Message-ID: <1447799871-56374-10-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33679 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbbKQWie (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:34 -0500
Received: by pabfh17 with SMTP id fh17so22927696pab.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:34 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>

When a sub-domain is powered off, attempt powering off the parent
domains to maximize power savings. A sub-domain that is IRQ safe may
however have a parent that is not IRQ safe and therefore cannot be
powered down in atomic context that the sub-domain may be powered off.

An IRQ safe sub-domain may attempt to power down the parent domain in a
synchronous call, if the parent is also IRQ safe.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8df43f8..0310e2b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -44,6 +44,8 @@ static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async);
+
 static inline int genpd_lock_nosleep(struct generic_pm_domain *genpd,
 					unsigned int subclass)
 	__acquires(&genpd->slock)
@@ -298,6 +300,13 @@ static int __genpd_poweron(struct generic_pm_domain *genpd)
 					&genpd->slave_links,
 					slave_node) {
 		genpd_sd_counter_dec(link->master);
+
+		/* Assume masters that are non-irq safe are always-on */
+		if (genpd->irq_safe && link->master->irq_safe) {
+			genpd_poweroff(link->master, false);
+			continue;
+		}
+
 		genpd_queue_power_off_work(link->master);
 	}
 
@@ -448,6 +457,13 @@ static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
+
+		/* Assume masters that are non-irq safe are always-on */
+		if (genpd->irq_safe && link->master->irq_safe) {
+			genpd_poweroff(link->master, false);
+			continue;
+		}
+
 		genpd_queue_power_off_work(link->master);
 	}
 
-- 
2.1.4

