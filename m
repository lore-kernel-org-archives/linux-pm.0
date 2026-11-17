Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912216;
	b=i7mZSS6tkVYuSVzTzbV7dp1gGLi04leGr+8t0T2uxy2PkO+mGyRpM5H7cuI6vF233UV0
	 +22r9WMPG0r9fM7xo9eMhe8P6Gc6wIRJ4QAvKa63sFJFUsjAkpQvALNizrCtB5r3vfwZd
	 nx6mbB8MsMzlryGNRKRBPR0QLEeVw23fjJeX7BsTidnOTKricU+O3TVSRMhgEZKkX9c8s
	 c3Krn6xtyJA0NpleHY3LcVrz0pP56UJgLQDKSLs234locKglTGanpzgT676DEOhTKZ4P0
	 og/5tA412vvxdnB+CgV9JdA7GIL8+TLor/IEPvqNUC4BSaVlBJsFYEdUlMwodJpnlZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fbLergfak+WMrqiKxAOYk5Uk7mKCg0A5nX4LTuRS+l8=;
	b=2KqFhBxBSUWsML8CR5zmaEk1PRgl2wZFXgFE5a0CWn7XuhNlM0hDznt2L37eyQi/x2S+
	 2rrnPnS2TRZTWNEo00NnWSkKkbrzPAfT8CC37/3NVxJPRHab4sicI7oZvrGoqUHa0o8iS
	 KTfqhNALkzIynxpiXGXOtRYvMLc8xEOutjVwpkEYocYvVyYz+ZQMTdiu5zSzLKNYK0u45
	 HfOTQWDdEORkn1j43jFHeKunWrCoxmOq98SElJYLCDYDbzacA+Zy4FS4f4rY8ybQ6s7jS
	 z2VKFGIP6o9aVfyEOME2rvAvBqHnP/sun8bEr07Zy3CaZ3FdQpOxIdszDpLyB1f70pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6YMjZNK;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559CD606A339
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559CD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6YMjZNK
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49a92144733so1820145f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794912214; x=1795517014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fbLergfak+WMrqiKxAOYk5Uk7mKCg0A5nX4LTuRS+l8=;
        b=R6YMjZNKpCPdCjunUUurKNtanrLhJAe6k5pvsGyzqb5Eul2emzA6h1NnWB0dIw8YLZ
         SQXPhuLrIAi3dwaGXM1gcAu6AOG6VlX1ot8jSuq03eSjGkA9aiah9/qzueco4ZDokb+T
         6R5BUQfudTDV2MpVQ5gndaYtt/a7YBuGVJxtPpSTNEoD74xi3iyd0YXlfrBRfDu75xHB
         9hBYZjg5EzJzpLIhL5V6uWywVnjbI4mPTW5FTDBGqbAY/dcop83TDjF2jD8KoFYyCwwb
         qZB1vhG8C2DfL0CoBGNsjdPj8rUaGwgymfyhzK7VDPcvdhZ24ilhs75BCuMKd0cVF2bk
         wpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912214; x=1795517014;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbLergfak+WMrqiKxAOYk5Uk7mKCg0A5nX4LTuRS+l8=;
        b=UJj3MfiZoAN/r2ZnMvYVUypMPrAoXq/SxQVsH5wTMHHev0ErtZUz4QtqfG0JC/4FyT
         ADp+SidwOKHpCYMcj8OO14PiJ7LmooeMBLClYmdWYKjEo2tXJMeo+IeZWbmChZNhCuzc
         1qZdU/ZqgmCXvABq7/VvOgPSXCZb0qQiW23II0iw8lzTDsDvqQeLNHVZHAc2SLZ5Gbmj
         8buJunwpya1cvZWz9v5fFENZiM7/FKQHf+w+WJBJVBElAED/sOfWGFxqNNFjV0RDdqQ8
         HLkD0SmebHMMlaaM9W6BLGntzUDNsfoDgSO7i2p8Nyf91nw8DxEkAPp5awLeSoUq1oCP
         f0Gg==
X-Gm-Message-State: APuU4Z+VN+6KP322IWLMDJMHOeM/plIr/021gvHYHZVnbmPgX4V4ZOFq
	mwJxIbBRmAS/KNLLh4L6L3mEVKNJo90b/FvSqNO7YF9hWAE0qeoUVH3P
