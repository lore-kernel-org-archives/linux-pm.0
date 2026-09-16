Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268DA4BEE43
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541382; cv=none; b=JigkE2YJzDfBu+KU6bD69BcyUM61rb/ObOT1xXCSIw0TNPXxyDs0rP06zxaVCib3Wa4gAerBbV9Hrr3MghUw0KbYiwMTSf1st507/CbibbdXHDN4Wev49/jAv4SZLc17Gcu84atC5guc08BkRTRuAa+XONaUGlXX1P2syCHLw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541382; c=relaxed/simple;
	bh=l2w8rqa+oRtITU8k6R8swpkO4gvrg46A1uEcLkeQ1gQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VW0Km+0D0ewuZ9mm65X8KFLguwOlee143CSbwHI2d795UZL+RjqraCwhqpviqTwiHUa6Uw0q00Z277AZJOxVWT+73TVx7hCsP8TIlyG/hgEKO2uzXyB42slzpAgbzBsWgnE05nZmYDEEbP2ooVDMV7coYNkcPQoDQ5EcnQQug9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euSCwRHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euSCwRHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0AF1F000FF;
	Wed, 16 Sep 2026 06:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541381;
	bh=0Ccy10gPl+NJxVI+xDW8Yh5V/AoKmyAbULXXi9H2Yr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=euSCwRHYtcUBMkeWNBswvj0klvhtUKt1DLjt0YyW0BphWZvIT7xARpYxOq/GbN4HY
	 IEo+XM4SwNIiw9P2jAQnLNnjdxVklrl5jhI7DRy9AGMAqJKkebEEgaAXINBuP10WNV
	 SLcuD0wSjwn09XI65ZJaAHrEeWmBIrbIrl538HIiKEygKAPdBQmAZKWQHQpqk+c1Yd
	 7QGXjp73p/hRdj4W1j1v5YU09BfqEYHMOhvwS1f2MU4kfdZDQpyZKrc40faLqfXb0b
	 UE2uaiJolSlBeqeJJRXGJmxiLRq9cshRehEJbhSgOnehTKPLjbGk7+4nFlWmQziKNk
	 +vukB1IpOvc0g==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:35 +0200
Subject: [PATCH 13/15] power: supply: ab8500_charger: Recover inactive
 AB8505 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-13-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

UsbChCtrl1.UsbChEna can remain set while UsbChStatus1.UsbChOn is
clear. The existing recovery only checks the control bit, so it considers
the charger enabled and leaves charging stopped.

The Samsung-GT-S7710-Skomer, Samsung-SGH-I407-Kyle, and
Samsung-SGH-T599-Codina-TMO product trees are reference points for
checking both bits and cycling the charger when they disagree.

Extend the USB charger check to detect this AB8505 state and enable the
check in the charging algorithm for AB8505. Only cycle the charger when
VBUS is debounced and no charger-not-OK, thermal, overvoltage, or
watchdog fault accounts for the inactive hardware.

Fixes: 4dcdf57773fd ("ab8500-bm: Quick re-attach charging behaviour")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_chargalg.c |  9 ++----
 drivers/power/supply/ab8500_charger.c  | 51 +++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index d2b9880b0770..71d82c6c193e 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1241,12 +1241,9 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 
 	charger_status = ab8500_chargalg_check_charger_connection(di);
 
-	if (is_ab8500(di->parent)) {
-		ret = ab8500_chargalg_check_charger_enable(di);
-		if (ret < 0)
-			dev_err(di->dev, "Checking charger is enabled error"
-					": Returned Value %d\n", ret);
-	}
+	ret = ab8500_chargalg_check_charger_enable(di);
+	if (ret < 0)
+		dev_err(di->dev, "Checking charger enable failed: %d\n", ret);
 
 	/*
 	 * First check if we have a charger connected.
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 8430bc247df7..19cc56624ee4 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -52,6 +52,7 @@
 #define MAIN_CH_DET			0x01
 #define MAIN_CH_CV_ON			0x04
 #define USB_CH_CV_ON			0x08
+#define USB_CH_ON			0x04
 #define VBUS_DET_DBNC_LONG		0x02
 #define VBUS_DET_DBNC1			0x01
 #define OTP_ENABLE_WD			0x01
@@ -1877,6 +1878,9 @@ static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
 	int vset_uv, int iset_ua)
 {
 	u8 usbch_ctrl1 = 0;
+	u8 usbch_status1;
+	u8 usbch_status2;
+	bool reenable;
 	int ret = 0;
 
 	struct ab8500_charger *di = to_ab8500_charger_usb_device_info(charger);
@@ -1892,7 +1896,52 @@ static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
 	}
 	dev_dbg(di->dev, "USB charger ctrl: 0x%02x\n", usbch_ctrl1);
 
-	if (!(usbch_ctrl1 & USB_CH_ENA)) {
+	reenable = !(usbch_ctrl1 & USB_CH_ENA);
+	if (is_ab8505(di->parent)) {
+		ret = abx500_get_register_interruptible(di->dev,
+							AB8500_CHARGER,
+							AB8500_CH_USBCH_STAT1_REG,
+							&usbch_status1);
+		if (ret < 0) {
+			dev_err(di->dev, "USB charger status read failed\n");
+			return ret;
+		}
+
+		if (!reenable && (usbch_status1 & USB_CH_ON))
+			return 0;
+
+		if (!(usbch_status1 & VBUS_DET_DBNC_LONG))
+			return 0;
+
+		ret = abx500_get_register_interruptible(di->dev,
+							AB8500_CHARGER,
+							AB8500_CH_USBCH_STAT2_REG,
+							&usbch_status2);
+		if (ret < 0) {
+			dev_err(di->dev, "USB charger fault status read failed\n");
+			return ret;
+		}
+
+		if ((usbch_status2 &
+		     (VBUS_CH_NOK | USB_CH_TH_PROT | VBUS_OVV_TH)) ||
+		    di->flags.usbchargernotok || di->flags.usb_thermal_prot ||
+		    di->flags.vbus_ovv || di->usb.wd_expired)
+			return 0;
+
+		if (!reenable) {
+			dev_info(di->dev,
+				 "USB charger enabled but inactive, cycling it\n");
+			ret = abx500_mask_and_set_register_interruptible(di->dev,
+									 AB8500_CHARGER,
+									 AB8500_USBCH_CTRL1_REG,
+									 USB_CH_ENA, 0);
+			if (ret < 0)
+				return ret;
+			reenable = true;
+		}
+	}
+
+	if (reenable) {
 		dev_info(di->dev, "Charging has been disabled abnormally and will be re-enabled\n");
 
 		ret = abx500_mask_and_set_register_interruptible(di->dev,

-- 
2.55.0

