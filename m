From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Correct comment in irq_safe_dev_in_no_sleep_domain()
Date: Tue, 31 Jan 2017 17:01:03 +0100
Message-ID: <1485878463-1672-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34844 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdAaQHn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 11:07:43 -0500
Received: by mail-lf0-f47.google.com with SMTP id n124so213428837lfd.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2017 08:07:42 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>

The earlier comment stated that the dev_warn_once() was going to be printed
once per device. Let's fix that, as dev_warn_once() is printed only once,
no matter of the device.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6b23d82..271e208 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -130,7 +130,7 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 
 	ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
 
-	/* Warn once for each IRQ safe dev in no sleep domain */
+	/* Warn once if IRQ safe dev in no sleep domain */
 	if (ret)
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
 				genpd->name);
-- 
1.9.1

