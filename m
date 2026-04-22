Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3B3815C5
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879810; cv=none; b=sXmo5J7rE31HcRYyCRZLa8zx1xxE+RoeWk+dBNkYPZPqA47wrq1FgqLh/Yv+K3Kwy7Li9KmXCJzyW6jIQzpeMZQ7QvES2Hn/A4LPRjYMVwU4gvYhLpYFA3GqJdVSF8K8w5/IyC4qzMzeWK0jmOPYS/WlfegVJdtVZgoWjuKKWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879810; c=relaxed/simple;
	bh=Vv1+AfS/7xSCRW0EJqJ5tYsZh8DIv4JK6RBnX9pSCCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcDV66bVk91cgiMrBZnHZDBR4SndKPyu71s+I+gm6Izfzv1lFN5E0sPdNSM+zzjP5OEUoPfuKFI4XTQNJPVYciB02tkU6UGJevdVkoQRJWqWVpcRCh2BbxNjJoIV9yNCW8cZp4NnvM1f42Ki2gZQrCb38esR/nbUtIE1ryCtQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/lV+Hc3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TT1dL1xK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/lV+Hc3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TT1dL1xK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGqfJ71218598
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1e9sKez2pO0
	WFR+E8EFHfxXVc5ZRx16s8xW16cRALIA=; b=a/lV+Hc36PlJEjollEl9LeLSOu3
	E3AAquoUjD/NK2wf22KTqvJIfMMHlLOoJyo8sw5ROTUWuI8fnT+GpXCGBWjr5HIf
	PnnojjXgw8Ggp/EM7HZmXQQSZ4qj+5wP+lBLwPMtVmSFaDl85h/58xwtHdN6tMEM
	k1GQrME5JWSTkWbCyKOiCZ8bE+VXlHvZJK/CqkM8u7RiUHiCkg8WpKtiPMYsfra8
	74H101TNVQBx6lg9gpSTHS4V8nkoEKZdQ04yRND1s9f0Wxc51TZi6RkPzVPodE+W
	FUG1eUK1ROvjHWXwERabf/tpDwWIgrogpni4z3dpPBsFz6lVZTAKZ2JvTfw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282r5sn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50f13da9684so41126961cf.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776879807; x=1777484607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e9sKez2pO0WFR+E8EFHfxXVc5ZRx16s8xW16cRALIA=;
        b=TT1dL1xKw6OAYXKwy+IYei5YJRmI7jPnrKXLszbvBGFyVYmKmzly69pBjz0+MXTFOr
         FymYB9r/TbkQpDT1iZ2WpZPWPbxqtmnk0PgsUARK2kczWu20k2O0SefEQAiakRUFieq1
         H+uj36pt070XDwlpVbuFSoe0DLEPL2C0qyhJZGNBKkZ3x7ODhidlsU2bkfmZT6RiSOtY
         xxuXCzkFWy7mbBlDv0qbEi3YelVGKgf2recygQSKMkHw0CI8+J5PYYETyjEIFSGV+gLG
         z8SjBagdcH9JSzV1HzpzUDSmauxgAoxHthPCBtOov0rNkTRwtv8ziVzRMglcB7/SqPvi
         DxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879807; x=1777484607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1e9sKez2pO0WFR+E8EFHfxXVc5ZRx16s8xW16cRALIA=;
        b=hXOEFjZ8NvcKWo4TCM/+G64oxgoTAqrRyjc+jwFJjCn+uHYvOQ+vUu45erh6eegT92
         eZ1uTn9oVHsRqVj9Xo4LQOX3MWG8Q4TIZ6Rw93CZTFQjuomXfkWm3smZ2WSuNOdv0vjz
         vTO/j3bBmaoOLXtkM1oxVfycwdNAl88y9QdNClpGczTwPtQw76R0oQraQImm6obY89e7
         9pxTwl7RGScYhzAOslYugGMydM+0exPH9x0FJ6loWGfak4VMpsVMCnrMvSFiNpQmJeyI
         CDDEpvcgpZk9tbRZc1dDOXFVURH387zTl5BvGhhEIEWOllM6GnOES+WXxy6aptqlTEbu
         i32w==
