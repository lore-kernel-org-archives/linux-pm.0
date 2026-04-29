Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F13FFACC
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479294; cv=none; b=pZqRhzPVtTpuCs+Sct9C97YLvfBOp+oWxFu8OCl2Ca5JgqTPBDr8KArxSvAxRCwpXBC1DTv9M79R8cnLW2DBSXT+9i5i9LpoqD2zzox3xcI/xaEW9Jo7BXF9+2qtKYiJyUQ4lyd6YuHWImQZVIkO7fJJhKNNUaCvpppTyUMLxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479294; c=relaxed/simple;
	bh=8Ds5xtxFWeweGbY4JmIoQElbN9Q78z7GjPvN5NTvYes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxHehByiAsnGkWmBXxS+7MRcG7kf1/BSLRIGzSrd7tfF27hMxAbj9gYQ7vNRJb9r5m6rcAx1vbsUgzShWff6bvaYOQ0Zz0WQQFC6LduD9pHgXS+Sp1FKn/sNKl9qYJzKO3sMGSrIAZ44FI8M5gpD2s9ZEO0tstOa8r0nZZtmBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oytIFMrS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ze9wlkyY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oytIFMrS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ze9wlkyY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TEteFS3752354
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=90AIa8NaCz+
	zkROO+2dxfNcs3zR8w2E4Z25myBlHOTA=; b=oytIFMrSelK7QEh/l986iwfINGm
	MA1VkwAQSTaH/BTsYOsIlL8q/l+85jXhcj2RraZNJi6KLNK7DkUiACr937R9zZ6D
	q+V8SE5O2a0LuxJ/++k7TPJBmQr/FX7uFCukmoHF1Eponp9XSJ+R8DjGHjn38LVx
	VcD1VGooUX26g40jjPZIkHt0SX7c/9zKf13CE8elfbCxor6iECQNem+U7aGTxaNz
	B4dvf/fLf1MYnhWR3g6eQZxgtKW2VzKPedU2JdZBVL2I5jD1rg3D5APbXTmJ3Q6q
	RlpwxHsJBtYx86465WoIB54msZq7eOCunzjjU1MABDiAuoBg9/3RMGPCixw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1jdpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56db8ed8e40so11543086e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479288; x=1778084088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90AIa8NaCz+zkROO+2dxfNcs3zR8w2E4Z25myBlHOTA=;
        b=Ze9wlkyYWnkXwztl8tGYO9PUX0DzvH7AFtkljcvdcXcl6KpBEyrJQyVKMOUBaPft56
         NHZ9NOl2DGXvqpM/EFQU+FZR2jIcQ7v0DklE6Lcwzc4WZqyRok5jGMZzjGLPFDjEe69c
         QIBHmFV8nSfklh3ciIlZLWq05aoc/cwwroW1oiGsEWM67z7zh4GF9TaZYuReidA28xLU
         Yctk3alZrLavJMITuZOWZNDUnqQiYfFJiFBe+SHxjASLeKuhxKuElRzPxx2hkyjIZFdp
         T4Dk4hQAtJ8zF7f8v98PINoO7ELGbTZ+FaRDu3LiXJYihzemErpsO/P6ixehOW6ekHiy
         ntgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479288; x=1778084088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90AIa8NaCz+zkROO+2dxfNcs3zR8w2E4Z25myBlHOTA=;
        b=lh9QCzpIQrZRNzl9glN+4iJag5mHCd+l9reOamIVR9Zbe/HqzA4E5Awvud453Vhmm3
         gz5OgUozSQjg+RmADP8c/eZ9xMDKbxyShBdJYFR6YUIH5XtfmZ0vwL/upZ4FMGU0bKAt
         V/f1kLYIzyXsRn5XpXoB1gZIhlgT7c24CmNQzR3Qn6AQHzgrol3KsuX2nGIWXfa47fNp
         8KzXBpE/3WIFYk7o1K3igO1PqqweBAV+k83u5/9yKVB38r2lOO158+DYcPklARuw10mv
         wLTt2lAn0cWkqB8d/EA9PhZlej44H0qgCR7ltfj0CTBi/vgcPtEhwDM5BsF0o4aFZOH9
         fEOA==
