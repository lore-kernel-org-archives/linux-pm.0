Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B024391E4B
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879807; cv=none; b=VFPL9GYCynNvcqSh8pIf26y/RgzwiM92/iFOJvhk9wz6U7HyzOOKKoCzsN9T8sjKlB9xQ3Rz+t1/hTtU2TkvQB59MlnHQwpDuUmbDERWnfbp9ngrkie3gMiM7rOGm3SRVgwolHJiaqG4WZx2584p8cOYJu26LoSkEZzi4ij7mjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879807; c=relaxed/simple;
	bh=EuGFtQsC7a5bcq3fuxmHgftjiPsKkyQGyjD8DJn3ogk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC7qYFZdsyTVVOadq7+i3e5CTbb224PX3muqAn7p7wIi3cAQYbY5o/tmMZHf4kJhV2LT95vcGYB7dFpEFhPgsl7928Y+pNLTrLiQhhO6ZX/yhiEP6LCud1iL0ka/uP/HO/UDoNnfkYZnw6SptMEyBK/W9BUfi3d0mFpqemfL+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jaz9SfvA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YRrpfa36; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jaz9SfvA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YRrpfa36"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MFWphg664335
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eWAtqSg/Vbx
	/yWW93k81ni9/DB10T+Cnl86NnNmbO8A=; b=jaz9SfvAgFHjXAUMa5h2VP07eo/
	wjX+LnMa3pe+Zz2DoN+uZu3RjSdzZTlEsmwaCXqEKgeNtZ9fSRSrep864Bx794hY
	b06QkOWp+R+bMr4kEAQ8Kct9hnbcO98iKbFg6kP7a7dItct2dVJ1Rjg6slI3FkcB
	NlzNnTcPqCOGvHNt5X3Me2ZReiiZOcbtF+iESze994pTyMGmvGU+w2awORnnKLMJ
	1ZOIJI0H5EXlptrTFXSPoC9U/N5Zo72vAC/2IqSWeQgxyDL08csAetDDYs7rnLT7
	RAO3oIDQ/HQ8C/q57eTE9ljyq6sAaWakqlWbGIyQex1C0CW30JtEOp/g/Rg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgsvyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50faf575af4so68652201cf.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776879804; x=1777484604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWAtqSg/Vbx/yWW93k81ni9/DB10T+Cnl86NnNmbO8A=;
        b=YRrpfa36aqrnedjv9or6Cwm2oZu4DuaofWF1dF4W7QjNFjs2+iHJu4vXsk/1U5uemz
         ybred0p/Ib8DF0cx+omklQe13dDNv0hhRXJqrydtLPGP1gvGXKXpIbivUO3pYw5jUmu7
         1pQ+qR7+m+43itfEKYBej7Du3WJclF/livZdtxpNNDlv9dKQeST3P7STJ1f+yGiDYtdJ
         bo+RboUrMSFae04vpkS3iZyN0WIwaHdZQ5027gWkCTCxaawbJ4VNqZ1a03y/FsE0N4Je
         Re0ueOGtuBULFd++yu/GJBbI48XmalIMez8/l1Jx/s2t52oZn7s2G+XHacJ4s23JJUfK
         +/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879804; x=1777484604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWAtqSg/Vbx/yWW93k81ni9/DB10T+Cnl86NnNmbO8A=;
        b=HQsqPQI7XtskeeVA4xGLqv8+NjabD3EkPaszye6MOShFJ8k6Dccuk3Zr2tz9+M2Jfu
         oIcN4OAILJgNHOeH3PCIHe9w95jsB7vA7uecjNomJrDl0HJDhiAz2FCgcfHH1YslGd72
         rCluxurIXcovF5dWjbHkIrFyE/GCUCH8FtiSB41Xop0RQ1Z3Ae6Th/y/ybn50LyUDXtf
         uxic79r8pA+tIDkdpAvHAbD2EI4HzdwAMHE4PPEgvK5J+KwOCDTwS7atXBTCsIESozXS
         ew6kVRkygkyycYmUVUw54+hShAGJtNp3dd0EDyeoRNAV73CB+mlOLUabWC4aRU0Hdg73
         fWHw==
X-Forwarded-Encrypted: i=1; AFNElJ+XX2IZY7Znjz26dmlaNOmkhdykLEg9gNXIXqlq16/1u1ZrmFbYEowqC+kt5If9VN7vmYDjvDkGJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSLPdlH6/pwZJJspURmW8WojxTAk1MgEWAbQnou2ONK4NEIga
	u3YddAqk27aJKkCjnzaKp+Z0R+vcTUmdjvkw24wZ/lznVCG+6p+r5r2Cz+yyEDSoLqhbywxX+2j
	U0EpU53q6Toudsl9GeNbw/YVWRlV9UXFQtAyQsL9UCAO/XBP8tq3HLn+XMdSnWw==
X-Gm-Gg: AeBDiesSiYRoYWzAvH2px0Tgtl077HHgG5pvlrl2lhZo2cfP05aU93GRMxJs2LOlDAS
	kYEDIlskVec3YnFFvGP3BbOprpp7g0ggTH6DuI+yzD6cB1pTpnnr8jOA17LcjBeueuJW92bzz+O
	yTGyE/vCHqJI8hlFLgBsgEfKMR5GaTKaocuR5Jc/Hj562OTTkhXOAYzIX7P+KQW79cTz3MfYBd0
	YWQzNQWRdIbllvRiKTU/WfHStTbwoSYiLO5sdz2YBmZJVFtYmlINdkmdIuV83DDQpKUUODjqLol
	B8KGkTl4M+hRbA0WV4J2rNLPLtNxDCGUJqvt6JwF/2RvtWFxKACLhmtI97JVpZA1hvTBBmJvban
	/SYK+f+r77XKLe7SwwU40DX/TAX8JcReSyaLhbINjVDzpBuTyD65lnHt+HvTR
