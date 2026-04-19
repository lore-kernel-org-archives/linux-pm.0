Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B3142E83
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622966; cv=none; b=AAb0y69QXH+56Zx38RdxdwW8QtrfV4Id1q51VClkQHr5aSzV2gwH852WqdaJtdbmvQMzRDrOMwSbATSlsFhsKEseJTaJh3FjRONVgrUNRlSlhpchPR9IHDTUHR1ZiTEnyTkoqiPE/k5YH+bMeLIchZPj/wjN669UvP7Fxl5um58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622966; c=relaxed/simple;
	bh=QFEKU97eqvDA0QMBKvkfQSYoQ7Mbh0z7Y4dUY+CpPEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yb5R1zG+lI4NertpW0U0KM/gyaMbaGHCr9cfjozc2yuFxadu56iVQsYbHLD54ftXZg3SXnBn1ufiprEz9QrKsRV8kY8cDZyRCYnfv/1LWh3s1U86/w0xbAVrnYHcxaYqCBi2SwSLbi+irmHVf2iSBI/1fQlsyLxjE260VaKRhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HY++AqGA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PcBZ2F8J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HY++AqGA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PcBZ2F8J"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J4f3La4182469
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8SJc8Ox6w4Z
	ygU6cO3C5yCKbel/yP+52HnTiIJQrGqw=; b=HY++AqGAu74IXd8c8x1L+F7ZUqR
	lSjqC6zchyrO75jh2vj5B0BDFA3hUtW8HeUBr5WYz304QyHcwWy4d0e2C0QbXWsb
	hZc5qNoJTXpvgjvrAIA7XBiPlpKm2ZSNREJ6jefmfD2CnIXm9ZKjHhAUB7ko2Pzo
	fJxACJn3JlGs7md2/McoajKWFq6r3HZTS9jB+HvCcOwt8sr0SdTspnSXEncnuG2C
	HfjgWZltexqh5UreiST4+FSyDloBAtZhTZPCQljgBX6o5r05dGjC4Nxp1whnFs8s
	z/gLn8qA/tzx/dyAz4uRiiu31feEDXP3uZGUTukZs2Wi7/CVsS4NS9btXGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm19fu30r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e423a05c8so32063161cf.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622963; x=1777227763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SJc8Ox6w4ZygU6cO3C5yCKbel/yP+52HnTiIJQrGqw=;
        b=PcBZ2F8JSu++3vfOirU6VjiJJtwQVI+vnh6da3EA+/q+ZpSdAHHZB9PlxQTGJ4uvmD
         wR1S7bf4Z1+Ldet3DS9F9RNwwSXS8eDj2djKIVXSh209u1LXgCAccmPnw+WFX3WqnS8j
         EzzWEBy4XW9iSwwQ6ocdC6QkwUT9R8Sc3eMyD/fgOTFcVmTTGnXDELNADBckz0a88yWH
         fh/nLqFsnCoDAfGztIZ0Jdl1ebPyXtGMPokvH+Wqwy+fhlZsDy4wiQ+ykfgUXCOp0sSJ
         B71tK673lPfkjXFyptEZtVadRtXxMgJmK4pp1risJ8Iig3sX41SYP7vBCx1zN12SEZQI
         5KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622963; x=1777227763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SJc8Ox6w4ZygU6cO3C5yCKbel/yP+52HnTiIJQrGqw=;
        b=eqqxiEXvwFAqOztWsUAIQ3g5NEQxUETlm2owgAziKPZHFHTPlWU/WoQbVkQJDiqonl
         ZJnPAykjSpOKXq8RElCkt0Lan1vDlzjq/xKvjCILDeA6CwMiwhh4JswLOO3ZOTg3pgmj
         s3GKv7pZn/ApbXceMkqj6MjFZfrbIBMaLUl8hfZbAar4ebco9T1NPD3ohJsPSqEzY8CQ
         YXVZcqc/Cp8Ck0qZu4PZklSXwdjt/Z1Q9v5s9bqnJHWSsrkyi1LAB8R2kwPa+dmOb3aL
         QnpL27XRWgz3ACY8VCzFhSy5JBcXa+7F0kMluUJRDQpzbAxtep/uaf8H6AgJTZsMmZZq
         tjJg==
X-Forwarded-Encrypted: i=1; AFNElJ9JivT+WY/82fpR3tBFpi2SzB6UIojXNwE0WIeVX1AEdR9/D3nV6NK4yL10x7r0ra7WJRyeXSlM+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFz79EZtMBs+PFX0hEz7tH+yqdO9VBt1roy0bol+ao2Ax6qHPL
	+2fXyLrYUzyZ1iMghRds77y/IBlxapWDKTmcl5KHyfdV7eJ9/V1RVMrpDdCC4O0ZU4d2p45t/OB
	/z17/9xM8QcIRGFa1fNNrJK+18kuk/I2dhYB8Gkb5oe8mhExzprEyq/zYyRBK9A==
