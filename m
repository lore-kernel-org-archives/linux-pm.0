Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259041;
	b=aFEKJZLPEboEtXHjlaVdMk8M6FwiO8DohAZMkmv1quzDAWy047YwH97QM/oK682N7qiJ
	 8W0xaEsF9O5crdKjYgAOme8m0uGRjyFdSAgUlsVYWNF+uLby80gcrau8O95UUsa73au60
	 sa6TJc4Lh3mQvyvkt3txBqnFj1L8mmKXh3t7jvEWNG0f5r46A5kiW7BtT3h+8E6H6ywBq
	 637kNTtaXRXsTt6gaPrNucuE3ZkcYYfv4su25SVldgBpMv6Ou7nI6Q//CiCHvA3MMr5wT
	 9Xji6Ct+1JHCFCNJ6Vgn6tQb12EmUrLBCfdsUPpXaVZ82ZTYu3r6XWdSkF/R8gPrgug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259041;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3UkgSTvG1c0XA8zbrYDI2em4WQKJ3eirHGMDzw/gh9M=;
	b=fx2uPr45PlzT6lQBnEkt+mysLuqMmrdDzV5qEqoPYKspAm49cH4VL0ni1Aw4CpJow+Sg
	 /U90EDN0uYXjyALsYIiJSaF9DbVAGggKzwKRAA9LwV2GDdrf9rcvaqOJSrNXJXC2Ol2fc
	 6VFnPhs1uDBVf2PFS6WMqAF6wgHuutWvDF4rgL1rjUPeP6ArTKtCJD3mH1qCMfdF5sre/
	 G5wLv5BQSBauIL+BNEJLNNk+Yd8AH7PLOh25x9uyEaugniGLJGDDPZqcAaq9ezr101cxg
	 BNbvkgb5zrxNahxqMsBcWaBNnHg+FWra4SOWk0OLzx8Y/VKe7BNA7EUkzo9B96ya3Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=CA5cOaY+;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="YZ/LUQR4";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AF606A31A;
	Thu, 29 Oct 2026 07:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B0AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=CA5cOaY+;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YZ/LUQR4
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T71Ndm808294;
	Thu, 29 Oct 2026 03:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=3UkgSTvG1c0XA8zbrYDI2em4WQKJ3eirHGMDzw/gh9M=; b=CA5cOaY
	+VkLU6K47DKD60uM3nUW6N5jeLrcMeCoV3fc59s+HEGHHTcvDouG63hwEZRFQ2iP
	AzXcw3TGn9+y1HHuZx6yH2RXqsJMPiRQDYTbjiVVFoc9C22v1HyyQT/rpuOnvI+R
	IoXRHmEHnvUuUMG7/dIt76Cd9AgOkMsjXpLmml8qsQkf0YWCbUzFixVCKCU3M3J5
	XmISMOpdYsow4opKXFfheO+lyW3SMhIvZcJoGph56nDQ3fBRYxi7ADrOVOthTT1e
	6u0SkrHbOr3UXdCHHWNzshnVxaJX6jtsiWIVuV3hH93OtS1kOTRuBIZjCFwY1cWx
	iQqcc5CZOjCYD3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3UkgS
	TvG1c0XA8zbrYDI2em4WQKJ3eirHGMDzw/gh9M=; b=YZ/LUQR43VMdtaDg6Op2E
	6mdm3k1915wC+8T3V741l1D2sH64jbz3oISUx6V8E2yGJ4NtDkpy8dV7AWVvo/uT
	IoODN4KYbhHQyzIMMrRrPdv06guLAeezSNU68kr24gSOGsZkXZOZr/RvulNFq4Vc
	2ouHPsBKgs2gVWkjqghsPkZLcttsb5IykyDS0FUeZmY6iRDDH0NTx709WfinNfmj
	qJ/5ftjw23OveZPGvdE9pLtFM5OIHW+aNwEwTlDPRnVCShwa0QESEulnHEllMT/5
	lxgj/k7SeLs6eK9I4pWAnEZdVrPrsiFwa7A9P+26H+ToFg8AHp1FzHrmMkTu16wk
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hm1d0g53y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 03:30:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69T7UaY5009140
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Oct 2026 03:30:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Oct 2026 03:30:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Oct 2026 03:30:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Oct 2026 03:30:36 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69T7UKMK010624;
	Thu, 29 Oct 2026 03:30:31 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <sre@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] power: supply: add LT8491 battery charger driver
