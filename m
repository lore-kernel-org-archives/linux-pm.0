Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296587;
	b=jYArHX0GEfZGu7JYyRhAM0m3ma3gEqD0DDzZ/LyxXla2r672e4kc5kGtW77d1jfj/d+i
	 jHPDtWbgcsN8rGRT7MSJwgUg4y8zmAIWahvwrDNAmYI4h0P7LBn4/M978/0mrrruROT2C
	 q4K+yxAzOrcvlx0zioL173BJ5kj3wGmTnvazmP5SxHETVrLiNHZZvJm7Rz0CiFRRuQD9y
	 IJWYDf5Ci+QwmCE3Xn0cXQ7bwUsxuJhljjlU701DVaoPSEb8UePYOCDQ13/deWaZULYog
	 7uhZF+dAhXyqAuRNvQJ7+SYqvlcB912Sy9ihvcg7MXcgbZ6S6J7htOYcRqdxIUrkJUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296587;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=86trBJaeCPwx4YZGmDt9Qew0ffAKyK0+MoM5yDgtmEs=;
	b=LE4VMyuGvkLJlgf2kPCFAO1ER5GGyGQ55JYYgIq6SGYyTXD3xr94GQX51bhH0nbMgzGQ
	 R+nBBaeaXulZutNQUnTEEJGjnWUYb8wwIzUKNT3FZ2urauHM/lUN4X0GmqeNxSsPMLY/m
	 LCq3KO7U3iBb13FD8k43hC9DjIblVVptssmUyMQ3kkRLfOt7Tt3rZBJBYcJl5oc3ROKke
	 xrJcy3twTFv35ocId5bd2LguP5udZhU/Lg4Div4X1wTW6BM9QByMjQFIVZjC3RfpvO5n6
	 w50atYYx1OwWsRMv6Oe8oncBFaL8xZwLTcWnAy7peMoLs7OJS6uI9vckKicP1PRam5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=nA0OgmHk;
	arc=none smtp.remote-ip=31.44.14.16
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [31.44.14.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB696606A31C;
	Thu, 29 Oct 2026 17:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB696606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=nA0OgmHk
Received: from mail-nwsmtp-smtp-production-main-38 (mail-nwsmtp-smtp-production-main-38.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:4d01:0:640:e9ac:0])
	by forward500d.mail.yandex.net (postfix) with ESMTPS id 184CC81731;
	Thu, 29 Oct 2026 20:56:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38 with ESMTPSA id itnBq5Sg9Sw0-CnCurzPo;
	Thu, 29 Oct 2026 20:56:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793296582; bh=86trBJaeCPwx4YZGmDt9Qew0ffAKyK0+MoM5yDgtmEs=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=nA0OgmHkybMWe8u+UyApk6qljaXsXFuxFTdq+AT23p+GHYa/vkwvys2iYQo6o1Gvb
	 6jHSd7MNtEoxgyT4srxlL4wtvMApsLOTWSuX6C7SM/cXtEJ43dSjEHvKiM9+0+D8jE
	 dO1+i2EO6cQhzVOKeP0SXVo8h1exd96RtMlRf7FY=
Authentication-Results: mail-nwsmtp-smtp-production-main-38; dkim=pass header.i=@yandex.ru
From: Kupreenko Danila <keckerz@yandex.ru>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] power: supply: add read-only CW2017 battery monitor
Date: Thu, 29 Oct 2026 20:53:16 +0300
Message-ID: <179329639684.489944.17646031923456877930.cw2017-first-public-rfc-2@yandex.ru>
In-Reply-To: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
References: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
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
X-Mailer: CW2017 public RFC via Python smtplib

Expose voltage, state of charge and temperature from a firmware-
initialized CW2017. Its register map and profile protocol differ from
CW2015, so use a separate monitor without initialization, reset or
profile upload operations. Reject all register-content writes through
regmap.

Require a successful VERSION read before registering power_supply. Retry
common bus errors up to three times with 20 ms between attempts, then
fail probe with the last errno. After communication succeeds, register
temporarily unavailable measurements and poll for recovery. Preserve
EPROBE_DEFER.

Keep the original sample errno internally and in rate-limited debug
output, but return ENODATA for unavailable measurements. Other transport
errno values abort power_supply_uevent, preventing an availability-
change notification from being formatted. Notify on validity transitions
and any changed exported measurement; fractional SOC changes that do not
change capacity stay quiet.

Poll every 30 seconds with coalesced timers. Back off failed polls
through 60, 120, 240 and at most 300 seconds; restore the normal period
on success. Resume triggers an immediate read and resets backoff. This
trades freshness for fewer scheduled polls, without claiming measured
energy savings.