X-Received: by 2002:a05:622a:7103:b0:50e:5eba:caec with SMTP id d75a77b69052e-50e5ebad365mr136708421cf.54.1776879803793;
        Wed, 22 Apr 2026 10:43:23 -0700 (PDT)
X-Received: by 2002:a05:622a:7103:b0:50e:5eba:caec with SMTP id d75a77b69052e-50e5ebad365mr136707811cf.54.1776879803278;
        Wed, 22 Apr 2026 10:43:23 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:43:22 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
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
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 04/12] thermal/core: Remove node pointer parameter when registering a tz
Date: Wed, 22 Apr 2026 19:42:53 +0200
Message-ID: <20260422174305.2899095-5-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
References: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EvRccSFHtYqQUHHVKLuVCWjngqp6dzke
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e908bc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=1QA-LxGU_wHIdTGdApUA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: EvRccSFHtYqQUHHVKLuVCWjngqp6dzke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfX05U+UbB//H4c
 TOkCz+1HU6QJ2CCUDUPjF3Sp+QVYiv+GNHnhRk4k/TnddVFXfnoipFyBwyDztAbAck+PHAiNAZT
 1sUs8+yYq0gPj2bzp3YpYpe/VDzSNX1redRYraXrLJBpIsm07VL/ds0B9mlKjIgXooBoXtzeFy0
 L3q3KrSMbDA+kxrJmHbCjvXhbGlgUqJ1fJ3RlhtNdTPYzwkK2KwYuD11j6F8tny8qLaFXN+Jcsu
 o7xjfyFnd2qlya7pDk/kpHv1MwybIcVobU4+PdvaxjBuOrifVlv4dsSZOi5qePJNc2O+JBA1kNV
 fzkTr2NppO8F6K8kB+TvF1LHJYTfOcI2IsqKSZ2mhdON502Vf1v52NLyimUCKLHxqrUXtUYPI3l
 3Gvbh1kNqqySNoYzNpvTTrbouIub5Mf8DtGJqQ1/bGegkbW1y2X9fDOv8SDWrIBQzowVtdtQm/C
 g3nJwphMFKouNpVw2XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171

Now we have a OF version for all functions registering a thermal zone
or a cooling device. Let's remove the device_node pointer parameter in
the core function which is inconsistent with non-OF code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 52 ++++++++++++++++++++++++++++++----
 drivers/thermal/thermal_core.h |  3 +-
 drivers/thermal/thermal_of.c   |  2 +-
 include/linux/thermal.h        | 11 +++++++
 4 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 35cf170f3fa1..113719466dc2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1042,7 +1042,6 @@ void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev)
 
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
- * @np:		a pointer to a device tree node.
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:	standard thermal cooling devices callbacks.
@@ -1050,15 +1049,12 @@ void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev)
  * This interface function adds a new thermal cooling device (fan/processor/...)
  * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
  * to all the thermal zone devices registered at the same time.
- * It also gives the opportunity to link the cooling device to a device tree
- * node, so that it can be bound to a thermal zone created out of device tree.
  *
  * Return: a pointer to the created struct thermal_cooling_device or an
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-__thermal_cooling_device_register(struct device_node *np,
-				  const char *type, void *devdata,
+__thermal_cooling_device_register(const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
@@ -1159,7 +1155,7 @@ thermal_cooling_device_register(const char *type, void *devdata,
 {
 	struct thermal_cooling_device *cdev;
 
-	cdev = __thermal_cooling_device_register(NULL, type, devdata, ops);
+	cdev = __thermal_cooling_device_register(type, devdata, ops);
 	if (!IS_ERR(cdev))
 		thermal_cooling_device_init_complete(cdev);
 
@@ -1167,6 +1163,50 @@ thermal_cooling_device_register(const char *type, void *devdata,
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
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 6e44bcf37b00..d45455bb9e9e 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -272,8 +272,7 @@ void thermal_governor_update_tz(struct thermal_zone_device *tz,
 void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev);
 
 struct thermal_cooling_device *
-__thermal_cooling_device_register(struct device_node *np,
-				  const char *type, void *devdata,
+__thermal_cooling_device_register(const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops);
 
 /* Helpers */
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index c4b67554df44..3ba8c970f11f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -533,7 +533,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 
-	cdev = __thermal_cooling_device_register(np, type, devdata, ops);
+	cdev = __thermal_cooling_device_register(type, devdata, ops);
 	if (IS_ERR(cdev))
 		return cdev;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d9ad860cee87..ba2c8b4dda87 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -278,6 +278,11 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
+
+struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type,
+				     void *devdata, const struct thermal_cooling_device_ops *ops);
+
 void thermal_cooling_device_update(struct thermal_cooling_device *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
@@ -322,7 +327,13 @@ static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
+
 static inline struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type,
+				     void *devdata, const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
 
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
-- 
2.43.0

