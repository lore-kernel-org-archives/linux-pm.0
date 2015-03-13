From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 8/9] mmmc: core: Keep PM domain powered during ->probe() of SDIO func driver
Date: Fri, 13 Mar 2015 16:43:48 +0100
Message-ID: <1426261429-31883-9-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:43309 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756885AbbCMPoY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:44:24 -0400
Received: by lbvp9 with SMTP id p9so23647336lbv.10
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:44:23 -0700 (PDT)
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
 drivers/mmc/core/sdio_bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 71357b8..0d89b4b 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -320,7 +320,14 @@ int sdio_add_func(struct sdio_func *func)
 	if (ret)
 		return ret;
 
+	ret = dev_pm_domain_get(func->dev.pm_domain);
+	if (ret) {
+		dev_pm_domain_detach(&func->dev, false);
+		return ret;
+	}
+
 	ret = device_add(&func->dev);
+	dev_pm_domain_put(func->dev.pm_domain);
 	if (ret) {
 		dev_pm_domain_detach(&func->dev, false);
 		return ret;
-- 
1.9.1