Protect cached samples with a mutex and cancel managed polling before
the power supply and regmap are released. Omit unsupported battery
presence and leave charging status unknown. Profile markers do not prove
calibration or temperature-source correctness; this monitor depends on
firmware setup.

Developed with Codex (GPT-6), independently of the later Firefly
reference. Host tests exercise the actual driver and mainline uevent
helpers with mocked kernel infrastructure.

The same driver source was built for Linux 7.1.3-msm89x7 and tested
on Xiaomi Redmi Go (R5). Module autoload, I2C binding, battery
measurements and kernel power_supply change events were verified.
The mainline kernel itself was not booted on this device.
Hardware suspend/resume, teardown, calibration and energy use
remain untested.

Assisted-by: LLM sparse
Signed-off-by: Kupreenko Danila <keckerz@yandex.ru>
---
 MAINTAINERS                           |   1 +
 drivers/power/supply/Kconfig          |  14 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/cw2017_battery.c | 370 ++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 drivers/power/supply/cw2017_battery.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 27124fd02..29a2e318a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6159,6 +6159,7 @@ M:	Kupreenko Danila <Keckerz@yandex.ru>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml
+F:	drivers/power/supply/cw2017_battery.c
 
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ee7dc5f26..a0503db31 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -141,6 +141,20 @@ config BATTERY_CW2015
 	  This driver can also be built as a module. If so, the module will be
 	  called cw2015_battery.
 
+config BATTERY_CW2017
+	tristate "CellWise CW2017 battery fuel gauge"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Read voltage, temperature and state of charge from a CellWise CW2017
+	  fuel gauge which has already been initialized with the correct battery
+	  profile. This driver does not wake or reset the gauge, upload profiles,
+	  or supply host-reported temperature. Uninitialized gauges do not report
+	  measurements. Battery profiles must use a maintained temperature input.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called cw2017_battery.
+
 config BATTERY_DS2760
 	tristate "DS2760 battery driver (HP iPAQ & others)"
 	depends on W1
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f3c0d1006..04f496d29 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
 obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
 obj-$(CONFIG_BATTERY_CPCAP)	+= cpcap-battery.o
 obj-$(CONFIG_BATTERY_CW2015)	+= cw2015_battery.o
+obj-$(CONFIG_BATTERY_CW2017)	+= cw2017_battery.o
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
 obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
