From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 8/9] amba: Add support for attach/detach of power domains
Date: Thu, 28 Aug 2014 10:39:01 +0200
Message-ID: <1409215142-8218-9-git-send-email-ulf.hansson@linaro.org>
References: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59620 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936410AbaH1Ija (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 04:39:30 -0400
Received: by mail-lb0-f173.google.com with SMTP id c11so498840lbj.32
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2014 01:39:29 -0700 (PDT)
In-Reply-To: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>

AMBA devices may on some SoCs resides in power domains. To be able to
manage these devices from there, let's try to attach devices to their
corresponding power domain during the probe phase.

To reverse these actions at the remove phase, we try to detach the
device from it's power domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 3cf61a1..8f52393 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -182,9 +182,15 @@ static int amba_probe(struct device *dev)
 	int ret;
 
 	do {
+		ret = dev_pm_domain_attach(dev, true);
+		if (ret == -EPROBE_DEFER)
+			break;
+
 		ret = amba_get_enable_pclk(pcdev);
-		if (ret)
+		if (ret) {
+			dev_pm_domain_detach(dev, true);
 			break;
+		}
 
 		pm_runtime_get_noresume(dev);
 		pm_runtime_set_active(dev);
@@ -199,6 +205,7 @@ static int amba_probe(struct device *dev)
 		pm_runtime_put_noidle(dev);
 
 		amba_put_disable_pclk(pcdev);
+		dev_pm_domain_detach(dev, true);
 	} while (0);
 
 	return ret;
@@ -220,6 +227,7 @@ static int amba_remove(struct device *dev)
 	pm_runtime_put_noidle(dev);
 
 	amba_put_disable_pclk(pcdev);
+	dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
1.9.1

