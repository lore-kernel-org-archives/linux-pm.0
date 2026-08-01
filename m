Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6D3BBFBB
	for <linux-pm@vger.kernel.org>; Sat,  1 Aug 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570551; cv=none; b=PYrswz2z5Htls6pBfvDCUt4zZQ++vLNP3+niKqDJHQE+/LWOrX+qYR25HyX4l0zU8e7LTiMvC5FhqSITQjqEOfrzdJi+fX9AdwrGi9bH3jeFdTZw+C0fv7QQn3J5UF/kXqAUEN2B81YNFPJqRefuLlUCMYMAe4xb5xDKfaPxC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570551; c=relaxed/simple;
	bh=wckzg7u3tcRfa6jZax71MInhaQ/FdjfR66RHknyTaWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Aqnbf+mQTIH9Ho5cpSIeueLMGrV6cceG3AJpNS2UefaRZbt/nIKo2LnMIT+jOHkYKQrcJsHbtS6nrvD7lFcQGkSNluRCQZtaqydDevmQ+/k+++TRXBslNq9IsXZlo/dyCVVFzMm4jO9gai7HmyitaFcxUZVR8FeQ3XyhyReaSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HB9bGlik; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X5+iNvth; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HB9bGlik";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X5+iNvth"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713LwPl2060672
	for <linux-pm@vger.kernel.org>; Sat, 1 Aug 2026 07:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AR4d/t3FeZghBRdNEvysF+
	dmiVXYZTZuk9ukn2d2jJw=; b=HB9bGlikE+hKDtQkZY5255y2GDa7C57OI23AF4
	lWcQOMdaHc7rNnnZl+xq+oKdpZCnQP6yfGv+CeZuK0A+IKUugvQ1jd5G8bv5vSoA
	vDyDCsr5e5QI+dPalRdJcJfCvzSQI0Ww1/HZ++9KFzU/jeJdQRv6Pig5HX2ayM4S
	oLgn7YvVqnetcRw4bAZ1gJ07mMgH7bc97WBK+sm+uPICCjuf3TlizREGK9jvtzqh
	WKPRq5xhaRnLkjXPNdgQEpqA7ZUuHCJilv4wUiQBxaVRp0oCPgZQQc6kbi6LvuQQ
	AawQHhrNdSukOtFuC8XJk302stXqAPgQ1Mp4BpLN6YKiaGhw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx0g6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 01 Aug 2026 07:49:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so1994142a12.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Aug 2026 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785570547; x=1786175347; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AR4d/t3FeZghBRdNEvysF+dmiVXYZTZuk9ukn2d2jJw=;
        b=X5+iNvthr3btkhia5PRUogo/+KmzCs/TZoQI4uQA8mpUCzTm0ym2WdFMXVfU2DqWEb
         0BCDTdEYMhjjvEaI4lzN31Wd0RoRKJ4azwHST3y+XuuzDdOxzvdm4U1txjPtfehFO+Z8
         8vAXolyNS/LsaR3EQpkzUxiC5MFcwpc8wsBlMKlwJXr7r6/0arMex3LZrTlermmIDxnS
         q6nPTiw3fLFoQJS94Gt428iNffvVgozkJzTWLjPQPayV/56JJzGxrhCpQwXvTaRiLv8p
         zHpH3+vpZpovbA5oE25x7GoOWRhlod0RI9Y6arVlE68/8+FDdqenP5r5PEPwrAIR0RMV
         bD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570547; x=1786175347;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AR4d/t3FeZghBRdNEvysF+dmiVXYZTZuk9ukn2d2jJw=;
        b=Hpwkn4MDvoKAOe/1Bv1oE66cjLwf8/EdgvPxF7o8HkcmUGGRCcOZRF+4sbhv4FBswg
         eO49EoVgVPN+OZk4V6HnvnG0g10x4WoGixdTIIS7S7zD8tTXrVGN96HRH9I2zTl9NhtR
         H4yrOxgSRUwAlAlr+OkPObWje6GY03uzwDX0DsV0G791AB46EMpJ2b2oeViEUqpR4aVi
         YzlBSN2QHNubtOMW1na/nyxjGeFQzfeZdXhaB2A915l4MmUk3JDOk0Y+leUtgPmM8vuR
         IEqk0tBMFAUgYZg1gw2MDwDeYkiHgHSCJDx2vKPpeUzHxCQCqnfDj+mWWCTdC8RdyP59
         okCw==
