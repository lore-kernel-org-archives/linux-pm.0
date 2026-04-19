Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B62DCBFC
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622981; cv=none; b=Y9kS9/2plBJOamH3dNi7O1T3QnReGAUqa9fkgoP3X5U90MLJebtj1FC0OSiN3hJu/5KgV/bPtnun2ye3UA2ut+nBYApnL7cNe6X02BoSdT3R20DKG9eWstxNra6wd7TQL8kykGS6q0vHGfX2FTcG2XQyIDIpN8QdjV/YPSg4wwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622981; c=relaxed/simple;
	bh=povEAdOX2hGXcdSaXed4zJHRaXYtqJTTyhdfcFG83BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKrk3F17Ov+8Lb5d93F+h2ucuynIPZug/oIABFzvHm8q+KXWEoJbwGQ5W52Q4/n60DMMBygt2fYCbJX+eTctI5vvVhnT3kvEEJxS+OLcM7tDb5cgAi8VFBpnLL/ZjF0opgJI8KSwVBR7/YA8sG++xIOGZ8tf5IIt3K8J28YwvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TtI/BbYq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eql5bx7j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtI/BbYq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eql5bx7j"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JGCdb5124821
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mBAk+Sm+mnO
	5DTzI9lKqPEUkJ5P/e03TPLtapt4NgHw=; b=TtI/BbYqpUab5NfqgQhMFLclp+1
	vB8QQKaUZdB3IKVwvUETKTX7BPZaM0leoiaXakCLo+BH3SBzBCFmCiehpHxoXYZM
	pM+ImQCuUPJdNay9rYSFyPJMflKv5KATqG+qDw2CnQof6stTseqGtop+jqw3YtnZ
	2gi3MuZITOPyCcC6+OKw8mhoS4FlFGH01J9J1DJWArEuDb1xPztJyEWE3Q4x2X0r
	uopJsMioEiWd4ImnyLchni5JQEAxGVeXYiVpiEMMAhVIKdWvyR+OscjBxdOoR6Yn
	CBQVZ3tVV3rJ20/nTm6ZzQzaW2GNfuEN9zMxaA5rJKuFOGUAEkWSM1c3rtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm1hx31wu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb706313beso272078285a.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622975; x=1777227775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBAk+Sm+mnO5DTzI9lKqPEUkJ5P/e03TPLtapt4NgHw=;
        b=Eql5bx7ji7v6RkxiDr9jn/dgXaqxyBXiFNl708/q108tqFTOgizdp2ZpkJ2UQpdqpL
         MR000OGUdo13lL5+YNs1xAjGdSZQ0IewxuzjRrjm5UgyiGnnu4m1ocOj6iK6RL0PSnue
         CqR6OIhKOvMZwrheP7vG+DMIARcFHaquz3A0BUBGX7qbThOqlIcFT2AHI+8eveH749zi
         k+X6E6AYShbhku0Dj5tcJAPHbMpTVAUEgvYoP4y6LTZ5xCH0H3aDyrVMo16F7u9ZD8Mz
         JthSnE7L/dL3LBNjv58hpPSJjzdO3lBC+UUopZ4PjcoNRLVnrqve75YgEPBQcxVruOg7
         5Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622975; x=1777227775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBAk+Sm+mnO5DTzI9lKqPEUkJ5P/e03TPLtapt4NgHw=;
        b=keOcrvb+rTfwE5fBq450aY3PcC1iWBtz8aqeaggfWWig2JmiQ33iMyCnRJB7Aw5LDc
         spD5nLO2PAaI9TNG5s2Zr9WzsCrP8brGX0DDX9IgZEq+pd5cGe5gaI+NPNZ0quvk1vf3
         bnsDcOsoNihwrvimBP/g7CuKabtv9MryQzIHnQ+zRIZNpBrUnJotAdB6Yg7NzkLeOEoa
         f8YLvOVpgSXMx49ZuGD1fk6Z4tY5+cpizP+EhZa35PeFTXuNUXftDt/YVxBVzaNTA/c6
         TOTRVyzD73SoZNUouPvm9Dqzp4wLyq7arYodu9Mr8qvE1jI8maWwG+jv2F10m3lG++Uj
         IphA==
X-Forwarded-Encrypted: i=1; AFNElJ8gRBHPq9OLZvgkWWt5gxfrOs6oUi4blQY8dy5d87AlgTLBcR7PiCSYLVFkWxZYMyoUQed7qMseFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKL8+mKTuVL1e20P8rlidDE+sJPDGB3YVoXCk1Idoz7CYOnpqd
	WVIJdSgwJuy5uW43v43DNL04lkJV5w/8/YtpsKYrRW7krnfZhAYOoYgvxhEZD+5iLDGKdnNSoiC
	H1SXio8jCD6avfpW0/m1IejOAuLWNVCv7/GqGDDJe8tgmifjh5NjCydr69QUZ4Q==
