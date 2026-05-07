Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1A3FBEB3
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161586; cv=none; b=VfuiVUGoKyfcGf5DYndr13WLLrWV89ISfTCEZgO8mwqTbbDUi7MQfgJFAv2vvs7rmczbH0mZlxav2vPCLbgjyq10r7UEtJBwnsv0rMZP2euZiFnNk9FND5Y1aPiPFh3ooitjnqEyhFXHomRIml0zHsVP8y4S2v6Bd5weHfwKTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161586; c=relaxed/simple;
	bh=WKPXbH5h2ybjOzoEHWip6SrvY2ABnzJ8hFR5GMG71uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u22JpwKWBToOBL2HftSzaiF0f0U5mAkvVjqZt2n6qklSJQ3sm54qYJtL0GqZrL8ErUvwSX9j8/wFP8JXVGNeTlyN2gzOqvwEJkwb/1u/PEXkfC4VGIe9w3+CTmE8mtpvhvPuZAjzaRmZKU1E3HW9HutJTnBXoZD/T+W8Dew2ojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkcLbesU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkcLbesU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44da2de25f3so661089f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161582; x=1778766382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNwuVHvFu1s7Mk8GKLERrP4YE5NdZti4xQ+xBZhJ0RM=;
        b=XkcLbesUnwo9v82LePnSXIrVw5UeoYgG4TI4clBtNF+IcOOH6IeoVO0xKwoLcYCkWZ
         gr9wwrRZEKK9/cY+J/kkJZej3x6xSGBQd5epZc652BsOfmQwL9NMzA4EIMq/Xuc39KZ2
         0MuGzfS8/PTAVkSdhrpGhrCv9nuWDtTc7RKC8AFCCryPA813gDn6czu5twGjSmsBviXc
         fb9FYVyaw/SYDrCco5d67bs2MC/Ilids5cBfZR1ey5fV/yd9otFgtVlnRJPicHzCzIi8
         gqmY1QHgzbTfktnWvE9fjiCMow3KJLAy9HHAyiiFt6kVSmRGi5+GZrhwAdEbFhj5izmG
         MR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161582; x=1778766382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNwuVHvFu1s7Mk8GKLERrP4YE5NdZti4xQ+xBZhJ0RM=;
        b=dfPCo49iiELpnqldBb6B3LPP8QzUX5fJFwiFEZg0y8ahrrFszoKcUslk/th4PHbt7r
         X9Qha0THOgsKSAKg1ZPHN4vpQuqwNvuGP/e6Y+Lzx+UJ2x3HTZiCqRXQFJ7VvwMXbrSR
         IWdeH0+6/J3r7HhiiOZkKLYnz5iCKPIl8hNydNZvcpli/uLzHPI5wc31CfazwZe/fA+j
         XwvnS7Sck86wb/BEswWvFHMaa5zb6nv+0wjiAEam4q5CLO7ne1fn6Dse4qX7qmDAu9sk
         Z+HBa/byd7gnRwk72/+qG8n8RtILkaBQNxphilqNKd92rCVPb/YLkPucQ8Z2r6UMS3tX
         D0BA==
X-Forwarded-Encrypted: i=1; AFNElJ+0QpKJzOjYuKYbwhOx31uszm5GJpqCmM3yHkoHjUmHUOAoOVnkRuw5rzn/ZYZxNGn+mBPpx1JdYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUzHa+z+fGq8Qfh4OoEWORn+/x1dbf/05TmBULnPXhXmpho4D
	HcpcHwfEWV+JX7FEetp+A+qnyq8W5nO0xNcyuvGzTBdWrO8iPVJqk25J
X-Gm-Gg: AeBDievezDjB9LnEt9uIni5VExn8FUj2NUwvaZfHXdHqBAQnrgp2HZXMndLI+hIxwQ5
	RkEcsijbUBLlhExH92Nw0cOW8e5OQSLBtVNBaUsK+K/4ws05+r9QOJIcjUgEYIj8ZXyrZbQiyWP
	3zCrxcstA9rU9fevgoZMB2niW8UxSqE+flcuExG4cHga5Fs9+RDpL7krxH1r6uiC8SfhlqrSr/I
	Y9CYSi08nZDZ3ch4fgDm1qEzTYMD56IPcDSBGd8yT9lKr8Sh7JjpUz2ubd5b+UZWTw0JUmm1CYH
	aQyZTkqwYJYeDcVfoCRwnQtgUBGCYNu/v60fDSBtPoktYpuUOa9IAC3y+rFLHXJS/zzIo1nZRiv
	Etkb6EYvo0HhyMz74VFjRQFEczVSxGS1hww1Mu5ggpyt0Bh9vJo5aQSeyxFlfKK7T72xjJwoPoq
	r/mioVBe/xkQbRvJUFqjpk628=
