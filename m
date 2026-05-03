Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080639182A
	for <linux-pm@vger.kernel.org>; Sun,  3 May 2026 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827412; cv=none; b=QTbNSOE1pfY/BV2+LxvS8qlbkGfb+wgdXQWftAt/J4g/0qtSfyptilPx/jHz7NpbjnMa6ajBNId38tb2SuCji/pCHBhibHS5WXgIDQBtlXmwQMJXh3Rurp77bK9U7CS8oHF2ZxoJTA1V4u2VxJm5HD4I8zthuz25tmMyaNWuyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827412; c=relaxed/simple;
	bh=1EgF4lTgujdWo2rd/7EwXCUxfgSPSR3dwMN1MO5rQws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNW6QuYbd3CiIacQ/iq364xqM6LtJ3KQQ2Y+d/GLZArwoJJPcBgj6ZTTN6wnZHxpO7fPBNiMomf1sXUGuW2fG/q/9Qx8xeEt/kz1pAYh6NwSO8M9gT2vYr77JWFkFjMgx9L2QQ9ZAJoiIM6VecN6ue07bUJh7twfSYy4Kc1PPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMwDfOHD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMwDfOHD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so5396157a12.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827409; x=1778432209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Js9Sb4OdjXT4vTjLNzONFBOEW5yTJMmHB2WqVPjGr4=;
        b=sMwDfOHDgc90Wq0YG4wbH69R1N5TUrNZgzNgZXthknn4mfIwviKNfTlAUXjD/LZEEa
         Vpj/CBMn+wfzGpTS3bydXJFtan7KfV9Po7E3JXF8GGd/hpGtYGpowaJWbb8fPt7QwnC6
         wM0SPO2JT428Kbr/TZW3RAaJb3flCMbk0EIdGFczPibdORa8DyTXZvdwIAZIzX8gxl2z
         tKf5jHojASgEvRRlLMn2EtPC+aN/vxpC/MAtpj2XF21Qgh8lGMLLhsXFREqT7E/IgkrG
         MfgbknMAaHkjGFNtZpr7pdtefC/155FniFlrJogEDWC7UhyBmiSbAAnsTCOb/adAYalM
         Sh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827409; x=1778432209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Js9Sb4OdjXT4vTjLNzONFBOEW5yTJMmHB2WqVPjGr4=;
        b=j6/MjdKdxQO0SjKn/JoT/NctYM78uQF7OQdJ4ZuCafuIP0rcCFjmWAhGeWqJsBhd6Q
         Y9ehzBMHEDo27LsFLf3CRr393bHxO/LvhKMiRJJE25gWS0AoI6B7W+0Oyeu77fati5xF
         bJU8E/SVN4C/2YOXDGry3XBjDt4d/3W/IFN+/nHyElf+827b0hYPg0x6VPpyRoElSpNp
         pYiS683KIR6/kTquP4EWy3ihQqzd660lMsh/rnFniC/Be0LWo3M0IRPDAvJqCZM5XpWl
         UYb2qidD02wncysDCc7hx7a6sCFUGgmzO2xZH0nzvxV6vAHeGoLpEltY43CQ/I/OSTVm
         +mag==
X-Forwarded-Encrypted: i=1; AFNElJ9VltwGLa5tguUl75FVyGqtDdgSLHRcfdyKogZHRqViao1r8f/p+G+o7KgQ7fHQzVlCZEKQIZLI1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1LxnExS9M1pxyc9MXHlvtrPzdX5WThSoXsxjdHDsm+4xy1DX
	TcN7rkXF/Yrzx2ifP/Awg+ShMjImNbtIecZWr9ieyWmmzU0N7JMMBudP
X-Gm-Gg: AeBDieuNoPGMT7e8A3zI+SdUjrbz2vTQaAe/PA/Q1C0ofVPgqNloU0izCqjCtlcwyu8
	6ktm5uPbD/iohq83N2tEfP4W1Mj39DSlFvQXxWCAy6wXl63tKrzRmpQKfPbWi7nDTiGgYJJDBQ+
	SI9sbaFpXMiTqCkGOhfYTtFoMlgnhO55aeojAmu23kdHXjWx3g3pMqJ2WLr0qWC6TZ6xlNQN7In
	hRRciJ8BcSRV6MnAmpfg7An87I/Tdn4rQqG6lns96/0TRLuXogBd/9h72iJcHqe61dEc8XV6BzE
	kadasummOFR5WfSVFuBrQWsPr2CYjg+PhXSlzpVQdcY0RqOaxGIbJBdDYaGlDIFNUJme0F4YnW6
	kw/a2HZwCupc/sPjNE5FmIPeIuGactivmJaVs8E8WBVaBpYrPYqqY1TEGfsaJ9v9T+1KPh9SNx4
	TcUMG/WWL8ryvS92S81cjgjDY=
X-Received: by 2002:a05:6402:4282:b0:66b:f0b3:42a7 with SMTP id 4fb4d7f45d1cf-67c1abb49d1mr2490450a12.24.1777827408878;
        Sun, 03 May 2026 09:56:48 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b8579891fsm2713649a12.0.2026.05.03.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:56:47 -0700 (PDT)
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
Subject: [PATCH v3 2/2] power: supply: Add support for Surface RT battery and charger
Date: Sun,  3 May 2026 19:56:34 +0300
Message-ID: <20260503165636.216257-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503165636.216257-1-clamor95@gmail.com>
References: <20260503165636.216257-1-clamor95@gmail.com>
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
Signed-off-by: wmjb <jethrob@hotmail.com>
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
index 000000000000..98b736f3b05a
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
+					    sizeof(str_buf) - 1, str_buf);
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