diff --git a/drivers/power/supply/cw2017_battery.c b/drivers/power/supply/cw2017_battery.c
new file mode 100644
index 000000000..86323849a
--- /dev/null
+++ b/drivers/power/supply/cw2017_battery.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Read-only monitoring of an initialized CellWise CW2017 fuel gauge.
+ * Register definitions and conversions follow the CW2017-DS V1.1 datasheet
+ * and Xiaomi's tiare-o-oss cw2017_fuel_gauge.c driver.
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+
+#define CW2017_REG_VERSION	0x00
+#define CW2017_REG_VCELL		0x02
+#define CW2017_REG_SOC		0x04
+#define CW2017_REG_TEMP		0x06
+#define CW2017_REG_CONFIG		0x08
+#define CW2017_REG_SOC_ALERT	0x0b
+
+#define CW2017_VERSION_NOT_READY	0xa0
+#define CW2017_CONFIG_NORMAL	0x00
+#define CW2017_PROFILE_UPDATED	BIT(7)
+#define CW2017_VCELL_MAX		GENMASK(13, 0)
+#define CW2017_SOC_MAX		(100 * 256)
+#define CW2017_POLL_INTERVAL_MS	30000U
+#define CW2017_MAX_POLL_INTERVAL_MS	300000U
+#define CW2017_PROBE_ATTEMPTS	3
+#define CW2017_PROBE_RETRY_MS	20
+
+struct cw2017_sample {
+	int voltage_uv;
+	int capacity;
+	int temp;
+	int error;
+};
+
+struct cw2017 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy;
+	struct power_supply_desc desc;
+	struct delayed_work work;
+	/* Protects the cached sample shared by polling and property readers. */
+	struct mutex lock;
+	struct cw2017_sample sample;
+	unsigned int poll_interval_ms;
+};
+
+/* Require an answer before registering a supply; do not infer battery presence. */
+static int cw2017_check_communication(struct cw2017 *cw)
+{
+	unsigned int version;
+	int attempt, ret;
+
+	for (attempt = 0; attempt < CW2017_PROBE_ATTEMPTS; attempt++) {
+		ret = regmap_read(cw->regmap, CW2017_REG_VERSION, &version);
+		switch (ret) {
+		case -EAGAIN:
+		case -EIO:
+		case -ENXIO:
+		case -EREMOTEIO:
+		case -ETIMEDOUT:
+			break;
+		default:
+			return ret;
+		}
+
+		if (attempt + 1 < CW2017_PROBE_ATTEMPTS)
+			msleep(CW2017_PROBE_RETRY_MS);
+	}
+
+	return ret;
+}
+
+/* Never wake/reset the gauge or change its profile as a side effect of a read. */
+static int cw2017_check_ready(struct cw2017 *cw)
+{
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(cw->regmap, CW2017_REG_CONFIG, &value);
+	if (ret)
+		return ret;
+	if (value != CW2017_CONFIG_NORMAL)
+		return -ENODATA;
+
+	ret = regmap_read(cw->regmap, CW2017_REG_VERSION, &value);
+	if (ret)
+		return ret;
+	if (value == CW2017_VERSION_NOT_READY)
+		return -ENODATA;
+
+	ret = regmap_read(cw->regmap, CW2017_REG_SOC_ALERT, &value);
+	if (ret)
+		return ret;
+
+	/* This flag is a host-written marker, not a profile checksum. */
+	return value & CW2017_PROFILE_UPDATED ? 0 : -ENODATA;
+}
+
+static int cw2017_read_sample(struct cw2017 *cw, struct cw2017_sample *sample)
+{
+	unsigned int temp;
+	u16 voltage, soc;
+	u8 raw[2];
+	int ret;
+
+	ret = cw2017_check_ready(cw);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(cw->regmap, CW2017_REG_VCELL, raw, sizeof(raw));
+	if (ret)
+		return ret;
+	voltage = get_unaligned_be16(raw);
+
+	ret = regmap_bulk_read(cw->regmap, CW2017_REG_SOC, raw, sizeof(raw));
+	if (ret)
+		return ret;
+	soc = get_unaligned_be16(raw);
+
+	ret = regmap_read(cw->regmap, CW2017_REG_TEMP, &temp);
+	if (ret)
+		return ret;
+
+	if (voltage > CW2017_VCELL_MAX || soc > CW2017_SOC_MAX)
+		return -ENODATA;
+
+	/* Reject a sample if a reset became visible during the reads. */
+	ret = cw2017_check_ready(cw);
+	if (ret)
+		return ret;
+
+	/* VCELL: 312.5 uV/LSB; SOC: 1/256 percent; TEMP: 0.5 C/LSB - 40 C. */
+	sample->voltage_uv = voltage * 625 / 2;
+	sample->capacity = soc / 256;
+	sample->temp = (int)temp * 5 - 400;
+
+	return 0;
+}
+
+static int cw2017_get_property(struct power_supply *psy,
+			       enum power_supply_property property,
+			       union power_supply_propval *value)
+{
+	struct cw2017 *cw = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (property) {
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		value->strval = "CW2017";
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		value->strval = "CellWise";
+		return 0;
+	case POWER_SUPPLY_PROP_STATUS:
+		value->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CAPACITY:
+	case POWER_SUPPLY_PROP_TEMP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&cw->lock);
+	/* Omit unavailable measurements from uevents instead of aborting them. */
+	ret = cw->sample.error ? -ENODATA : 0;
+	if (!ret) {
+		switch (property) {
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+			value->intval = cw->sample.voltage_uv;
+			break;
+		case POWER_SUPPLY_PROP_CAPACITY:
+			value->intval = cw->sample.capacity;
+			break;
+		case POWER_SUPPLY_PROP_TEMP:
+			value->intval = cw->sample.temp;
+			break;
+		default:
+			break;
+		}
+	}
+	mutex_unlock(&cw->lock);
+
+	return ret;
+}
+
+static void cw2017_poll(struct work_struct *work)
+{
+	struct cw2017 *cw = container_of(to_delayed_work(work), struct cw2017, work);
+	struct cw2017_sample sample = { };
+	bool changed;
+
+	sample.error = cw2017_read_sample(cw, &sample);
+	if (sample.error)
+		dev_dbg_ratelimited(cw->dev, "Measurements unavailable (%d)\n",
+				    sample.error);
+
+	mutex_lock(&cw->lock);
+	changed = !cw->sample.error != !sample.error ||
+		  (!sample.error &&
+		   (cw->sample.capacity != sample.capacity ||
+		    cw->sample.voltage_uv != sample.voltage_uv ||
+		    cw->sample.temp != sample.temp));
+	cw->sample = sample;
+	mutex_unlock(&cw->lock);
+
+	if (changed)
+		power_supply_changed(cw->psy);
+
+	if (sample.error)
+		cw->poll_interval_ms = min(cw->poll_interval_ms * 2,
+					   CW2017_MAX_POLL_INTERVAL_MS);
+	else
+		cw->poll_interval_ms = CW2017_POLL_INTERVAL_MS;
+
+	queue_delayed_work(system_freezable_wq, &cw->work,
+			   round_jiffies_relative(msecs_to_jiffies(cw->poll_interval_ms)));
+}
+
+static bool cw2017_readable_reg(struct device *dev, unsigned int reg)
+{
+	return reg == CW2017_REG_VERSION ||
+	       (reg >= CW2017_REG_VCELL && reg <= CW2017_REG_TEMP) ||
+	       reg == CW2017_REG_CONFIG || reg == CW2017_REG_SOC_ALERT;
+}
+
+static bool cw2017_writeable_reg(struct device *dev, unsigned int reg)
+{
+	return false;
+}
+
+static const struct regmap_config cw2017_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = CW2017_REG_SOC_ALERT,
+	.readable_reg = cw2017_readable_reg,
+	.writeable_reg = cw2017_writeable_reg,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const enum power_supply_property cw2017_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int cw2017_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct power_supply_config config = { };
+	struct cw2017 *cw;
+	int ret;
+
+	cw = devm_kzalloc(dev, sizeof(*cw), GFP_KERNEL);
+	if (!cw)
+		return -ENOMEM;
+
+	mutex_init(&cw->lock);
+	cw->dev = dev;
+	cw->poll_interval_ms = CW2017_POLL_INTERVAL_MS;
+	i2c_set_clientdata(client, cw);
+
+	cw->regmap = devm_regmap_init_i2c(client, &cw2017_regmap_config);
+	if (IS_ERR(cw->regmap))
+		return dev_err_probe(dev, PTR_ERR(cw->regmap), "Failed to create regmap\n");
+
+	ret = cw2017_check_communication(cw);
+	if (ret)
+		return dev_err_probe(dev, ret, "Gauge did not respond\n");
+
+	cw->sample.error = cw2017_read_sample(cw, &cw->sample);
+	if (cw->sample.error == -EPROBE_DEFER)
+		return dev_err_probe(dev, cw->sample.error, "Failed to read gauge\n");
+	if (cw->sample.error)
+		dev_warn(dev, "Measurements unavailable (%d); polling will retry\n",
+			 cw->sample.error);
+
+	cw->desc.name = devm_kasprintf(dev, GFP_KERNEL, "cw2017-%s", dev_name(dev));
+	if (!cw->desc.name)
+		return -ENOMEM;
+	cw->desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	cw->desc.properties = cw2017_properties;
+	cw->desc.num_properties = ARRAY_SIZE(cw2017_properties);
+	cw->desc.get_property = cw2017_get_property;
+	config.drv_data = cw;
+	config.fwnode = dev_fwnode(dev);
+
+	cw->psy = devm_power_supply_register(dev, &cw->desc, &config);
+	if (IS_ERR(cw->psy))
+		return dev_err_probe(dev, PTR_ERR(cw->psy), "Failed to register battery\n");
+
+	/* Cancel polling before devres releases the power supply and regmap. */
+	ret = devm_delayed_work_autocancel(dev, &cw->work, cw2017_poll);
+	if (ret)
+		return ret;
+
+	queue_delayed_work(system_freezable_wq, &cw->work,
+			   round_jiffies_relative(msecs_to_jiffies(cw->poll_interval_ms)));
+
+	return 0;
+}
+
+static int cw2017_suspend(struct device *dev)
+{
+	struct cw2017 *cw = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&cw->work);
+	mutex_lock(&cw->lock);
+	cw->sample.error = -ENODATA;
+	mutex_unlock(&cw->lock);
+
+	return 0;
+}
+
+static int cw2017_resume(struct device *dev)
+{
+	struct cw2017 *cw = dev_get_drvdata(dev);
+
+	cw->poll_interval_ms = CW2017_POLL_INTERVAL_MS;
+	queue_delayed_work(system_freezable_wq, &cw->work, 0);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cw2017_pm_ops, cw2017_suspend, cw2017_resume);
+
+static const struct of_device_id cw2017_of_match[] = {
+	{ .compatible = "cellwise,cw2017" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cw2017_of_match);
+
+static const struct i2c_device_id cw2017_ids[] = {
+	{ "cw2017" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cw2017_ids);
+
+static struct i2c_driver cw2017_driver = {
+	.driver = {
+		.name = "cw2017-battery",
+		.of_match_table = cw2017_of_match,
+		.pm = pm_sleep_ptr(&cw2017_pm_ops),
+	},
+	.probe = cw2017_probe,
+	.id_table = cw2017_ids,
+};
+module_i2c_driver(cw2017_driver);
+
+MODULE_AUTHOR("Kupreenko Danila <Keckerz@yandex.ru>");
+MODULE_DESCRIPTION("CellWise CW2017 battery monitor");
+MODULE_LICENSE("GPL");
-- 
2.56.0

