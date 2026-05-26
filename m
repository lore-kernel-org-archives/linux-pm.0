Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64A3FF8A6
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804540; cv=none; b=WhmCCqU7LRI6Q3Nn5suYrkxuvMNMJcyRHxk1to3Ungxq66WaLrMdTAWbAm3Ys1Kb8aKpYsenpuUzfbEr80RmbrvzxTUSJRK8L50MkJ+oy0TqHunsq/MhNzhh/rkqETw+uneEVcepjucJpMNleeJgONLSVPVqLIGlurmU48eXNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804540; c=relaxed/simple;
	bh=dVTi16Ji7zjZVXFk/PV/mKHcJ3PxlBnabFv/88k2YU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7fYUncFNtYEoRFXe29OeKq78KlqK/n1An7PiNAywNUnU38625C5en4zGvprResoWXVlFM2gw6on7jlWUZyA3zIv6AsEGWzrq7nHTCkd6GwIXM80hg4ML13Mdilf9EgSPTRjQgeyueAVPyJRz7jZS/jPQnXy1s73qpzJMTwOwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vs1fI3rC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OlPN9zT5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vs1fI3rC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OlPN9zT5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsUF12697843
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=G6UXIPhMd/k
	O1OykWot46Jp8kUhSq0VPJM75VskYv8U=; b=Vs1fI3rC53mf8ty4C3MQDoI3NoN
	P2hDWOQWHOUFNlURAtT291LyZkfxAlxLjPGUa1Jt7yxBgSh9+Gs6g1VGmchTxxwf
	e5tShePQN3WboG40OZInsN/be8Vz1GOkCSMHDVFXYAjtgqyPpIoQWGozYZ/Csk0R
	iBnwQz7f37bE83rgEB9HFPvL3x627ScOHFXNTlgJZ4x8RHiIHsHTDja1AZ9opyYP
	iJa1ymeUgb6k9+t3IUzef72h4hH2HLlOzUT4jMWE9xgBurgxoEaGg6jUbxB/iE4o
	IxPeIp5CETqjEBuLlzh7DElD+J/y0wEf8h9YbfWtM3TFyBIJr/mffGGjDmw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm046hc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:58 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9619ae0b916so1940688241.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804537; x=1780409337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6UXIPhMd/kO1OykWot46Jp8kUhSq0VPJM75VskYv8U=;
        b=OlPN9zT5sbZ6PCNsHVdfUShdgs7dw1tU1XzIGh+M/qy/ZucjnG6nndIkvdwD5urjG4
         QGGgpIQBUzJ9qjxJXAQVGfUqdHyJ9g+87Fcrf5/QXgKtLb91TmKllcUZWqwsxwGtEdEL
         +IJg1W9Ok8c8nEyeMGAs3oTftuOizoIDcG0pdIxFXQSOUEOO8KIQYy2zf+TFUzG68J8m
         wKeEfAuy40enx4JyT7bWTCgf2KN7n6E/OSoyTBArJ3PWnDUEXrwCzUfSdigV60H5FeyU
         W1hOjWofiEeH1VER6vmHnLens2jBgSgz2xqyuLAv/3JKLvEY2Q+uSoUMBwDQY1yXfPED
         GOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804537; x=1780409337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6UXIPhMd/kO1OykWot46Jp8kUhSq0VPJM75VskYv8U=;
        b=lNFokYkrrreW6KBeOA31epkVamC45KCfeWX/UwfTbEMMpmwWJk2dTuBEd70QFcl1yf
         dDRA6lGMbZQOMEllSa3nPJkD6H+1kOM3AKP5ITeg0NxgHAmC4Q+Sg0WaxpBpv1148jw+
         RTB63wZMZF6oe1X/meP/LKV43Tdzh/IwablNvdm1KfYSsZ76QrJsCAxEHlErG9fsX8mV
         T3UxvQAYBXbZGAGd9hm0WE9Nf2d/c86xuwFhaqHRvlXVrANaMKNjcSvOtsNqMTiZDar/
         zTANPf7JHkbidzgGzFVbnuJp/iuWtgQhkRxZ7caJiL37MDaXOy7n98yZcvH7ziuHvj3o
         HhJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aw7R1H8CSblq5aGrxk7JzEKDnasCov4xTCcirFBy3qP7tDBXfCcT1IPYoLVdM8U1onB3bd81cdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGuFPXwf5JPxps8AfZWdLlij613YWWTx0qvzDv2rDNYJW//Tl
	kOYWnZZc6KsKiMBKROvpQDNYSTF7Pq9w7hyc3UzXo+H8xOOspXLv7Q5mZHnVRMfOwiZ07fYP4Pw
	9AEXhSmpjTO++VNu2Mx5nph4g8soQFYjQIDArBdEJ9WL1q7XyFUAX6dTuQIE6Tw==
