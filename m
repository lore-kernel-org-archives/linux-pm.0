Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6848EBF7;
	Thu,  3 Sep 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432429; cv=none; b=J8+2Cznr7Shr7wAQr4lH9SBipXlyg/T+aPY4JF1p62H8dRFTKLbTbPHt5GKzSm5HjVIkLtXnx848Tc1vhzFeQHDbMwMnu2pelqtH7/Q9JPf/7Ww1GeSzPanocU4cUrzYZb3vZcynu1iMC8rRpP3OrsVKL/JbOST6nXZPUbNBZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432429; c=relaxed/simple;
	bh=WywByyC2WVI1TE+sRmAS9YEPorwB/BiOSgsJj0BKMwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw4+aGaoWbcJcNFKNOadsVgA4CRN0W6cc0EHsVdxxOJZ0WbBOGBPTLkje7zYL+jpsEt0pbvLuI/b6wqFkbUGG4GJfQK23/a5dmonFXTbvKR/9B4G/M0mGypR3nK05cIu9WwBdqwCOOwQGBGBUwHo5Sa08FCBAFfKcM43Rw3NkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YxbukAIt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YxbukAIt"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AF7xV850432;
	Thu, 3 Sep 2026 06:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xQOFa
	VIrAE55INvBFmHv4rGODLQLGQFArjwMbVdXQIg=; b=YxbukAIt3W+uVSSp4TCSb
	FPUOaEquUKwahghq+yBy2S6mXOiZfcLpQlA9NJ2IjmWtMFMchDd2hgrTi+mnDV+D
	Wj+icffRHy6jYWVVmZvfM8F60kEOnL7/By130z9Phm1AFRgoLrUfGzaFCQCPOvrr
	hJU2IOk0dNZnrOG1lqgw2zB81MSzvXd8GUgKGsX2mkelFy4vaUnLpQKfgcJSxxDO
	pD/Z0cskaOgUxPHOAi3KYem1gmCiVKkHSDofHEknaZUB9n3ceUtuDEE3lgAjQ5wZ
	Wb1HTeXrZijgHwS0DxXI6RRgU+Hv/z5Gobx80iG7VANRFDubqjgHlMl+eOhGFJF7
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ufb92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:46:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 683AkwGW059075
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 06:46:58 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 3 Sep 2026 06:46:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 3 Sep 2026 06:46:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 3 Sep 2026 06:46:57 -0400
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.223.216])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 683AkdDE015001;
	Thu, 3 Sep 2026 06:46:52 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <robh@kernel.org>,
        <sre@kernel.org>
Subject: [PATCH v2 2/2] power: supply: add LT8491 battery charger driver
Date: Thu, 3 Sep 2026 18:46:37 +0800
Message-ID: <9c260e1c2056c69be1cb7a05abcd10ba657c1548.1788432152.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788432152.git.johnerasmusmari.geronimo@analog.com>
References: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com> <cover.1788432152.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfXyVsrhYU2KH6f
 d6zJNmgjmsO6fE6tnCUPV8G2QiyAFkYrGhL6V4N033bxFsi8VFqCwQKf7C2TyTAgRjgGAWdcVw0
 vhrrOvYG7Y+7eeumMYtVbR2Rv+y8qFTze7YMwsaJOIO3o4Um9KSTgJDExqY/Ef7VqBlyQnTlDLz
 ihy/W00n+66S8iQ+B8CBUojTGUAmf0eTX+W+Oj/a60x0vXwflTlvnF+sImgCzpf4rdnkZ88rW//
 pkdb+vuEDlzfxP7McgL+Ga5ipQC6RrNXUNGpAO/l0hpmuOJgYWhG+kdAZCAZuPS9WE1/GzrVTio
 yqoofmhiDScR9gvXfp2nn0v5Xpfmb85t2oR9z4RIPaZWeP7OwB442BwBkv2BHdrs3Nn6+9q85V+
 TaNkSJ97TFPeeBUrVH9oQfRmi8SclaAHy4uY3lXrVmGN0rDgm0E/v5P3g2+udpWgMVLtLRdLu4H
 QepVYsM1/wZH9h03Cmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfX8h7OCKNwjA+0
 8wColQako9xlIDna2LXph/9IRukNKNbHZTajO9LA3tB1vCG0+KHGttNzkhLk29RKyDHILZrQEnh
 Pb0ZI5sbcUb90/SjQpKTEWW8TNuv/5eEDJL4O2pTvFIVA14zk20m
X-Proofpoint-GUID: H0Mi29mvf0EvjVRybPMgThaT-8vY0h1r
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a995023 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Z_6zUrearLLfCFo25iUA:9
X-Proofpoint-ORIG-GUID: H0Mi29mvf0EvjVRybPMgThaT-8vY0h1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030093

Adds initial support for the LT8491 High Voltage Buck-Boost Battery
Charge Controller with I2C