Date: Thu, 29 Oct 2026 15:30:12 +0800
Message-ID: <20261029073012.1498-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261029073012.1498-1-johnerasmusmari.geronimo@analog.com>
References: <20261029073012.1498-1-johnerasmusmari.geronimo@analog.com>
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
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -yz6ov0amVDcD56p2xqdxFTbbaBX1Q5z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX0A2rToN9uTvc
 3E+nboP7MsA5nY6EYucEOXDIfaXwGvsbQaCfQogA8c/43bvpTtng0c16PnHTbcmY6AZpaqazOto
 e+ncQxM2oYgzwcOZ2KnghHGGUmh1YhdvVldmAknBKOmqfJ97slM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX9kwn+YBFJ+mj
 91kjOHnjCBOpAGzgA43ksgsXwETpN44xoTSD7zyF4jynrLTahu5uXeiHbvhukI+X9j1QgTG0n+A
 PXqgC+va7+554n4x11K9mudjV6HH+OvjUPjqqXiEngmeetKnaP+9xjV5BxY1Bh7vgnMIW8ikBVX
 a0ZsyQ4Vqq4t1skZoe8rei4QLxnIUYCxp+Z0pU6WS+orewWt9KdsLqS5Itoz1wJGJ8lHpVKKd8o
 2e1QAEYER1TrtO2Ms+8bdGJXBz+E6A6hL/ohq3iXcjuqVENe6meuldbjaPWRoqp6IwFsG6JM9au
 SouPBDn1OFbwRjom90jgvNgSQ+e/BAV01KGji7iD9RfYeamevMujyMRpuUGaxnIJN2h/FgWt4kY
 m55GbJqTjF/NURPHsHtPni2O5me42S/gA/UdgawfotRl2Azit4hvKllDgUNhzJfy9WxeSYwl933
 DuHcJp75tmBslMt1ERQ==
X-Authority-Analysis: v=2.4 cv=M7XYuCws c=1 sm=1 tr=0 ts=6ae2f61d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Z_6zUrearLLfCFo25iUA:9
X-Proofpoint-ORIG-GUID: -yz6ov0amVDcD56p2xqdxFTbbaBX1Q5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290028

Add support for the Analog Devices LT8491 buck-boost battery charge
controller connected over I2C. The driver registers a power supply
exposing the charging status, battery voltage, current, power and
temperature, and the battery temperature limits. The PCB resistor
values needed by the chip's telemetry are read from the devicetree and
written to the chip at probe.

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 MAINTAINERS                           |   1 +
 drivers/power/supply/Kconfig          |   9 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/lt8491_charger.c | 428 ++++++++++++++++++++++++++
 4 files changed, 439 insertions(+)
 create mode 100644 drivers/power/supply/lt8491_charger.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b3cc7649..badfce0b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15471,6 +15471,7 @@ M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
