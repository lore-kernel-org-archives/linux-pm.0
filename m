Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502901;
	b=dD/qtLfJtBH/nAiicnV9f9kkBLQUY+ToGD88gaNE/ctcWKCWbUeiNdBResjn9PDpcMaF
	 AzFZ6nL5hUag/9yi6yaXf8cciSv3U8psaPcnaPUImNCI/RsVI6HDBgsJI0fsmG/97dtjZ
	 8uLvVmpqO/AStK5Xi+L83vO99P7nY5JkPNeJ86RcdibOYRclVbRujunKqCgnsrRiobeLv
	 8XmhNbIjhLU1TyGN4T+cAq8p4xCs6SWEMjrivZc1RCMKyapTozaCguD2FlGxAYCHxyFXh
	 Sf1SAbIVubGgZ9vyU3e5OBsaWKohflCC8HdXd6QfaW2kp1LLw6BxqLtXNnHsUNP/a7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502901;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RORxRwb5/DmurP0FfkMtcwvXHMALG7NTq8gSS0b/OHo=;
	b=JO+zc2LqTV0lRXNnePk/Id5AqF33+ETZHJQIsMPW27Oze+I2D4kvri+z+b8oyHVOVG0F
	 y8Fm7O00cIY+Ao2Hc7zCcpiAjeRzGNXkL6C0phgwyignHkOySCtaJ91jhhM7w2Ql17QdS
	 3EOWPLMMZfFG1Uk8LPW3ATpaTImsJ4V/N8u9DW9xkvmGQi3EPvoDRpkKy9MXSZw/ArEdj
	 OpGlGJmmX2C2AldsYVoVepvDlHi9ZwMokUBA/LE/JQL1JGPRRgh+9PuuMXVRoTjsV9N/x
	 47ofyNe1o3i/pAkgafjB+75pZpp8ApDD3c1gYckt4Yh5YIFeOoEJFRnPA/+iL3cTqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7HSAaVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267F606A31C;
	Tue, 20 Oct 2026 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7HSAaVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A351F000C4;
	Tue, 20 Oct 2026 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502901;
	bh=RORxRwb5/DmurP0FfkMtcwvXHMALG7NTq8gSS0b/OHo=;
	h=From:Date:Subject:To:Cc;
	b=D7HSAaVqgjBc6JoobJSjHQ7U9G7aLvwZ0sdmzZGqSAw7AB+1GR/G5rjn570vgqe6s
	 EnncGnjovpeeHPkUTiatxOxtTU4c9VUU6oEJVdNn7Eeaffpn0QXDl5ooOQ7Z4ajHsf
	 QWgZ0tuH2DjzhqlMyA55B3o/bgIhGOMBL+KvDYfo5OW1+/QReyjfFwa5jQIx1ZI+qe
	 ZjrU9LN8mWY2kv6bKFCxSaI7WVv3jI8TTwtS29Nc7dNYDLUk5Py1BH6b4viYqPs+8h
	 XWzM5+aBu/mYzKOsJxqjtjVIdRHDORB2S2My6WHgvxgGisMcEejw+pPv9R3P1ONmPO
	 uQdyqPVEb0syw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 20 Oct 2026 15:28:08 +0200
Subject: [PATCH] power: supply: qcom_battmgr: Expose USB connector
 temperature
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-topic-usb_temp-v1-1-3dbe390f9834@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auEWRtIIw3qVUSKmYw6hTYhkxSh5
 O5GXb7F/zsIZSaBi9oh08bCce0YDgrwdV+fpDl0gzXWDcYaXWJi1FX8VGhJ+hhGR4hndOMJepQ
 yPfj9G15vf0v1M2H5XqC1D+a4RNByAAAA
X-Change-ID: 20261020-topic-usb_temp-3d56ecc9c658
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792502899; l=2480;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=NOvsQD5Wge0yLCLmWzofS9BLUycIquob+kT0cCuiLOs=;
 b=whqhvGQXbTHW3n6wd8GD4AReivFj2fNJbmJnhWUx88LNbU56YztVfDeY/y50y+37bVOzb3xA4
 fX9vOHltITlB7YfK/OoFvBQD0nYG8mRw0llvYZAGuqi/HtPZwtPN8Mt
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The firmware is capable of reporting the temperature of the connector.
Expose it at the USB supply.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Tested on Kodiak/FP5
---
 drivers/power/supply/qcom_battmgr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index a7237ba09be1..9410a4a1387c 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -87,6 +87,7 @@ enum qcom_battmgr_variant {
 #define USB_ADAP_TYPE			7
 #define USB_MOISTURE_DET_EN		8
 #define USB_MOISTURE_DET_STS		9
+#define USB_TEMP			10
 
 #define BATTMGR_WLS_PROPERTY_GET	0x34
 #define BATTMGR_WLS_PROPERTY_SET	0x35
@@ -298,6 +299,7 @@ struct qcom_battmgr_usb {
 	unsigned int current_max;
 	unsigned int current_limit;
 	unsigned int usb_type;
+	int temperature;
 };
 
 struct qcom_battmgr_wireless {
@@ -977,6 +979,7 @@ static const u8 sm8350_usb_prop_map[] = {
 	[POWER_SUPPLY_PROP_CURRENT_MAX] = USB_CURR_MAX,
 	[POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT] = USB_INPUT_CURR_LIMIT,
 	[POWER_SUPPLY_PROP_USB_TYPE] = USB_TYPE,
+	[POWER_SUPPLY_PROP_TEMP] = USB_TEMP,
 };
 
 static int qcom_battmgr_usb_sm8350_update(struct qcom_battmgr *battmgr,
@@ -1037,6 +1040,9 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		val->intval = battmgr->usb.usb_type;
 		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = battmgr->usb.temperature;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1074,6 +1080,7 @@ static const enum power_supply_property sm8350_usb_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_TEMP,
 };
 
 static const struct power_supply_desc sm8350_usb_psy_desc = {
@@ -1517,6 +1524,10 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case USB_TYPE:
 			battmgr->usb.usb_type = le32_to_cpu(resp->intval.value);
 			break;
+		case USB_TEMP:
+			battmgr->usb.temperature =
+				DIV_ROUND_CLOSEST((int)le32_to_cpu(resp->intval.value), 10);
+			break;
 		default:
 			dev_warn(battmgr->dev, "unknown property %#x\n", property);
 			break;

---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261020-topic-usb_temp-3d56ecc9c658

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

