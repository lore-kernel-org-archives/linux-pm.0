Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD543FFAD0
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479291; cv=none; b=abW0p5n8Fe5LJLr7OG2ILR7wSJQzVKITkPNAZNFqVKF49A/xrI/eeNH4pwm/EiDtP/d/RmeDs2zB7lJSoJ3MfJdfrvaeAWg59mHNgUzDnjOon1Crg5voQu8TXxlMphBsy+Et781mGGb0tU0Vv0Hi/EO4j7btFNRi8SNT2xiqQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479291; c=relaxed/simple;
	bh=ucaCDj4JwLttK9kftItHCJtiuUaF4EVrTaan65KQiOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOWeGuAtK3HqtLQgRKNBuWRIATlrecNFb8D1SI3phS7ORlv1X9ePpkjAduXxrRiGUiLhTD3IZ9+QNasHtJSEZAv3PsNKeOzL1UM3wyyUxhXlrrcz0iewV0jx9S0LkCYSPb2ruOB3cYQTJm84P0OWgdjMgW009hmxt4tS5+ZET7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eroR2myb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cuHtKjLD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eroR2myb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cuHtKjLD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFPwuH2094252
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zntdVnn2QBA
	NBiRKm99c9eG0gPaGBihJjkVAd8lHTuk=; b=eroR2mybXRWp1ZtSzUvF4wmF2wZ
	TQu48TtAK/2kK2fN4sRkekLTPRGpiVKsq1x0YyLOw69JdtD33G1VEUtyZGx6oul2
	Qy9ulDh/PFO6GwI6stJj0uJxeVh7u/mmAPOMKxGMMw/12TPoOI7bv77sLPpnJi8k
	cSdM5oV9p+VmoncpjwYwrzM8Kmjb8z9hrWbdOfNHK73NnyACET1jTy5Die1g+oLd
	4RJ5hbdLGgTEdpLyYR9rTfQLKLiRDE/6gyzCGQ2LN5tv/OkF3TmNs0YSpb8mN2QF
	255KB4ut9FQyVPnEVOQu7r1pefpDNJCWquii4Ou6R1Lebe9SPpLj2JHbb2g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3t648-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:45 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f4a1cc334so9698052e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479285; x=1778084085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zntdVnn2QBANBiRKm99c9eG0gPaGBihJjkVAd8lHTuk=;
        b=cuHtKjLDZJGSdGTi+mudqv0da+4f62QgljJfL7x6ufrS9Xg+e4HGL7u5z8fjJaqrGP
         xJuw6pESgOEsDxCashd+16hX7nFA75eTS5sTzw5e/tGev2FJm3SMuxd80FNmt8jWgBra
         OtSqXROO1fHAaQIcyZ4G9DZaJvywbnFhF4cj94Kh6pd+w7S1nmBDJcuOXSmCCEkbSbQX
         e3p4yiZQ1OJYat6Tvg1RDQsds4gzXalI49IBi9AMt48AduNff0/uFLSAUr3C4pNOTmf1
         oK9mUFeIAzSUtVaY7vlY02TRKwZDYraPC5KtMPOoxrVs+YLgamEA7oifCIgzajNW9gBB
         ui+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479285; x=1778084085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zntdVnn2QBANBiRKm99c9eG0gPaGBihJjkVAd8lHTuk=;
        b=av49IqNa3C49y8t/8ttGHeLTJzY4U6+bqxLjufQhFBF9Bqk1qlqcJ9AIV/+F6/8sFs
         TPuHPZSgp3OnFXO8mGV0fP4q8Es4pogrblPTLyp4DC84yMbAx5C0tmQYsnvlucju5O6q
         eERQQneQdQwPk1VNB2f0UDPDI2d1SVTS0DNtys5dpsqvrPA2/iOKzL6MZ9OaU4DupKZS
         PkNjL2UWlzREwTkAw6dkr2RbxyzCAh2alxLVhmlwqZUzmuLgRdMmahJseF7ozk59BWhq
         VpUIAsJ1bB1K2IKb2oimydm5zsCD5nyIUCxxhy5HKYV1CGKR7dpZeHSaF1J7OnDPUrkW
         zMag==
