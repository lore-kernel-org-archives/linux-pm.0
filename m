Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571383;
	b=KjAqdz29JfY8FgizInScfJXKWC8CNnkeXy05V7KOhgNg0EXHaQtRBxKeLRi8/ahcPu2P
	 8WdWcqJQZZNaSoXZM3Lcma6W5a6+Hi3ZWd2/2viGvXz1U2EELuEIlFDPvvoYW33x7fu3X
	 /xj3xKVi9pFl5XGIZLVIeqHM680vAS3uTeDamHDmvrCBLMrx4xcq9Mw7KptQrWHZaBdWv
	 hXFba5ZzmBcr3R1LJWwEkuJyM9Fr1NlLxh73GUSR39lwJZwj3pp6u1iikNuZdiwIlnk4i
	 3EHCXrVVOak3m0Faeq55Ha3jYPdfHdkv6N4XT4fi4y3ayQ20yq2/H8MCkFRnzV6kCcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Y/auMRVMZxu4xOdTWGkueqFmsIrhjab9mC5KzTte/o=;
	b=Vo3fpgXzTrzycm+7PP7TCxXLkxfo68cxnJV3LcYlvSA+NiaNGAokIMkb4AuMmlBWW43K
	 WHyVUMX8xVmDx0l5kWXkYy99RS2YINkW41j3E9oMMfSDnz4YvtWOXReX3JPn9wsAUDs0T
	 bkA155ee3JjwC0T6wecFthIs/oHDbIbnu6/+K1qKCWenQsKdGdUHpfmP+I3p+Fwyr8Nzh
	 w6/llJfQzq+wg0OFVs0mF6QCyvxVm0WqXOU1QSrwlFuWc+sUwaOX6kH1zNDPNWIkD/RbK
	 hU8BGe3kQTq5pwIxXzhD0TBn9L7js5dApU022Pnb+Bdpl2cwGMlVkQ7YkIHY0yDD29A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXMJsvI1;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D575606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D575606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXMJsvI1
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36681e85e87so901029eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571382; x=1793176182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Y/auMRVMZxu4xOdTWGkueqFmsIrhjab9mC5KzTte/o=;
        b=eXMJsvI1CwL6FdVVz5jS3JeyWlnfGS34ayOpJy9N5kcMdGOp+0nUcvtD4GLDAcBsVK
         pKi7uN/4ciMzq6u2k9ujwAJXo9KwqAIvVHhMmGE/Iui1Y/KXgodIypGD5Z6rDF6rlxBz
         LT37iLMDK/Q9Yo4dBC8l8dJRIjtg4oHwUDNXaJJ66CN/KkKj5uXnii5zdtr7tshA8D3a
         wdop+fdqRp+6ubQXnkYpHZ+M2g0q+FpzbQzOmSCL7/GKWAOQsQ4UYYxYRFbIc8+bFb+P
         kCySA5AubxitUY27l0SkhjNyjK3o2ecMkqeOjzd7MHXbrLELv0X6Qibe01UAkFefl3my
         f47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571382; x=1793176182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Y/auMRVMZxu4xOdTWGkueqFmsIrhjab9mC5KzTte/o=;
        b=chnNXGrZ0B9VCDQVDXbici33g+DUnkSHmMlbvDJSRe37EsPb3yJApyU9mtnJoWRGpc
         YI6UjV4daNmgkChj2sMAbsQGSnDvJ1NSxsrBJw2PHeCn/xtxvGC7lJsp/9nSovVNN2c0
         jNuXDqw285lzQWoNXX8n5KQFNEmz0iGFnDKdx5w9eXIkxhyrdlQ70XG+c83bKCnDShM3
         gqIkE84WEcrU9mqVGyDSBG4zQm/2HVpD9fHjM0LGE66qVJiJ/SHTJacfVqWZWTfUYyNC
         xgcuErqtZ/B7s7y6crJoCbAjUyUPsBJWW+z2GjNXws05frjfxFT3iwa8zCQKbNxTz5Yl
         XCTQ==
X-Gm-Message-State: AFq9FYLoIYNz1uVhwi85T2XdBHP0nH+ZgdSt7bscBNz9aesxlgoLCcuP
	4f5d6FuyiPKzaXd/xT1D5eY3ekS5S1I6KfgU+wtcvP31uF67RdpEJi81
