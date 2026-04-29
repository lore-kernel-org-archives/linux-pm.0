Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2234014A7
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479297; cv=none; b=CHPfTa2eyasSWa1BTqs8NbH1vLI1maYHmHylJ38w2sHMEMpgwG5wpzJoIy9x25iShCgVR2sY8Ep22sIqOry2Y+3aQQP9BtPOJGkF85K5z7JalHuYP8Rruv9i+bi2ohxM4iW9UisJpF8tSG/0YXTtRWAvRJNxMc5ftFDWukhhSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479297; c=relaxed/simple;
	bh=Ex6Mp6yHP3NfKWI4Djrm33G8n0aBYcaYmApLwhOBJeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up7NPRhX9elb+XqBVDsEHnRoV8FvE+eOCFbun21QmAa71O2xQHs6rTP7ck2d/JLDf38W+SH8Lw9dRVt1wZIs9bTASGDlI/lFKXN2ohRlBVNmBFVhIMd3d1UqEAdWVRFKPIEGIadDS2nWqI9IPNmTTgHX8CKiytpzkDcj/SrL+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iCEQz41S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bUOEx5RJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iCEQz41S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bUOEx5RJ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF4auw3066948
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=E3jiCPQeEhU
	GxNHVRP3aV2Dn9BaGTadLWJf5AW9mXkk=; b=iCEQz41SuHPbf+wrx8gm8zZ3rsM
	RjH2VXgjy/3nwYBmYsNy5JpoSBcr3lgALB9Nu/U520RTA2eb9JYKaLX1tjpCn7TL
	O1C0LW2mXsD+ph5eMh85ahC3SbNHbZzEwLfvBhMmuaEMxCbI1U+k5BS2d3+N7+SO
	ULBn+6aGZqygTOV0yGWaJ+sIDPnOUkFe/WRI7HZ5vsUn6o4auKAiY9+K8n32kfZ0
	iO15qowVXk8r76iJomqo8tUoVlWy7ko2YJfGk2BB7xSMogJqGF7bDc4/1XJG3g9g
	KJQwcpGm9G2YMkgjREt/E2XHWmLP27LWjwSQFeAONACIQdaMH/8reuIuh7A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxbdy3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:51 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56db8ed8e40so11543131e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479291; x=1778084091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3jiCPQeEhUGxNHVRP3aV2Dn9BaGTadLWJf5AW9mXkk=;
        b=bUOEx5RJfDnK15eLSdd0tGVPkVLX2UWjLFhyZs8B7WSd4eQX9Oi01W31pv/COenQIH
         mEDSDBVUa5acxbkQOxsS3nKuZqnJ+pexkoeFJajCTTPOJSyBSCMjgwpiMNNI2zzE+BHS
         iR2t4OOqGgqYaiAL4iL8fskX62JlxCOcpOTlnR8JMOcmCJjgRrpgrZFva56maKF3o3xD
         t8b6+lwrtBAajqX1bWyiUfYGZ/EWwBwlKrxKl7jYkgpj7IKeoM8VogZPUuj7Era0hwKc
         gc/iq52PgIbFnV/42RhVRSHYDQ5Iwd+0uIGoem8MRP9Oc1hz14D6GY/WB1OmhvyL2d1E
         jg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479291; x=1778084091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E3jiCPQeEhUGxNHVRP3aV2Dn9BaGTadLWJf5AW9mXkk=;
        b=DCoBwvIKUGLTTEqvzwe/hO9UB0J7OzPqzrH8eZwgkc0QmuNfXmwcZMZZK1q4eYlB0Y
         FoCI4DKPWmyj5CR1ZVNwWj4AHh7dwp/A+x2PAnoj7YTPBTDRwMCu2OUEhyUYJ8bR4SEb
         6p26D3KMRPQ6dSgUq4mAhs1wL7uLgupKVOsij3RF3MdLaREI1xG4DWaKNive6md8TCAw
         0rqnsi8yp9Smbokup9igc9a1o8xpz8spEjdfo7u8Hy7FrP40JtQuTrYFNdOKKoVrxB3C
         FdlFP9C5ysDcETtM0PwkBzimMH9OgxOOOuo2EiR6sJc8I3ifSNl4TSbI3MEP+m1WjUR/
         AguQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uuah25OjpYYjsRSExzmZl19++1cCQFK4xPhqqmVqM4onXD+zNdhi7ABkkXMYBuZwMZuNxuTN89A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2+EquGu8cBW2mhkr25zhsmS1hdZfe7wLsEq5gPiuMcbD5WUm
	8FlEryp/5jVtXKvk569+agoCLw4rq2U0SlWuzHT+s6UcMTccl4eCMj0/RNHaOgQEIeOUOmSlXmI
	dxXUr9dqQLUKyoOU6svIfUbqKgfJx0MsJLWybjF/OsuVy/JEWktnu7h1YQjgwJA==
