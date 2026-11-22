Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324420;
	b=iTVRCk1F9FiboGR2BLMpL+fcYWgfolK81yXMYxAfGkXMB83xTG2DtzHAma+m+7Bdl0FR
	 Gjb1Ob8L9CP0he2cSmVPuLdu6zYBS7KjcoJSa5dLCaFOPMmVf+wT2md3f40yaA2jg/FhC
	 T3J7QiWlpZM7qfNeGVoVrJjUSWfbc7Dre+wK8bZSvtoXcnsJPRgWg54mc2FCrQc471Fsh
	 h364jNlab3dQjWJOMdkSkk6Tn9IYz64vMHoW525hCpDoPFegd3G9NsM8GIizfcUBDzCv0
	 dgNF/7zmeeeUqVM7UOPoHdsaBQQIwiB7FcmdppNEHfR1biR1TQHtNFsOUWK5cw7SeyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324420;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DiFLCNWuAguYC7GlMjmHWyzByIH688Zqc4FSeopoDIE=;
	b=qtVUpet7ThTB4zqSDKJvWT+9DiSvjdnqT1TmmG3aVCa7vkZFBaN4xD4dcbjMfjPr+Ray
	 yD8i2HNzvgwRpArt7XA9oAfGzfbmMhHF3Z0/+MRFTw6BwmhqVMNho2cdj4sgU0UwJl2fg
	 ldt0i5m2+7ixJzZ2KeMc9pJVcgMdVOAKJ107t0d95T1Tv8whwaq1uqWY3o1rEeROutKJB
	 RNoRtIPRyc9s1RWrkEFAI/RbPVpYadSGHFnE7bLzpFC+rSQx856+HrWd3JNPksK8RM6sA
	 bZD4VyREp7savV3wDIDDcp4d5cFHCKJVCPLqPrnxohLei8eVt9PqYLTlBxuRflvMQRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiZaCiqf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC5606A337;
	Sun, 22 Nov 2026 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiZaCiqf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324420;
	b=mkxb6P+u7UJMFw0sp2R8LeNKN3kdabUcQEIh8fhiIfGt8SYYCunudGqxRNwESyYeb5kN
	 ilHkrxAwKTA10x5Zldj3HaJLRdFuq/vEvTz0CPxacE7ZWviHIHnfubPrVQI37Rv32TtRQ
	 mxM+yMfaytYtyE2zU2B7rpAshJ6JTW3utkDz5aYZ5ZDJA90cWcwRSXlb6YNvT4m2T5eg5
	 Leo74f3TeqYvvuioYL8UdEV0TKqtC2Sdel5pfa+iAM9lcEif6CHx2rv00bUGNni3XPtdA
	 tu6Avxft7roxZj1I5yEA2fYiJDOEVzTrO4LMeW5RH/6zyZd4iEWp8kz/YJJf+ct5oIA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324420;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DiFLCNWuAguYC7GlMjmHWyzByIH688Zqc4FSeopoDIE=;
	b=WfK/0cZY1tqrSBWjvU6D4qMkbPGCuD3MLUqpzicENjOKIvFmG5PxNTYpjebMZqGUe8f7
	 GRaHyaKjG106hDLmdE5tH9yE5Yn5D60vlI2iArMowUBlePU3pBQz7jZPHkuvTjZF4Bh0o
	 VHltFTU1iczUHhLC7+rw1Ec0vWVU/exsp37T/TextNe3GPPbwoFmuCgnGfJXiTkRaGmqi
	 UTxIc0d4C85ZuO9DxAL/jSO/zMMgd8SdHq+aQk8X1TAOKVCSJ4nmawVZ3i6o+zQwjnmS/
	 uVYWwqXJYXbJqj6uefiw2AGTYHs972MPcZ939ILguGXt6Ee6sps3TBwV/l/RRf9ItgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 070671F000C6;
	Sun, 22 Nov 2026 05:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324420;
	bh=DiFLCNWuAguYC7GlMjmHWyzByIH688Zqc4FSeopoDIE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=TiZaCiqf+5SO4JL05f20TU+pBaCDWk0EKy1X9V9+22n+LKzcOhv0ySgzaBl7EicrU
	 VTkAz71dZkG/ocZ6WXcmMbIoO0KIqRvuXbIHRO2tFvXC9GyDRH2Jlgm2eKpFmnYnN5
	 xDUvG61PaJUC60LTunkHO+sqjbXMspnZePo6jMzYEwtcYYi5nTliX5VUslpT0fPF9l
	 z387Q6/hYpalphcwFa52x/BJ4STmNWIAE5vDCJ2Tjol81PCEnT5pGlLzs/v6MCkQDo
	 dcqJwozIwgbXbGY9wtirkxLvEEs8P+d42xUHpXBREONzk8X8cvw6xCgSWFjpJGMvFs
	 KNHtsGxxcrLaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8C64E4BF2E;
	Sun, 22 Nov 2026 05:13:39 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:13:31 +0000
