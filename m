Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D23E5A07
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325738; cv=none; b=eh3DGq8wttidk0dDA57h+8rYXqkMcVxcSQ0zZd/QOJ2czQImxVUPfbGhFbuyeAM4mpXoOPHmAOt3+XwSizx3CpBw8OsRkfNo+aVdKX4hRatKSvXXcdSi2UmwsR5qCNrlnGy6OEjM4bfEnbuqtX+gmSeGFuYlOn3Yr3THXEY59TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325738; c=relaxed/simple;
	bh=flF3gM+ls8NCC15Kl05QZuJECqecVFLFSPOIUecbqQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7um6gnTkyY0O4jgV6XY2yP0dr2EwxWLtiNKykpmn8Bv0ZyLYFD69tOJlOnl0XqQMwHYSJXJe4EEkYQeBfyThYEgdghTS7swUbp+wNruQNWKFNv9Fup2jkNvfLhxfomkGbAs69Wq4DsKyCteVQ/3ak0Mmt3WgCvSsMMFDP2TVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kSAfBTHq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yh/odtc/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSAfBTHq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yh/odtc/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641ZZC3614039
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 08:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sMXAEt1UU05Yx+F3i4P8rVl8JdgR+Ujt9uqqKvjo26U=; b=kSAfBTHqcsfGzXIf
	LVxusbGWCzUIB6mNjmg0UByI26D+JEYIN4wGu81HvzcZcxU6lQyW2qqSgZYK1JPL
	hWq6SCLmo4UIS8Fm0AQvwesGyo/pD+EhW06Uy/d8/32SGU0NjdST6Bg+Njrewe3p
	uqgfKJBiwMJrWKfaFdMkpKE4Cr6stYvuz+T93Z0W3tibusaHZJQirW/zPmw6Akni
	LSSjUBleXp0CmLLgaF8p7KVrSiI+FSStAlJNouZrs/iRGuhDPm4DSQnb7Mjc+E0M
	AxXlfarKxjVLgcXGn7fxnculKgaPMvvMq2KQrJgpYjTEnroZtsia1pNu+vBNytZ+
	DX/iJA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvn9k2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:15:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c891ed872ddso4258453a12.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783325730; x=1783930530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMXAEt1UU05Yx+F3i4P8rVl8JdgR+Ujt9uqqKvjo26U=;
        b=Yh/odtc/ti7IfCFREM3GhA5rl6A7cNM/6wgx5VsMgo//OLeyBb9CgdyZJLKFg9wkoF
         7jYswPw/aMbSxQDrkcVvIiPiTY+9zkNJLRBxd7ovuxByc5PpfpQXqXLuBcDxhtMWls4G
         R/IE2Z/UWw72AP98djCJgX0tiI9UgcPKpLo23flEXN1o0Upo2FkrQnG6GTlb//dA4vzb
         WZn4lbGv+U+MDnVSepPoOCbHCw6il9dobhHsRPrv21n1cWbZ9LSS7rtazz6Pf31SRybc
         T2vKO3WCfwrNWB28HDmhPcsZXTTxMki7m6207QOZ3sjAOt8XPt7vVws88SHqDGfxzayM
         voYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783325730; x=1783930530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMXAEt1UU05Yx+F3i4P8rVl8JdgR+Ujt9uqqKvjo26U=;
        b=WdFbgi+z0pu2KcXXMwmXNPxsdoRZMHkIFQSDUH2qzUMHO2puznxl3i7NMeru9BVR+T
         V/Sb6JTRqmb28OKDVhF1Rljx5BFxeWWK/eSz3bTJ8eEFMhqdHY6Gal0IWeWEBe3ZdHiu
         KiMTwd+LCpQDhh8rJZF5bojvbX9Lx2jU2gcFqfijo4larv07PLdJ7GCAzD9gNr/nlNfC
         bNOG4SjlnOwJyQB30J7qYBRXCFGJ0Wbizolyxn/LC7bdpSDq83Hrl2qpsskyu48nNBs7
         CzfLF4qxTfrusYTHmtRKiaa0018xDpVgvPY7QXQ14N+mgqpkf6kYOdVPNfeAxKf8Y5HX
         nTxQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbpxAQ4tAvdA8/lTwd+H7I+Ivtql3Qn6tDgPRvLHRbFmEN3oJ+LGE1xm3R73o7ct3p70Asrgwd5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5n+ONVftFcHckT7L4dvA5IfP0CJ86m3n6WzQ7Y9aFW9bfi4/5
	au091CDvdr49kLGsSSU5WaZOrrSkJtfdSmuyVaQsmE/pBU1lD6Zt9KU13xD0r9D/vr6Oi2asvWN
	3Ps7GZWromeKpMW4XSv+Kx5hnKHbh9FL98gwo5b+m7OCR0gO5JKzrwQ5yqC+GK3RlRtQDrA==