X-Forwarded-Encrypted: i=1; AFNElJ+eGh1iDJ7/uTAHoaZvclGTrJMvbYH2aWTTO2yZXzpAEAPwO7a8nZ1L9GNx+85XjQ8f9WBFjunOng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vm+cbC+NFBOQAiaeRYwhZtCqL15mih1nK2753f3rS2S8gEfQ
	+kT2BHhMfsGSMy8b+jHH+eG3yIePJ46XSLyGxL48y+h3RDM59I6/r2nA0W+3ZLHOdY9PG0fvCIo
	wXlVhoXUoTpNnGAQO6O4PwMtH4vD0KP6I9hGrb+LmiydCq0zqOFxYEED0ZTnGVg==
X-Gm-Gg: AeBDietgHy4y0He2QBgQL/bRamTEosTqxrwLsNfEpdLSfEUjFLBzRz+0xzbtd5bKzom
	uODG3PAEz4Cqxt5T7IwQCUj5WEP0YV1KkXvO8w3KkjnQ+OySpR8uCsb7tsfOjNN2cCl1odPmfwN
	FdMakCJiSF0GPx4IRpt0FLLrYV1ZFYbTUvueZR3ieFg0/hpy68sQlggJq0OayI8NWGOyU8zjnRV
	u36RjNm4iJcfNTkqJHdvp01yV9LqdqqqCW9qBxE8lZ00Ufa4YN7BEIlzmEME/FZxaVG/fWsbaNr
	fKEKmLUrDrB9pFs4YWycTJuaRNfsEOa4m82i/PPXzoqDNHLWayKLFfCb8iPG45QFFss8ByWJAbC
	y7bgOkvp0O392Vxs2EQCWJIhMhKpNPfq0HiLqNIVf2jXFdaf74BD5adQLyu9K
X-Received: by 2002:a05:6122:8b06:b0:56b:a673:27bb with SMTP id 71dfb90a1353d-573a55d5522mr5018163e0c.8.1777479284699;
        Wed, 29 Apr 2026 09:14:44 -0700 (PDT)
X-Received: by 2002:a05:6122:8b06:b0:56b:a673:27bb with SMTP id 71dfb90a1353d-573a55d5522mr5018099e0c.8.1777479284231;
        Wed, 29 Apr 2026 09:14:44 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:43 -0700 (PDT)
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
Subject: [PATCH v3 03/11] thermal/of: Move the node pointer assignation in the OF code file
Date: Wed, 29 Apr 2026 18:14:16 +0200
Message-ID: <20260429161430.3802970-4-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: On9yYO-8XOGe8pdxtnJXckBBeJPETRVI
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f22e75 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=LI5FT54bHBAbo1Xzr3gA:9
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: On9yYO-8XOGe8pdxtnJXckBBeJPETRVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfX59oaGc5lcWFw
 AZGoxxkC0xQzr9jP6NOXBs7XaZr0oqStjzZ50HZ1+R89n5Xro3qaoufbv1T6RJJwCAGMc4mJCGL
 GsAw59JJ7GmUFwwEo+8yL3afzXRcbL6gAvPSpKkZC3XA5DQVB/iOJazc2i/FgDcvUuUeNqphD1e
 5zFGRLZcj+x1uE6ouxV1fpaVOk3Kq8NSwvSwI8YoWPQXzdElrowyKj7KBec1QCT/qk4y8oRKLB/
 2i0N7sHpM8r87PUI8MFdKGC8T6eE/9FrBd3FRTWEk9YHG9dgevTfH7PKCStPXPOyGdAuprihqR7
 ulOjBeV+8RVHe6mMkjrtwX5CZgbPrAR37NLG6MlweblcLTlQjmvQHB+WHOH0Ypftf1PfbsYFi3f
 Z5scgG2uFuVLv8xQ0TAZf0lFdNHtAFOXef76F+CfutUcAVmW0jlI1L0ROdX0+mih93MYznObeMo
 DrzL/lJjRffyxmnujfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290162