X-Forwarded-Encrypted: i=1; AFNElJ8mt6CgnmJaVWhuIlwSNtAnXHmKAAaUXW8cntHr2zCoe9TALBcLy4Y1cJaVaDsL3tpR7mwYjhgdVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJ6p6gYWcOmKBVt8WXRMCIQydCas2q8EvH6n/SQEVag9+ZRra
	oUqznUrig/F71VtxIN8+jbbqez9TE8MSF0HONavpAqv9y9ymPG+tjJLoVUHaju9xWn1YlXpdW28
	DelrJDKc1JmODPn06xr3AB/3smY0Qest45xKBfeeEgjJpHcRBlC8pOM1Lowl0fQ==
X-Gm-Gg: AeBDiet1rbnDSMoOClA698NZlHFDx42MA6xBpUisRyd1pfDZgBC8FjVJe3IiPZgs0aH
	xWAI6lw3kR0SlrKlWPpnM9NpWaeAvvhaRiqepqAY8onqkYT0iPbZRUVu7k2fGqbOX0+1RfhUp3d
	qEhvruuuBPIxedH2q4kCDPVPC/5iFL+l8gT5B4uCUinlCFO7Z/owUe2TNc7oB0B6fPfClnPeCQY
	RujNBYo7HWcjc72StUsdiJMY9duubLZQqSQlHJeFlHE+WmZcJZ5KaSLkYwWw6deB1zc1Ry7zD0O
	HsDAjrdFZvAN+VV9NoyGZgt7sZyM4fWXFYesdklzECK5Sowl9NS9mKaVcr04T13wh3AAgLQxSsz
	CVidJv9vEEqp9gThxpytOmeyB0a3Rgbw23MKgFNeqSD6lp5xOofBegC8qzsnH
X-Received: by 2002:a05:6122:3109:b0:56f:6d27:cadc with SMTP id 71dfb90a1353d-573a55d8ed8mr4558041e0c.7.1777479288511;
        Wed, 29 Apr 2026 09:14:48 -0700 (PDT)
X-Received: by 2002:a05:6122:3109:b0:56f:6d27:cadc with SMTP id 71dfb90a1353d-573a55d8ed8mr4557981e0c.7.1777479288067;
        Wed, 29 Apr 2026 09:14:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:47 -0700 (PDT)
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
Subject: [PATCH v3 05/11] thermal/core: Put of_node field cooling device structure under Kconfig option
Date: Wed, 29 Apr 2026 18:14:18 +0200
Message-ID: <20260429161430.3802970-6-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f22e79 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=5aU8Z_IAf-MFAndoPNkA:9
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfXzYlrIntPuhI9
 /JaK/Iw2sMQJH0yaX5RmrCnkwpWL0ogmcWLev2vs9Aw9pdZ+m2gwgpuuGVlGHgQlPVtVlu5x/Mr
 lkc3CowRftW1zyB3vQjiYWVFVVwrwQNEWj6q4p24WmXJ3Iq9V9eVoQhHifj/JYx5bMGLnkOtFYC
 AcTYaYEhatIIyuTY3EuW971k1SU/yFv37R2CSkRqSB+aZmtsRtK2V7GnPCGS9SYaBRTA0bE/uNB
 8hza5Ogton/9NseI5m262ZgtMbOQTwfgG1Q2wtOrvkONbLwOAJXgKhuFSg1rxWmrJ0xS+sosTmM
 zamiBEtyQ5Dzg+aHKXbEjx6l7RHJu0mEPx7luWZ8qOyphvFRGhEU+IggVct0v+PC/QRMgJBAcTh
 70b7pVhoykzlubAGTEv1Qs4Nv4F13RNEnNvaCWHoDJ/RMYNQ3hTknIujGyWSfn+487dzRWZs2wL
 0/bux7zcI72vojlbocg==
X-Proofpoint-GUID: 6CgcWiS42yqSGetQEdPBgoJ_0Slfoj8n
X-Proofpoint-ORIG-GUID: 6CgcWiS42yqSGetQEdPBgoJ_0Slfoj8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290162

The device node pointer in the cooling device structure is only needed
by the thermal OF in order to bind a thermal zone with a cooling
device. Now only the OF based drivers are using the thermal OF
functions and do not call the function with a NULL device_node
parameter as before. We can put this field under the CONFIG_THERMAL_OF
condition and make it go away if the device tree is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 include/linux/thermal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 50b43e328ab9..eff01fba0c81 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,7 +125,6 @@ struct thermal_cooling_device {
 	const char *type;
 	unsigned long max_state;
 	struct device device;
-	struct device_node *np;
 	void *devdata;
 	void *stats;
 	const struct thermal_cooling_device_ops *ops;
@@ -133,6 +132,9 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+#ifdef CONFIG_THERMAL_OF
+	struct device_node *np;
+#endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
-- 
2.43.0

