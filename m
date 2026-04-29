Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBA3FE370
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479286; cv=none; b=imLEfAB5/f3/0+LmCdiJ6fE66MjxIIRTFEMhBmrEdLnFrN+e6Zya2Ll0a/Mxj0zIqcv92wp9BTuS18F09x/L/7oss9aIcXI102l++4AX/a0lFF2kf8OZoj7n3um5Kreg8h0nRTZkEVVz+VhY8q9Ow7pVjwzOULg3LMsIqi5+NaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479286; c=relaxed/simple;
	bh=IU2MCLywi7WPT9xemBFBEzKAZ9qlZTenQAWiYNvqPD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE0qCXqWrwyG3bmrKjvV5vDcqw30iOK/y2+Grmbzss0NaO7wk9dxbdFgSmbpOQKZS0Da+rePNe9NvrI2QRkx4dGYUkt7/lgpQccA0woe3RKGAndq9fbOvZihAZ+uSCqGO/oUVscMBfr9+0T6ry8Vh9i1GcxsbhOzS+tvgA5LeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wg60DPxX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUVGMw23; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wg60DPxX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUVGMw23"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCefWI317338
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gE6qfjz1c35
	S/sZOZiWzimGIx9b4T9mf/ksJNqxGO8c=; b=Wg60DPxXjSAuM0xqDSJNRrs8fuI
	VBTChIjBqaPhfeXfwtFd+GpP4TPnPvRwpeOslCFT/qB09q8LxoPRv6p097pZ116U
	VWJPgu2n1/DgXnOBQilB7fmEoNN/vakrXAChmmLFVQT7SY4vrNyatiX8wEBA9RYj
	laga3simhD3ZpMXHkZkfeumwWnsUketlLtsAzaTjS/X/IFE54j9T5uocsERfapZy
	imtJkwfPG3IuSWUsqsDW5yPqvG6fgcACxqGQe7mrjRg0MGITpjALKr9fjQgbDY1o
	zCZ6/a8Z2UbHLg/bdaxUjXjjGE/yLlLkwIj77CxfqhCYe84ImhrMzozLuhA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duj6t8u02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:41 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f58148c0fso9400966e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479281; x=1778084081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE6qfjz1c35S/sZOZiWzimGIx9b4T9mf/ksJNqxGO8c=;
        b=JUVGMw23gXiSu2pbxihNendDX/9SOrlKu0P5cFpsUbdTaODVCy0vNPYLyr5tR1gKSs
         c2D+FMt8Eo0cJ3eK91DlQccZ3t5KaqYe4DOO/MAiIZ2ApYDp0X0l3Cgd5znbMjClMCDV
         vdwa5E5u1lLtbFxwCRICLaHSYqKqqQlJsE+1qnTSVMcJOJtvx3jrRxzKKb4KViMcYKx3
         kX2zd6H7rXpJVnJpz1XMlYbApYmpjcE8933/UDyrC4j6zlTkO1SZOuidnIi5A94OXCCp
         EdM2vDAk3pmOysVHQ5fPt/gdB64YoCiTVWj2lmy3o+NqQsDetw5Usr2fXlrYPZrsNpx3
         QrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479281; x=1778084081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gE6qfjz1c35S/sZOZiWzimGIx9b4T9mf/ksJNqxGO8c=;
        b=VhbLQoWyjd2lGC2rxT0v2fTqIUTnWtMB1qVmYMfJmoZky/oRU9fk3gWZ1zOn6tZmjw
         vR3XlcZXkUyScoBG75CPhVqGTYSKIcZiw09O3EikvH6j9t+cfrJSFuItnjxGZOnXsNSV
         bG6SXtzGKFOLLGeprxOF55ygLRQD8JwwCnY547JeUHrbzcbKSMf2HxOUgNV34b/Z6HMk
         HNEY4vAp/pHVwTAK17x8tgW2OsOUfPYo3Kxy97LINrf4nvZy0eHUbasDuqbeepBN8LNW
         cqHYiu/5or3qjeZVJcK/r5elvBSyfRuI2gpIPSm+ydJ/nsglMdNQtPQJnK1aZvNtiA9X
         LZbw==
X-Forwarded-Encrypted: i=1; AFNElJ/tC637AgjptK4BWgNux16cXnN2f4v5jzc9bVh9bCdvz52s1CDdDL8FXB6gWcBVGfmq20QDs0GIxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtacBf916/2jK5mLK/kZn7jOhOV17vdv9ur1J7y63BXdhZ0bT
	OVidTtJdzvqUgstrBR3fxJVB78molLhYDajgUL0xuVZcCzbBTCJ4+FkiIZUDkrM02OrOVbUkoRx
	AniGa00y7iJ5w4Wl5UBPpoOA1cEUz2MOXpz8jaOWnqhdd8LRAtZrOqIFxsM+fFA==