X-Forwarded-Encrypted: i=1; AHgh+RqYar56cIe30AoPk0uIFJW0ji+3A6WgGGFtf7fjsFjT6QV8E+Yo8IHHILSB/WvKKHDSK7ptBxq9jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHL+Dk7kPpTsnkVQBMQTg92jgd39qt5y3iiTe2mx38Y5bpYlo3
	dcCqu1BKYVKwVBEJ2HAUrOxl1YzIFVfqNnw3cwfmLQfPB0ELWqPiofK7AOWox6sYbtV1xSCDgUi
	KSk4fvgsrQhGmF1xbsweY5mH9BhKwlAxGAM3ctpieMrp+QAzCNX5wpEkmW5N0hw==
X-Gm-Gg: AR+sD11TE0j833s5txszDVko+UnTTm1pR/POc+gQIDRRiLgkvbd101m9cBUzSITHHgR
	rCDzzG42CJrnojc5oGzJiNyR4w3gmkxQ3cIN/g7aVQwMLwP6TJFFErUOMTdbQ0TIT0o4qG1ub0w
	ymbmBmckEz41JGDxr3p7Lbc+/4z1lZSq4bZ8r8d7fz304gqA5ZqjvJITdTC/HSfbmUNgKQdwLwG
	ixDK47x0JPwi2EdCEzzJe1l+rVh2zLPL3yKRJ4V/gHQ0pQgqNx+g4b6hLXgEA6bIgB84EJWc3ck
	h9z86T0xxIU54ZdS8fFMeXhiZRWonORVix4qphXEcuDXBni+Vw7ghH4KpnKZ/HoxX7NNxx4B5GP
	lg6uxsbK1vjlvPfzSIXHnSDE8t+5OZA==
X-Received: by 2002:a05:6a21:7d01:b0:3c6:3c5b:fe66 with SMTP id adf61e73a8af0-3c92a89c78amr2513275637.41.1785570547097;
        Sat, 01 Aug 2026 00:49:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d01:b0:3c6:3c5b:fe66 with SMTP id adf61e73a8af0-3c92a89c78amr2513247637.41.1785570546546;
        Sat, 01 Aug 2026 00:49:06 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm9645923c88.15.2026.08.01.00.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:49:06 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 13:18:45 +0530
Subject: [PATCH] power: supply: qcom_battmgr: Add multi-port USB-C power
 supply support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-b4-battmgr-multiport-usb-v1-1-89d90bf5de1f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANykbWoC/yXMTQrCQAxA4auUrA1MSxlHryIumprWiP0hyYhQe
 ndHXX6L9zYwVmGDc7WB8ktMlrmgPlTQ37t5ZJRbMTShiSGFGqlF6tynUXHKT5d1UcdshG1kCsd
 TijENUPJVeZD3b325/m2ZHtz79wf7/gFTLsCpfAAAAA==