X-Gm-Gg: AYBFou1VRQD/QqXh1xgQsnSUK0FK2tV6MCz9DWJQJTc5Wk2JJy6s7c1sA8Lz1k7t3gN
	xj2yLrTSZWipP7d7fQcuiaqdTiGsvF6kaW9jLkYCdootNKCKWkY1Xh3ETTOsFfNVnM6/M/ckO/B
	stU1dRDzYjv2xPE7tCeaQfc86iqvM8E/gMdlfCmhKWgNs8HBcCOpIZYSW3HSylI2z26j/l/laks
	o6Yc2pHzb4lnIQUeguT3uB07h6nFINquC0KEQlwOkIHU6xIsWzvrYdlZ5yVbvByKi37mPguJ+/M
	KHwoyk3yaURC+Jsf0OjtxhlBuZ+Zeq8EFejp22tzkcJmLbnfJBUrL3hUMiAMN7qW/YgFcGsBhcc
	8YabiApAZEx/RkHoGq9yrzoksnc2n7P7L5fumdKbWwRSH1Lhp8z+NDN8RkzqBR3dy+pwc8uNMw4
	0MTDVS1ogGe7ljrP3Gn9yP8NYLSV4B1wiifXwXy5VzBTC2ct+UlTPPKgfZfnaqL/jxcLjxNEcXu
	vE3S8LRHzMhJu/nVrYk6ZQMNaRcU7DWDfi9wpYe8dFU7OVyOxJN/CV43POdRzf7dcn+2/pHXiyu
	vQDXdvAjaajzk+2EBzhpnoft1ZOnxHfHRHOuk8OqcqUfqA==
X-Received: by 2002:a05:7301:92e:b0:342:645a:5cf with SMTP id 5a478bee46e88-3674b82bb89mr2298077eec.1.1792571382033;
        Wed, 21 Oct 2026 01:29:42 -0700 (PDT)
