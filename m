Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9423FC10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C392086A
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555396829;
	bh=LprYqWAwQlV4mdWW7mU+WdVxasqOzsOCbNzRMa+yKgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=abByfS1Kynpwo+vZoJSYuEPWgL8YXHWlceTPLrUHtqZktKKVR0Czv+1eUXjLeYadf
	 7FbU+eD17DPomzD3GSZ9Z8x/LEu3U2fmTXovPLJ5MM1rstZR6ctUsQ57LQycEEcqHj
	 Jx+7wXhvCVzpPQ2SXzFz6cESB8G+nU8KMjTEhKHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfDPGk2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:40:28 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33988 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDPGk2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Apr 2019 02:40:28 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 9AF5260292; Tue, 16 Apr 2019 14:40:25 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 4/7] power: supply: axp20x_usb_power: add function to get max current
Date:   Tue, 16 Apr 2019 14:40:21 +0800
Message-Id: <20190416064024.20414-5-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416064021.ZGTJqcHg7jTQzgz-pZr66487HsJ0WBRDxdnx9iytlwE@z>

From: Quentin Schulz <quentin.schulz@bootlin.com>

To prepare for a new PMIC, factor out the code responsible of returning
the maximum current to axp20x_get_current_max.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 52 ++++++++++++++-----------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 290028aed230..04c2cafbe8e6 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -102,6 +102,35 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	return false;
 }
 
+static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
+	case AXP20X_VBUS_CLIMIT_100mA:
+		if (power->axp20x_id == AXP221_ID)
+			*val = -1; /* No 100mA limit */
+		else
+			*val = 100000;
+		break;
+	case AXP20X_VBUS_CLIMIT_500mA:
+		*val = 500000;
+		break;
+	case AXP20X_VBUS_CLIMIT_900mA:
+		*val = 900000;
+		break;
+	case AXP20X_VBUS_CLIMIT_NONE:
+		*val = -1;
+		break;
+	}
+
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -140,28 +169,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
-		if (ret)
-			return ret;
-
-		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-		case AXP20X_VBUS_CLIMIT_100mA:
-			if (power->axp20x_id == AXP221_ID)
-				val->intval = -1; /* No 100mA limit */
-			else
-				val->intval = 100000;
-			break;
-		case AXP20X_VBUS_CLIMIT_500mA:
-			val->intval = 500000;
-			break;
-		case AXP20X_VBUS_CLIMIT_900mA:
-			val->intval = 900000;
-			break;
-		case AXP20X_VBUS_CLIMIT_NONE:
-			val->intval = -1;
-			break;
-		}
-		return 0;
+		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
 			ret = iio_read_channel_processed(power->vbus_i,
-- 
2.20.1

