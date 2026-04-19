Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579AD2D8370
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622955; cv=none; b=rPRw65HxrWqBZ58GWzjKqS8IFC+zP1c7BcCQEOW5uuot8zxCUZBASE32JaPQHWLEOtlMB4377/rk4vMFo2J6AQBJdTolOV2/+wm3md+bzbXlBWx6FZ3wz3v1EgJiZPCPKJr9XykfFs6Bh16qwQvM5uff1Dfua7U8QK7wLbFsy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622955; c=relaxed/simple;
	bh=Y5QeZARN7N3l8TrjUL9gkwuxX1udIH2jTgvXmLkTbGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCfX3tvZ73oHHoIomVTnSioW3/A3IG1GVlKybLEagLoShnO9l7ojhqb27qv4JYRPvkWyRbEoMP8Xg8jx1hXRgC9+gUJg3mqs/TD+bqElQP6J1LepiLrebBbQJXfYHY4Fh8J6SDLyTrq4LEw3i2cD1bV5KXI1aHHf1ageAVSKvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fR/kbv6y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NSayfFFj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fR/kbv6y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSayfFFj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63INSXvd3703648
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Id99JuSnTtg
	UpQfz1lcAgo+qRwxEaTN/a4aEv+mMZ7g=; b=fR/kbv6yuw2Javw4aiZzls9kvWP
	hXh6FMerTskNuujJ63dhQ5iFe5WuXxavHWJ2M289iDfcxA49kMs/oBu+fBk7qCHK
	8VoDOC4w7JlGlDrV0rNUxsbBAWPzdylTabsD+63TaBGM8enIJp+DRmIlpymWVr/A
	PZaJ0hjZ3ljXtixb3hj3Ot6e58BIOMcUYG0bhFbK14LqgrV4ycrcByrN3pDhEgdR
	QFvBGev9r3DkyyoYp5wucigwl5JRjsIGgNhM4I8SfsUOulx9y+3NQm+/Rlgi00vX
	NM9HGZo9OIaOav6hQ9RZdjqN4/63eXyyZOqhrscjhZ2TeivoyV+s9xU6IcA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ujyq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d5d1c2289so51226801cf.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622953; x=1777227753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id99JuSnTtgUpQfz1lcAgo+qRwxEaTN/a4aEv+mMZ7g=;
        b=NSayfFFju3bGyNoA60kWMNUMAfgGG7Yvq/7e9/OZvPtcMSLWdhzUt0lHLNaTbjebWG
         vJRqrgjf77Sg7iRsmogm2zaQZc4PBsPw+yB7/pYjdgM2O7sOmf6+IC00r+ErrMEQsMSG
         NCa9aLVaMm9ylShx9JhuYM9SvxrL3iKFDhRaoxfi3y6d+3uXeEcTnDxzk86cdJ/jJDVg
         ZBy5SF93YGEaVNJYz4VzxrRwqGBjmhGXlg0E3nPUst26otlZnstrgI13jVhOBN8uvCJN
         cqCNwqfuICttJJuw68Mk3Tbj+EKz67JYlo9raJloIpzDXOwz27N4TDmvOSi1WEDWwQxf
         gMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622953; x=1777227753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Id99JuSnTtgUpQfz1lcAgo+qRwxEaTN/a4aEv+mMZ7g=;
        b=GEbJ6MGgHa4GaOmp8loWQqItNp9ozpBD8sOrHpzXmzVnLgwcdfsTJQgbuWVED8Cvy8
         9CxoG6n/Bcs8+6KaSeA2n5pUJbmmF8BpLDQk/JUBow6aBg0ug5kNraSQL3PziJo9/GdA
         7WgGaPulkODexd5QxS0fyyxylyQ+F0rvnm7qiWu2hmVbxJ3InA62Bg6SeP2XC3781PYN
         lfO4RjKtxUTfYMjqEuY7AYfFu3uwg8s+1qNiVw8CI+mOYJq6K8iw4kVue8y/OVOx5hBL
         D9Q1X0Tzs7FxEqimZhuHbHyHHoP5ac6nPJxpdD4EVx5FRYm5lVJj5GtlSjWy5I/b/Q/i
         Cs9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9l+MpoiX7Sbbf2ltGdR35p+ayQN745VmCZsDOyrMz4m2LxE+MXYf2Z0f2+IIKOMLUmyCfJn6+BVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3SW4mo9AhUcv4LJtvg8RUgSHfbMkkVHRW9J7MIsFLrvAVj2X
	KRNiWqleT7hr0zaIeBqvptQ69mQlqficZakMms0WpCKoT+Tg9oVrC0fEkW2LGw6uhgkh4MQNJ5S
	31sowrvPev1HncFZEs5piU27IGhuzKgj9KzW8IKaKiVFPBQYnboYJL5Nr8zIUng==
X-Gm-Gg: AeBDievEbAU9/k4bgOxMm8ojw6AAG+66Ga5bQ86jNKA6aLZByaoqAj0vm7bzSTCf6mN
	FT8sEmOAkG9qelCOKZI97ztFw+qutA0JAY7QvXVa+oiY6w/DscEBdMahtZErgmZVyG1ANRJwqe+
	MDLXPH+NNu9jQ+qVRd4MG5Qg1OQSzHSZpA/WBSDBI1LIaozaUu4AUI20Vj6h+ZzhrcYle8vHtED
	vjife4o4+9xKD4D/nE8R88zKVI2Xg54biEa10qDVmY8ByeORjmnNvk7/tQe+tHo724Zgcit909I
	0JWvkiWPAQay5Jt3lq5rqWXzxm6QMIwBiijlJr5ehi7JbOsft6u02qeXahTZiY90J2uUGjbcH2y
	QsG6O84LtgxZzeJHiX4UeyoR8+Aq/1YXQCZchvzwrEFoIlW0PTV+uY7Xo3Gtu