X-Gm-Gg: AYBFou2XVetjZ7zUWFehp4MUD6R6eqkxdxBZdHXZDHJADGsvTF4ceRLE/R+rtTlG34N
	XzhMePawEeANHyQSITipdAkwHQA20vmvkV5r4k/wYeXU78sMlrErCf1yV2BVrw5+GIRyVC9pQbG
	Mi5dMxdU+Hh+XGL08GZoYG51OEX+DZyRVvfQ/38KBlLA0FKg+nHeN/WckrqpJ1bfRIVNzCSDRd+
	z4/SjFYfa3UXq+gX0Fn0c05VmRLkIkLhEDQ4KMfoBl6B1ZR1724Jbz3kVmI5dLwgOlNQ7mD4K1Q
	b7kV18PpBp5y7ZrVplV3Q3bxzASdCxGgjmyu8KtuWw+KQDhOnVsxMk5R8psah/VB7aounDUnrFX
	MBZeKpYMd/LTD32lmrmaUtyGThmH5XuiMg04scoz5kxI34kvZLrLGdhzG9y1ltCVI8bbFheQxX2
	z15nq7ynlbkZQWwRHO5YKEruu+OWz0k5IkcXawiDnbYh3fBagfXU24nyA6llOw4bbRp42R6ogCc
	nWOI6yWwgBXLLvgfURdkWINt5f083OUVrakk+v2eozyK/lJZTcsJ1Ms/HkWtuIbcChUReoqJDOj
	SAPKE4zoUyk=
X-Received: by 2002:a05:600c:a302:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb7347d930mr88329715e9.9.1794912213572;
        Tue, 17 Nov 2026 02:43:33 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783e9288sm61091805e9.15.2026.11.17.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:43:32 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH 2/2] power: supply: s2mu106-fuelgauge: add standalone driver
Date: Tue, 17 Nov 2026 13:43:28 +0300
Message-ID: <20261117104328.1176951-3-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117104328.1176951-1-tadilhusrev@gmail.com>
References: <20261117104328.1176951-1-tadilhusrev@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a standalone driver for the fuel gauge in the Samsung S2MU106
PMIC, as fitted on the Samsung Galaxy XCover5 (own I2C address, 0x3b).
It shares the S2MU005 fuel gauge's STATUS/RVBAT/RCURCC/RSOC register
layout and scaling, which this driver reads directly with the stock
fixed-point formulas; it has no MONOUT average-monitoring registers,
so unlike s2mu005-battery.c it never reads VOLTAGE_AVG/CURRENT_AVG or
uses current_avg to decide POWER_SUPPLY_STATUS.