X-Gm-Gg: AeBDieso8ilRMUov+VBMgiPJLRzhEEKvWqi3GSw8P0lZVv+gs66jnv8ROktni/65CTf
	Fn6mITUNAYV/1nGYfHnb32UvFIEwtinY170+FGycqTCwAg753PeTrdwPaM6x/ICST3sc5YMUxLl
	T/tZrkMG7zIWwS+DBkKTXJRkd7wUrL1inl/Vr8yfr54Fjk6KFyFneNy3NjcQbKppma3va47z9QX
	GLtCrr4+OzkPdUo5llwRGks43uiAsmyEO8VIkaxM0/E70qNXevPedPmNufSdlHDCli/YyeZvEyH
	DND9/uvzwZoCWigwEeI2Q8xt1zb2ucR4gFnQeqYcnDV6MkCIATPjB04xdbeKCQkOBus7K0or013
	p7B37y42kc/39J9KOTKSlC5pqAJ8KsLudTqVN9PLbZwNH2r0nBi2pmvo6fHgp
X-Received: by 2002:a05:6122:4f9f:b0:56e:f876:5626 with SMTP id 71dfb90a1353d-573a556f6d0mr4627307e0c.5.1777479280761;
        Wed, 29 Apr 2026 09:14:40 -0700 (PDT)
X-Received: by 2002:a05:6122:4f9f:b0:56e:f876:5626 with SMTP id 71dfb90a1353d-573a556f6d0mr4627240e0c.5.1777479280360;
        Wed, 29 Apr 2026 09:14:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:39 -0700 (PDT)
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
Subject: [PATCH v3 01/11] thermal/core: Use devm_add_action_or_reset() when registering a cooling device
Date: Wed, 29 Apr 2026 18:14:14 +0200
Message-ID: <20260429161430.3802970-2-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: pyP4VAaS1Hdp7gMTDnguVfTZVWKoXHmb
X-Authority-Analysis: v=2.4 cv=KcHidwYD c=1 sm=1 tr=0 ts=69f22e71 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=99rag_Q9uAacP-dHLx0A:9
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: pyP4VAaS1Hdp7gMTDnguVfTZVWKoXHmb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MyBTYWx0ZWRfX8HqIWFl5v/3h
 EZ/481C85i41AICdQKEQMwGBf1fkJHGToS4x70rnD7Vi19SPsZ4Zdu978EPCZmHDim5xxcepxI7
 LaCsxY+OJ6rRdYAfC7enwZCro2msur/kprCIPyWcUan1HhpffvBsyccpIMS041G31mvBUwBT1aT
 hX42OxFxkZeY+QlZzTa7Lp7I9u06ABEbhFJqIM1A13+wzUYjScwHYLwnFdqoEErqu5lXkqbiv89
 lUXNWNHK1cCpKzlja6wAEUCIa8QupCiClnaepi1qlPMKzY6x1Acy856ehendauE4e6WsLjlarEU
 4mjIUobrz5ulxXdMvx4a7Crwld1UOmsh89e9z/d7wL0fCubIp5Tyx85VycvOjTLoJhYiNVPoXOs
 yJnAA+XvGSo5/RLtDDnNYfXckFyLD3GOVL5o4ivxoVvNKg26ZVzpHqLgonfn/t7Smvh2zqYknRB
 G94TDnnOuKrucetvgNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290163

Use devm_add_action_or_reset() which does the replaced code. It
results in a simpler and more concise code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f4e2dc46b8f..664a4cc95199 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1187,10 +1187,11 @@ thermal_of_cooling_device_register(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
-static void thermal_cooling_device_release(struct device *dev, void *res)
+static void thermal_cooling_device_release(void *data)
 {
-	thermal_cooling_device_unregister(
-				*(struct thermal_cooling_device **)res);
+	struct thermal_cooling_device *cdev = data;
+
+	thermal_cooling_device_unregister(cdev);
 }
 
 /**
@@ -1216,23 +1217,18 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 				const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
-	struct thermal_cooling_device **ptr, *tcd;
+	struct thermal_cooling_device *cdev;
+	int ret;
 
-	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	cdev = __thermal_cooling_device_register(np, type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
 
-	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
-	if (IS_ERR(tcd)) {
-		devres_free(ptr);
-		return tcd;
-	}
-
-	*ptr = tcd;
-	devres_add(dev, ptr);
+	ret = devm_add_action_or_reset(dev, thermal_cooling_device_release, cdev);
+	if (ret)
+		return ERR_PTR(ret);
 
-	return tcd;
+	return cdev;
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
 
-- 
2.43.0

