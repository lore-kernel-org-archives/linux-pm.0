From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 7/9] mmc: core: Attach PM domain prior probing of SDIO func driver
Date: Mon, 13 Oct 2014 16:02:08 +0200
Message-ID: <1413208930-26019-8-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:51625 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbaJMOCp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Oct 2014 10:02:45 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so8757248wgg.20
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2014 07:02:44 -0700 (PDT)
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

Align the behvaior to how other buses are handling attachment of PM
domains. Additionally, let's add error handling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 65cf7a7..ba97779 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -313,13 +313,19 @@ int sdio_add_func(struct sdio_func *func)
 	dev_set_name(&func->dev, "%s:%d", mmc_card_id(func->card), func->num);
 
 	sdio_acpi_set_handle(func);
+
+	ret = dev_pm_domain_attach(&func->dev, false);
+	if (ret)
+		return ret;
+
 	ret = device_add(&func->dev);
-	if (ret == 0) {
-		sdio_func_set_present(func);
-		dev_pm_domain_attach(&func->dev, false);
+	if (ret) {
+		dev_pm_domain_detach(&func->dev, false);
+		return ret;
 	}
 
-	return ret;
+	sdio_func_set_present(func);
+	return 0;
 }
 
 /*
-- 
1.9.1

