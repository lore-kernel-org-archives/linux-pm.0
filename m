Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C573FFABC
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479288; cv=none; b=Swe6qelr9XJ/qQ98XkD9GhYofHzr4kxlVxLKT4yQh3fyLbL1UmBUAfgl36NWk+4PbHUKR2NNjerDH1Nw/MpTuY5G3havme/9fEcA8roxWLX4LHmgGyhINuKL9SfKAmqI02k2SfbjJnDQypde/YCE/8mGTUoisIDSB4R96CN0heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479288; c=relaxed/simple;
	bh=GMW15JQKvh68RISGmBmQhQtahGk5c0uHc5SrSpqibxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGFszzFXyPDx1muFqHKl8g1CvCtVJa/bqK70vGrerYp/V7m32qluoITjShmMEcNHO6bAwSrpRLmZ6l5PHZKCAp2p7mol2+11NAqyluplFThHoQcgwnyrBOmDvKiItdPc/AC5vvG0mnaawhqrsWRKHy9nIosZAFNn6/VmyR+XUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hu62zZRs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XhSfUpDT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hu62zZRs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XhSfUpDT"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFsCWG963253
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=knJvi0AtUY/
	Bcp4iZX+go0eWYlAuBgaLg+IAzj9hl5U=; b=Hu62zZRsSuI5mdtp2s46mby9gS2
	KSAkAKoaRT+bhvxTxekRT4klxPG4w4RTrvp78ZNOT2uir2IodOtTKpcZgK/zAtwJ
	+/IKmMvAnfrwBEu/GQKqVbA9zrz/iRvSjPGEB3dHGv7fr6dWMm/NG5E1uT1oOisc
	a3nQYQCoQBiRhvhkJk8b7zUi0/eVKw/LVmAWrZ6Yp2ln3RFtGmyFRh1OTLcjW6d6
	EsFlMSuwrC8XA2Q9MOAKR29nyw8LP7AOMOnVQ56ZiiSAzkRhm+NI8RRLqbyyPK2S
	qYXeFo/MkL5o4CswHlOZEmonv/x1nKIGIS3/zrwHV4B/wzs7xvdAyzj41NQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4v96h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:43 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56eecfd79e7so25414084e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479283; x=1778084083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knJvi0AtUY/Bcp4iZX+go0eWYlAuBgaLg+IAzj9hl5U=;
        b=XhSfUpDThCaO7LgdkyZ+juE15I+ZXKSmabJM9FUOw6ELfC+Zg9NeVZJjDPEOydeaxV
         x12H80crWANaD4bJgxSGnGbX6NfyZStzy9pfbysiOj71qaUvmIIo1IBl8s43s04JwTym
         phDZ9U41uSPxdYttxfrKR23NQ90Rtu/AFc+I11GeoiF8pAR0cimuB5GESGOVnn8w9dOr
         ZuGrqmHHiM3KrYCyB1ceBZkn0XjvpSsjoqMJ0rUUEipDFLinuIugCMGp7nYF3PmeqRbo
         IJxnuOKMZCvn1b0U+ze0LG+p3Dc0GeopKTBeKfxDI+1qTribe/x0ujx8mr8E7kGE9Xwi
         WZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479283; x=1778084083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knJvi0AtUY/Bcp4iZX+go0eWYlAuBgaLg+IAzj9hl5U=;
        b=OHUoJ1pGiX9D/Cg2koYmhyQBZmAO/jsEbwii3fM1BpxLZnCNnbG/De7GSL9r15vuSQ
         HuvflKob4QBXHKEBu6ISyt3YxmfixgVJEedYEA2j6hTp7M4FkZaqyKb1u4t7/3Wg4nuV
         kQivC4F3c5WfA3WELZX3tZozsBwl0/kunERKfAY0cbr/3WvK31hNZ2edf3JJuOlMn483
         JlVKMZC/hSljaqEAikYxh8zgofOGL3pFYYMb2YlvDYZU3je/OIq4JcqHsJ3I2glpWNr7
         L6S+XPNicoha4MRgKHtwufu9md8Xv5SsxO5xXe/IO7oXF+urg6+0ALgDMguD8t6PyfbH
         8+SQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PdVC2HODx+1ZctLMofSTUDHg8XELUs6C9uwgllp8o4rAG+ygF+JmajUu+Jrl3MdByY2dmjtMm0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMaqfxq/DuUDYNyDEjPTKpCNFcA/VWJ8VYU8VA05FZ6qvMpXr
	iKS/wNlWcl8AkExu2527GFkCzAJjIZw3xjFL8v7b6bgzxfDipUmUeyuM7wgBoF5bkHnqUmPvVMC
	bzAfSaLOazfQMaZj6dzLxCkXMAu110vVEts9aBHfecZe/2Pc9stBmLsnRAWVvhA==
