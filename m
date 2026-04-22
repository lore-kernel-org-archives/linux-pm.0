Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846239769E
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879822; cv=none; b=K1vv3JubQ2pyAwdJJzrq1ibMVRwkad2LCQEpXiM+RyV9a0HCoLLAhIdJqDN65TQCYx3VmfQSlVVsDjrzyl2OmxWu9huKo2Qqedkkb3O+R6/plk7f+zUrz+1UYkShcsHS7ce/ZyOjYwZg3iCiZ+ocnBkcaoxnRP9TRZdr45vTS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879822; c=relaxed/simple;
	bh=WZWZt0bPOVWm1f/mYYZeoQ2v34IzpqaOtZm+yK+w7as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iamevBRrwe82eAgkLTAUw4UCBfwviuW7QXoSkvtM/ptFvmwcLncz7YScaGq396E93a4gMGDXOwE2TbL9c7dQSjFua9CmuKjz3gdLZ80waLyrQsU3Ukl3zVD3gNJC4dreB3k/Saj2MgEhoDkSsYRTI1uu6RomU+/D/ZmkHRnDniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lUqpt0hJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BDQPDJcW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUqpt0hJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BDQPDJcW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGqWgg1218382
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RPB74rjHmio
	iPv8T6HjThisH0Pt4yN6/d8eSpZWAlsw=; b=lUqpt0hJTHzrhLdMaxsXr1yL/Fh
	QIO7xd91xuTaR1uBj9aRW4uYyAghxi5e2s46MWED1RA1pwtw86fPuQowXyVZl/53
	zJi3+nUZAPEtRGBoWl0gc3aQZpHIaeef3IXzFAOOAro9tMFlEfYrs1qpm69nbK2Z
	Kpauw5EHQsA+7sRPj3r/CWWCdI9N2Eip0Oe1CRikzNElMqHPzycVstu9WhRbqUno
	bS1jYHZF9P+XWq66kwucSubbHwmb7956UtbgzAy0ODQWUCNmsSUw91OlNm5s90RC
	RSKyjFItBcb5NJ/cmcjeznKRQmtA9KKhofw0Kg7ndPzBTqoIZHjAUoR4HAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282r5u1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fae95c82cso18816081cf.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776879819; x=1777484619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPB74rjHmioiPv8T6HjThisH0Pt4yN6/d8eSpZWAlsw=;
        b=BDQPDJcWLPjk/9InnjEvMER23d7GmHkbtkD1mVisSrdv+26s3yaiaUOPwxm9Ik8QPU
         v0sZhIo6AQ9hUqA41jiCJKmjt8X23tR+P7Wwny3YPIqo3wEXaWnI5n4F/Z+nLw9qPXMQ
         +wZbpqQLbPeZFzVJ92z1wvVLvTanbDigDIFK8YxxJ58XBvyhNSTJ11LISZflrh7vXj02
         lyr28Y72+sd3YGdzTy6JuRVtJp2yjYutDq/JIGJq31xemdJA7l2LJNM8onZN9AgOUR+A
         ZLHwzudlUu/CHXVQhAB/6v+64m/hYm8EWq00EcyokkhC/Pd5+O9h7E/xfMIrlpoGIHye
         gPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879819; x=1777484619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPB74rjHmioiPv8T6HjThisH0Pt4yN6/d8eSpZWAlsw=;
        b=TGA3pc36LA3QU4DGmaryLOjaSSMilUQFNCtUrrn8cDOvQg7kdIjhWiU+PZYaY6l9xR
         YzDi39eOPCTcj+sngAqDad8ULQ0mADUF9kL2a3+MWr6WIACM6dM7YeEK8BFSuEBWgi51
         Q3MIWonHtptfcKvF/aX1s0mZtIkxn0lMf4YB4E9zJ1miVDJkXTCU3M3GOd4rJ+0JzAdW
         ao825RWvA2+jzphlLZmziIpQkni1V6GKx0KrThG7va7zNjDyo5UTL5XPfHpfCu9hz8PO
         fZ1MPH9ph8MbpfTy9TE5i5U/k5eQtCMhLoKNyA8/4nneGwCc2zG4f/YJDI0wx0kDGeW8
         MALQ==