Received: from localhost.localdomain ([113.161.48.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm5199132eec.6.2026.10.21.01.29.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 01:29:41 -0700 (PDT)
From: Adrian Nguyen <thenguyen1024@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Casey Connolly <casey.connolly@linaro.org>,
	Adrian Nguyen <thenguyen1024@gmail.com>
Subject: [PATCH v2 2/2] power: supply: Add Qualcomm SMB1351 charger driver
Date: Wed, 21 Oct 2026 15:28:41 +0700
Message-ID: <20261021082841.79147-3-thenguyen1024@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021082841.79147-1-thenguyen1024@gmail.com>
References: <20261021082841.79147-1-thenguyen1024@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm SMB1351 is a switch-mode battery charger that some phones
use in parallel with the charger in their PMIC.

On the Vsmart Active 1 (SDM660, PM660) it is powered from VBUS alone:
without VBUS it does not answer on I2C, and whenever VBUS comes back it
starts over from its OTP defaults. Those defaults enable charging
through an active-low pin that the PM660 holds low, with a 4.5 V float
voltage on a 4.4 V battery. So whenever the PM660 suspends its USB
input, the SMB1351 charges the battery on its own. Since commit
98d68b74ebb9 ("power: supply: qcom_smbx: allow disabling charging"),
qcom_smbx does that when user space writes 0 to the status property of
the PM660 charger to stop charging.

Add a driver that keeps the charger disabled. Each time the PMIC
charger reports a change, the driver hands the charge enable control to
I2C with charging disabled, which does not depend on how the PMIC drives
the enable pin, and sets the float voltage from the monitored battery.
Making qcom_smbx drive the pin high instead would keep the chip off
only because of the pin polarity in its OTP, which the downstream
driver does not rely on: it programs the polarity over I2C. The float
voltage only matters if charging gets enabled anyway, for example
through i2c-dev: charging then stops at the battery's maximum voltage
instead of 4.5 V.

While the chip does not answer, the driver retries for about two
seconds and then treats VBUS as absent. A chip without VBUS NACKs its
address, so only other I2C errors are logged. A power supply reports
whether the chip answers, which with this wiring means that it has
VBUS. It also reports the charging status, the charge type and the
float voltage set in the chip.

The chip can also lose VBUS and reset without the PMIC charger
reporting a change. Until the PMIC suspends its input, a reset chip
looks the same as a configured one in the status register: neither
charges. So reading the status or the charge type also checks that the
enable control is still set to I2C. If it is not, or if the chip does
not answer, they read as unknown and the driver tries to configure the
chip again.

Charging in parallel also needs the PMIC charger to split the current
and to drive the enable pin, so it is left for later.

The SMB1351 shares its float voltage and enable control registers
(0x03 and 0x06) with the Summit SMB347, but not its command and status
registers: configuration writes are allowed by bit 6 of 0x30, not by
bit 7, which the downstream driver names a reload bit; charging is
enabled in 0x32, not 0x30; and the status is at 0x3a, not 0x3d.
smb347-charger also applies its charging configuration only once, in
probe, and fails to probe when the chip does not answer, so it cannot
handle a chip that answers only while it has VBUS and has to be
configured again each time VBUS returns.

The version register of the chip on this board reads 0xb2, which the
downstream driver identifies as an SMB1350. The two chips share the
registers used here. The register definitions and the enable control
come from that driver:
https://github.com/LineageOS/android_kernel_xiaomi_sdm660/blob/49688d8750f2fca28271f936cfcfec5d97c0d7a4/drivers/power/supply/qcom/smb1351-charger.c

The cause was found with an LLM coding assistant, which read the
SMB1351 and PM660 registers on the phone and compared them with the
stock devicetree and the downstream driver.

Assisted-by: LLM coccinelle sparse
Signed-off-by: Adrian Nguyen <thenguyen1024@gmail.com>
---
 drivers/power/supply/Kconfig        |  14 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/qcom_smb1351.c | 426 ++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+)
 create mode 100644 drivers/power/supply/qcom_smb1351.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ee7dc5f2617a..d1dd39f47e38 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -1182,6 +1182,20 @@ config CHARGER_QCOM_SMB2
 	  adds support for the SMB2 switch mode battery charger found
 	  in PMI8998 and related PMICs.
 
+config CHARGER_QCOM_SMB1351
+	tristate "Qualcomm SMB1351 parallel charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to enable the driver for the Qualcomm SMB1351 charger
+	  and the register-compatible SMB1350, which some phones use in
+	  parallel with the charger in their PMIC. The driver keeps the
+	  charger from charging the battery on its own and reports whether
+	  it has input power.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called qcom_smb1351.
+
 config FUEL_GAUGE_MM8013
 	tristate "Mitsumi MM8013 fuel gauge driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f3c0d1006c1a..07b5f0d02f2a 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_CHARGER_SURFACE_RT) += surface-rt-ec.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
+obj-$(CONFIG_CHARGER_QCOM_SMB1351)	+= qcom_smb1351.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
 obj-$(CONFIG_MACSMC_POWER)	+= macsmc-power.o
 obj-$(CONFIG_CHARGER_MAX77759)	+= max77759_charger.o
diff --git a/drivers/power/supply/qcom_smb1351.c b/drivers/power/supply/qcom_smb1351.c
new file mode 100644
index 000000000000..8089051cb44a
--- /dev/null
+++ b/drivers/power/supply/qcom_smb1351.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm SMB1351 charger driver
+ *
+ * The SMB1351 is a switch-mode battery charger that some phones use in
+ * parallel with the charger in their PMIC. On some of them, such as the
+ * Vsmart Active 1, it is powered from VBUS only: without VBUS it does not
+ * answer on I2C, and when VBUS returns it starts over from its OTP
+ * configuration. This driver supports only that wiring and treats a chip
+ * that answers as having VBUS. It keeps charging disabled, and reapplies
+ * its configuration whenever the PMIC charger reports a change or a status
+ * read finds the chip reset. Parallel charging, interrupts and OTG are not
+ * supported yet.
+ *
+ * Copyright (c) 2016-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2026 Adrian Nguyen <thenguyen1024@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#define SMB1351_VFLOAT_REG		0x03
+#define SMB1351_VFLOAT_MASK		GENMASK(5, 0)
+
+#define SMB1351_CHG_PIN_EN_CTRL_REG	0x06
+#define SMB1351_EN_PIN_CTRL_MASK	GENMASK(6, 5)
+#define SMB1351_EN_BY_I2C_0_DISABLE	0x00
+
+#define SMB1351_VERSION_REG		0x2e
+#define SMB1351_VERSION_SMB1350		BIT(1)
+
+#define SMB1351_CMD_I2C_REG		0x30
+#define SMB1351_CMD_BQ_CFG_ACCESS	BIT(6)
+
+#define SMB1351_CMD_CHG_REG		0x32
+#define SMB1351_CMD_CHG_EN		BIT(1)
+
+#define SMB1351_STATUS_4_REG		0x3a
+#define SMB1351_STATUS_HOLD_OFF		BIT(3)
+#define SMB1351_STATUS_CHG_MASK		GENMASK(2, 1)
+#define SMB1351_STATUS_CHG_NONE		0
+#define SMB1351_STATUS_CHG_PRE		1
+#define SMB1351_STATUS_CHG_FAST		2
+#define SMB1351_STATUS_CHG_TAPER	3
+
+#define SMB1351_CHG_REVISION_REG	0x3f
+
+#define SMB1351_VFLOAT_MIN_UV		3500000
+#define SMB1351_VFLOAT_MAX_UV		4500000
+#define SMB1351_VFLOAT_STEP_UV		20000
+
+/* Let VBUS settle after the PMIC charger reports a change */
+#define SMB1351_SETTLE_MS		300
+/* Right after VBUS appears the chip may not answer yet */
+#define SMB1351_RETRY_MS		200
+#define SMB1351_RETRY_TIMEOUT_MS	2000
+
+struct smb1351 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy;
+	struct delayed_work work;
+	unsigned long retry_until;	/* jiffies, when to stop retrying */
+	unsigned int vfloat_code;	/* set before the work is enabled */
+	bool online;			/* only written by the work */
+	bool identified;		/* only used by the work */
+};
+
+static const enum power_supply_property smb1351_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+};
+
+static int smb1351_status(unsigned int stat)
+{
+	if (stat & SMB1351_STATUS_HOLD_OFF)
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	if (FIELD_GET(SMB1351_STATUS_CHG_MASK, stat) != SMB1351_STATUS_CHG_NONE)
+		return POWER_SUPPLY_STATUS_CHARGING;
+
+	return POWER_SUPPLY_STATUS_NOT_CHARGING;
+}
+
+static int smb1351_charge_type(unsigned int stat)
+{
+	switch (FIELD_GET(SMB1351_STATUS_CHG_MASK, stat)) {
+	case SMB1351_STATUS_CHG_PRE:
+		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+	case SMB1351_STATUS_CHG_FAST:
+	case SMB1351_STATUS_CHG_TAPER:	/* constant voltage phase */
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
+	default:
+		return POWER_SUPPLY_CHARGE_TYPE_NONE;
+	}
+}
+
+/*
+ * Read the charger status, provided the chip is still configured. The driver
+ * only ever selects the I2C enable control, so any other setting means that
+ * the chip has been reset and is no longer kept from charging.
+ */
+static int smb1351_read_status(struct smb1351 *chip, unsigned int *stat)
+{
+	unsigned int en;
+	int ret;
+
+	ret = regmap_read(chip->regmap, SMB1351_CHG_PIN_EN_CTRL_REG, &en);
+	if (ret)
+		return ret;
+
+	if ((en & SMB1351_EN_PIN_CTRL_MASK) != SMB1351_EN_BY_I2C_0_DISABLE)
+		return -EIO;
+
+	return regmap_read(chip->regmap, SMB1351_STATUS_4_REG, stat);
+}
+
+static int smb1351_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct smb1351 *chip = power_supply_get_drvdata(psy);
+	bool online = READ_ONCE(chip->online);
+	unsigned int stat, vfloat;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = online;
+		return 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		/* -ENODATA leaves the property out of a uevent */
+		if (!online)
+			return -ENODATA;
+		ret = regmap_read(chip->regmap, SMB1351_VFLOAT_REG, &vfloat);
+		if (ret)
+			return -ENODATA;
+		val->intval = SMB1351_VFLOAT_MIN_UV +
+			      FIELD_GET(SMB1351_VFLOAT_MASK, vfloat) *
+			      SMB1351_VFLOAT_STEP_UV;
+		return 0;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!online) {
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			return 0;
+		}
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		if (!online) {
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+			return 0;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * The chip can lose VBUS, and with it its configuration, without the
+	 * PMIC charger reporting a change. If it has been reset or does not
+	 * answer, run the work again, unless a run with its own deadline is
+	 * already pending. Report "Unknown" rather than an error, which would
+	 * drop the whole uevent.
+	 */
+	ret = smb1351_read_status(chip, &stat);
+	if (ret && !delayed_work_pending(&chip->work)) {
+		WRITE_ONCE(chip->retry_until, jiffies +
+			   msecs_to_jiffies(SMB1351_RETRY_TIMEOUT_MS));
+		queue_delayed_work(system_freezable_wq, &chip->work, 0);
+	}
+
+	if (psp == POWER_SUPPLY_PROP_STATUS)
+		val->intval = ret ? POWER_SUPPLY_STATUS_UNKNOWN :
+				    smb1351_status(stat);
+	else
+		val->intval = ret ? POWER_SUPPLY_CHARGE_TYPE_UNKNOWN :
+				    smb1351_charge_type(stat);
+
+	return 0;
+}
+
+static int smb1351_configure(struct smb1351 *chip)
+{
+	struct regmap *map = chip->regmap;
+	unsigned int cmd, en, vfloat;
+	int ret;
+
+	/* The configuration registers can only be written with this bit set */
+	ret = regmap_set_bits(map, SMB1351_CMD_I2C_REG,
+			      SMB1351_CMD_BQ_CFG_ACCESS);
+	if (ret)
+		return ret;
+
+	/* Clear the command first, so that I2C control starts out disabled */
+	ret = regmap_clear_bits(map, SMB1351_CMD_CHG_REG, SMB1351_CMD_CHG_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(map, SMB1351_CHG_PIN_EN_CTRL_REG,
+				 SMB1351_EN_PIN_CTRL_MASK,
+				 SMB1351_EN_BY_I2C_0_DISABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(map, SMB1351_VFLOAT_REG, SMB1351_VFLOAT_MASK,
+				 FIELD_PREP(SMB1351_VFLOAT_MASK,
+					    chip->vfloat_code));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, SMB1351_CMD_CHG_REG, &cmd);
+	if (ret)
+		return ret;
+	ret = regmap_read(map, SMB1351_CHG_PIN_EN_CTRL_REG, &en);
+	if (ret)
+		return ret;
+	ret = regmap_read(map, SMB1351_VFLOAT_REG, &vfloat);
+	if (ret)
+		return ret;
+
+	if ((cmd & SMB1351_CMD_CHG_EN) ||
+	    (en & SMB1351_EN_PIN_CTRL_MASK) != SMB1351_EN_BY_I2C_0_DISABLE ||
+	    FIELD_GET(SMB1351_VFLOAT_MASK, vfloat) != chip->vfloat_code)
+		return -EIO;
+
+	return 0;
+}
+
+static void smb1351_work(struct work_struct *work)
+{
+	struct smb1351 *chip = container_of(to_delayed_work(work),
+					    struct smb1351, work);
+	unsigned int version;
+	bool online;
+	int ret;
+
+	/* The chip only answers while it has VBUS */
+	ret = regmap_read(chip->regmap, SMB1351_VERSION_REG, &version);
+	online = !ret;
+
+	if (online && !chip->identified) {
+		bool smb1350 = version & SMB1351_VERSION_SMB1350;
+
+		dev_info(chip->dev, "found %s (version %#04x)\n",
+			 smb1350 ? "SMB1350" : "SMB1351", version);
+		chip->identified = true;
+	}
+
+	if (online)
+		ret = smb1351_configure(chip);
+
+	if (ret && time_before(jiffies, READ_ONCE(chip->retry_until))) {
+		queue_delayed_work(system_freezable_wq, &chip->work,
+				   msecs_to_jiffies(SMB1351_RETRY_MS));
+		return;
+	}
+
+	if (!online) {
+		/* Without VBUS the chip does not acknowledge its address */
+		if (ret != -ENXIO)
+			dev_warn_ratelimited(chip->dev,
+					     "failed to read version: %pe\n",
+					     ERR_PTR(ret));
+	} else if (ret) {
+		dev_err_ratelimited(chip->dev,
+				    "failed to disable charging: %pe\n",
+				    ERR_PTR(ret));
+	}
+
+	if (online != chip->online) {
+		dev_dbg(chip->dev, "VBUS %s\n", online ? "present" : "absent");
+		WRITE_ONCE(chip->online, online);
+		power_supply_changed(chip->psy);
+	}
+}
+
+static void smb1351_external_power_changed(struct power_supply *psy)
+{
+	struct smb1351 *chip = power_supply_get_drvdata(psy);
+
+	WRITE_ONCE(chip->retry_until,
+		   jiffies + msecs_to_jiffies(SMB1351_SETTLE_MS +
+					      SMB1351_RETRY_TIMEOUT_MS));
+	mod_delayed_work(system_freezable_wq, &chip->work,
+			 msecs_to_jiffies(SMB1351_SETTLE_MS));
+}
+
+static const struct power_supply_desc smb1351_psy_desc = {
+	.name = "smb1351-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = smb1351_properties,
+	.num_properties = ARRAY_SIZE(smb1351_properties),
+	.get_property = smb1351_get_property,
+	.external_power_changed = smb1351_external_power_changed,
+};
+
+static const struct regmap_config smb1351_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	/* 0x40-0x47 are interrupt status registers that clear on read */
+	.max_register = SMB1351_CHG_REVISION_REG,
+	/* The chip forgets its configuration whenever it loses VBUS */
+	.cache_type = REGCACHE_NONE,
+};
+
+static void smb1351_disable_work(void *data)
+{
+	struct smb1351 *chip = data;
+
+	disable_delayed_work_sync(&chip->work);
+}
+
+static int smb1351_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	struct smb1351 *chip;
+	int vfloat_uv;
+	int ret;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = dev;
+
+	chip->regmap = devm_regmap_init_i2c(client, &smb1351_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				     "failed to initialize regmap\n");
+
+	/*
+	 * external_power_changed() can run as soon as the power supply is
+	 * registered, before devm_power_supply_register() returns. Keep the
+	 * work disabled until the rest of probe is done.
+	 */
+	INIT_DELAYED_WORK(&chip->work, smb1351_work);
+	disable_delayed_work(&chip->work);
+
+	psy_cfg.drv_data = chip;
+	psy_cfg.fwnode = dev_fwnode(dev);
+
+	chip->psy = devm_power_supply_register(dev, &smb1351_psy_desc,
+					       &psy_cfg);
+	if (IS_ERR(chip->psy))
+		return dev_err_probe(dev, PTR_ERR(chip->psy),
+				     "failed to register power supply\n");
+
+	/*
+	 * Added after the power supply, so this runs before the power supply
+	 * is unregistered. Unlike devm_delayed_work_autocancel(), disabling
+	 * the work also turns later requeues into no-ops.
+	 */
+	ret = devm_add_action_or_reset(dev, smb1351_disable_work, chip);
+	if (ret)
+		return ret;
+
+	ret = power_supply_get_battery_info(chip->psy, &info);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get battery info\n");
+
+	if (power_supply_battery_info_has_prop(info,
+					       POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX))
+		vfloat_uv = info->constant_charge_voltage_max_uv;
+	else if (power_supply_battery_info_has_prop(info,
+						    POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN))
+		vfloat_uv = info->voltage_max_design_uv;
+	else
+		return dev_err_probe(dev, -EINVAL,
+				     "battery has no maximum voltage\n");
+
+	if (vfloat_uv < SMB1351_VFLOAT_MIN_UV ||
+	    vfloat_uv > SMB1351_VFLOAT_MAX_UV)
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported float voltage %d uV\n",
+				     vfloat_uv);
+
+	chip->vfloat_code = (vfloat_uv - SMB1351_VFLOAT_MIN_UV) /
+			    SMB1351_VFLOAT_STEP_UV;
+
+	/* Leave the chip to the work, it does not answer without VBUS */
+	WRITE_ONCE(chip->retry_until,
+		   jiffies + msecs_to_jiffies(SMB1351_RETRY_TIMEOUT_MS));
+	enable_delayed_work(&chip->work);
+	mod_delayed_work(system_freezable_wq, &chip->work, 0);
+
+	return 0;
+}
+
+static const struct of_device_id smb1351_of_match[] = {
+	{ .compatible = "qcom,smb1351" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, smb1351_of_match);
+
+static const struct i2c_device_id smb1351_i2c_id[] = {
+	{ .name = "smb1351" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, smb1351_i2c_id);
+
+static struct i2c_driver smb1351_driver = {
+	.driver = {
+		.name = "qcom-smb1351",
+		.of_match_table = smb1351_of_match,
+	},
+	.probe = smb1351_probe,
+	.id_table = smb1351_i2c_id,
+};
+module_i2c_driver(smb1351_driver);
+
+MODULE_AUTHOR("Adrian Nguyen <thenguyen1024@gmail.com>");
+MODULE_DESCRIPTION("Qualcomm SMB1351 charger driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

