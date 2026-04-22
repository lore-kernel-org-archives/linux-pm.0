Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7423909B9
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879802; cv=none; b=qV2qPRrvRFgoOsU6K5SjJ3NNwkJeNkFlA3VkSkPH8AyUP9YGBF5EorX62GlCTU+fch8raTywT/sQgMjJv/WIYwChj2KnPDYxf+6mrr+6YnGReWnpTg9xIIC2cJI98998TxC+sQlEhjbo1szzHc0OtJJTltoETe3U/X7l9fXuVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879802; c=relaxed/simple;
	bh=8CJ7eadvGl7GqKniVLLqEwYFaXzs263oYCNun34bBFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXMMH71F02fBchlC/b72AqcfV62HhGVjmPuS+oEV6/Gcu0YxQdUN+mMFFADcZ0hS2o7nTgfhNsmDyswnf5O0QgrcIChvJuwzLQJ1zjlRlgEm9HLrse5i75n6LbmkdxNivYe5RSVFMo36nZzQrB6Kch/nC2AA55IwaoS2V41neWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHExX8TY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fr9SS3qC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHExX8TY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fr9SS3qC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG3gH61230220
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pzqN02xmUOc
	iJ0Ac5IjOLUP8JJ7SGTjboIPlBRiCRas=; b=bHExX8TY9KGvxpewtk35G4YGTru
	Bq6uReObllkg5SsUPG+ejYdnC3LE5wvfGRO/G9FrrAS/vBhOGDBEQ2DWjgqHcl+M
	YqJw1DpakmPJBZzgCgBY3iTsaNrzrrjzuBDTIHR+9PZYMo/Vj7f1Oms98jCQY/nK
	8YnW+FxKd9nAifxVVsqhMggWanDAybN+1VrORNLEw5J6XjLSxar7QbyQzOK6wu2o
	ZIMVSVzFZYEP3egzthJqDcBfRr90AuSTIYa8xU8Km8v4dUJ8lYsamFhBKwwx+SNX
	DDJ3dzKQxwrcBPDw7v4uIRbu/jKxC3zPoPm5bQGLWe2xoyqwAdJy/T2eDpw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h68brm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b220c72bbso143468411cf.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776879799; x=1777484599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzqN02xmUOciJ0Ac5IjOLUP8JJ7SGTjboIPlBRiCRas=;
        b=Fr9SS3qCEmeu7HV2xgZio0/obt6/5l6Iru9d8aRGyG7XXO4Yd1uguDC89thhnHfkwe
         JZ1IXDCVe4wdNbDQ6GotdfE3G7/1GCbTcaakllXhU7FWZOBPymAOQgZd/nh5Do8tTNzZ
         IxixZOl2f+IM5NQqgDYPfyXijyHfUMehRJfVMV9jcd/IcfYLlLiPdQShdH2tIaXDAXCn
         J59EwT9bGoIsOZxlo54a05i2k2B6vW1vE8XUnzvk1bbhK1rxYdlL6eQHIjGdWmumFLk1
         Nw2CUCJy5bCh7K0Y9Ji2iBxq2M3Mabp5IABmIhZa4pMG5COXQSgnoKASljJVx+V7v+RY
         rWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879799; x=1777484599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzqN02xmUOciJ0Ac5IjOLUP8JJ7SGTjboIPlBRiCRas=;
        b=jsauxXa2VzrjDRHPCpfoWunVXDB5fZNDzfDdtvnd3i1Ii/+8BIUSw3rSYAc7Jtgqr7
         54e0Tz2BnsJasVUjg4ukBOo4WSVV84JbNVv2Rg4xRzMZjGD7E0h2CEg5fCWxVBkgofA2
         xoqc1z4Ni2D3cWiEfTehA/Ld0e6cUhgElhE0ugfLqdoYJmnUZyY2s+UIogxHnq7q8MUf
         zv7C/baLOpS8UX6RLKneWDR3sMONtS44GqtGlz59wxoE/RALAe/0aQIDJyx5atSE5uQi
         9bM1vKQagsZqq51kfqhcwA8Nacpv1vo/3IM3NMpzN2uIvPRJA5lfM8ytXWclmvGp3KRs
         gHog==
X-Forwarded-Encrypted: i=1; AFNElJ+VLMVKXOLURerT01Cupn2M6CkORsxMeizAT29zHHP2gsfQZ2n8KTD9fxDKfvSarqEJ36hSXf7pmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqDb2FQtc8TdhFQ0p2cKxTkYxMKjs4cw5aB1+DBDGSbnZ/VA7
	+kjQNGFVaiX3qf3txCXp10y4vZcqrIt3fXKhgqvt0ud1hBub5YA1z1OKhrSeAJ7e8I+ta0xiGLz
	U5fDpxkDKaadW+md7xL0727riuFLhPbxeujXPz9QDUsDPMe3zxdbL74qGfDziCg==