The driver provides functionality to monitor key parameters including:
Voltage, Current, Power, Temperature, Status

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 MAINTAINERS                           |   1 +
 drivers/power/supply/Kconfig          |   9 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/lt8491_charger.c | 412 ++++++++++++++++++++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/power/supply/lt8491_charger.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d79187312f789..317ca2e8ca9bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15175,6 +15175,7 @@ M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
+F:	drivers/power/supply/lt8491_charger.c
 
 LTC1660 DAC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f0ede1cecb6a8..146ea3743eb2d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -598,6 +598,15 @@ config CHARGER_LT3651
 	  Say Y to include support for the Analog Devices (Linear Technology)
 	  LT3651 battery charger which reports its status via GPIO lines.
 
+config CHARGER_LT8491
+	tristate "Analog Devices LT8491 charger"
+	depends on I2C
+	help
+	  Say Y to include support for the Analog Devices (Linear Technology)
+	  LT8491 battery charge controller connected to I2C. The LT8491 is a
+	  high voltage buck-boost switching regulator battery charger
+	  controller.
+
 config CHARGER_LTC4162L
 	tristate "LTC4162-L charger"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 31fe4a145929a..d3d2721333204 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
 obj-$(CONFIG_CHARGER_LT3651)	+= lt3651-charger.o
+obj-$(CONFIG_CHARGER_LT8491)	+= lt8491_charger.o
 obj-$(CONFIG_CHARGER_LTC4162L)	+= ltc4162-l-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
