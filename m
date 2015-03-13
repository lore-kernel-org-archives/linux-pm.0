From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 9/9] Revert "PM / Domains: Power on the PM domain right after attach completes"
Date: Fri, 13 Mar 2015 16:43:49 +0100
Message-ID: <1426261429-31883-10-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45031 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161043AbbCMPo0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:44:26 -0400
Received: by lbvn10 with SMTP id n10so23662788lbv.11
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:44:25 -0700 (PDT)
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Due to the invent of dev_pm_domain_get|put() API and related code in the
generic PM domain, we can now safely revert this commit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7314459..e89eb74 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2220,7 +2220,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
-	pm_genpd_poweron(pd);
 
 	return 0;
 }
-- 
1.9.1