X-Received: by 2002:a05:6000:1366:b0:453:aad2:77a0 with SMTP id ffacd0b85a97d-453aad2783cmr1379837f8f.3.1778161581612;
        Thu, 07 May 2026 06:46:21 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524833e1sm20701615f8f.2.2026.05.07.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:46:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 2/2] power: supply: Add support for Surface RT battery and charger
Date: Thu,  7 May 2026 16:46:07 +0300
Message-ID: <20260507134608.76222-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507134608.76222-1-clamor95@gmail.com>
References: <20260507134608.76222-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Add support for Embedded Controller found in the Microsoft Surface RT and
used to monitor battery cell and charger input status and properties.
Controller works both for UEFI and APX booting.

[wmjb: added POWER_SUPPLY_PROP_CHARGE_NOW support]
Signed-off-by: Jethro Bull <jethrob@hotmail.com>
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/Kconfig         |  11 +
 drivers/power/supply/Makefile        |   1 +
 drivers/power/supply/surface-rt-ec.c | 389 +++++++++++++++++++++++++++
 3 files changed, 401 insertions(+)
 create mode 100644 drivers/power/supply/surface-rt-ec.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 4d04de6586ae..13661d3d39b4 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -1168,6 +1168,17 @@ config BATTERY_UG3105
 	  device is off or suspended, the functionality of this driver is
 	  limited to reporting capacity only.
 
+config BATTERY_CHARGER_SURFACE_RT
+	tristate "Battery & Charger driver for Microsoft Surface RT"
+	depends on I2C && GPIOLIB
+	help
+	  UEFI/APX driver for the 1st-generation Microsoft Surface RT
+	  battery. Driver supports reading battery properties and
+	  charger status.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called surface-rt-ec.
+
 config CHARGER_QCOM_SMB2
 	tristate "Qualcomm PMI8998 PMIC charger driver"
 	depends on MFD_SPMI_PMIC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 3959b974ec84..ebd3beef4c84 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
 obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
 obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
 obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