X-Gm-Gg: AeBDievQCEAkPcyuE3XvuYwI2UD5Eb24ZYJriUoa5nxE9oJy+iEu7CxpO9+fBWWD+Sp
	+suDqejtrvZitHcXFrs0NBwYLh3joN98ofVrtTrYlZJOSsHm/vP7B57o4JCHZngEkfIkbI57upB
	Jp2WE1ymgiHqo3Q0EJrVarxj6Xc1Q3QBNg/8O4dr4tHUxpZM5Np8ut42UFOLOitvnTOXpmOvJlo
	0CcuI0pWOMNyM3rbd+gd0dCiz0PdktEo4GefwfpwfBPMlw0iwXE7Nk9Ic+lM1kifyEnymH8SxLr
	LI9my7aPatsMEZy7mwfo6bUeiNawmmdNmFLvpADqbSDaGn4EUlusKPGb0Lp2wkEqXP1gBNqDZiq
	g9blkwGYLLddZlqyhxf2QSO36trafgrC7XTSSXTdUejCz+4E460uAmIH1aOCi
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr4901027e0c.14.1777479290522;
        Wed, 29 Apr 2026 09:14:50 -0700 (PDT)
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr4900974e0c.14.1777479290066;
        Wed, 29 Apr 2026 09:14:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:49 -0700 (PDT)
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
Subject: [PATCH v3 06/11] thermal/of: Move OF code where it belongs to
Date: Wed, 29 Apr 2026 18:14:19 +0200
Message-ID: <20260429161430.3802970-7-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Uh9GN1gu529DAtA6vbWgLwS8bsv41eBf
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f22e7b cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=jLM6qsj88INzSaGZquIA:9
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfX+8qErJPHnl3S
 fgVG4qhVVEn8AA/UTEi2FuermRINEDWl01bStntjWa9kluytCaJ0XxM5Vck9LzeMUivm/0nD7AB
 0bD2Yi8r8u8CtofOxlnM1q7R5gztsUimvb6p7Mtc8aPuB6iWa+BbeinNHRG4cJFD0bIg+iPh3h3
 VDQqPvwIBdkQ6a4Vha3bTC8RGy4a70HRkCH4TCb2rArIbfOn0V8a1NjH7pmjhyOXxPbwSpcsx0g
 WamM6vVHyIS8Dj0QSBNzMySj5d795HKu3/+ZK6ISnVgKzNIUsG/wZzwXnacSE9RBXEo9y5uaZXJ
 PT0hlj3rUsviqipF6Ye2VZD9aJqTcd7ULOfJHHjgn7sWz26I8i1AflnNjskA1dx/3cgmOJV8wMy
 03R5UQv9W74v9SCRxN76ijmJjA0m+fvOUxuWIzlTk5DfVgj2Rk4IjAm5tjwzu+ZymOhDHTlEutz
 saZBMjppT2rEWhNV9Rw==
X-Proofpoint-ORIG-GUID: Uh9GN1gu529DAtA6vbWgLwS8bsv41eBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290162

