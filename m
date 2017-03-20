From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] PM / Domains: Don't warn about IRQ safe device for an always on PM domain
Date: Mon, 20 Mar 2017 11:19:23 +0100
Message-ID: <1490005163-28633-5-git-send-email-ulf.hansson@linaro.org>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34598 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753688AbdCTKUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 06:20:23 -0400
Received: by mail-lf0-f51.google.com with SMTP id z15so53400734lfd.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 03:19:39 -0700 (PDT)
In-Reply-To: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

When an IRQ safe device is attached to a no sleep domain, genpd prints a
warning once, as to indicate it is a suboptimal configuration from power
consumption point of view.

However the warning doesn't make sense for an always on domain, since it
anyway remains powered on. Therefore, let's change to not print the warning
for this configuration.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8a2bfc8..bfba02f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -132,8 +132,12 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 
 	ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
 
-	/* Warn once if IRQ safe dev in no sleep domain */
-	if (ret)
+	/*
+	 * Warn once if an IRQ safe device is attached to a no sleep domain, as
+	 * to indicate a suboptimal configuration for PM. For an always on
+	 * domain this isn't case, thus don't warn.
+	 */
+	if (ret && !genpd_is_always_on(genpd))
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
 				genpd->name);
 
-- 
2.7.4
