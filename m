From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/9] i2c: core: Keep PM domain powered during ->probe()
Date: Fri, 13 Mar 2015 16:43:45 +0100
Message-ID: <1426261429-31883-6-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:36979 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757131AbbCMPoS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:44:18 -0400
Received: by labgq15 with SMTP id gq15so23487229lab.4
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:44:16 -0700 (PDT)
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
 drivers/i2c/i2c-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 210cf48..0eabe55 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -655,8 +655,15 @@ static int i2c_device_probe(struct device *dev)
 
 	status = dev_pm_domain_attach(&client->dev, true);
 	if (status != -EPROBE_DEFER) {
+		status = dev_pm_domain_get(client->dev.pm_domain);
+		if (status) {
+			dev_pm_domain_detach(&client->dev, true);
+			return status;
+		}
+
 		status = driver->probe(client, i2c_match_id(driver->id_table,
 					client));
+		dev_pm_domain_put(client->dev.pm_domain);
 		if (status)
 			dev_pm_domain_detach(&client->dev, true);
 	}
-- 
1.9.1