X-Gm-Gg: AeBDiesOmxJsrzutKA0fepHNEGm2lSw2iG1HZ6T41EYOS+mF6wxT75OldD7ITUa/G8O
	c/Oi3aBdeLcCBkLvIrpAlxisoBegTjC8rfp1dxENGruKGb/Rbgn8GZ4qLqJLgPnLNv/kaHLtXx9
	I7dWGPInvh7uUY18qitP7rE2KoymRoLgV8EkWmfOvasRkz7xjOeKhQiATe/182Lm1WktxQqiwKu
	XpKiW2sB9BGtE1Rg2icNeorS/zJa8t7yrfUudH07rDSg4tsf40sOnUyGymhC0Yk3pk7Fmc28Yvy
	GFYRAxWJn8CP35hEuaKB+pr/nF3yOgFZl3g5UL2NCGmuKn9p8MhwQZnsqEkqwzWTYK/h/dit0iQ
	SBtrYFbw/uwTh5EiAGYxgI2Bjg9TUnG31ZKJed/Pe6dhu9UjDDEwYIIyAgNGa
X-Received: by 2002:a05:6122:179b:b0:56a:ef51:4cae with SMTP id 71dfb90a1353d-573b348ac72mr2720530e0c.4.1777479282946;
        Wed, 29 Apr 2026 09:14:42 -0700 (PDT)
X-Received: by 2002:a05:6122:179b:b0:56a:ef51:4cae with SMTP id 71dfb90a1353d-573b348ac72mr2720438e0c.4.1777479282359;
        Wed, 29 Apr 2026 09:14:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:41 -0700 (PDT)
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
Subject: [PATCH v3 02/11] thermal/core: Add a non-OF registering function
Date: Wed, 29 Apr 2026 18:14:15 +0200
Message-ID: <20260429161430.3802970-3-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfX8LD5izuV9g3S
 1FZS/VA68oEXmH3Q00vMBvpLWOZvtHrv9FqkQf1Jwci/bCoJyFTltVOoFCiogCs/4BbN6KDyY2V
 p/KC69zEvIaWIRMyfuUTq4SO25n4djGaQOUorvuXSzI/OzG6ePu3dsjIuNgG3GJ8KplPScI9/kt
 VCFJOqBETEOqvmUG+JrIJ99BBICMejgiByo5sPJa/gJ5zt8Y7vXjk8gv+65Pc7IK0Wbd501vIhp
 FU7MtL8S6/7rZF0z8n+EiB9n5TcIGQ7kB6DodJWUIB8roSM06KLkWJSR+1KzqQw5rSitWLfWzhN
 6+KAuD9kZtC4GnW6HhXSGpAmEeAllHRSL0yEXtFDNGQEuCz2s7xDqDmytamHAFfJTbQ+TNFs9/i
 lEeBEw6/sGw58WI4z0bwjLGBJZDzHBTMrd3b/VZEhytElKH/lJQCUHoZ2nG3lqpmEKtLMeCW7lw
 4xeB/FuSoGNAmHkZrMw==
X-Proofpoint-GUID: NfxNW4huiOQpp0RGkFoAO4p4HL2WpK-V
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f22e73 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=AEQiIq00j7-0rvc0-mQA:9
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: NfxNW4huiOQpp0RGkFoAO4p4HL2WpK-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290162

In order to propose an alternative to non OF code registering a
cooling device, provide functions which are not for OF code. That sets
the scene for OF and non-OF code split.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 35 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        | 16 ++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 664a4cc95199..5c954bcae4a4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1194,6 +1194,41 @@ static void thermal_cooling_device_release(void *data)
 	thermal_cooling_device_unregister(cdev);
 }
 
+/**
+ * devm_thermal_cooling_device_register() - register a thermal cooling device
+ * @dev:       a valid struct device pointer of a sensor device.
+ * @type:      the thermal cooling device type.
+ * @devdata:   device private data.
+ * @ops:       standard thermal cooling devices callbacks.
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
+devm_thermal_cooling_device_register(struct device *dev,
+				     const char *type, void *devdata,
+				     const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device *cdev;
+	int ret;
+
+	cdev = __thermal_cooling_device_register(NULL, type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	ret = devm_add_action_or_reset(dev, thermal_cooling_device_release, cdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return cdev;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_cooling_device_register);
+
 /**
  * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
  *					       device
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0ddc77aeeca2..50b43e328ab9 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -253,8 +253,12 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
-				   const struct thermal_cooling_device_ops *);
+devm_thermal_cooling_device_register(struct device *dev, const char *type,
+				     void *devdata, const struct thermal_cooling_device_ops *ops);
+
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np, const char *type,
+				   void *devdata, const struct thermal_cooling_device_ops *ops);
 struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
@@ -304,6 +308,14 @@ static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
+
+static inline struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type,
+				     void *devdata, const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
 	const char *type, void *devdata,
-- 
2.43.0

