Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2439447C;
	Sun, 18 Oct 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364620; cv=none; b=eNj4wcikIjhDx8ZtHZwU6CaABnV3T//PUizBpqJjKyCdwBECzcdmYKr5sk0Ih/eVUaO6GDN8mgLBzHubG6QQsnq0yZ6FbXs9HtNwJ9ioY5f5yLyL0jvIi0epNtB5aEUK3dbSTXKfBgTWYRiG3IPyt03XL1/nnE2EB3yTzW5lTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364620; c=relaxed/simple;
	bh=NvIjxg/fWYFUncGbu5m+1h4xWTuPzwp7dT1mrszFrq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZljCe14GxGYe8avLZHxUeSflz0RUOQcLnuppz+sNltK2rXT0w1XYOj4HaWJnaWbEK5R1mX7O8kENdvGWsP9Zp10EC4U2i3CyuVbBrQHNMKGytutac+1R6jiHtmZxeJzY8YpISg8o5Mdo7GSo/hVsiEP5Yn7Venz506XSDDQglMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br/t0mJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br/t0mJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23BC3C2BCF7;
	Sun, 18 Oct 2026 23:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792364620;
	bh=NvIjxg/fWYFUncGbu5m+1h4xWTuPzwp7dT1mrszFrq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=br/t0mJ2jCBR1hCwRRhSyjL+TfNLmuf8SBeZoHRb2GslshwTU/atUIH/GeV1ASK/Y
	 1fXhZtO1gMcofawPIntLLEdNGyM3aW9Y/cx/XeNHj/4yP0ZyEBb+g0HVbT2Xe6E2xs
	 Wmi3m6qmRH6r/2AoPg06ezTSY5OwDAgN9Y2uaSjpz0EEy9Yq8lDsxQ+/M9eZ/ILwkL
	 yTFEK96l20wUZb+2su8sn0Qwjc0Ln8eoBmSAO0ADNsykpq5uRfcBsvyj0p3p2OzRp/
	 Waz66nq7QNonKNdbRHjQxK6Kcv95X2+9WK8HEAIzce6sViQUf9sCU4MgiIMLrXYDDM
	 nYSjSFmR9qbUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05713CCA490;
	Sun, 18 Oct 2026 23:03:40 +0000 (UTC)
From: Rinat Muhamedgaliev via B4 Relay <devnull+rinat.muhamedgaliev.gmail.com@kernel.org>
Date: Mon, 19 Oct 2026 02:03:39 +0300
Subject: [PATCH v7] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-master-v7-1-a1fc488d9c77@gmail.com>
References: <20261019-master-v7-0-a1fc488d9c77@gmail.com>
In-Reply-To: <20261019-master-v7-0-a1fc488d9c77@gmail.com>
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792364618; l=3405;
 i=rinat.muhamedgaliev@gmail.com; s=default; h=from:subject:message-id;
 bh=u6AybZx90IGQ0lK+NcGvrAL8vA4kcBYcEKv9GZFRxvU=;
 b=Rj7mh+r7Fgm4ai3tRsy/ikhnOQvtT0L9fdt2i+andL5pq+MUibtwVXMc7mNX0ASKsWqSzamJ4
 uiDy6cWkBgiBSuBPltqeWP5XUvKxMq/Xtz1/YBYddmmmebvu1qwnHGN
X-Developer-Key: i=rinat.muhamedgaliev@gmail.com; a=ed25519;
 pk=qkYQO8LRlRErWiLzlpK8jHbRIxv8+7v06+ytcxX8mec=
X-Endpoint-Received: by B4 Relay for rinat.muhamedgaliev@gmail.com/default
 with auth_id=1072
X-Original-From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Reply-To: rinat.muhamedgaliev@gmail.com

From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>

OnePlus 6 and 6T replacement battery packs may contain either a bq27411
or a bq27541 fuel gauge at I2C address 0x55. The device tree currently
identifies the gauge as bq27411, but a bq27541 uses a different register
map and then reports invalid battery values.

Read the DeviceType control subcommand when probing a bq27411. Keep the
existing profile for DeviceType 0x0421, but select the bq27541 profile
for DeviceType 0x0541. This retains the established DT ABI and supports
replacement packs without introducing a generic compatible.

Tested on OnePlus 6T (fajita) with DeviceType 0x0541: voltage, state of
charge, and temperature were reported correctly. Testing on hardware with
DeviceType 0x0421 would be appreciated.

Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 67 ++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 94b00bb89c17..a9982953e4f2 100644
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
@@ -136,6 +141,56 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
 	return 0;
 }
 
+static int bq27xxx_battery_i2c_check_device_type(struct bq27xxx_device_info *di)
+{
+	enum bq27xxx_chip detected_chip;
+	int expected_type;
+	int ret;
+
+	switch (di->chip) {
+	case BQ27411:
+		expected_type = BQ27411_DEVICE_TYPE;
+		break;
+	case BQ27541:
+		expected_type = BQ27541_DEVICE_TYPE;
+		break;
+	default:
+		dev_warn(di->dev, "expected DeviceType undefined\n");
+		return 0;
+	}
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
+		detected_chip = BQ27411;
+		break;
+	case BQ27541_DEVICE_TYPE:
+		detected_chip = BQ27541;
+		break;
+	default:
+		dev_err(di->dev, "unrecognized DeviceType 0x%04x\n", ret);
+		return -ENODEV;
+	}
+
+	if (detected_chip == di->chip)
+		return 0;
+
+	dev_warn(di->dev,
+		 "detected DeviceType 0x%04x instead of expected 0x%04x\n",
+		 ret, expected_type);
+	di->chip = detected_chip;
+
+	return 0;
+}
+
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
@@ -169,6 +224,18 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
 	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
 
+	/* Add fuel gauges with supported DeviceType reporting to this list. */
+	switch (di->chip) {
+	case BQ27411:
+	case BQ27541:
+		ret = bq27xxx_battery_i2c_check_device_type(di);
+		if (ret)
+			goto err_failed;
+		break;
+	default:
+		break;
+	}
+
 	ret = bq27xxx_battery_setup(di);
 	if (ret)
 		goto err_failed;

-- 
2.56.0


