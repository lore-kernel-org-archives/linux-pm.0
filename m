Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619E4C77B8
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717109; cv=none; b=Czoge1Qfa6+3McroCrhGWyxr4chXrE6vyOtkyiDyV1GDk32Uu03StvlG7MYKNSiyxvQL6s5ODPKKp/WA/nABnf/CfzW19//X1hBltXZLgwCqRPQA6CmRXbrJXcZcfG4AV+11qgj2amlPdXyakqBXtN9pk782GIh3H1z6H94cppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717109; c=relaxed/simple;
	bh=A9o/QYEXpXdIJCc9/P1XsKYnCLBu5/GlCz2zCEhEcdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZY6mlNWUfboOAlV9ZdfwtXAfWf/MKz0gBYNn6xNHq05HHsF9PoTuyYxFPlBuDtM8XT/Uv0jMGQEZ3hAp/a/D/XZW3bapJNvoFI/rr3LvfKJSyFUxctd4Qh74NCVz8ZARJUI02ZxcahaOYfke4H6otl+bixc5W7s7mYhtzd9P3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXf3vCmD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ND+uo4Qw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXf3vCmD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ND+uo4Qw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8x7pA1400202
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fsqqjEAZXtutPj2bLmJfhUXNgNSspoGv2SMxeBHWhRw=; b=JXf3vCmDqFiQ9QHT
	EGF/f4b0GNSXca9LmGTf5hO1SVOymmNV5F8FBQKMWJOpo2ujGKF6Rkyblwnbm/cI
	UUI4LfP4JEZDstkkcGkGjQ41I9T4rccxwj6z3JU9YJK/BiVNEXYK1Su6WsRhvDYe
	s17FF7mn9AOr6x91GToOahhhfEi9ic+CCbTtJu1sdni9HHGnVLQzUdZBK0HJdKqk
	PFKP9Ptr4Fyl9iOOkGz1yKQ7O01ro5K5qBZRU8mzHW7RZieEjCTIX473EqS1W3xC
	r7wePSE88TJmX0odNhNlZ+ziBQJsJIFVJ8gYbzrPSe1clzt5t2XEa09rzdDNkSEn
	hyc17A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr83958m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:45:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so192940165ad.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784717106; x=1785321906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsqqjEAZXtutPj2bLmJfhUXNgNSspoGv2SMxeBHWhRw=;
        b=ND+uo4QwRwTDgZqq0c6Fw7bYMxcOd3VUkCNmT7k15J+lFX/jTe+I/jAi9NJqLbhQ/b
         l41O6IA5rtVzJlvg7RAHfbGY2tX6R4k5f3g/V2eQ6qAAwYFrL3NA3QfB/aZ9rWjWJcjP
         ZZSZjvudwbkJMm3b8yNHBVgukqNK20aLLmgDufMUpmSoZ1A+6jgFuwu6EQGJFL2alIdc
         7ri6buG8rHIOyZibp8+yLC5MkXhlsOp3YqFHVWzJLF5TFwFgnZqgEN+czVdzdxYlQ7OL
         Kdsm1Bf4nh9zqrNC/9Ghp4+dZqD5zMhEoZx7yBdQrPHzNeMMruWa3C29rCAgmv4iHR1L
         mtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717106; x=1785321906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsqqjEAZXtutPj2bLmJfhUXNgNSspoGv2SMxeBHWhRw=;
        b=rjM4mBnwf/i7cP70995Ivpdu5y2ynDo8tbW2bDookz4ycotyVgNbI/GbRA3CiuxPWX
         jWuklkZ1wQlYFJY3KC75IdLWv5fF9DkfmMjHxuHuo2RTAAtgYDfU887u/j56DmQYDU3K
         9QUCH/L4gVMYyXbVLabjiu4LLWeXGDgEKMsCv6aTs429RrElAHGM0KplNAzgvpvkm0s6
         JsYWASwwBzovamCHKbOvAUSqMA+DCDf9766+L1c/aNQ/2XoMuwZgH+TBSk8HL+SkMkLv
         JssWZ169CryrgaQ5y4Tyo2pG+j8Th78l54syQvpBa30Y9fFCiphKXCWOxek9mZNnTojG
         O7BQ==
X-Forwarded-Encrypted: i=1; AHgh+RoB9V5Wogdu6CSBcs9o0gEWAYbkvx55wS3nqGol8ySeSuVjZWD/lx9BMmWK1X/iQcUvNgIfn6EohA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ke4icQ9xJvrxtj9ckdzhdxUV+RIdmf+5j8Pk1M2m3vDD5BFk
	ACAO2f9Q6zlKY7LIqez1cIsb/cUtKIw7d6mSlXZjvsdFc7sFj95hQ6KUYYLPROc1OiPROR9RWj0
	cHO2na3vW+sgq5oXEeW0XiQTzo1A0yuE42stkDKDL0LZ7laurZOocpRdVWuTMAA==