X-Gm-Gg: AeBDievFN0yLt1eIZD/E87E5lgnp39ZbLMI7SXgRQ74Jw8fyMpy0BRukrPG6KjGRorK
	QgtUGR1AcFUmgdSEKdF/Iff6mpLaxA9J8S5YZrmLN4DSkM/G79ypL7kHad46uV7v9iAJY96Ed/B
	2e8fQxB7qAh5cU0ec2GAaPDD6DXw9t6HGufL3IXoLpDxxvMyW9WDqzlCZmz4CN/D3EBV5yO5HiR
	GL+SdGW2TEI0qU3R7enUGN+hdYQ9ecZD2C//OFM+spEV2XzDiLf6Wi7ZSAahnAYZxnrRXzFiv1i
	sA/sbvJukFWptqcDNn0ms9TuvyPAv630k/WVa0Ft31fSqT8lPS2JM6XrImOb3AhRrLbEZbQGg4n
	G+xgCjBdS60C9gX/hnD8MguYPkJ2fSrBmrsezeCjWTyxj4jI0xqNcltypmo+5
X-Received: by 2002:ac8:7fd2:0:b0:509:1ffc:c538 with SMTP id d75a77b69052e-50e36b3f557mr342328391cf.19.1776879799278;
        Wed, 22 Apr 2026 10:43:19 -0700 (PDT)
X-Received: by 2002:ac8:7fd2:0:b0:509:1ffc:c538 with SMTP id d75a77b69052e-50e36b3f557mr342327611cf.19.1776879798680;
        Wed, 22 Apr 2026 10:43:18 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:43:17 -0700 (PDT)
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
Subject: [PATCH v2 02/12] thermal/of: Move OF code where it belongs to
Date: Wed, 22 Apr 2026 19:42:51 +0200
Message-ID: <20260422174305.2899095-3-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69e908b8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=gsbXGzNoRcIiw2hTtpUA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfX6FQXhCyka7Fr
 G6QFvn63UD0mjkSstiV9GBFTmYoeJ+dQ01jK4nwleGev2cDoIyJ1Z0EeLij8Adu8xGEUlYy+xTb
 lujMFx8iDwPKPgQIehHwABdQ5w+DfMQpTEZcA1wrF+vWP9p8YARXxSovHxWigtpKAoSCWeHsyFX
 IOrs2TyBUX7sDe+eNCV8tiYdb9AF2u+wFW991hRdt6GZT/BdVAAQRhxZ798YiBn8etJ/lJ3pQzz
 raSOsPG9w6FGNiyPwYI5o3QVLCuk5kRdBOazYc6NyHfSu17C0cRoWX3E5EHfuMz1dOTuH5X0vCw
 hgeOs0uLHdYAqeN08cxXjQnuN0sBUjyXscsXhPppSrWWBYpEb7RtD0KaDL67t9FyzCYYgeClY5H
 RF3nxeZTeTeuhbt1e8VcTFBWNod+BsbeGsIEoMuDFkNZz7N85LxgZVxhjGwzXplPhTWFeZD2Sjx
 z1fRx/0Kfn2+bXJjliA==
X-Proofpoint-GUID: gLlcguCBkbgqHwKN66kN4-Fc5OWUBpRE
X-Proofpoint-ORIG-GUID: gLlcguCBkbgqHwKN66kN4-Fc5OWUBpRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171

The functions:
 - thermal_of_cooling_device_register()
 - devm_thermal_of_cooling_device_register()

 are related to thermal-of but they are implemented in
 thermal-core. Move these functions to the right file.

As the thermal-of file depends on CONFIG_THERMAL_OF=y, by moving these
two functions in it, when non-OF drivers are using this API that
results in a link issue. In order to prevent unnecessary
circumvolutions with the changes, the stubs have been added in the
header file resulting in having the non-OF drivers compiled without
the CONFIG_THERMAL_OF=y using these stubs and failing to register
their cooling devices.

This is temporary as the next changes introduces the functions for
non-OF drivers and returning to the initial state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 75 +---------------------------------
 drivers/thermal/thermal_core.h |  5 +++
 drivers/thermal/thermal_of.c   | 72 ++++++++++++++++++++++++++++++++
 include/linux/thermal.h        | 47 ++++++++++++---------
 4 files changed, 105 insertions(+), 94 deletions(-)

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
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0ddc77aeeca2..d9ad860cee87 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -198,6 +198,15 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops);
+
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops);
 #else
 
 static inline
@@ -211,6 +220,23 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
 }
+
+static inline struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 int for_each_thermal_trip(struct thermal_zone_device *tz,
@@ -252,14 +278,6 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
-				   const struct thermal_cooling_device_ops *);
-struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops);
 void thermal_cooling_device_update(struct thermal_cooling_device *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
@@ -305,18 +323,7 @@ thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-	const char *type, void *devdata,
-	const struct thermal_cooling_device_ops *ops)
-{ return ERR_PTR(-ENODEV); }
-static inline struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops)
-{
-	return ERR_PTR(-ENODEV);
-}
+
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
 { }
-- 
2.43.0