+F:	drivers/power/supply/lt8491_charger.c
 
 LTC1660 DAC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ee7dc5f26..2a5a0c823 100644
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
index f3c0d1006..7b85b35b5 100644
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
index 000000000..eab5ea720
--- /dev/null
+++ b/drivers/power/supply/lt8491_charger.c
@@ -0,0 +1,428 @@
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
+#include <linux/iopoll.h>
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
+
+#define LT8491_UPDATE_TELEM_CMD 0xAA
+
+/* A telemetry update typically takes 20ms to complete, per the datasheet. */
+#define LT8491_TELEM_POLL_PERIOD_US 2000
+#define LT8491_TELEM_UPDATE_TIMEOUT_US 50000
+
+/* LT8491_CFG_TBAT_{MIN,MAX}_REG hold a signed whole-degree-Celsius value. */
+#define LT8491_TBAT_MIN_C -128
+#define LT8491_TBAT_MAX_C 127
+
+/* LT8491_TELE_TBAT_REG: reset value, and thermistor-disconnected indication. */
+#define LT8491_TBAT_NOT_MEASURED 0x7FFF
+#define LT8491_TBAT_DISCONNECTED 0x7777
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
+	int i;
+	int serial_number[LT8491_MFR_DATA_LEN];
+
+	for (i = 0; i < LT8491_MFR_DATA_LEN; i++) {
+		serial_number[i] = i2c_smbus_read_word_data(info->client,
+							    LT8491_MFR_DATA1_LSB_REG + i * 2);
+		if (serial_number[i] < 0)
+			return serial_number[i];
+	}
+
+	scnprintf(info->serial_number, sizeof(info->serial_number), "%04x%04x%04x",
+		  serial_number[0], serial_number[1], serial_number[2]);
+
+	return 0;
+}
+
+static int lt8491_update_telemetry(struct lt8491_info *info)
+{
+	int ret, val;
+
+	ret = i2c_smbus_read_byte_data(info->client, LT8491_STAT_CHARGER_REG);
+	if (ret < 0)
+		return ret;
+
+	/* Telemetry acquisition is already running; nothing to trigger. */
+	if (FIELD_GET(LT8491_TELEM_ACTIVE_MASK, ret))
+		return 0;
+
+	ret = i2c_smbus_write_byte_data(info->client, LT8491_CTRL_UPDATE_TELEM_REG,
+					LT8491_UPDATE_TELEM_CMD);
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, val,
+				val < 0 || !FIELD_GET(LT8491_TELEM_ACTIVE_MASK, val),
+				LT8491_TELEM_POLL_PERIOD_US,
+				LT8491_TELEM_UPDATE_TIMEOUT_US, false,
+				info->client, LT8491_STAT_CHARGER_REG);
+	if (ret)
+		return ret;
+
+	return val < 0 ? val : 0;
+}
+
+static int lt8491_get_property(struct power_supply *psy,
+			       enum power_supply_property psp,
+			       union power_supply_propval *val)
+{
+	struct lt8491_info *info = power_supply_get_drvdata(psy);
+	int ret;
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
+			ret = lt8491_update_telemetry(info);
+			if (ret)
+				return ret;
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_VBAT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret * 10000;
+
+		return 0;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = lt8491_update_telemetry(info);
+			if (ret)
+				return ret;
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_IOUT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		val->intval = ret * 1000;
+
+		return 0;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		scoped_guard(mutex, &info->lock) {
+			ret = lt8491_update_telemetry(info);
+			if (ret)
+				return ret;
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
+			ret = lt8491_update_telemetry(info);
+			if (ret)
+				return ret;
+
+			ret = i2c_smbus_read_word_data(info->client,
+						       LT8491_TELE_TBAT_REG);
+			if (ret < 0)
+				return ret;
+		}
+
+		if (ret == LT8491_TBAT_NOT_MEASURED ||
+		    ret == LT8491_TBAT_DISCONNECTED)
+			return -ENODATA;
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
+}
+
+static int lt8491_set_property(struct power_supply *psy,
+			       enum power_supply_property psp,
+			       const union power_supply_propval *val)
+{
+	struct lt8491_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		if (val->intval < LT8491_TBAT_MIN_C * 10 ||
+		    val->intval > LT8491_TBAT_MAX_C * 10)
+			return -EINVAL;
+
+		return i2c_smbus_write_byte_data(info->client,
+						 psp == POWER_SUPPLY_PROP_TEMP_ALERT_MIN ?
+						 LT8491_CFG_TBAT_MIN_REG :
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
+static const enum power_supply_property lt8491_properties[] = {
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
+	val /= divider;
+	if (val > U16_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "Value for %s is out of range.\n",
+				     propname);
+
+	/* The device has no word-write transaction; write low then high byte. */
+	ret = i2c_smbus_write_byte_data(info->client, reg, val & 0xff);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_write_byte_data(info->client, reg + 1, val >> 8);
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
+	info->psp = devm_power_supply_register(dev, &lt8491_desc, &psy_cfg);
+	if (IS_ERR(info->psp))
+		return dev_err_probe(dev, PTR_ERR(info->psp),
+				     "Failed to register power supply.\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id lt8491_id[] = {
+	{ .name = "lt8491" },
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
+MODULE_AUTHOR("John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>");
+MODULE_DESCRIPTION("LT8491 battery charger");
+MODULE_LICENSE("GPL");
-- 
2.34.1