X-Gm-Gg: AeBDietk68wU7FmcO4crjYhPe8gVWd+FoBjyznnv2oWHlMJoPMZAMecXf91EGcEc7UN
	MKMGYt71B7Eg1SLoG35kBiEhp/plsL9HwWQJwyIsdfG7yzPAqjVlde8VKdTnIirZiboTDO51/WV
	GDO5kh+yKzT7ZM0+Fp1H4Mz8Bhj0hbjX+DARWUkl4aF7KU1kRjVQNZwH8nQBXwU2gPVVOqAXE3F
	r9rXZ5umdKRTEg9Fwg0ISJf9kzT/O5z7mRCYk4r5nVBMVs03wPvMBcbxcnCgJKNNtMrQ05yjNOx
	1isPyau7vN3CO/Ik4+r4Sy1C93zamnGY1KfZF1jwxvptmVesVaLgU79yQjQ4dYo2S227lLdfpVb
	lG1nn0IKgbNb2jrDNkr44weq/sB8h1+4izOkZUADVoas0uyXfFs7LqDESVDG2
X-Received: by 2002:a05:622a:5c05:b0:50b:4755:94b9 with SMTP id d75a77b69052e-50e36c77202mr167950591cf.56.1776622974637;
        Sun, 19 Apr 2026 11:22:54 -0700 (PDT)
X-Received: by 2002:a05:622a:5c05:b0:50b:4755:94b9 with SMTP id d75a77b69052e-50e36c77202mr167950031cf.56.1776622974124;
        Sun, 19 Apr 2026 11:22:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:52 -0700 (PDT)
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
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU IP)
Subject: [PATCH v1 11/14] thermal/of: Introduce cooling device of_index
Date: Sun, 19 Apr 2026 20:21:55 +0200
Message-ID: <20260419182203.4083985-12-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Jjof1xIhNhNCbKRpgM2ciyMk68h2PuZa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX2mNs+0hibCul
 eUln4S4GkZcfNxVMp7J8hnHeLQtNLL6nsdBWu18aMfzqGaRneRIWNq3rz1cQC6QA8vdkZJuCUQr
 7zEl/jmvJLFDAP9IZsS79P+3R8BVjKFX3Yyp+wP86uc8qDFdqar01wF0NDYucU8UJdwjSc9y8cd
 G3sMcJEy68loRcWYzxSGqarLH4eg8qpjSguB+LEoE+NKJimzrNnyQfcP9Ac8M0lMEDseNL5ix41
 RG41EkI8fZz5UHc/PMP2BPsrfLQoYCpyKlvOTX6YaXxcJAYW3sJlnqhQe8otqemE0RrQGWVgdnQ
 KMk1pcBG86csOuUUeNlHCnNBRWty5keJWhW3lBeKRQpZUkGoRLUTlymjEdafNXL26bT7DcB72Mm
 XTdOV32GdcCMlsWekbCv8tMiI1MsD8dhMfh39/DqJemR9obpT9o2LYLIlebJ68HgVtM+kcmJn1X
 jV0RPA4TG0cixmk+HGQ==
X-Proofpoint-GUID: Jjof1xIhNhNCbKRpgM2ciyMk68h2PuZa
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=69e51d7f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=UUaV7nkyxFtcjw1PROYA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190197

As described in the previous change, the new incoming DT binding will
describe a tuple device_node + cooling device id, instead of child
nodes.

Let's augment thermal_of_cooling_device_register() to receive the
cooling device id and propagate the changes to the four remaining
drivers using the non-devm version of the cooling device registering
function.

Add the id in the cooling device structure and store the value when
registering it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 drivers/thermal/cpufreq_cooling.c     | 2 +-
 drivers/thermal/cpuidle_cooling.c     | 2 +-
 drivers/thermal/devfreq_cooling.c     | 2 +-
 drivers/thermal/thermal_of.c          | 6 ++++--
 include/linux/thermal.h               | 5 +++--
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a891d4f1f843..a965cc0633fc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1791,7 +1791,7 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	int ret;
 
 	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
-		gpu->cooling = thermal_of_cooling_device_register(dev->of_node,
+		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
 				(char *)dev_name(dev), gpu, &cooling_ops);
 		if (IS_ERR(gpu->cooling))
 			return PTR_ERR(gpu->cooling);
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
index ba5093f612d0..a728da1f4e56 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -514,6 +514,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
 /**
  * thermal_of_cooling_device_register() - register an OF thermal cooling device
  * @np:		a pointer to a device tree node.
+ * @of_index:	a cooling device index in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:		standard thermal cooling devices callbacks.
@@ -527,7 +528,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
@@ -538,6 +539,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 		return cdev;
 
 	cdev->np = np;
+	cdev->of_index = of_index;
 	thermal_cooling_device_init_complete(cdev);
 
 	return cdev;
@@ -579,7 +581,7 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = thermal_of_cooling_device_register(np, type, devdata, ops);
+	tcd = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6535353ae83c..9813f02db088 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -134,6 +134,7 @@ struct thermal_cooling_device {
 	struct list_head node;
 #ifdef CONFIG_THERMAL_OF
 	struct device_node *np;
+	int of_index;
 #endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
@@ -201,7 +202,7 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
@@ -225,7 +226,7 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-- 
2.43.0