Subject: [PATCH] power: supply: qcom_smbx: Make the float voltage
 adjustable
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
Message-Id: <20261122-b4-smbx-ccv-v1-1-0ecc4217b58c@enser.io>
X-B4-Tracking: v=1; b=H4sIAPp5AmsC/yXMwQ7CIBAE0F9p9uyqECLWX2k8wLJYTETDKmnS9
 N8FPb7JzKwgXBILXIYVCtck6Zkb1G4Aml2+MabQDPqoT0ppjd6gPPyCRBWjtTZEcw5+HKEtXoV
 jWn5v0/Vv+fg707tf9IZ3wuiLyzT3qPNQ7d5gIQ3b9gVBNQZRjwAAAA==
X-Change-ID: 20261122-b4-smbx-ccv-f777df48db99
To: Sebastian Reichel <sre@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Robin Snyders <robin@snyders.xyz>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324411; l=5793;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=c81KUHplwWRmxuVs0d0MhXnbVsifOIAU8afoDoBp8fU=;
 b=Ll0mm0xiLTjcmUVG66bC1fcaaIlZ0tYWOeV2SJwrJnvIrAnPltOkPU4a5tL/lJPGGBByyewf8
 GEsQUpAyUvcDD8RViA1zHeMCRlafQHvHKGePNniq3S7YnIr+RdESGeB
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io
Content-Transfer-Encoding: 7bit

From: EMCP333 <emcp@enser.io>

Charging a lithium battery to a lower voltage is the usual way to make
it last longer, and on PMI8998 and PM660 the float voltage is the
register that sets that voltage. The driver programs it once at probe
from the battery data, and userspace cannot change it.

Expose it as POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE, writable, and
the value probe left as CONSTANT_CHARGE_VOLTAGE_MAX. A write is clamped
to the range between the lowest setting and that maximum, then rounded
down to a 7.5 mV step, so userspace can charge the battery less than
the battery data allows but never more. Without battery data, the
maximum is whatever the boot firmware set.