X-Received: by 2002:a05:622a:5148:b0:50d:8bf2:45cd with SMTP id d75a77b69052e-50e36c124f4mr172055321cf.34.1776622952280;
        Sun, 19 Apr 2026 11:22:32 -0700 (PDT)
X-Received: by 2002:a05:622a:5148:b0:50d:8bf2:45cd with SMTP id d75a77b69052e-50e36c124f4mr172054861cf.34.1776622951738;
        Sun, 19 Apr 2026 11:22:31 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:30 -0700 (PDT)
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
Subject: [PATCH v1 01/14] thermal/of: Move OF code where it belongs to
Date: Sun, 19 Apr 2026 20:21:45 +0200
Message-ID: <20260419182203.4083985-2-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfXxyec4c3sOT3M
 55Vvep66iclUCLlDVoNovq7yf4UAA0/AYZRXyY0uC+rJfmatTlQpoIHBdeQkV8amDby6PtT4HLs
 o6hlZ8LTwJQRecy0ZZmboHYX8If2yhsMgZUWBpCnJYOGhqecmGrE8p6MSfZ/LZEAbPDTJadaHTI
 zD1Lb2maAvaEBeeb/QXlhlj3GtuPmCRA36Kd2MiOd3ACjXF/37nvwUvCEsilts6JOYb7+iLqo8B
 bT7uDCrz4PGkLYjLXyjgYkQ2O232Yu5EfNCS48X0Iy0hoNgxBSAYwybw8Lp4QMFz0u4dW5mXAJU
 SGUL2bCroDlnvrl34/G5K46MOvaj23MOOHiRo8WNAYfKrBT6NaSiPmr5gT7TIP1dDSxt0Awdfd4
 9YBnKaMWfQwo0wPWcfzQs9nJcvON9kK8tJ/hIZPpI7uK+61eddiJhvd60GkB3M6Opruq5rB3OSQ
 Y4LvxoqR35M461Ab3jw==
X-Proofpoint-GUID: 55lBzBbSKA1ySjf_SnnVX5PTdYvZUyOI
X-Proofpoint-ORIG-GUID: 55lBzBbSKA1ySjf_SnnVX5PTdYvZUyOI
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e51d69 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=9vQL-81oGOs3f0jwIh4A:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

The functions:
 - thermal_of_cooling_device_register()
 - devm_thermal_of_cooling_device_register()

 are related to thermal-of but they are implemented in
 thermal-core. Move these functions to the right file.

Pure move patch.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 75 +---------------------------------
 drivers/thermal/thermal_core.h |  5 +++
 drivers/thermal/thermal_of.c   | 72 ++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f4e2dc46b8f..8a70768b46dd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1056,7 +1056,7 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
  * Return: a pointer to the created struct thermal_cooling_device or an
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
-static struct thermal_cooling_device *
+struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
 				  const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
@@ -1163,79 +1163,6 @@ thermal_cooling_device_register(const char *type, void *devdata,
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
-/**
- * thermal_of_cooling_device_register() - register an OF thermal cooling device
- * @np:		a pointer to a device tree node.
- * @type:	the thermal cooling device type.
- * @devdata:	device private data.
- * @ops:		standard thermal cooling devices callbacks.
- *
- * This function will register a cooling device with device tree node reference.
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
- *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
- */
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-				   const char *type, void *devdata,
-				   const struct thermal_cooling_device_ops *ops)
-{
-	return __thermal_cooling_device_register(np, type, devdata, ops);
-}
-EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
-
-static void thermal_cooling_device_release(struct device *dev, void *res)
-{
-	thermal_cooling_device_unregister(
-				*(struct thermal_cooling_device **)res);
-}
-
-/**
- * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
- *					       device
- * @dev:	a valid struct device pointer of a sensor device.
- * @np:		a pointer to a device tree node.
- * @type:	the thermal cooling device type.
- * @devdata:	device private data.
- * @ops:	standard thermal cooling devices callbacks.
- *
- * This function will register a cooling device with device tree node reference.
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
- *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
- */
-struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops)
-{
-	struct thermal_cooling_device **ptr, *tcd;
-
-	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
-	if (IS_ERR(tcd)) {
-		devres_free(ptr);
-		return tcd;
-	}
-
-	*ptr = tcd;
-	devres_add(dev, ptr);
-
-	return tcd;
-}
-EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
-
 static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
 {
 	struct thermal_cooling_device *pos = NULL;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index d3acff602f9c..bdd59947b24f 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -269,6 +269,11 @@ void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz);
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
 
+struct thermal_cooling_device *
+__thermal_cooling_device_register(struct device_node *np,
+				  const char *type, void *devdata,
+				  const struct thermal_cooling_device_ops *ops);
+
 /* Helpers */
 #define for_each_trip_desc(__tz, __td)	\
 	for (__td = __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 99085c806a1f..398157e740fc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -510,3 +510,75 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
 			       devm_thermal_of_zone_match, tz));
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
+
+/**
+ * thermal_of_cooling_device_register() - register an OF thermal cooling device
+ * @np:		a pointer to a device tree node.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:		standard thermal cooling devices callbacks.
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
+thermal_of_cooling_device_register(struct device_node *np,
+				   const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
+{
+	return __thermal_cooling_device_register(np, type, devdata, ops);
+}
+EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
+
+static void thermal_cooling_device_release(struct device *dev, void *res)
+{
+	thermal_cooling_device_unregister(*(struct thermal_cooling_device **)res);
+}
+
+/**
+ * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
+ *					       device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @np:		a pointer to a device tree node.
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
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device **ptr, *tcd;
+
+	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
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
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
-- 
2.43.0