The node pointer being assigned to the cooling device structure is an
action done by the thermal OF only and does not belong to the core
framework code. Move the node pointer assignation in the thermal OF
code. Consequently, the devm_thermal_of_cooling_device_register() can
call its non-devm version resulting in a more intuitive design of the
API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 51 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5c954bcae4a4..7867e6bc0a6c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1040,26 +1040,11 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
 		thermal_zone_cdev_bind(tz, cdev);
 }
 
-/**
- * __thermal_cooling_device_register() - register a new thermal cooling device
- * @np:		a pointer to a device tree node.
- * @type:	the thermal cooling device type.
- * @devdata:	device private data.
- * @ops:	standard thermal cooling devices callbacks.
- *
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
- * It also gives the opportunity to link the cooling device to a device tree
- * node, so that it can be bound to a thermal zone created out of device tree.
- *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
- */
 static struct thermal_cooling_device *
-__thermal_cooling_device_register(struct device_node *np,
-				  const char *type, void *devdata,
-				  const struct thermal_cooling_device_ops *ops)
+__thermal_cooling_device_register(const char *type, void *devdata,
+				  const struct thermal_cooling_device_ops *ops,
+				  void (*initcb)(struct thermal_cooling_device *,
+						 void *), void *data)
 {
 	struct thermal_cooling_device *cdev;
 	unsigned long current_state;
@@ -1089,7 +1074,6 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
-	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
@@ -1127,6 +1111,9 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (current_state <= cdev->max_state)
 		thermal_debug_cdev_add(cdev, current_state);
 
+	if (initcb)
+		initcb(cdev, data);
+
 	thermal_cooling_device_init_complete(cdev);
 
 	return cdev;
@@ -1146,7 +1133,7 @@ __thermal_cooling_device_register(struct device_node *np,
  * thermal_cooling_device_register() - register a new thermal cooling device
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
- * @ops:		standard thermal cooling devices callbacks.
+ * @ops:	standard thermal cooling devices callbacks.
  *
  * This interface function adds a new thermal cooling device (fan/processor/...)
  * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
@@ -1159,10 +1146,17 @@ struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(NULL, type, devdata, ops);
+	return __thermal_cooling_device_register(type, devdata, ops, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
+static void thermal_of_cooling_device_init(struct thermal_cooling_device *cdev, void *data)
+{
+	struct device_node *np = data;
+
+	cdev->np = np;
+}
+
 /**
  * thermal_of_cooling_device_register() - register an OF thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -1183,7 +1177,14 @@ thermal_of_cooling_device_register(struct device_node *np,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(np, type, devdata, ops);
+	struct thermal_cooling_device *cdev;
+
+	cdev = __thermal_cooling_device_register(type, devdata, ops,
+						 thermal_of_cooling_device_init, np);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	return cdev;
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
@@ -1217,7 +1218,7 @@ devm_thermal_cooling_device_register(struct device *dev,
 	struct thermal_cooling_device *cdev;
 	int ret;
 
-	cdev = __thermal_cooling_device_register(NULL, type, devdata, ops);
+	cdev = thermal_cooling_device_register(type, devdata, ops);
 	if (IS_ERR(cdev))
 		return cdev;
 
@@ -1255,7 +1256,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 	struct thermal_cooling_device *cdev;
 	int ret;
 
-	cdev = __thermal_cooling_device_register(np, type, devdata, ops);
+	cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
 	if (IS_ERR(cdev))
 		return cdev;
 
-- 
2.43.0