X-Forwarded-Encrypted: i=1; AFNElJ8u7+BsmbFB2tlFegkkXF0pdyyfIhnlHAlZI/OyUTt5MNuWDXHX2DSY5nngEXmloxFLpLsJfhCZfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rmH7HobzwquVHPBWKXZPbFGyqrpUh3PDVv1JhAzjFBZb/nX3
	1QSZTiMZ/4DdX7ZvFwBBpbhK4+aIsmqasgXz6++2dwDcsbh8t3+1ztA8HbsVE7068BOLUDsHI43
	FgH2jvYXcdK7pQc2f1ynvzgsWfVbwqjOth9Xx85AAyzxSx87TZfTi8AflCPi4dQ==
X-Gm-Gg: AeBDieuPo5qZockrwzjwFCfzX+FTFGecSKDkWqIk2GCR3FXjqIvWWPwUXmcMgp2Go+O
	8TOscXKijPZW5+B8o31dO2cSlxedwM84kdbJbTfT/LuwUEY/R7PirZilUknOoXlrrazVfLTgIo+
	kEdvfe3YY2o0dPpViV4FjDpBhap0YhRbqr7jFgBKrPncfAgYw94DQ4P6UNDZZu/qkcdWpNq9wsa
	sJHbowzLoBvBJj+H+CP32niCy9dvWxjhORRjwd5j2nuTbtKTwSSRdJNJIF1dQfvu2VVyRJjPHap
	iKhyg5G9wzrsEp5fM171Ps3w4FAKtsINeIVxVpfBbcUrCNHjxAsvoL0JHfsAypWxzNIeEqnhvH0
	31AXgdVkD61EhuidV6kWmdKavWtI0K6U/g4HlesMEi4BAixSQScH80BngE4qM
X-Received: by 2002:a05:622a:1e89:b0:50b:1e5d:992b with SMTP id d75a77b69052e-50e36c74de4mr337070541cf.54.1776879806981;
        Wed, 22 Apr 2026 10:43:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1e89:b0:50b:1e5d:992b with SMTP id d75a77b69052e-50e36c74de4mr337069651cf.54.1776879806451;
        Wed, 22 Apr 2026 10:43:26 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:43:24 -0700 (PDT)
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
Subject: [PATCH v2 05/12] thermal/of: Move the node pointer assignation in the OF code file
Date: Wed, 22 Apr 2026 19:42:54 +0200
Message-ID: <20260422174305.2899095-6-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfX+JdplK/OgRV0
 YRzrJu26WuHdvGmVJm6G/3Cjxk84qqNvDXQu3ptEz57MsV3eriX6ksnQIWXHvB16ffc146Z7lc0
 RU88PpwrtkcdNOeeEmFtwUtpqQQfPCFxTXvyp50m0fJ2kRhbu77P9r9RugyKv3/5M79DYiwThYt
 xqFi/jYjmOLMCGLJ0uoSPBTtitYOFcHWC+I8XnwMoxxOEahZojiDSjvXOXFfk7VMJ4cmSyG8qKp
 tFGK3QTOJIiL0PZJoKWzPUABw59/ZVdoBSZZe13me3QAgwH2hTEKJNdWatjvJK1kAy5J4JZI8VA
 hVaN/DTxTugOFe9Eypk0TN9sq20XE9ZdePjxBcr5v2Bh6tSvtVu3+4+5A0vi7VNuCPaHrkXpmmT
 gfeva1rMJ4D+Emiqse/JW3Xb5rdd3QsD/RiJpQCDybrPlbcrwgd1UCXT3irEFqWpcusrxMzIwKR
 UfMnWqHPtMUozpFnk3w==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e908c0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=DEwMSQuYoAZka129e_kA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 1BrRTKrj7XgdjRr1W59-Tqnbs5E0j1T7
X-Proofpoint-ORIG-GUID: 1BrRTKrj7XgdjRr1W59-Tqnbs5E0j1T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171

The node pointer being assigned to the cooling device structure is an
action done by the thermal OF only and does not belong to the core
framework code. Move the node pointer assignation in the thermal OF
code. Consequently, the devm_thermal_of_cooling_device_register() can
call its non-devm version resulting in a more intuitive design of the
API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 1 -
 drivers/thermal/thermal_of.c   | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 113719466dc2..9c4081d58972 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1085,7 +1085,6 @@ __thermal_cooling_device_register(const char *type, void *devdata,
 
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
-	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 3ba8c970f11f..ee9776d0e5be 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -537,6 +537,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 	if (IS_ERR(cdev))
 		return cdev;
 
+	cdev->np = np;
 	thermal_cooling_device_init_complete(cdev);
 
 	return cdev;
@@ -578,7 +579,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
+	tcd = thermal_of_cooling_device_register(np, type, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
-- 
2.43.0