The functions:
 - thermal_of_cooling_device_register()
 - devm_thermal_of_cooling_device_register()

 are related to thermal-of but they are implemented in
 thermal-core. Move these functions to the right file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 78 +-------------------------------
 drivers/thermal/thermal_core.h |  6 +++
 drivers/thermal/thermal_of.c   | 83 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        | 48 ++++++++++++--------
 4 files changed, 118 insertions(+), 97 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 7867e6bc0a6c..f779fd393323 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1040,7 +1040,7 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
 		thermal_zone_cdev_bind(tz, cdev);
 }
 
-static struct thermal_cooling_device *
+struct thermal_cooling_device *
 __thermal_cooling_device_register(const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops,
 				  void (*initcb)(struct thermal_cooling_device *,
@@ -1150,44 +1150,6 @@ thermal_cooling_device_register(const char *type, void *devdata,
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
-static void thermal_of_cooling_device_init(struct thermal_cooling_device *cdev, void *data)
-{
-	struct device_node *np = data;
-
-	cdev->np = np;
-}
-
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
-	struct thermal_cooling_device *cdev;
-
-	cdev = __thermal_cooling_device_register(type, devdata, ops,
-						 thermal_of_cooling_device_init, np);
-	if (IS_ERR(cdev))
-		return cdev;
-
-	return cdev;
-}
-EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
-
 static void thermal_cooling_device_release(void *data)
 {
 	struct thermal_cooling_device *cdev = data;
@@ -1230,44 +1192,6 @@ devm_thermal_cooling_device_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_thermal_cooling_device_register);
 
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
-	struct thermal_cooling_device *cdev;
-	int ret;
-
-	cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
-	if (IS_ERR(cdev))
-		return cdev;
-
-	ret = devm_add_action_or_reset(dev, thermal_cooling_device_release, cdev);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return cdev;
-}
-EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
-
 static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
 {
 	struct thermal_cooling_device *pos = NULL;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index d3acff602f9c..6935b09b9978 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -269,6 +269,12 @@ void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz);
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
 
+struct thermal_cooling_device *
+__thermal_cooling_device_register(const char *type, void *devdata,
+				  const struct thermal_cooling_device_ops *ops,
+				  void (*initcb)(struct thermal_cooling_device *,
+						 void *), void *data);
+
 /* Helpers */
 #define for_each_trip_desc(__tz, __td)	\
 	for (__td = __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 99085c806a1f..ba6f246ddef0 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -510,3 +510,86 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
 			       devm_thermal_of_zone_match, tz));
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
+
+static void thermal_of_cooling_device_init(struct thermal_cooling_device *cdev, void *data)
+{
+	struct device_node *np = data;
+
+	cdev->np = np;
+}
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
+	struct thermal_cooling_device *cdev;
+
+	cdev = __thermal_cooling_device_register(type, devdata, ops,
+						 thermal_of_cooling_device_init, np);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	return cdev;
+}
+EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
+
+static void thermal_of_cooling_device_release(void *data)
+{
+	struct thermal_cooling_device *cdev = data;
+
+	thermal_cooling_device_unregister(cdev);
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
+	struct thermal_cooling_device *cdev;
+	int ret;
+
+	cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	ret = devm_add_action_or_reset(dev, thermal_of_cooling_device_release, cdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return cdev;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index eff01fba0c81..f207ca6b63ae 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -200,6 +200,15 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 
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
@@ -213,6 +222,23 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
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
@@ -254,18 +280,11 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
+
 struct thermal_cooling_device *
 devm_thermal_cooling_device_register(struct device *dev, const char *type,
 				     void *devdata, const struct thermal_cooling_device_ops *ops);
 
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *type,
-				   void *devdata, const struct thermal_cooling_device_ops *ops);
-struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops);
 void thermal_cooling_device_update(struct thermal_cooling_device *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
@@ -319,18 +338,7 @@ devm_thermal_cooling_device_register(struct device *dev, const char *type,
 }
 
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

