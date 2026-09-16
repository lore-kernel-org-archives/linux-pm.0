Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558A3ED5B9
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541378; cv=none; b=Mz9EvikxVzHRq05Xgux6D6KxuhKc1cWk7lZnZre8udy2EUFVfoOGjFmi4/JMGi9C9xZRinloK9/UKbpfmGcwW/qa4Fgug0fOIGWDUQncrlBBXfSlWTGsYj7qpxocu2P+0eIuOTqT5EYk4MQhCxtmosBX/KAVcNEkyvwxPQSeXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541378; c=relaxed/simple;
	bh=kwRurD/h0ClFmNL/4vWfvQdcVQ3aUJNHb9pqHg6tXbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtdDz9JSJGmN2WKqa9oXHj9jN68258eBVL2H3N8b0kzzBYoJyDbdKvOiFlrP/1EtSxvUElldQMl9x1+9yZFrp6DjO5Rdy4lOsAJPEyKvFJqstpd2IN86X8f7eYUi6hY+do3UoHiLSnLThgmI3lr7h+S/vNjw461fGVjp711X3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+msvxr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+msvxr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1F51F00898;
	Wed, 16 Sep 2026 06:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541376;
	bh=cFMEZXweoG/CK8VtGXk1sym6jBYDfaVNx8tqFwVih3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z+msvxr36y9i82/pi2cpD8KIY0MklY2fxDt+5h9TQaSU+ixb9PVu0zDtpsjh0kdxf
	 6oCMfp48MPzsIqS/gIR8cI/E728o4yaM0BuFrkC/daxf6jvdiAywF6JiE4KxFt+iDS
	 XzehtITL5YzoWTIyjo8dvf0Pl9I8iQNRWxDuVTpnlgEkgk3LF/tlVA3juJZEECdujU
	 CJynvlO34IE74h5f24eKcqiLRVm/ASu5VFNG/vDFcNJtgrSCQFCwb6HkQvUncWUTmZ
	 Txwa3Wm2IuRqpLCyrjTxgYSERzTPlcwYLPAcyN16be+R2Y+SsaL6bwpsXjcDPJn62U
	 3kgtesb6qFnxg==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:31 +0200
Subject: [PATCH 09/15] power: supply: ab8500_charger: Respect AB8505
 register layout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-9-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Several AB8505 charger fields differ from AB8500. Its long VBUS
falling debounce is 300 ms rather than 100 ms, and its VBUS
overvoltage selector has a different encoding programmed through OTP.
Writing the AB8500 6.3 V value selects 9 V on AB8505.

AB8505 revision 3 also defines SwControlFallback as reserved,
correcting older documentation which led the driver to support
autopower there. Preserve the AB8505 overvoltage setting, wait for its
documented debounce, and reject the unsupported autopower setting.

Fixes: 0ed5107fa860 ("ab8500-charger: Do not touch VBUSOVV bits")
Fixes: b016322293c7 ("ab8500-charger: Add support for autopower on AB8505 and AB9540")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_charger.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 4810dfbe948d..08042ef222be 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -52,7 +52,7 @@
 #define MAIN_CH_DET			0x01
 #define MAIN_CH_CV_ON			0x04
 #define USB_CH_CV_ON			0x08
-#define VBUS_DET_DBNC100		0x02
+#define VBUS_DET_DBNC_LONG		0x02
 #define VBUS_DET_DBNC1			0x01
 #define OTP_ENABLE_WD			0x01
 #define DROP_COUNT_RESET		0x01
@@ -383,6 +383,10 @@ static void ab8500_enable_disable_sw_fallback(struct ab8500_charger *di,
 	u8 bit;
 	int ret;
 
+	/* SwControlFallback is reserved and must remain clear on AB8505. */
+	if (is_ab8505(di->parent))
+		return;
+
 	dev_dbg(di->dev, "SW Fallback: %d\n", fallback);
 
 	if (is_ab8500(di->parent)) {
@@ -703,12 +707,16 @@ static int ab8500_charger_detect_chargers(struct ab8500_charger *di, bool probe)
 
 	if (!probe) {
 		/*
-		 * AB8500 says VBUS_DET_DBNC1 & VBUS_DET_DBNC100
+		 * AB8500 says VBUS_DET_DBNC1 & VBUS_DET_DBNC_LONG
 		 * when disconnecting ACA even though no
 		 * charger was connected. Try waiting a little
-		 * longer than the 100 ms of VBUS_DET_DBNC100...
+		 * longer than its 100 ms debounce. AB8505 uses
+		 * a 300 ms falling debounce for the same bit.
 		 */
-		msleep(110);
+		if (is_ab8505(di->parent))
+			msleep(310);
+		else
+			msleep(110);
 	}
 	ret = abx500_get_register_interruptible(di->dev, AB8500_CHARGER,
 		AB8500_CH_USBCH_STAT1_REG, &val);
@@ -719,7 +727,7 @@ static int ab8500_charger_detect_chargers(struct ab8500_charger *di, bool probe)
 	dev_dbg(di->dev,
 		"%s AB8500_CH_USBCH_STAT1_REG %x\n", __func__,
 		val);
-	if ((val & VBUS_DET_DBNC1) && (val & VBUS_DET_DBNC100))
+	if ((val & VBUS_DET_DBNC1) && (val & VBUS_DET_DBNC_LONG))
 		result |= USB_PW_CONN;
 
 	return result;
@@ -3185,7 +3193,7 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 		}
 	}
 
-	if (is_ab8505_2p0(di->parent))
+	if (is_ab8505(di->parent))
 		ret = abx500_mask_and_set_register_interruptible(di->dev,
 			AB8500_CHARGER,
 			AB8500_USBCH_CTRL2_REG,
@@ -3534,11 +3542,14 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	di->bm = &ab8500_bm_data;
 
-	di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
-
 	/* get parent data */
 	di->dev = dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
+	di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
+	if (di->autopower_cfg && is_ab8505(di->parent)) {
+		dev_warn(dev, "autopower is not supported on AB8505\n");
+		di->autopower_cfg = false;
+	}
 
 	/* Get ADC channels */
 	if (!is_ab8505(di->parent)) {

-- 
2.55.0

