From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v5 05/11] drivercore / platform: Convert to dev_pm_domain_attach|detach()
Date: Fri, 19 Sep 2014 20:27:38 +0200
Message-ID: <1411151264-16245-6-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40375 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750AbaISS2H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 14:28:07 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so606356pab.4
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2014 11:28:05 -0700 (PDT)
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Previously only the ACPI PM domain was supported by the platform bus.

Let's convert to the common attach/detach functions for PM domains,
which currently means we are extending the support to include the
generic PM domain as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/base/platform.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ab4f4ce..904be3d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -506,11 +506,12 @@ static int platform_drv_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	acpi_dev_pm_attach(_dev, true);
-
-	ret = drv->probe(dev);
-	if (ret)
-		acpi_dev_pm_detach(_dev, true);
+	ret = dev_pm_domain_attach(_dev, true);
+	if (ret != -EPROBE_DEFER) {
+		ret = drv->probe(dev);
+		if (ret)
+			dev_pm_domain_detach(_dev, true);
+	}
 
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
 		dev_warn(_dev, "probe deferral not supported\n");
@@ -532,7 +533,7 @@ static int platform_drv_remove(struct device *_dev)
 	int ret;
 
 	ret = drv->remove(dev);
-	acpi_dev_pm_detach(_dev, true);
+	dev_pm_domain_detach(_dev, true);
 
 	return ret;
 }
@@ -543,7 +544,7 @@ static void platform_drv_shutdown(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 
 	drv->shutdown(dev);
-	acpi_dev_pm_detach(_dev, true);
+	dev_pm_domain_detach(_dev, true);
 }
 
 /**
-- 
1.9.1

