From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/9] amba: Keep PM domain powered during ->probe()
Date: Fri, 13 Mar 2015 16:43:43 +0100
Message-ID: <1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:33728 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756987AbbCMPoN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:44:13 -0400
Received: by labmn12 with SMTP id mn12so23556209lab.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:44:12 -0700 (PDT)
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
 drivers/amba/bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f009936..19182b0 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -241,8 +241,15 @@ static int amba_probe(struct device *dev)
 		if (ret == -EPROBE_DEFER)
 			break;
 
+		ret = dev_pm_domain_get(dev->pm_domain);
+		if (ret) {
+			dev_pm_domain_detach(dev, true);
+			break;
+		}
+
 		ret = amba_get_enable_pclk(pcdev);
 		if (ret) {
+			dev_pm_domain_put(dev->pm_domain);
 			dev_pm_domain_detach(dev, true);
 			break;
 		}
@@ -252,6 +259,7 @@ static int amba_probe(struct device *dev)
 		pm_runtime_enable(dev);
 
 		ret = pcdrv->probe(pcdev, id);
+		dev_pm_domain_put(dev->pm_domain);
 		if (ret == 0)
 			break;
 
-- 
1.9.1

