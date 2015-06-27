From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 05/16] arm: domain: Remove hack to add dev->driver.
Date: Fri, 26 Jun 2015 21:02:25 -0600
Message-ID: <1435374156-19214-6-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33604 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbF0DCw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:52 -0400
Received: by pdjn11 with SMTP id n11so84890608pdj.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:52 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Fixed in Generic PM domains framework.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/domains.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
index 8388f54..3248409 100644
--- a/arch/arm/kernel/domains.c
+++ b/arch/arm/kernel/domains.c
@@ -48,26 +48,6 @@ static int arm_domain_cpu_init(void)
 			return -ENODEV;
 		}
 
-		/* 
-		 * HACK: genpd checks if devices are runtime_suspended
-		 * before doing a poweroff of the domain.  However, that check
-		 * assumes that that device has a driver.  Since CPU devices don't
-		 * have a driver, genpd assumes that the device is runtime_suspended
-		 * and will power off the domain as soon as the any device 
-		 * in the domain does a runtime_suspend.
-		 *
-		 * c.f. the following code in pm_genpd_poweroff():
-		 *
-		 * if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
-		 *      || pdd->dev->power.irq_safe))
-		 *  	not_suspended++;
-		 *
-		 * Just removing the pdd->dev->driver check would also work, 
-		 * but not sure if that's right in the general case.
-		 */
-		cpu_dev->driver = kzalloc(sizeof(struct device_driver), GFP_KERNEL);
-		WARN_ON(!cpu_dev->driver);
-
 		if (cpu_online(cpuid)) {
 			pm_runtime_set_active(cpu_dev);
 			pm_runtime_get_noresume(cpu_dev);
-- 
2.1.4

