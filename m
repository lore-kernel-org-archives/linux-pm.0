From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/9] drivercore / platform: Keep PM domain powered during ->probe()
Date: Fri, 13 Mar 2015 16:43:44 +0100
Message-ID: <1426261429-31883-5-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39938 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851AbbCMPoP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:44:15 -0400
Received: by lbiw7 with SMTP id w7so23679531lbi.7
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:44:14 -0700 (PDT)
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/platform.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9421fed..d35fef1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -509,7 +509,14 @@ static int platform_drv_probe(struct device *_dev)
 
 	ret = dev_pm_domain_attach(_dev, true);
 	if (ret != -EPROBE_DEFER) {
+		ret = dev_pm_domain_get(_dev->pm_domain);
+		if (ret) {
+			dev_pm_domain_detach(_dev, true);
+			return ret;
+		}
+
 		ret = drv->probe(dev);
+		dev_pm_domain_put(_dev->pm_domain);
 		if (ret)
 			dev_pm_domain_detach(_dev, true);
 	}
-- 
1.9.1