diff --git a/drivers/power/supply/lt8491_charger.c b/drivers/power/supply/lt8491_charger.c
new file mode 100644
index 0000000000000..225d5dd4dd721
--- /dev/null
+++ b/drivers/power/supply/lt8491_charger.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices LT8491 Battery Charger
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+
+#define LT8491_TELE_TBAT_REG 0x0
+#define LT8491_TELE_POUT_REG 0x2
+#define LT8491_TELE_PIN_REG  0x4
+#define LT8491_TELE_EFF_REG  0x6
+#define LT8491_TELE_IOUT_REG 0x8
+#define LT8491_TELE_IIN_REG  0xA
+#define LT8491_TELE_VBAT_REG 0xC
+#define LT8491_TELE_VIN_REG  0xE
+#define LT8491_TELE_VINR_REG 0x10
+#define LT8491_STAT_CHARGER_REG 0x12
+#define LT8491_STAT_CHRG_FAULTS_REG 0x19
+#define LT8491_CTRL_UPDATE_TELEM_REG 0x26
+
+#define LT8491_CFG_RSENSE1_REG 0x28
+#define LT8491_CFG_RIMON_OUT_REG 0x2A
+#define LT8491_CFG_RSENSE2_REG 0x2C
+#define LT8491_CFG_RDACO_REG 0x2E
+#define LT8491_CFG_RFBOUT1_REG 0x30
+#define LT8491_CFG_RFBOUT2_REG 0x32
+#define LT8491_CFG_RDACI_REG 0x34
+#define LT8491_CFG_RFBIN2_REG 0x36
+#define LT8491_CFG_RFBIN1_REG 0x38
+#define LT8491_CFG_TBAT_MIN_REG 0x40
+#define LT8491_CFG_TBAT_MAX_REG 0x41
+#define LT8491_MFR_DATA1_LSB_REG 0x5C
+
+#define LT8491_TELEM_ACTIVE_MASK BIT(6)
+#define LT8491_CHARGING_MASK BIT(2)
+#define LT8491_BAT_DISCON_FLT_MASK BIT(3)
+
+#define LT8491_UPDATE_TELEM_CMD 0xAA
+
+#define LT8491_MFR_DATA_LEN 0x3
+
+struct lt8491_info {
+	struct i2c_client *client;
+	struct power_supply *psp;
+	char serial_number[16];
+	/* protect against device accesses */
+	struct mutex lock;
+};
+
+static int lt8491_read_serial_number(struct lt8491_info *info)
+{
+	int i, ret;
+	int serial_number[LT8491_MFR_DATA_LEN];
+
+	for (i = 0; i < LT8491_MFR_DATA_LEN; i++) {
+		serial_number[i] = i2c_smbus_read_word_data(info->client,
+					LT8491_MFR_DATA1_LSB_REG + i * 2);
+		if (serial_number[i] < 0)
+			return serial_number[i];
+	}
+
+	ret = sprintf(info->serial_number, "%04x%04x%04x", serial_number[0],
+		      serial_number[1], serial_number[2]);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lt8491_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct lt8491_info *info = power_supply_get_drvdata(psy);
+	s16 ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = i2c_smbus_read_byte_data(info->client,
+					       LT8491_STAT_CHARGER_REG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = FIELD_GET(LT8491_CHARGING_MASK, ret) ?
+					POWER_SUPPLY_STATUS_CHARGING :
+					POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						LT8491_TELE_VBAT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret * 10000;
+
+		return 0;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						       LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_IOUT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret;
+
+		return 0;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						       LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_POUT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret * 10000;
+
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP:
+		scoped_guard(mutex, &info->lock) {
+			ret = i2c_smbus_read_byte_data(info->client,
+						       LT8491_STAT_CHARGER_REG);
+			if (ret < 0)
+				return ret;
+
+			if (!FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret)) {
+				ret = i2c_smbus_write_byte_data(info->client,
+						LT8491_CTRL_UPDATE_TELEM_REG,
+						LT8491_UPDATE_TELEM_CMD);
+				if (ret)
+					return ret;
+			}
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_TBAT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = sign_extend32(ret, 15);
+
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		ret = i2c_smbus_read_byte_data(info->client,
+					       LT8491_CFG_TBAT_MIN_REG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = sign_extend32(ret, 7) * 10;
+
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		ret = i2c_smbus_read_byte_data(info->client,
+					       LT8491_CFG_TBAT_MAX_REG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = sign_extend32(ret, 7) * 10;
+
+		return 0;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "lt8491";
+
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Analog Devices";
+
+		return 0;
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = info->serial_number;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int lt8491_set_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct lt8491_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		return i2c_smbus_write_byte_data(info->client,
+						 LT8491_CFG_TBAT_MIN_REG,
+						 val->intval / 10);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return i2c_smbus_write_byte_data(info->client,
+						 LT8491_CFG_TBAT_MAX_REG,
+						 val->intval / 10);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int lt8491_property_is_writeable(struct power_supply *psy,
+					enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static enum power_supply_property lt8491_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const struct power_supply_desc lt8491_desc = {
+	.name		= "lt8491",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= lt8491_properties,
+	.num_properties	= ARRAY_SIZE(lt8491_properties),
+	.get_property	= lt8491_get_property,
+	.set_property	= lt8491_set_property,
+	.property_is_writeable = lt8491_property_is_writeable,
+};
+
+static int lt8491_configure_resistor(struct lt8491_info *info,
+				     const char *propname, int divider,
+				     unsigned int reg)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+	u32 val;
+
+	ret = device_property_read_u32(dev, propname, &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Missing %s property.\n",
+				     propname);
+
+	return i2c_smbus_write_word_data(info->client, reg, val / divider);
+}
+
+static int lt8491_configure_telemetry(struct lt8491_info *info)
+{
+	int ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rsense1-micro-ohms", 10,
+					LT8491_CFG_RSENSE1_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rimon-out-ohms", 10,
+					LT8491_CFG_RIMON_OUT_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rsense2-micro-ohms", 10,
+					LT8491_CFG_RSENSE2_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rdaco-ohms", 10,
+					LT8491_CFG_RDACO_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rfbout1-ohms", 100,
+					LT8491_CFG_RFBOUT1_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rfbout2-ohms", 10,
+					LT8491_CFG_RFBOUT2_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rdaci-ohms", 10,
+					LT8491_CFG_RDACI_REG);
+	if (ret)
+		return ret;
+
+	ret = lt8491_configure_resistor(info, "adi,rfbin2-ohms", 10,
+					LT8491_CFG_RFBIN2_REG);
+	if (ret)
+		return ret;
+
+	return lt8491_configure_resistor(info, "adi,rfbin1-ohms", 100,
+					 LT8491_CFG_RFBIN1_REG);
+}
+
+static int lt8491_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct lt8491_info *info;
+	struct power_supply_config psy_cfg = {};
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->client = client;
+	psy_cfg.drv_data = info;
+
+	ret = devm_mutex_init(dev, &info->lock);
+	if (ret)
+		return ret;
+
+	ret = lt8491_read_serial_number(info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Can't read serial. Hardware error.\n");
+
+	ret = lt8491_configure_telemetry(info);
+	if (ret)
+		return ret;
+
+	info->psp = power_supply_register(dev, &lt8491_desc, &psy_cfg);
+	if (IS_ERR(info->psp))
+		return dev_err_probe(dev, PTR_ERR(info->psp),
+				     "Failed to register power supply.\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id lt8491_id[] = {
+	{ "lt8491", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lt8491_id);
+
+static const struct of_device_id lt8491_of_match[] = {
+	{ .compatible = "adi,lt8491" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lt8491_of_match);
+
+static struct i2c_driver lt8491_driver = {
+	.driver = {
+		.name = "lt8491",
+		.of_match_table = lt8491_of_match,
+	},
+	.probe = lt8491_probe,
+	.id_table = lt8491_id,
+};
+module_i2c_driver(lt8491_driver);
+
+MODULE_AUTHOR("John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com");
+MODULE_DESCRIPTION("LT8491 battery charger");
+MODULE_LICENSE("GPL");
-- 
2.34.1