X-Gm-Gg: AfdE7cmD7imXZIhUMytun2ccF3IzdWwIwNn6P6B4gx9EDmTEO+sjtQnAdcyBFkUMQuH
	UMkjWZyKrQUa2HoQ8Lepef646YdO8iK+3M3NV/G6XGQ9tvJ2W3FxC9NtxCH/LEQ9X8b0/jHlQJ0
	jIL+aE55YyZDeEmxdeydW7UhWgOilPmMR0oCdJQGxkqoJzGCfPJ2hB9wP+DHP+Azyni5ikPRZIv
	Gke0W0+ZVocryzkn7uHMHqndRvrqX+Cy1ar+QEOWOxM1ohDH41UBXUyiu/h0KNuTDqPdfRX6E9j
	9MnUa80pQjfWO0ewl1UOfUcpyWopcPO7iuPZfed3DLzvq1oTVdkD93UTjBGkue3zkarYYCCUQxL
	VK8+U2gUjHYPsuA3C0BAZHt+7ja/NDEIPh6rB1KavslA=
X-Received: by 2002:a05:6a21:4903:b0:3bf:49c8:f73 with SMTP id adf61e73a8af0-3c03e4a330cmr9309149637.35.1783325729587;
        Mon, 06 Jul 2026 01:15:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:4903:b0:3bf:49c8:f73 with SMTP id adf61e73a8af0-3c03e4a330cmr9309110637.35.1783325729031;
        Mon, 06 Jul 2026 01:15:29 -0700 (PDT)
Received: from hu-sachgupt-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f4cd4b1sm5584525a12.12.2026.07.06.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:15:28 -0700 (PDT)
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 13:44:36 +0530
Subject: [PATCH v2 2/2] thermal: qcom: Add support for Qualcomm MBG thermal
 monitoring
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-spmi-mbg-driver-v2-2-f883ff1d8719@oss.qualcomm.com>
References: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
In-Reply-To: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Sachin Gupta <sachin.gupta@oss.qualcomm.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4b6422 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LIlL8iqg20j2UnsMqcUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: M2fjZpv6kLfkRZC9SdIkSMBlpoKMTMSR
X-Proofpoint-GUID: M2fjZpv6kLfkRZC9SdIkSMBlpoKMTMSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX1Ksm/kP6FJs3
 08BjFqg9wXxuEx2z+2Cipk0V2mIAJP6PQJNzHJFu0ho8cO8aZiwNGLjvNP+6H30ROQOoD0F0J9G
 ptYJcLs58teAf21nJkwaZJQaxhhEzdmVee3a1vMhCa2gyxZKKwVmA7kDdrCS+HgBUGtjiTBDEkh
 KhycuM056HybGH316FdQC7ffajaSsUg9O1d2pP7wSuWdeNEy9tdxfj85TAcFTQVMa64QSQ2JfJE
 Usfs89fHx9Hx1gk/yqe7vPqmm+FjPnCaDs/YkTtZwTiz7XvaeaJBvo4ZrhpewVd8cNgTPhsX3iu
 pqQiisybhdHa72Jd88HtftKgx32euuoFoW43vX7isNruk3UBwt911VexjvYu1vaUgY7YxbfwxPm
 q0xlNvOb8aq0mbikQGNjg1rk0CuVQ3qGtupiHoT901anUfA+zwkDplWvr89/zVVieQ/IFOVuUFF
 S9tYAgtrqXFIYB8R3pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX/FpFgUAgEmtz
 g70j8GAeIfdi/GYkYWHMfXIUHaRcHt5qr4Ctkd1bibXjo2ddk6HeHJ/h3mzI4t9vqAAqs2y3Iyo
 nW6rIVOJT35NhLGybb40jpONpCH7ikA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

Add driver for the Qualcomm MBG thermal monitoring device. It monitors the
die temperature, and when there is a level 1 upper threshold violation, it
receives an interrupt over spmi. The driver reads the fault status
register and notifies thermal accordingly.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
---
 drivers/thermal/qcom/Kconfig            |  11 ++
 drivers/thermal/qcom/Makefile           |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 256 ++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index a6bb01082ec6..f2fc24a3096f 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -21,6 +21,17 @@ config QCOM_SPMI_ADC_TM5
 	  Thermal client sets threshold temperature for both warm and cool and
 	  gets updated when a threshold is reached.
 