X-Change-ID: 20260801-b4-battmgr-multiport-usb-46eb0798668f
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785570543; l=16255;
 i=kamal.wadhwa@oss.qualcomm.com; s=20260406; h=from:subject:message-id;
 bh=wckzg7u3tcRfa6jZax71MInhaQ/FdjfR66RHknyTaWY=;
 b=LpBXz4x4Qa8BCLCHZnjP+HyhPBnPNoUfHEC98tKrz9Zx0pS9HQXIGYAvfmd4EbNJ8bG7Ax8KR
 D8z7+vhS+yhDhP8fWCBRS2NNX4yOjUK+5J9M5qQzE3dRmYDSgfggi05
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=ylH1NxUZkBpYsmww89g6zVxpS0q8qthtzcORkYxn/Ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA1NSBTYWx0ZWRfXzaHVsZ3E6SJO
 r49TENkKFwJLdCeugdOPnQvdwF2BUt8EPb4e4O2+FQzP7oZ0JUd1W9no94cAWZfAX3isvG0VIdr
 Mu0ozVGfOjG31lg9Y3t2z3sacmOuTwanNL2ZuZSO4cc/qeizofYnVtPCUuZNO+pFzFnaHRNBDbA
 IT7PJdRd1EvK5KmrWkshOQhtM9Tdcy0OT3AzYrp2R1d7e8pjyOyRwW1XBLgRf89O3GZCn4dSdfn
 X0NbnqPod5kBUjzlKsTBGlPEJQB9FsBEb+FNtFXeIgGWGyNBzrIH6C0uHdhc24nTJHqNajXbj6+
 mJBrVat4jw3yBHoG8iJPOzHLXXh24QQTa9f0a2rvw7+NIDBxpTiw1IK77Ond7dhSJR721M2WpWr
 CfXUy1eA+CxrpCztMl7PX+e5Q9jLW+0mvKTHZtPHaeGZpfQzJSZYdKnXQ5GpZvDkbhHApyC4ic9
 nYvO9A7If1c9SUi9qwg==
X-Proofpoint-GUID: UqjEhB00vpgdMTMVaO3OMBqOZRFP7tIq
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6da4f4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zFCAPC_QsuEp93vFkkwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA1NSBTYWx0ZWRfX3GveOqmiMU85
 zVWda3tGOM5udHEMlUVv/px5pInKW6Hp6EtehR77RPvUlvEeEQMN0sJMToFnU4Dx+NEgIAY5DSX
 ygZK7fv92qMrmp3N5QSlN7yL81xE+k0=
X-Proofpoint-ORIG-GUID: UqjEhB00vpgdMTMVaO3OMBqOZRFP7tIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010055

Extend the qcom_battmgr driver to report up to MAX_USB_PORTS (3)
USB-C power supply ports on the X1E80100 & Glymur platform, which
exposes more than one charger port to firmware.

At firmware-enable time, query USB_NUM_PORTS over the existing
BATTMGR_USB_PROPERTY_GET opcode to discover how many ports the
firmware actually reports, and register the additional
"qcom-battmgr-usb2"/"qcom-battmgr-usb3" power supplies only when the
firmware confirms a second/third port. Each additional port is polled
independently via new BATTMGR_USB2_PROPERTY_GET/SET (0xC0/0xC1) and
BATTMGR_USB3_PROPERTY_GET/SET (0xC2/0xC3) opcodes so its properties
are not aliased to the primary port's state.

Also add the POWER_SUPPLY_PROP_CAPACITY entry to x1e80100_bat_props[].

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 353 +++++++++++++++++++++++++++++++++++-
 1 file changed, 351 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d00..17675a9975d6 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -26,6 +26,8 @@ enum qcom_battmgr_variant {
 	QCOM_BATTMGR_X1E80100,
 };
 
+#define MAX_USB_PORTS                   3
+
 #define BATTMGR_BAT_STATUS		0x1
 
 #define BATTMGR_REQUEST_NOTIFICATION	0x4