X-Gm-Gg: Acq92OHmcGGmNTgQkgqn398elA0s6Lx6dTVZ/xjL3+NUsLLE5RyG6HTSliDV3B46DXe
	COuBVqXwieLtuQZX+0IkSgeMr5PZWMn0X4Qsp9S0a2S1sB63Qvrw+nsWegLjWIGBiWolhkP4jIw
	o/Lblw1b15V6M4vLGdUrCeiAnTPl+CQg34Xpv+HbkxfXO6IDFIAHi13/otStjgkmhPsAvpQX3es
	9+53KL110O0ocVfHBC6pd8Zrlxc3TEqhpXqvMMpTLxnOfQc7lcVDtlQT0IdMCTcXL76ldxJTpJm
	dEnMUEvelnkk4rzRzQ0tKbTO2nhl8FXNZ35Q863LHfCkWsyScJrympyeBK/naHovdlkUghXg9bW
	qdBC/PbVkc4ysnfPUTFZTyH2zSTMHeqClUNhUJD5oCkt5NVg7
X-Received: by 2002:a05:6102:3585:b0:631:41f9:ffa2 with SMTP id ada2fe7eead31-67c8cba579fmr9659440137.29.1779804537470;
        Tue, 26 May 2026 07:08:57 -0700 (PDT)
X-Received: by 2002:a05:6102:3585:b0:631:41f9:ffa2 with SMTP id ada2fe7eead31-67c8cba579fmr9659341137.29.1779804536926;
        Tue, 26 May 2026 07:08:56 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:08:55 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
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
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU IP)
Subject: [PATCH v4 07/10] thermal/of: Add cooling device ID support
Date: Tue, 26 May 2026 16:08:08 +0200
Message-ID: <20260526140802.1059293-19-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6389; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=dVTi16Ji7zjZVXFk/PV/mKHcJ3PxlBnabFv/88k2YU0=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalPNVBQAibKwSwwBkb0vLMg4KKtMGIGLaVT+ ft/izW2PkeJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpTwAKCRCoMiOKKk/o T/s+B/9pB7YmbECtdsq9wJWAQ5z9GQ+XLDNRpTPnfv+MhLef3Q3bBIe64n23M2pGnOn0d+pek/j bVoCgQQqhL24FQu4NH5Vj+8/K9THKuv8oh0nc1bDrO7how58z8OQ6MpeOI37vJxJzrl1aOau62s o8QRndQqT3P4H1EHDQ472qztQnp9IaBgWAyG7AQ9nTyfV6q+3IZBwPfG8F2CsTxmBiVyYIHzSht xlI0oBu9AdUOFHxuOL0k+9xW4vp+iOGIfuH2xAmiaceglj6P8vhj9f+VIlmMyyHnoUSXrgLTrB5 /oQHsWBTK+c5Y12Yt1DmOc9oWlC6YZPgZDScMMZLtHbgkKxR
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a15a97a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=M2J-0F0GypFtCefbwVAA:9
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: o2aJMJak4Xm9k0H0QSrd9xWuSSv5cSNW
X-Proofpoint-ORIG-GUID: o2aJMJak4Xm9k0H0QSrd9xWuSSv5cSNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfX3oP2jWvlxh0V
 W/cc8qDNEGwCPlkaWfDeENEB+6Xo0pEooIaM4bfanOiyMsFyUn5LB6BaDFsvtejcgTZ6MBfV0TE
 NzRayeuGOuyvCXS+1GSGbXOafNk+RETuoEFpyn9bGUStJ1DUaZMTsDYQoedOW0TRin7Suks4s2b
 dxQfIXlBVZzv8JOi5u7kjEQVSvazEmZWitmAz3mzOXV6CiwJI1pfaH5+tSfK3/SvstqHO7ie02L
 kMSOnnvf9luOF7rwBEFMiJSBhnJXx+H672ZN9NuwTyjyo6dKKMQ6djeDrNquW1odxDqsDQLPFsz
 Xr0+Ex6u+Yo2Fbr3RaoNWzeVo6v+xBUjmjqYpyBJp8uFwB/+Qg9XtoGq7QfmlXIf32QZj0IaDkC
 IKhlX5rUkFbb34h6VuRAaGCnQLqWSLIuhaKmwRnE4YDgbA0GVUeXOhsqT93C0PDpmbXlA9ekCfP
 JV/zdKwM+0uhaQl8rWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260121