This replaces a previous version of this series
(https://lore.kernel.org/all/20261116074000.355176-1-tadilhusrev@gmail.com/)
that instead extended s2mu005-battery.c with a samsung,s2mu106-fuel-gauge
fallback compatible; see "dt-bindings: power: supply: add
samsung,s2mu106-fuelgauge" in this series for why that shape was
dropped.

The driver was drafted with an AI coding assistant (Claude Code,
Anthropic) from this register map; I reviewed every line, built it
(arm64, 0 warnings), ran checkpatch --strict (clean), and tested it on
a Samsung Galaxy XCover5 (re-confirmed 2026-11-17, kernel
7.4.0-rc1-00023-gdcb8b91fb779+ #30): it probes, and
/sys/class/power_supply/s2mu106-battery/ reports plausible voltage,
capacity and charging-status values that track the device's actual
state (confirmed live, including across a flash/reboot cycle).

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 drivers/power/supply/Kconfig             |  13 ++
 drivers/power/supply/Makefile            |   1 +
 drivers/power/supply/s2mu106-fuelgauge.c | 240 +++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 drivers/power/supply/s2mu106-fuelgauge.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 1eeb176b2..cc8fed03b 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -240,6 +240,19 @@ config BATTERY_S2MU005
 
 	  This driver, if built as a module, will be called s2mu005-fuel-gauge.
 
+config BATTERY_S2MU106
+	tristate "Samsung S2MU106 PMIC fuel gauge driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to build a driver for the fuel gauge block of the
+	  Samsung S2MU106 PMIC, as fitted on the Samsung Galaxy XCover5.
+	  It is a standalone I2C device at address 0x3b, reporting
+	  voltage, current, capacity and charging status.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called s2mu106-fuelgauge.
+
 config CHARGER_S2MU106
 	tristate "Samsung S2MU106 charger driver (read-only)"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index cd16c6e48..531a0b024 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -135,4 +135,5 @@ obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
 obj-$(CONFIG_MACSMC_POWER)	+= macsmc-power.o
 obj-$(CONFIG_CHARGER_MAX77759)	+= max77759_charger.o
+obj-$(CONFIG_BATTERY_S2MU106)	+= s2mu106-fuelgauge.o
 obj-$(CONFIG_CHARGER_S2MU106)	+= s2mu106-charger.o
diff --git a/drivers/power/supply/s2mu106-fuelgauge.c b/drivers/power/supply/s2mu106-fuelgauge.c
new file mode 100644
index 000000000..2fdd72c80
--- /dev/null
+++ b/drivers/power/supply/s2mu106-fuelgauge.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung S2MU106 Fuel Gauge driver (XCover5)
+ *
+ * Register map confirmed against stock source AND live device dmesg:
+ *   kernel_src/extracted/.../s2mu106_fuelgauge/s2mu106_fuelgauge.{c,h}
+ *   hw_exhaustive/11_usb.txt + 20_kernel_base.txt (stock driver live on 0-003b @ i2c-0 0x3B)
+ *
+ * Confirmed registers (stock s2mu106_fuelgauge.h; defines are "addr>>1, R/W bit excluded"):
+ *   0x00  FG_STATUS    — power-on / por bits
+ *   0x04  RVBAT        — raw VBAT ADC (16-bit LE); mV = (raw*1000)>>13   [live: vbat 3899]
+ *   0x06  RCUR_CC      — coulomb-counter current, 2's-comp 16-bit;
+ *                        bit15 set = charging [live: -386 mA]
+ *   0x08  RSOC         — raw SOC, 2's-comp 16-bit;
+ *                        %*100 = (raw&0x7FFF)*10000/(1<<14) [live: SOC 67]
+ *   0x2A  RSOC_R       — alternate SOC representation (NOT the main path; stock uses RSOC 0x08)
+ *   0xC3  FG_PROP      — calibration mode (0x09 → normal)
+ *
+ * NOTE: earlier revs read RVBAT/RCUR from 0x26/0x28 citing a "live 3899 mV". That voltage was
+ * real but came from the STOCK driver reading 0x04 (dmesg s2mu106_get_vbat) — 0x26/0x28 are not
+ * fuel-gauge registers at all. Corrected to the stock 0x04/0x06/0x08 map.
+ *
+ * Exposed as a power_supply "s2mu106-battery" with:
+ *   POWER_SUPPLY_PROP_VOLTAGE_NOW   (µV)
+ *   POWER_SUPPLY_PROP_CURRENT_NOW   (µA, signed)
+ *   POWER_SUPPLY_PROP_CAPACITY      (% int 0-100)
+ *   POWER_SUPPLY_PROP_STATUS        (derived from current sign + SOC)
+ *   POWER_SUPPLY_PROP_PRESENT
+ *   POWER_SUPPLY_PROP_TECHNOLOGY    (LION)
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+/* Register definitions */
+#define S2MU106_FG_STATUS		0x00
+#define  FG_STATUS_ACTIVE		BIT(7)
+
+#define S2MU106_RVBAT_L			0x04	/* 16-bit LE: low byte first */
+#define S2MU106_RVBAT_H			(S2MU106_RVBAT_L + 1)
+
+#define S2MU106_RCUR_CC_L		0x06	/* 2's-complement 16-bit LE coulomb counter */
+#define S2MU106_RCUR_CC_H		(S2MU106_RCUR_CC_L + 1)
+
+#define S2MU106_RSOC_L			0x08	/* 2's-complement 16-bit LE */
+#define S2MU106_RSOC_H			(S2MU106_RSOC_L + 1)
+
+/* Scaling is done with the stock fixed-point formulas inline (see get_property); the
+ * old per-LSB constants were for the wrong registers and are gone.
+ */
+
+struct s2mu106_fg {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy;
+	struct mutex lock;	/* serialises the two-register reads in get_property() */
+};
+
+static int fg_read16(struct s2mu106_fg *fg, u8 lo_reg, s32 *val, bool is_signed)
+{
+	unsigned int lo, hi;
+	int ret;
+
+	ret = regmap_read(fg->regmap, lo_reg, &lo);
+	if (ret)
+		return ret;
+	ret = regmap_read(fg->regmap, lo_reg + 1, &hi);
+	if (ret)
+		return ret;
+
+	if (is_signed)
+		*val = (s16)((hi << 8) | lo);
+	else
+		*val = (u16)((hi << 8) | lo);
+	return 0;
+}
+
+static int s2mu106_fg_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct s2mu106_fg *fg = power_supply_get_drvdata(psy);
+	s32 raw;
+	int ret = 0;
+
+	mutex_lock(&fg->lock);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = fg_read16(fg, S2MU106_RVBAT_L, &raw, false);
+		if (!ret)
+			/* stock s2mu106_get_vbat: mV = (raw*1000)>>13; expose as µV */
+			val->intval = (((u32)raw * 1000) >> 13) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW: {
+		u32 cc, mag;
+		s32 ma;
+
+		ret = fg_read16(fg, S2MU106_RCUR_CC_L, &raw, false);
+		if (ret)
+			break;
+		cc = (u16)raw;	/* RCUR_CC: 2's-complement coulomb-counter word */
+		/*
+		 * stock s2mu106_get_current: bit15 set => charging (positive),
+		 * clear => discharging (negative). Scale mA = (mag*1000)>>12, then
+		 * mA->µA in a second step so mag*1000000 can't overflow s32.
+		 */
+		if (cc & 0x8000) {		/* charging */
+			mag = ((~cc) & 0xFFFF) + 1;
+			ma = (s32)((mag * 1000) >> 12);
+		} else {			/* discharging */
+			mag = cc & 0x7FFF;
+			ma = -(s32)((mag * 1000) >> 12);
+		}
+		val->intval = ma * 1000;	/* µA */
+		break;
+	}
+	case POWER_SUPPLY_PROP_CAPACITY: {
+		u32 soc;
+
+		ret = fg_read16(fg, S2MU106_RSOC_L, &raw, false);
+		if (ret)
+			break;
+		soc = (u16)raw;
+		/* stock s2mu106_get_rawsoc: %*100 = (raw&0x7FFF)*10000/(1<<14) */
+		if (soc & 0x8000)
+			val->intval = 0;	/* negative SOC -> treat as empty */
+		else
+			val->intval = clamp_val(((soc & 0x7FFF) * 10000 / (1 << 14)) / 100,
+						0, 100);
+		break;
+	}
+	case POWER_SUPPLY_PROP_STATUS: {
+		u32 cc;
+
+		ret = fg_read16(fg, S2MU106_RCUR_CC_L, &raw, false);
+		if (ret)
+			break;
+		cc = (u16)raw;
+		/* bit15 set = charging (stock convention); independent of the µA scaling */
+		if (cc & 0x8000)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if ((cc & 0x7FFF) > 20)	/* small deadband (~5 mA) */
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	}
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&fg->lock);
+	return ret;
+}
+
+static enum power_supply_property s2mu106_fg_props[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+};
+
+static const struct power_supply_desc s2mu106_fg_desc = {
+	.name		= "s2mu106-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= s2mu106_fg_props,
+	.num_properties	= ARRAY_SIZE(s2mu106_fg_props),
+	.get_property	= s2mu106_fg_get_property,
+};
+
+static const struct regmap_config s2mu106_fg_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xFF,
+};
+
+static int s2mu106_fg_probe(struct i2c_client *client)
+{
+	struct s2mu106_fg *fg;
+	struct power_supply_config cfg = {};
+
+	fg = devm_kzalloc(&client->dev, sizeof(*fg), GFP_KERNEL);
+	if (!fg)
+		return -ENOMEM;
+
+	fg->dev = &client->dev;
+	mutex_init(&fg->lock);
+
+	fg->regmap = devm_regmap_init_i2c(client, &s2mu106_fg_regmap_config);
+	if (IS_ERR(fg->regmap))
+		return PTR_ERR(fg->regmap);
+
+	i2c_set_clientdata(client, fg);
+
+	cfg.drv_data = fg;
+	fg->psy = devm_power_supply_register(&client->dev, &s2mu106_fg_desc, &cfg);
+	if (IS_ERR(fg->psy))
+		return PTR_ERR(fg->psy);
+
+	dev_info(&client->dev, "S2MU106 fuel gauge registered (addr 0x%02x)\n",
+		 client->addr);
+	return 0;
+}
+
+static const struct i2c_device_id s2mu106_fg_id[] = {
+	{ "s2mu106-fuelgauge", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, s2mu106_fg_id);
+
+static const struct of_device_id s2mu106_fg_of_match[] = {
+	{ .compatible = "samsung,s2mu106-fuelgauge" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, s2mu106_fg_of_match);
+
+static struct i2c_driver s2mu106_fg_driver = {
+	.driver = {
+		.name		= "s2mu106-fuelgauge",
+		.of_match_table	= s2mu106_fg_of_match,
+	},
+	.probe		= s2mu106_fg_probe,
+	.id_table	= s2mu106_fg_id,
+};
+module_i2c_driver(s2mu106_fg_driver);
+
+MODULE_DESCRIPTION("Samsung S2MU106 Fuel Gauge driver");
+MODULE_AUTHOR("Adil Hüsrev Tepe");
+MODULE_LICENSE("GPL");
-- 
2.53.0

