From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 7/9] spi: core: Convert to dev_pm_domain_attach|detach()
Date: Tue,  9 Sep 2014 13:36:08 +0200
Message-ID: <1410262570-22785-8-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:44008 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437AbaIILhB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 07:37:01 -0400
Received: by mail-la0-f52.google.com with SMTP id b8so7547395lan.25
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 04:36:59 -0700 (PDT)
In-Reply-To: <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-spi@vger.kernel.org

Previously only the ACPI PM domain was supported by the spi bus.

Let's convert to the common attach/detach functions for PM domains,
which currently means we are extending the support to include the
generic PM domain as well.

Cc: linux-spi@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/spi/spi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ca935df..72a0beb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -264,10 +264,12 @@ static int spi_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	acpi_dev_pm_attach(dev, true);
-	ret = sdrv->probe(to_spi_device(dev));
-	if (ret)
-		acpi_dev_pm_detach(dev, true);
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret != -EPROBE_DEFER) {
+		ret = sdrv->probe(to_spi_device(dev));
+		if (ret)
+			dev_pm_domain_detach(dev, true);
+	}
 
 	return ret;
 }
@@ -278,7 +280,7 @@ static int spi_drv_remove(struct device *dev)
 	int ret;
 
 	ret = sdrv->remove(to_spi_device(dev));
-	acpi_dev_pm_detach(dev, true);
+	dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
1.9.1