X-Forwarded-Encrypted: i=1; AFNElJ8O7Uk3LtS48yXyFJhVFA8lP9BBLdqFeCclWUdL7eMb0UZlvUGeB1DbZSt/X1g7vh0+o2LgM3SX3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YydHcRtOag1yb1Rh09RNxOoGu2NKC80Y825GmJQl2ETHaTrLKK0
	XWEKfeokgiNl3IZ8KMTmh7VhsqviLS2dc0ejxZR3BZCq0l8YoN5qTO9D6wYcpXyQz5cXVuCuzZs
	mhxN9ImxCZIKPkLEMPYg2KS9qMCbOHg7Whdf3WldelAldTQgVCAqsqVjCyA2Oxw==
X-Gm-Gg: AeBDiesv6GL8wHxbER3G3A0mbb/tyNIjwPfe1SEeV+DX7LH090z/s/bEQqX6Tr99gmF
	2Ufa3znJwl+qo65rI67kxYmF6vjPcvXQoIKeoSDYfjSyG8Ub+Cop56V6l0bUwX6fUdPa/O3SV8Q
	RApLFYQxmA1Lvjs9DHsqLQBwpprZxeB3W6WV0YKqciAXMTUaMe2xSsK5Z5HmvFIkl5bM05abTgz
	8kZ+bATABoiLYkhLayJoVrvDaz8LwLfQS5PY0a93VeIusf3+Ad5DZCYK6u+WLjee9LJnuocl0IG
	Mq6UURzdmflDmUfdtdjlcYoRfRY2mAOObyz0KieEE1cOmaZ785OdL3cqy9i9smarHTYBDTMfhcM
	RzvzQdsK6AzjtKQgkzqgUwWG/LYaSQsKAnoz4QtAO9IP1DF94GR7xpxt+ZfjD
X-Received: by 2002:ac8:7c46:0:b0:50f:bdc1:3bbc with SMTP id d75a77b69052e-50fbdc14892mr80054881cf.45.1776879819027;
        Wed, 22 Apr 2026 10:43:39 -0700 (PDT)
X-Received: by 2002:ac8:7c46:0:b0:50f:bdc1:3bbc with SMTP id d75a77b69052e-50fbdc14892mr80054371cf.45.1776879818424;
        Wed, 22 Apr 2026 10:43:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:43:36 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU IP)
Subject: [PATCH v2 09/12] thermal/of: Introduce cooling device of_index
Date: Wed, 22 Apr 2026 19:42:58 +0200
Message-ID: <20260422174305.2899095-10-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfX9X5zovJi1q05
 z20NB0wzTWFmHe6YdJlDdv0amb+bXdcwcUoU1cL6ZQREbR8C1Gvvf/LZXfipbUdl3ZIBnECTH9K
 HOIgUM+JRTt+kNb1ShI/gQhZSfoZYE8SN7q6NHLNMduUQHW4l/z7rFwOPnP0Rr45oIEvJxDRvH2
 UDi53xRpz32WHAuJz5tNK6jwnGJYLMYXS6uq7ebwkR10yJa7zpLqV/gQk8N9jpLxoJ6wkdjAyXf
 6rem/mbxMbtQYYsYLU+nA12TkEgNSx9wt+TUFTU3cryGvTy+GVA+8Aab3S94Q/ZHn3AhVsqQOIO
 EZ+afd4A/lZBSrPMCuUeudLqkRkQTmuXo96ptArXocu+j/20oCj99z4eYt2ZMvcRM+jDd7PzIZa
 UsEEzqphi0JuJYuw3w6ltVyKhHlEaeBbwjPmKVOleslJlQOvpv5gWMSsJI92e38/AAvOuazHR2i
 rHGlFNLkKDeBPv6akvg==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e908cc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=UUaV7nkyxFtcjw1PROYA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: d5zEc6gWHLXRTX0eNKb3GvzMLouF_KZy
X-Proofpoint-ORIG-GUID: d5zEc6gWHLXRTX0eNKb3GvzMLouF_KZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171

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
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 5 +++--
 drivers/thermal/cpufreq_cooling.c     | 2 +-
 drivers/thermal/cpuidle_cooling.c     | 2 +-
 drivers/thermal/devfreq_cooling.c     | 2 +-
 drivers/thermal/thermal_of.c          | 6 ++++--
 include/linux/thermal.h               | 6 ++++--
 6 files changed, 14 insertions(+), 9 deletions(-)

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
index d06487bb5e67..a9319ff81d1d 100644
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
@@ -582,7 +584,7 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = thermal_of_cooling_device_register(np, type, devdata, ops);
+	tcd = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b3c448f7d919..070dcf7f77b6 100644
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
@@ -201,7 +202,8 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
+				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
 struct thermal_cooling_device *
@@ -224,7 +226,7 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-- 
2.43.0

