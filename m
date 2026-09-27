Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A606231A3B;
	Sun, 27 Sep 2026 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790543838; cv=none; b=teBxx6F1RNFg57rYS/xcnVzinAtFFKAy9gtWFJLY8zn5Ve7zL5gfmFiglNTzOYXLB5i/pW3lmSkpkCsDboeiZQAIZNdPiSHHLq8oyE/BfCOM3qeexxeN+wMEoPUwz4Joib95rCBkt03JP/E64m3udZdA6Eua6t1FHfnIvawbFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790543838; c=relaxed/simple;
	bh=CyPnmzIJSUvBRZI0xOHTGgHHjBuYikIrDMNDtsOUfZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NdWy5MZiO+tFqx98u/4POpxf03A+t07Al9Uc2r7yveWvUmDoxxRPDIF6qEA+46BMTEfTrQ3o/YPl21pwpeOdymgWrTBJHdmU5WvOTBMifg0RGXRTZTVVWYGC15G2z25p3a8/hm4sG36p/IeazxI8wt6wFepaJ4T7vFv9mW9/KPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkBJWt30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkBJWt30"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1E47C2BCB3;
	Sun, 27 Sep 2026 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790543837;
	bh=CyPnmzIJSUvBRZI0xOHTGgHHjBuYikIrDMNDtsOUfZs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UkBJWt30VJLZOHX+vvw5M4BSvbVbSlFEzyuzL/AHfNcPS+E3g8433bOg53iVIjIEv
	 GCdxyc92NzQ1MPKz48yp2fcBYIGj41CThwZTAa7cVwS4IBOakcpDZJNtk3pC4hThcX
	 v1JcCig4HcW7V8PxvPQZ8g/621qkZOEj5/L7rqFU6+PzkNND3FBlhD1ZQkjtEzcrPA
	 K7yWNL/1WkRO/BF+vc1hAFkSL1Iw8HyGwNY84XE/n6xXpGRfG4jLfuV2GGoxiktA1Q
	 iX0leW25zGU2w+nSYxKt23u5c20sCzgKj5Jb0fIdwfQ76SeId84AChgH5W18NsNfJv
	 6LbCwEG0bjDgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5F5C9830E;
	Sun, 27 Sep 2026 21:17:17 +0000 (UTC)
From: Rinat Muhamedgaliev via B4 Relay <devnull+rinat.muhamedgaliev.gmail.com@kernel.org>
Date: Mon, 28 Sep 2026 00:17:17 +0300
Subject: [PATCH v4] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-master-v4-1-052c73ec1767@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avErBNEwrCrRAvLsSbIwqkIpLtnt
 fzgfy8BYyRkaIoEEU9iWkNGVRYwTDaMKMhlg5JKS6NqsVjeMYreSeud0UajhxxvET1d31Hb/ea
 jn3HY3zXc9wOttx+dagAAAA==
X-Change-ID: 20260927-master-bd0afd9696ef
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790543836; l=3730;
 i=rinat.muhamedgaliev@gmail.com; s=default; h=from:subject:message-id;
 bh=LDPX+qzAP96f/Gr3A6zlVkUDdRUYlzESJ8Imhmnzv+I=;
 b=m6FAG85DpMn9tIEfxK9ou8OCXPNKB8uTyCksgF2mZnuU06ZuOMNtvC0KMptQurVe8pprOt8u6
 7YbQJBWkUdSBMaey72SC7Z6mCg5osAN2GRHfps9gnrfmhitrGNMC+Y4
X-Developer-Key: i=rinat.muhamedgaliev@gmail.com; a=ed25519;
 pk=qkYQO8LRlRErWiLzlpK8jHbRIxv8+7v06+ytcxX8mec=
X-Endpoint-Received: by B4 Relay for rinat.muhamedgaliev@gmail.com/default
 with auth_id=1072
X-Original-From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Reply-To: rinat.muhamedgaliev@gmail.com

From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>

OnePlus 6 and 6T replacement battery packs may contain either a bq27411 or a bq27541 fuel gauge at I2C address 0x55. The device tree currently identifies the gauge as bq27411, but a bq27541 uses a different register map and then reports invalid battery values.

Read the DeviceType control subcommand when probing a bq27411. Keep the existing profile for DeviceType 0x0421, but select the bq27541 profile for DeviceType 0x0541. This retains the established DT ABI and supports replacement packs without introducing a generic compatible.

Tested on OnePlus 6T (fajita) with DeviceType 0x0541: voltage, state of charge, and temperature were reported correctly. Testing on hardware with DeviceType 0x0421 would be appreciated.

Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
---
OnePlus 6 and 6T replacement battery packs can contain either a bq27411 or a
bq27541 fuel gauge. The latter requires a different register map and produces
invalid battery readings when interpreted as a bq27411.

v4 drops the proposed generic DT compatible and DTS changes. The I2C driver
instead reads DeviceType while probing the existing bq27411 compatible, and
selects the bq27541 profile if the device reports 0x0541.

The bq27541 path was tested on a OnePlus 6T. Testing on an OnePlus 6 or 6T
whose fuel gauge reports DeviceType 0x0421 (bq27411) would be appreciated.

Changes in v4:
- Drop the generic compatible and binding update.
- Keep the established OnePlus DTS unchanged.
- Detect bq27541 from DeviceType in the bq27411 probe path.
- Send as a new thread.
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 94b00bb89c17..732164423423 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -16,6 +16,11 @@
 static DEFINE_IDR(battery_id);
 static DEFINE_MUTEX(battery_mutex);
 
+#define BQ27XXX_REG_CTRL		0x00
+#define BQ27XXX_DEVICE_TYPE		0x0001
+#define BQ27411_DEVICE_TYPE		0x0421
+#define BQ27541_DEVICE_TYPE		0x0541
+
 static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
 {
 	struct bq27xxx_device_info *di = data;
@@ -136,6 +141,32 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
 	return 0;
 }
 
+static int bq27xxx_battery_i2c_check_device_type(struct bq27xxx_device_info *di)
+{
+	int ret;
+
+	ret = di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_DEVICE_TYPE,
+			    false);
+	if (ret < 0)
+		return ret;
+
+	ret = di->bus.read(di, BQ27XXX_REG_CTRL, false);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case BQ27411_DEVICE_TYPE:
+		return 0;
+	case BQ27541_DEVICE_TYPE:
+		dev_warn(di->dev, "detected bq27541 instead of bq27411\n");
+		di->chip = BQ27541;
+		return 0;
+	default:
+		dev_err(di->dev, "unsupported device type 0x%04x\n", ret);
+		return -ENODEV;
+	}
+}
+
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
@@ -169,6 +200,12 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
 	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
 
+	if (di->chip == BQ27411) {
+		ret = bq27xxx_battery_i2c_check_device_type(di);
+		if (ret)
+			goto err_failed;
+	}
+
 	ret = bq27xxx_battery_setup(di);
 	if (ret)
 		goto err_failed;

---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20260927-master-bd0afd9696ef

Best regards,
--  
Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>