Tested on a OnePlus 6T (PMI8998) on a 6.18-based kernel, with this
patch and a backport of commit 2a26d260e72a ("power: supply: qcom_smbx:
fix float voltage selector"). constant_charge_voltage_max reads
4395000, and writes read back as below, with the selector read through
regmap debugfs:

  4100000 -> 4095000 (selector 81)
  4500000 -> 4395000 (selector 121, the maximum)
  3000000 -> 3487500 (selector 0, the lowest setting)

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Signed-off-by: EMCP333 <emcp@enser.io>
---
Also ran on v7.4-rc3 on the same phone, as this exact commit, with the
charge daemon stopped: writing 4100000, 4500000 and 3000000 reads back
4095000, 4395000 and 3487500 (float voltage selectors 0x51, 0x79 and
0x00).
---
 drivers/power/supply/qcom_smbx.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 8a2f635a6c..2d30c18671 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -381,6 +381,7 @@ struct smb_init_register {
  * @base:		Base address for smb registers
  * @regmap:		Register map
  * @batt_info:		Battery data from DT
+ * @float_voltage_max_uv: Highest float voltage userspace may set, in uV
  * @initial_charge_enable: Charging enable state before hardware setup
  * @status_change_work: Worker to handle plug/unplug events
  * @cable_irq:		USB plugin IRQ
@@ -395,6 +396,7 @@ struct smb_chip {
 	unsigned int base;
 	struct regmap *regmap;
 	struct power_supply_battery_info *batt_info;
+	int float_voltage_max_uv;
 	u8 initial_charge_enable;
 
 	struct delayed_work status_change_work;
@@ -417,6 +419,8 @@ static enum power_supply_property smb_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 };
 
 static int smb_get_prop_usb_online(struct smb_chip *chip, int *val)
@@ -653,6 +657,32 @@ static int smb_get_prop_health(struct smb_chip *chip, int *val)
 	return 0;
 }
 
+static int smb_get_float_voltage(struct smb_chip *chip, int *val)
+{
+	unsigned int sel;
+	int rc;
+
+	rc = regmap_read(chip->regmap, chip->base + FLOAT_VOLTAGE_CFG, &sel);
+	if (rc < 0)
+		return rc;
+
+	*val = SMB2_FLOAT_VOLTAGE_MIN_UV +
+	       (sel & FLOAT_VOLTAGE_SETTING_MASK) * SMB2_FLOAT_VOLTAGE_STEP_UV;
+
+	return 0;
+}
+
+static int smb_set_float_voltage(struct smb_chip *chip, int val)
+{
+	unsigned int sel;
+
+	val = clamp(val, SMB2_FLOAT_VOLTAGE_MIN_UV, chip->float_voltage_max_uv);
+	sel = (val - SMB2_FLOAT_VOLTAGE_MIN_UV) / SMB2_FLOAT_VOLTAGE_STEP_UV;
+
+	return regmap_update_bits(chip->regmap, chip->base + FLOAT_VOLTAGE_CFG,
+				  FLOAT_VOLTAGE_SETTING_MASK, sel);
+}
+
 static int smb_get_property(struct power_supply *psy,
 			     enum power_supply_property psp,
 			     union power_supply_propval *val)
@@ -682,6 +712,11 @@ static int smb_get_property(struct power_supply *psy,
 		return smb_get_prop_health(chip, &val->intval);
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		return smb_apsd_get_charger_type(chip, &val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return smb_get_float_voltage(chip, &val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval = chip->float_voltage_max_uv;
+		return 0;
 	default:
 		dev_err(chip->dev, "invalid property: %d\n", psp);
 		return -EINVAL;
@@ -700,6 +735,8 @@ static int smb_set_property(struct power_supply *psy,
 					  USBIN_SUSPEND_BIT, !val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return smb_set_current_limit(chip, val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return smb_set_float_voltage(chip, val->intval);
 	default:
 		dev_err(chip->dev, "No setter for property: %d\n", psp);
 		return -EINVAL;
@@ -712,6 +749,7 @@ static int smb_property_is_writable(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		return 1;
 	default:
 		return 0;
@@ -1064,6 +1102,15 @@ static int smb_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, rc, "Couldn't set vbat max\n");
 
 skip_float_voltage:
+	/*
+	 * Userspace may lower the float voltage to charge the battery less,
+	 * but not raise it above what is set now: the battery's voltage or,
+	 * without battery data, the boot firmware's setting.
+	 */
+	rc = smb_get_float_voltage(chip, &chip->float_voltage_max_uv);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc, "Couldn't read vbat max\n");
+
 	rc = smb_init_irq(chip, &irq, "bat-ov", smb_handle_batt_overvoltage);
 	if (rc < 0)
 		return rc;

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-smbx-ccv-f777df48db99

Best regards,
--  
EMCP333 <emcp@enser.io>