X-Gm-Gg: AeBDiesv52NKXs/SJNwas1mfhsheG4HWwwObOF2btY3wRTe9ZZP1R1nSNSiBsIqNacz
	j24U6nIt7ydNv5QcpZ3rVipNAPbpNTuyoCwwi4HJLQmKEVesUuMOVetENzWucXCTA1d17i9aRth
	RycO/GJlZbHgddVqU9MqYLLoiwwwfX1YOve/FHGKnQKWGxZ9kbl4h6iK+yOx591Nu9aWd71c4Yu
	pOzvpf/D+Hz0KdPEulnVymg1owa0Xf1QdBHUQueGk7bkXImIsYAQrJxjKWjMygHJbwBehJqDue6
	6Vd9WX/94ipS6yPY1jgKcfDcruukRySnmFZi/bKrWxLmRXtDWI66Bvn1FeepCmS+a+mqTzrneEC
	aDSwlxzlx6hXgCECBSS7uiG98bJZXQCiar4gUuOe+2NSU7QOAabE3w5DcGfYA
X-Received: by 2002:ac8:7fcf:0:b0:50e:32cd:52fa with SMTP id d75a77b69052e-50e3661d434mr140438421cf.3.1776622962796;
        Sun, 19 Apr 2026 11:22:42 -0700 (PDT)
X-Received: by 2002:ac8:7fcf:0:b0:50e:32cd:52fa with SMTP id d75a77b69052e-50e3661d434mr140438211cf.3.1776622962349;
        Sun, 19 Apr 2026 11:22:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:41 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v1 06/14] thermal/core: Register cooling device non-OF drivers
Date: Sun, 19 Apr 2026 20:21:50 +0200
Message-ID: <20260419182203.4083985-7-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX16iCN/jpvwYi
 GyXRg2dS1WED4FuhR7ZcpZtxWKA+1xOQnPKUI1k/KpyBfXzE/ox9bwyAEhh3sGIivIo6bwPhBgU
 1OA6bq+pomISyp4J6fqGaxtj421j4j73nI99Z+dik7ZDBDzVpLEdDvlACwKzbjbmGWY02izHSqV
 /rEG/fVUQ3EbXF2K215NkbLYVa5nzUP0OXnmOeJrDht/SY2wDLw2mdzklT6uSIWcRaH5/uYaPpW
 fs18j4jqrXN1tZUeamDg2moYxvs+NhHg+of8ocdlOZbSDnvB6hWOtnRKRsmmmUU2IIjWjSiSwiM
 DZt1C77JWAmIIHNAdAJ0R09NkMNtDVdtgghdyp7w6yRhiLrBUwrWIIY8JeLK8i2I02ytTFbg5uV
 wHfO9viHpQonDuyw2q/wyyi3LUbZE0bcfr7EP6O+SAgRltY4SRxcCoEMmpq1AjmHtHarL4lPHdO
 csHWx5Td5mbB1kMy35g==
X-Proofpoint-ORIG-GUID: BKMvUm0n4FzaexARryjvWa0KJNMkLC_c
X-Proofpoint-GUID: BKMvUm0n4FzaexARryjvWa0KJNMkLC_c
X-Authority-Analysis: v=2.4 cv=FMorAeos c=1 sm=1 tr=0 ts=69e51d73 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=axTsjYC8yfnw0r5e9iIA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190197

Provide a non-OF functions to register a cooling device in order to
have a clear separation between OF and non-OF code. Drivers not using
a devicetree can then migrate to this function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 44 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        | 13 ++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f5d214d51a1..356a49e541fd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1164,6 +1164,50 @@ thermal_cooling_device_register(const char *type, void *devdata,
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
+static void thermal_cooling_device_release(struct device *dev, void *res)
+{
+	thermal_cooling_device_unregister(*(struct thermal_cooling_device **)res);
+}
+
+/**
+ * devm_thermal_cooling_device_register() - register a thermal cooling device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
+ *
+ * This function will register a cooling device with device tree node reference.
+ * This interface function adds a new thermal cooling device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type,
+				     void *devdata, const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device **ptr, *tcd;
+
+	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tcd = thermal_cooling_device_register(type, devdata, ops);
+	if (IS_ERR(tcd)) {
+		devres_free(ptr);
+		return tcd;
+	}
+
+	*ptr = tcd;
+	devres_add(dev, ptr);
+
+	return tcd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_cooling_device_register);
+
 static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
 {
 	struct thermal_cooling_device *pos = NULL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0ddc77aeeca2..d9332b037188 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -260,6 +260,11 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
 				const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops);
+
+struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type,
+				     void *devdata, const struct thermal_cooling_device_ops *ops);
+
 void thermal_cooling_device_update(struct thermal_cooling_device *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
@@ -317,6 +322,14 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
+
+struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type,
+				     void *devdata, const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
 { }
-- 
2.43.0