Introduce an identifier (cdev_id) for cooling devices registered from
device tree.

This prepares support for a new DT binding where cooling devices are
identified by a tuple (device node, ID), instead of relying on child
nodes.

Existing users are updated to pass a default ID of 0, preserving the
current behavior.

Future changes will extend the cooling map parsing to match cooling
devices based on both the device node and the ID.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  5 +++--
 drivers/thermal/cpufreq_cooling.c     |  2 +-
 drivers/thermal/cpuidle_cooling.c     |  2 +-
 drivers/thermal/devfreq_cooling.c     |  2 +-
 drivers/thermal/thermal_of.c          | 14 ++++++++------
 include/linux/thermal.h               |  6 ++++--
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a891d4f1f843..552631c3554a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1791,8 +1791,9 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	int ret;
 
 	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
-		gpu->cooling = thermal_of_cooling_device_register(dev->of_node,
-				(char *)dev_name(dev), gpu, &cooling_ops);
+		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
+								  dev_name(dev),
+								  gpu, &cooling_ops);
 		if (IS_ERR(gpu->cooling))
 			return PTR_ERR(gpu->cooling);
 	}
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 32bf5ab44f4a..768859a7aed0 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -592,7 +592,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (!name)
 		goto remove_qos_req;
 
-	cdev = thermal_of_cooling_device_register(np, name, cpufreq_cdev,
+	cdev = thermal_of_cooling_device_register(np, 0, name, cpufreq_cdev,
 						  cooling_ops);
 	kfree(name);
 
diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 425f596614e8..bbd2e91cf5ab 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -207,7 +207,7 @@ static int __cpuidle_cooling_register(struct device_node *np,
 		goto out_unregister;
 	}
 
-	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
+	cdev = thermal_of_cooling_device_register(np, 0, name, idle_cdev,
 						  &cpuidle_cooling_ops);
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 1c7dffc8d45f..0330a8112832 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -454,7 +454,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (!name)
 		goto remove_qos_req;
 
-	cdev = thermal_of_cooling_device_register(np, name, dfc, ops);
+	cdev = thermal_of_cooling_device_register(np, 0, name, dfc, ops);
 	kfree(name);
 
 	if (IS_ERR(cdev)) {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b59d2588ff7a..0110b195f7a3 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -514,6 +514,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
 /**
  * thermal_of_cooling_device_register() - register an OF thermal cooling device
  * @np:		a pointer to a device tree node.
+ * @cdev_id:	a cooling device id in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:	standard thermal cooling devices callbacks.
@@ -528,9 +529,9 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-				     const char *type, void *devdata,
-				     const struct thermal_cooling_device_ops *ops)
+thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
+				   const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
 	int ret;
@@ -540,6 +541,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 		return cdev;
 
 	cdev->np = np;
+	cdev->cdev_id = cdev_id;
 
 	ret = thermal_cooling_device_add(cdev, devdata);
 	if (ret)
@@ -585,9 +587,9 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
         struct thermal_cooling_device *cdev;
         int ret;
 
-        cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
-        if (IS_ERR(cdev))
-                return cdev;
+	cdev = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
 
         ret = devm_add_action_or_reset(dev, thermal_of_cooling_device_release, cdev);
         if (ret)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e6328234a42b..fb7649439dfa 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -134,6 +134,7 @@ struct thermal_cooling_device {
 	struct list_head node;
 #ifdef CONFIG_THERMAL_OF
 	struct device_node *np;
+	u32 cdev_id;
 #endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
@@ -201,7 +202,8 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
+thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
+				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
 struct thermal_cooling_device *
@@ -224,7 +226,7 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-- 
2.43.0

