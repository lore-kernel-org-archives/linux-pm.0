From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 8/9] mmmc: core: Keep PM domain powered during ->probe() of SDIO func driver
Date: Mon, 13 Oct 2014 16:02:09 +0200
Message-ID: <1413208930-26019-9-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:51264 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbaJMOCs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Oct 2014 10:02:48 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so7517254wiv.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2014 07:02:47 -0700 (PDT)
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index ba97779..83c8836 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -318,7 +318,14 @@ int sdio_add_func(struct sdio_func *func)
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