+config QCOM_SPMI_MBG_TM
+	tristate "Qualcomm SPMI PMIC MBG Temperature monitor"
+	depends on QCOM_SPMI_ADC5_GEN3
+	select REGMAP_SPMI
+	help
+	  This enables a thermal driver for the MBG thermal monitoring device.
+	  It shows up in sysfs as a thermal sensor with single trip point.
+	  It notifies the thermal framework when this trip is violated. The
+	  temperature reported by the thermal sensor reflects the real
+	  time die temperature through ADC channel.
+
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 0fa2512042e7..1bec2746b98d 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 				   tsens-8960.o
 obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
+obj-$(CONFIG_QCOM_SPMI_MBG_TM) += qcom-spmi-mbg-tm.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_QCOM_LMH)		+= lmh.o
diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
new file mode 100644
index 000000000000..fa2f10002253
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+#include <linux/iio/consumer.h>
+
+#define MBG_TEMP_MON2_FAULT_STATUS	0x50
+
+#define MON_FAULT_STATUS_MASK		GENMASK(7, 4)
+#define MON_FAULT_LVL1_UPR		0x5
+
+#define MON2_LVL1_UP_THRESH		0x59
+
+#define MBG_TEMP_MON2_MISC_CFG		0x5f
+#define MON2_UP_THRESH_EN		BIT(1)
+
+#define MBG_TEMP_STEP_MV		8
+#define MBG_TEMP_DEFAULT_TEMP_MV	600
+#define MBG_TEMP_CONSTANT		1000
+#define MBG_MIN_TRIP_TEMP		25000
+#define MBG_MAX_SUPPORTED_TEMP		160000
+
+/**
+ * struct mbg_tm_chip - MBG thermal monitor device data.
+ * @map: regmap for accessing MBG thermal registers.
+ * @dev: mbg_tm_chip device.
+ * @tz_dev: thermal zone device registered with the thermal framework.
+ * @lock: mbg_tm_chip lock for set trip temperature.
+ * @base: base register offset for this MBG instance
+ * @irq: interrupt line used to signal threshold events
+ * @last_temp: last measured temperature.
+ * @last_thres_crossed: indicates whether the last interrupt crossed a threshold
+ * @adc: IIO ADC channel used for temperature sensing
+ */
+struct mbg_tm_chip {
+	struct regmap			*map;
+	struct device			*dev;
+	struct thermal_zone_device	*tz_dev;
+	struct mutex                    lock;
+	unsigned int			base;
+	int				irq;
+	int				last_temp;
+	bool				last_thres_crossed;
+	struct iio_channel		*adc;
+};
+
+/**
+ * struct mbg_map_table - temperature to voltage mapping entry
+ * @min_temp: minimum temperature supported by this mapping entry
+ * @vtemp0: reference voltage or ADC code corresponding to the temperature
+ * @tc: temperature coefficient used for conversion calculations
+ */
+struct mbg_map_table {
+	int min_temp;
+	int vtemp0;
+	int tc;
+};
+
+static const struct mbg_map_table map_table[] = {
+	{ -60000, 4337, 1967 },
+	{ -40000, 4731, 1964 },
+	{ -20000, 5124, 1957 },
+	{ 0,      5515, 1949 },
+	{ 20000,  5905, 1940 },
+	{ 40000,  6293, 1930 },
+	{ 60000,  6679, 1921 },
+	{ 80000,  7064, 1910 },
+	{ 100000, 7446, 1896 },
+	{ 120000, 7825, 1878 },
+	{ 140000, 8201, 1859 },
+};
+
+static int mbg_tm_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret, milli_celsius;
+
+	scoped_guard(mutex, &chip->lock) {
+		if (chip->last_thres_crossed) {
+			dev_dbg(chip->dev, "last_temp: %d\n", chip->last_temp);
+			chip->last_thres_crossed = false;
+			*temp = chip->last_temp;
+			return 0;
+		}
+	}
+
+	ret = iio_read_channel_processed(chip->adc, &milli_celsius);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read iio channel with %d\n", ret);
+		return ret;
+	}
+
+	*temp = milli_celsius;
+
+	return 0;
+}
+
+static int temp_to_vtemp_mv(int temp)
+{
+	int idx, vtemp, tc = 0, t0 = 0, vtemp0 = 0;
+
+	for (idx = 0; idx < ARRAY_SIZE(map_table); idx++)
+		if (temp >= map_table[idx].min_temp &&
+		    temp < (map_table[idx].min_temp + 20000)) {
+			tc = map_table[idx].tc;
+			t0 = map_table[idx].min_temp;
+			vtemp0 = map_table[idx].vtemp0;
+			break;
+		}
+
+	/*
+	 * Formula to calculate vtemp(mV) from a given temp
+	 * vtemp = (temp - minT) * tc + vtemp0
+	 * tc, t0 and vtemp0 values are mentioned in the map_table array.
+	 */
+	vtemp = ((temp - t0) * tc + vtemp0 * 100000) / 1000000;
+
+	/* step size is 8mV */
+	return abs(vtemp - MBG_TEMP_DEFAULT_TEMP_MV) / MBG_TEMP_STEP_MV;
+}
+
+static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int low_temp,
+				int temp)
+{
+	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret = 0;
+
+	guard(mutex)(&chip->lock);
+
+	/* The HW has a limitation that the trip set must be above 25C */
+	if (temp > MBG_MIN_TRIP_TEMP && temp < MBG_MAX_SUPPORTED_TEMP) {
+		ret = regmap_write(chip->map, chip->base + MON2_LVL1_UP_THRESH,
+				   temp_to_vtemp_mv(temp));
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_set_bits(chip->map, chip->base + MBG_TEMP_MON2_MISC_CFG,
+				      MON2_UP_THRESH_EN);
+		if (ret < 0)
+			return ret;
+	} else {
+		dev_err(chip->dev, "Set trip b/w 25C and 160C\n");
+		ret = regmap_clear_bits(chip->map, chip->base + MBG_TEMP_MON2_MISC_CFG,
+					MON2_UP_THRESH_EN);
+		return -ERANGE;
+	}
+
+	/*
+	 * Configure the last_temp one degree higher, to ensure the
+	 * violated temp is returned to thermal framework when it reads
+	 * temperature for the first time after the violation happens.
+	 * This is needed to account for the inaccuracy in the conversion
+	 * formula used which leads to the thermal framework setting back
+	 * the same thresholds in case the temperature it reads does not
+	 * show violation.
+	 */
+	chip->last_temp = temp + MBG_TEMP_CONSTANT;
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops mbg_tm_ops = {
+	.get_temp = mbg_tm_get_temp,
+	.set_trips = mbg_tm_set_trip_temp,
+};
+
+static irqreturn_t mbg_tm_isr(int irq, void *data)
+{
+	struct mbg_tm_chip *chip = data;
+	int ret, val;
+
+	scoped_guard(mutex, &chip->lock) {
+		ret = regmap_read(chip->map, chip->base + MBG_TEMP_MON2_FAULT_STATUS, &val);
+		if (ret < 0)
+			return IRQ_HANDLED;
+		if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR)
+			chip->last_thres_crossed = true;
+	}
+
+	if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR) {
+		dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
+		thermal_zone_device_update(chip->tz_dev, THERMAL_TRIP_VIOLATED);
+	} else {
+		dev_dbg(chip->dev, "Lvl1 upper threshold not violated, ignoring interrupt\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mbg_tm_probe(struct platform_device *pdev)
+{
+	struct mbg_tm_chip *chip;
+	struct device_node *node = pdev->dev.of_node;
+	u32 res;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &pdev->dev;
+
+	mutex_init(&chip->lock);
+
+	chip->map = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!chip->map)
+		return -ENXIO;
+
+	ret = device_property_read_u32(chip->dev, "reg", &res);
+	if (ret < 0)
+		return dev_err_probe(chip->dev, ret, "Couldn't read reg property\n");
+
+	chip->base = res;
+
+	chip->irq = platform_get_irq(pdev, 0);
+	if (chip->irq < 0)
+		return dev_err_probe(chip->dev, chip->irq, "Failed to get irq\n");
+
+	chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
+	if (IS_ERR(chip->adc))
+		return dev_err_probe(chip->dev, PTR_ERR(chip->adc), "Failed to get adc channel\n");
+
+	chip->tz_dev = devm_thermal_of_zone_register(chip->dev, 0, chip, &mbg_tm_ops);
+	if (IS_ERR(chip->tz_dev))
+		return dev_err_probe(chip->dev, PTR_ERR(chip->tz_dev),
+				     "Failed to register sensor\n");
+
+	return devm_request_threaded_irq(&pdev->dev, chip->irq, NULL, mbg_tm_isr, IRQF_ONESHOT,
+					 node->name, chip);
+}
+
+static const struct of_device_id mbg_tm_match_table[] = {
+	{ .compatible = "qcom,pm8775-mbg-tm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mbg_tm_match_table);
+
+static struct platform_driver mbg_tm_driver = {
+	.driver = {
+		.name = "qcom-spmi-mbg-tm",
+		.of_match_table = mbg_tm_match_table,
+	},
+	.probe = mbg_tm_probe,
+};
+module_platform_driver(mbg_tm_driver);
+
+MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