@@ -76,6 +78,10 @@ enum qcom_battmgr_variant {
 
 #define BATTMGR_USB_PROPERTY_GET	0x32
 #define BATTMGR_USB_PROPERTY_SET	0x33
+#define BATTMGR_USB2_PROPERTY_GET	0xC0
+#define BATTMGR_USB2_PROPERTY_SET	0xC1
+#define BATTMGR_USB3_PROPERTY_GET	0xC2
+#define BATTMGR_USB3_PROPERTY_SET	0xC3
 #define USB_ONLINE			0
 #define USB_VOLT_NOW			1
 #define USB_VOLT_MAX			2
@@ -86,6 +92,13 @@ enum qcom_battmgr_variant {
 #define USB_ADAP_TYPE			7
 #define USB_MOISTURE_DET_EN		8
 #define USB_MOISTURE_DET_STS		9
+#define USB_CONNECTOR_TEMP		10
+#define USB_REAL_TYPE			11
+#define USB_TYPEC_COMPLIANT		12
+#define USB_SCOPE			13
+#define USB_CONNECTOR_TYPE		14
+#define USB_F_ACTIVE			15
+#define USB_NUM_PORTS			16
 
 #define BATTMGR_WLS_PROPERTY_GET	0x34
 #define BATTMGR_WLS_PROPERTY_SET	0x35
@@ -297,6 +310,7 @@ struct qcom_battmgr_usb {
 	unsigned int current_max;
 	unsigned int current_limit;
 	unsigned int usb_type;
+	unsigned int num_ports;
 };
 
 struct qcom_battmgr_wireless {
@@ -316,6 +330,8 @@ struct qcom_battmgr {
 	struct power_supply *ac_psy;
 	struct power_supply *bat_psy;
 	struct power_supply *usb_psy;
+	struct power_supply *usb2_psy;
+	struct power_supply *usb3_psy;
 	struct power_supply *wls_psy;
 
 	enum qcom_battmgr_unit unit;
@@ -329,8 +345,12 @@ struct qcom_battmgr {
 	struct qcom_battmgr_status status;
 	struct qcom_battmgr_ac ac;
 	struct qcom_battmgr_usb usb;
+	struct qcom_battmgr_usb usb2;
+	struct qcom_battmgr_usb usb3;
 	struct qcom_battmgr_wireless wireless;
 
+	struct power_supply_config usb_psy_cfg;
+
 	struct work_struct enable_work;
 
 	/*
@@ -829,6 +849,7 @@ static const enum power_supply_property x1e80100_bat_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -1042,8 +1063,136 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int qcom_battmgr_usb2_x1e80100_update(struct qcom_battmgr *battmgr,
+					     enum power_supply_property psp)
+{
+	unsigned int prop;
+	int ret;
+
+	if (psp >= ARRAY_SIZE(sm8350_usb_prop_map))
+		return -EINVAL;
+
+	prop = sm8350_usb_prop_map[psp];
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB2_PROPERTY_GET, prop, 0);
+	mutex_unlock(&battmgr->lock);
+
+	return ret;
+}
+
+static int qcom_battmgr_usb3_x1e80100_update(struct qcom_battmgr *battmgr,
+					     enum power_supply_property psp)
+{
+	unsigned int prop;
+	int ret;
+
+	if (psp >= ARRAY_SIZE(sm8350_usb_prop_map))
+		return -EINVAL;
+
+	prop = sm8350_usb_prop_map[psp];
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB3_PROPERTY_GET, prop, 0);
+	mutex_unlock(&battmgr->lock);
+
+	return ret;
+}
+
+static int qcom_battmgr_usb2_get_property(struct power_supply *psy,
+					  enum power_supply_property psp,
+					  union power_supply_propval *val)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (!battmgr->service_up)
+		return -EAGAIN;
+
+	ret = qcom_battmgr_usb2_x1e80100_update(battmgr, psp);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = battmgr->usb2.online;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = battmgr->usb2.voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = battmgr->usb2.voltage_max;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = battmgr->usb2.current_now;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = battmgr->usb2.current_max;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval = battmgr->usb2.current_limit;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = battmgr->usb2.usb_type;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qcom_battmgr_usb3_get_property(struct power_supply *psy,
+					  enum power_supply_property psp,
+					  union power_supply_propval *val)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (!battmgr->service_up)
+		return -EAGAIN;
+
+	ret = qcom_battmgr_usb3_x1e80100_update(battmgr, psp);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = battmgr->usb3.online;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = battmgr->usb3.voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = battmgr->usb3.voltage_max;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = battmgr->usb3.current_now;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = battmgr->usb3.current_max;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval = battmgr->usb3.current_limit;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = battmgr->usb3.usb_type;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const enum power_supply_property sc8280xp_usb_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
 static const struct power_supply_desc sc8280xp_usb_psy_desc = {
@@ -1064,6 +1213,42 @@ static const struct power_supply_desc sc8280xp_usb_psy_desc = {
 		     BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID),
 };
 
+static const struct power_supply_desc x1e80100_usb2_psy_desc = {
+	.name = "qcom-battmgr-usb2",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = sc8280xp_usb_props,
+	.num_properties = ARRAY_SIZE(sc8280xp_usb_props),
+	.get_property = qcom_battmgr_usb2_get_property,
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_C)       |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD)      |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_DRP)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_PPS)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID),
+};
+
+static const struct power_supply_desc x1e80100_usb3_psy_desc = {
+	.name = "qcom-battmgr-usb3",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = sc8280xp_usb_props,
+	.num_properties = ARRAY_SIZE(sc8280xp_usb_props),
+	.get_property = qcom_battmgr_usb3_get_property,
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA)     |
+		     BIT(POWER_SUPPLY_USB_TYPE_C)       |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD)      |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_DRP)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_PD_PPS)  |
+		     BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID),
+};
+
 static const enum power_supply_property sm8350_usb_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -1212,6 +1397,10 @@ static void qcom_battmgr_notification(struct qcom_battmgr *battmgr,
 		break;
 	case NOTIF_USB_PROPERTY:
 		power_supply_changed(battmgr->usb_psy);
+		if (battmgr->usb2_psy)
+			power_supply_changed(battmgr->usb2_psy);
+		if (battmgr->usb3_psy)
+			power_supply_changed(battmgr->usb3_psy);
 		break;
 	case NOTIF_WLS_PROPERTY:
 		power_supply_changed(battmgr->wls_psy);
@@ -1260,6 +1449,7 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 	unsigned int opcode = le32_to_cpu(resp->hdr.opcode);
 	unsigned int source;
 	unsigned int state;
+	unsigned int property;
 	size_t payload_len = len - sizeof(struct pmic_glink_hdr);
 
 	if (payload_len < sizeof(__le32)) {
@@ -1355,6 +1545,121 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 	case BATTMGR_CHG_CTRL_LIMIT_EN:
 		battmgr->error = 0;
 		break;
+	case BATTMGR_USB_PROPERTY_GET:
+		property = le32_to_cpu(resp->intval.property);
+		if (payload_len != sizeof(resp->intval)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for %#x request: %zd\n",
+				 property, payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		switch (property) {
+		case USB_ONLINE:
+			battmgr->usb.online = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_NOW:
+			battmgr->usb.voltage_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_MAX:
+			battmgr->usb.voltage_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_NOW:
+			battmgr->usb.current_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_MAX:
+			battmgr->usb.current_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_INPUT_CURR_LIMIT:
+			battmgr->usb.current_limit = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_TYPE:
+			battmgr->usb.usb_type = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_NUM_PORTS:
+			battmgr->usb.num_ports = le32_to_cpu(resp->intval.value);
+			break;
+		default:
+			dev_warn(battmgr->dev, "unknown property %#x\n", property);
+			break;
+		}
+		break;
+
+	case BATTMGR_USB2_PROPERTY_GET:
+		property = le32_to_cpu(resp->intval.property);
+		if (payload_len != sizeof(resp->intval)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for %#x request: %zd\n",
+				 property, payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		switch (property) {
+		case USB_ONLINE:
+			battmgr->usb2.online = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_NOW:
+			battmgr->usb2.voltage_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_MAX:
+			battmgr->usb2.voltage_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_NOW:
+			battmgr->usb2.current_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_MAX:
+			battmgr->usb2.current_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_INPUT_CURR_LIMIT:
+			battmgr->usb2.current_limit = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_TYPE:
+			battmgr->usb2.usb_type = le32_to_cpu(resp->intval.value);
+			break;
+		default:
+			dev_warn(battmgr->dev, "unknown property %#x\n", property);
+			break;
+		}
+		break;
+	case BATTMGR_USB3_PROPERTY_GET:
+		property = le32_to_cpu(resp->intval.property);
+		if (payload_len != sizeof(resp->intval)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for %#x request: %zd\n",
+				 property, payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		switch (property) {
+		case USB_ONLINE:
+			battmgr->usb3.online = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_NOW:
+			battmgr->usb3.voltage_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_MAX:
+			battmgr->usb3.voltage_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_NOW:
+			battmgr->usb3.current_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_MAX:
+			battmgr->usb3.current_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_INPUT_CURR_LIMIT:
+			battmgr->usb3.current_limit = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_TYPE:
+			battmgr->usb3.usb_type = le32_to_cpu(resp->intval.value);
+			break;
+		default:
+			dev_warn(battmgr->dev, "unknown property %#x\n", property);
+			break;
+		}
+		break;
 	default:
 		dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
 		break;
@@ -1583,6 +1888,8 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
 		qcom_battmgr_sm8350_callback(battmgr, data, len);
 }
 
+static char *qcom_battmgr_battery[] = { "battery" };
+
 static void qcom_battmgr_enable_worker(struct work_struct *work)
 {
 	struct qcom_battmgr *battmgr = container_of(work, struct qcom_battmgr, enable_work);
@@ -1591,11 +1898,53 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 		.hdr.type = cpu_to_le32(PMIC_GLINK_NOTIFY),
 		.hdr.opcode = cpu_to_le32(BATTMGR_REQUEST_NOTIFICATION),
 	};
+	struct power_supply *psy;
 	int ret;
+	int num_ports_fw = 0;
 
 	ret = qcom_battmgr_request(battmgr, &req, sizeof(req));
 	if (ret)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
+
+	if (battmgr->variant == QCOM_BATTMGR_X1E80100) {
+		mutex_lock(&battmgr->lock);
+		ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB_PROPERTY_GET,
+						     USB_NUM_PORTS, 0);
+		mutex_unlock(&battmgr->lock);
+		if (ret < 0) {
+			dev_dbg(battmgr->dev, "Failed to read USB_NUM_PORTS from SoCCP, rc=%d\n",
+				ret);
+		} else {
+			num_ports_fw = battmgr->usb.num_ports;
+			if (num_ports_fw > MAX_USB_PORTS) {
+				dev_err(battmgr->dev, "USB ports reported by SoCCP: %d exceeds max %d\n",
+					num_ports_fw, MAX_USB_PORTS);
+				num_ports_fw = MAX_USB_PORTS;
+			}
+		}
+
+		if (num_ports_fw >= 2 && !battmgr->usb2_psy) {
+			psy = devm_power_supply_register(battmgr->dev, &x1e80100_usb2_psy_desc,
+							  &battmgr->usb_psy_cfg);
+			if (IS_ERR(psy)) {
+				dev_err(battmgr->dev, "failed to register USB port-1 power supply: %ld\n",
+					PTR_ERR(psy));
+			} else {
+				battmgr->usb2_psy = psy;
+			}
+		}
+
+		if (num_ports_fw >= 3 && !battmgr->usb3_psy) {
+			psy = devm_power_supply_register(battmgr->dev, &x1e80100_usb3_psy_desc,
+							  &battmgr->usb_psy_cfg);
+			if (IS_ERR(psy)) {
+				dev_err(battmgr->dev, "failed to register USB port-2 power supply: %ld\n",
+					PTR_ERR(psy));
+			} else {
+				battmgr->usb3_psy = psy;
+			}
+		}
+	}
 }
 
 static void qcom_battmgr_pdr_notify(void *priv, int state)
@@ -1621,8 +1970,6 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{}
 };
 
-static char *qcom_battmgr_battery[] = { "battery" };
-
 static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
@@ -1648,6 +1995,8 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
 	psy_cfg_supply.num_supplicants = 1;
 
+	battmgr->usb_psy_cfg = psy_cfg_supply;
+
 	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
 	init_completion(&battmgr->ack);

---
base-commit: 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
change-id: 20260801-b4-battmgr-multiport-usb-46eb0798668f

Best regards,
--  
Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

