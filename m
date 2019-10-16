Return-Path: <SRS0=MfD0=YJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F8FA372B
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7A621848
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 22:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbfJPWaM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:30:12 -0400
Received: from muru.com ([72.249.23.125]:37650 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfJPWaM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:30:12 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 20D6B8198;
        Wed, 16 Oct 2019 22:30:46 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/2] power: supply: cpcap-charger: Improve battery detection
Date:   Wed, 16 Oct 2019 15:30:05 -0700
Message-Id: <20191016223005.9246-3-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016223005.9246-1-tony@atomide.com>
References: <20191016223005.9246-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are currently using a wrong ADC range for the battery detection.
The ADC returns the battery temperature if connected.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -176,20 +176,21 @@ static enum power_supply_property cpcap_charger_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
+/* No battery always shows temperature of -40000 */
 static bool cpcap_charger_battery_found(struct cpcap_charger_ddata *ddata)
 {
 	struct iio_channel *channel;
-	int error, value;
+	int error, temperature;
 
 	channel = ddata->channels[CPCAP_CHARGER_IIO_BATTDET];
-	error = iio_read_channel_raw(channel, &value);
+	error = iio_read_channel_processed(channel, &temperature);
 	if (error < 0) {
 		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
 
 		return false;
 	}
 
-	return value == 1;
+	return temperature > -20000 && temperature < 60000;
 }
 
 static int cpcap_charger_get_charge_voltage(struct cpcap_charger_ddata *ddata)
-- 
2.23.0