X-Gm-Gg: AR+sD10DEDLjyBXiblp4TXj9LrJHcRMgS/+PE2/9WsU3jyePqzgJd+lbuSo5VJHzNlI
	HHLdx/+fg5LoV1Fj5XH6zAepPRGuuOoI2gj7W8SkmAX+8tLtg/ut4r3Yga77qGs28O2aDVkmZgo
	OETU/Z/XLxKVDfuZ2F021q0owq+kby2WYQ7ACzh5hReqnZXcKlqPcNHjUXuYbpE2adfeuS6jJaw
	4mGsDCAiFN+hJzdeWIjOG0AyAwcTWQJkgZEhcVh6RMYROa0Ah+PFmS+usXCMIV9JruE8BGrUPh8
	8KIPqlH4vbNQ5BHiSijS7yIzgECBvQQFDGqaeSnX79YGdUL5Xzu31fH/5JzXnwcHNElHNMl9nBV
	mmLoFemn3s1pGY1yadtdbUecYAHW2XsIl
X-Received: by 2002:a17:903:986:b0:2ca:cee0:e172 with SMTP id d9443c01a7336-2cf34a0a3ffmr229889265ad.30.1784717105674;
        Wed, 22 Jul 2026 03:45:05 -0700 (PDT)
X-Received: by 2002:a17:903:986:b0:2ca:cee0:e172 with SMTP id d9443c01a7336-2cf34a0a3ffmr229888665ad.30.1784717104962;
        Wed, 22 Jul 2026 03:45:04 -0700 (PDT)
Received: from hu-sachgupt-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e797asm12382455ad.39.2026.07.22.03.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:45:04 -0700 (PDT)
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:14:42 +0530
Subject: [PATCH v3 2/2] thermal: qcom: Add support for Qualcomm MBG thermal
 monitoring
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spmi-mbg-driver-v3-2-ef73064f2789@oss.qualcomm.com>
References: <20260722-spmi-mbg-driver-v3-0-ef73064f2789@oss.qualcomm.com>
In-Reply-To: <20260722-spmi-mbg-driver-v3-0-ef73064f2789@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, mfd@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Sachin Gupta <sachin.gupta@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: WnqFVlRN2gSa7O2Az5L625tYB6ocqEU7
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a609f32 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Ngz-wdeGRUxtqNebZn4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WnqFVlRN2gSa7O2Az5L625tYB6ocqEU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfX+rN/+rBJXV98
 sEEsnk4STYFDIWZ/Hw/cR/BaG+aAheK8lJvTRYO7HJUgZXp3bXND+O0+115NPjO51jR4Xzasfub
 8hkr1IKUOgGG7XNptUqqACvHrKD1ppm3ThQ0nqwuuNcpW7Rhidr9nL37GQxn7qrhBs00DYelSH+
 EHCX/XfPT2cW0E6k1sFPUVboSdTeAxM4iPJ81POjfral+KswNcd3ipFRCu+nC1aiBjyhGpJfv0X
 6GNZ3zz9kG42Brg3SkZZ/LFx1XYGVi4723Grj5fCp830tarMsUIGpdB12O59SlSq6ZCZEW3tOHM
 B3wShZFX0c7GEn1tpcRAB1BTEhbwbw0WlWEkK/LstjXMzZY2urhFDalAwpYlAvmKkn4nHcGhto2
 lpkiT/YZypf8wWhrtbQ6Ew8IB/Gl12ogGEoWLM4qR3kdxxp4lJuLu7QHVQYQfAOVZ7gxVxQr11k
 7qDBMhw9aP/QuWMTJZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfX7PZi1dT3j9SF
 zRAUYOOIV/TXHTV7+7AYBmpHnwf7uw42D2E6ks1P1GQ4ogTfc/aAeOKFdl/L079bpOpZ9HLbszK
 zgquLiKnd54qGIa5wfGdor05IXZbTjs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220103

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

Add a driver for the Qualcomm MBG (Master Bandgap) thermal monitoring
device. It monitors PMIC die temperature in hardware and raises an
interrupt when a programmed threshold is crossed.

MBG hardware supports two upper-threshold levels. Currently, only the
level-1 threshold is supported by the driver.

Temperature is read from the associated ADC channel, and when a level-1
upper-threshold violation occurs, the hardware generates an interrupt
over SPMI. The driver notifies the thermal framework accordingly.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
---
 drivers/thermal/qcom/Kconfig            |  14 ++
 drivers/thermal/qcom/Makefile           |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 256 ++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index a6bb01082ec6..ecfd1d166e53 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -21,6 +21,20 @@ config QCOM_SPMI_ADC_TM5
 	  Thermal client sets threshold temperature for both warm and cool and
 	  gets updated when a threshold is reached.
 
+config QCOM_SPMI_MBG_TM
+	tristate "Qualcomm SPMI PMIC MBG Temperature monitor"
+	depends on QCOM_SPMI_ADC5_GEN3
+	select REGMAP_SPMI
+	help
+	  This enables Qualcomm PMIC MBG (Master Bandgap) thermal monitor.
+
+	  The MBG block monitors PMIC die temperature in hardware and raises an
+	  interrupt when the programmed threshold is crossed.
+
+	  Temperature is read from the associated ADC channel, and threshold
+	  interrupts are forwarded to the thermal framework as trip-violation
+	  events. Current support handles a single LVL1 upper (hot) trip.
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