+obj-$(CONFIG_BATTERY_CHARGER_SURFACE_RT) += surface-rt-ec.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
diff --git a/drivers/power/supply/surface-rt-ec.c b/drivers/power/supply/surface-rt-ec.c
new file mode 100644
index 000000000000..a728ae0db858
--- /dev/null
+++ b/drivers/power/supply/surface-rt-ec.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/devm-helpers.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/power_supply.h>
+#include <linux/types.h>
+
+/* Register Addresses (B=byte; W=word; S=string) */
+#define REGB_STATUS			0x02
+#define REGW_VOLTAGE_NOW		0x20
+#define REGW_CURRENT_NOW		0x24
+#define REGW_CAPACITY			0x28
+#define REGW_CHARGE_NOW			0x2a
+#define REGW_CHARGE_FULL		0x2c
+#define REGW_CYCLE_COUNT		0x3a
+#define REGW_CHARGE_FULL_DESIGN		0x3c
+#define REGW_VOLTAGE_MAX_DESIGN		0x3e
+#define REGW_SERIAL_NUMBER		0x44
+#define REGS_MANUFACTURER		0x46
+#define REGS_MODEL_NAME			0x52
+#define REGS_TECHNOLOGY			0x5a
+#define REGB_ONLINE			0x67
+
+struct srt_ec_device {
+	struct i2c_client *client;
+
+	struct power_supply *bat;
+	struct power_supply *psy;
+
+	struct gpio_desc *enable_gpiod;
+	struct delayed_work poll_work;
+
+	unsigned int technology;
+	unsigned int capacity;
+
+	const char *serial;
+	char manufacturer[13];
+	char model_name[10];
+};
+
+static const enum power_supply_property srt_bat_power_supply_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static const enum power_supply_property srt_psy_power_supply_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static int srt_bat_get_value(struct i2c_client *client, int reg, int *val)
+{
+	int ret;
+
+	switch (reg) {
+	case REGW_CHARGE_NOW:
+	case REGW_CHARGE_FULL_DESIGN:
+	case REGW_CHARGE_FULL:
+	case REGW_VOLTAGE_MAX_DESIGN:
+	case REGW_VOLTAGE_NOW:
+		ret = i2c_smbus_read_word_data(client, reg);
+		if (ret < 0)
+			return ret;
+
+		*val = ret * 1000;
+		break;
+
+	case REGW_CURRENT_NOW:
+		ret = i2c_smbus_read_word_data(client, reg);
+		if (ret < 0)
+			return ret;
+
+		*val = (s16)ret * 1000;
+		break;
+
+	case REGW_CAPACITY:
+	case REGW_CYCLE_COUNT:
+		ret = i2c_smbus_read_word_data(client, reg);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		break;
+
+	case REGB_STATUS:
+		ret = i2c_smbus_read_byte_data(client, reg);
+		if (ret < 0)
+			return ret;
+
+		if (ret & BIT(0))
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			*val =  POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+
+	case REGB_ONLINE:
+		ret = i2c_smbus_read_byte_data(client, reg);
+		if (ret < 0)
+			return ret;
+
+		*val = (ret & BIT(1)) >> 1;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int srt_bat_power_supply_get_property(struct power_supply *psy,
+					     enum power_supply_property psp,
+					     union power_supply_propval *val)
+{
+	struct srt_ec_device *srt = power_supply_get_drvdata(psy);
+	struct i2c_client *client = srt->client;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = srt->manufacturer;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = srt->model_name;
+		break;
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = srt->serial;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = srt_bat_get_value(client, REGW_CAPACITY, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = srt_bat_get_value(client, REGW_CHARGE_NOW, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = srt_bat_get_value(client, REGW_CHARGE_FULL, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = srt_bat_get_value(client, REGW_CHARGE_FULL_DESIGN,
+					&val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = srt_bat_get_value(client, REGW_CURRENT_NOW, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		ret = srt_bat_get_value(client, REGW_CYCLE_COUNT, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = srt_bat_get_value(client, REGB_ONLINE, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (srt->capacity < 100)
+			ret = srt_bat_get_value(client, REGB_STATUS, &val->intval);
+		else
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = srt->technology;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		ret = srt_bat_get_value(client, REGW_VOLTAGE_MAX_DESIGN,
+					&val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = srt_bat_get_value(client, REGW_VOLTAGE_NOW, &val->intval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int srt_psy_power_supply_get_property(struct power_supply *psy,
+					     enum power_supply_property psp,
+					     union power_supply_propval *val)
+{
+	struct srt_ec_device *srt = power_supply_get_drvdata(psy);
+	struct i2c_client *client = srt->client;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = i2c_smbus_read_byte_data(client, REGB_ONLINE);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret & BIT(0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void srt_bat_poll_work(struct work_struct *work)
+{
+	struct srt_ec_device *srt =
+		container_of(work, struct srt_ec_device, poll_work.work);
+	int ret, capacity;
+
+	ret = srt_bat_get_value(srt->client, REGW_CAPACITY, &capacity);
+	if (!ret && capacity != srt->capacity) {
+		srt->capacity = capacity;
+		power_supply_changed(srt->bat);
+	}
+
+	/* continuously send uevent notification */
+	schedule_delayed_work(&srt->poll_work, 30 * HZ);
+}
+
+static irqreturn_t srt_psy_detect_irq(int irq, void *dev_id)
+{
+	struct srt_ec_device *srt = dev_id;
+
+	power_supply_changed(srt->psy);
+
+	return IRQ_HANDLED;
+}
+
+static const struct power_supply_desc srt_bat_power_supply_desc = {
+	.name = "surface-rt-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = srt_bat_power_supply_props,
+	.num_properties = ARRAY_SIZE(srt_bat_power_supply_props),
+	.get_property = srt_bat_power_supply_get_property,
+	.external_power_changed = power_supply_changed,
+};
+
+static const struct power_supply_desc srt_psy_power_supply_desc = {
+	.name = "surface-rt-ac-adapter",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = srt_psy_power_supply_props,
+	.num_properties = ARRAY_SIZE(srt_psy_power_supply_props),
+	.get_property = srt_psy_power_supply_get_property,
+};
+
+static char *battery_supplied_to[] = { "surface-rt-battery" };
+
+static int srt_ec_probe(struct i2c_client *client)
+{
+	struct power_supply_config bat_cfg = {};
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct srt_ec_device *srt;
+	char str_buf[4];
+	int ret;
+
+	srt = devm_kzalloc(dev, sizeof(*srt), GFP_KERNEL);
+	if (!srt)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, srt);
+	srt->client = client;
+
+	srt->enable_gpiod = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(srt->enable_gpiod))
+		return dev_err_probe(dev, PTR_ERR(srt->enable_gpiod),
+				     "failed to get enable gpio\n");
+
+	/* wait till EC is ready */
+	usleep_range(1000, 1500);
+
+	ret = i2c_smbus_read_word_data(client, REGW_SERIAL_NUMBER);
+	if (ret < 0)
+		return ret;
+
+	srt->serial = devm_kasprintf(dev, GFP_KERNEL, "%04x", ret);
+	if (!srt->serial)
+		return -ENOMEM;
+
+	ret = i2c_smbus_read_i2c_block_data(client, REGS_MANUFACTURER,
+					    sizeof(srt->manufacturer) - 1,
+					    srt->manufacturer);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, REGS_MODEL_NAME,
+					    sizeof(srt->model_name) - 1,
+					    srt->model_name);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, REGS_TECHNOLOGY,
+					    sizeof(str_buf), str_buf);
+	if (ret < 0)
+		return ret;
+
+	if (!strncmp(str_buf, "LION", 4))
+		srt->technology = POWER_SUPPLY_TECHNOLOGY_LION;
+	else
+		srt->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+
+	bat_cfg.drv_data = srt;
+	bat_cfg.fwnode = dev_fwnode(dev);
+
+	srt->bat = devm_power_supply_register(dev, &srt_bat_power_supply_desc,
+					      &bat_cfg);
+	if (IS_ERR(srt->bat))
+		return dev_err_probe(dev, PTR_ERR(srt->bat),
+				     "failed to register battery power supply\n");
+
+	psy_cfg.drv_data = srt;
+	psy_cfg.fwnode = dev_fwnode(dev);
+	psy_cfg.supplied_to = battery_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
+
+	srt->psy = devm_power_supply_register(dev, &srt_psy_power_supply_desc,
+					      &psy_cfg);
+	if (IS_ERR(srt->psy))
+		return dev_err_probe(dev, PTR_ERR(srt->psy),
+				     "failed to register AC power supply\n");
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, srt_psy_detect_irq,
+					IRQF_ONESHOT, client->name, srt);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to request interrupt\n");
+
+	ret = devm_delayed_work_autocancel(dev, &srt->poll_work, srt_bat_poll_work);
+	if (ret < 0)
+		return ret;
+
+	schedule_delayed_work(&srt->poll_work, HZ);
+
+	return 0;
+}
+
+static int srt_ec_suspend(struct device *dev)
+{
+	struct srt_ec_device *srt = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&srt->poll_work);
+
+	return 0;
+}
+
+static int srt_ec_resume(struct device *dev)
+{
+	struct srt_ec_device *srt = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&srt->poll_work, HZ);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(srt_ec_pm_ops, srt_ec_suspend, srt_ec_resume);
+
+static const struct of_device_id srt_ec_of_match[] = {
+	{ .compatible = "microsoft,surface-rt-ec" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, srt_ec_of_match);
+
+static struct i2c_driver srt_ec_driver = {
+	.driver = {
+		.name = "surface-rt-ec",
+		.of_match_table = srt_ec_of_match,
+		.pm = &srt_ec_pm_ops,
+	},
+	.probe = srt_ec_probe,
+};
+module_i2c_driver(srt_ec_driver);
+
+MODULE_AUTHOR("Jonas Schwöbel <jonasschwoebel@yahoo.de>");
+MODULE_DESCRIPTION("Surface RT Embedded Controller driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

