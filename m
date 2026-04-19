Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A12EA172
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622974; cv=none; b=b9cVPaxE2+7Kp8iMlNd1/bS2VzbhV5+YdEU1LYl9vZ3w+EA56TPfRJnxcuxbznvGuFyK7rIDwLnch89UFFqjhO9z5lJ4kMLv5JqVIh/sTNHsm12x0TUKFYuEq+Owo8sA8XpmULn9vXIMCa7deMtDC/PLCkMpz2ryn3BgPbMZ1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622974; c=relaxed/simple;
	bh=+x9c9NXuRa5b02u2PWhWcGBzOOAZ9xf2sJMC+EoLd2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdUT98xNOeWAAzzG3VtNLPT9JXoznUFlscoOS1upW5HMQjsdOU4QY8dpVB+w9uNAbxibwOdYTZQmKAG+4Uq6as1hlfTXqgYA+0tMwmFtc+ms6Tz4UcgMt5tyy+FmO6iD0dJfvaKqxtkkSd01Uhk2npQ506zG7iKVL1QJKtxprHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwD1Tyb+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NJ/gJONP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwD1Tyb+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NJ/gJONP"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J1ANbq2990443
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lO8B9/Q2g6C
	ekw4Z+jMGvtIbLlF84pmBrYJu05mJ+9E=; b=JwD1Tyb+BwQ7FAk2LDV+ceBz1T9
	TZOX0HAjW2onU8WkhUmGt1mGJ6JapPn0U+qkaJMqXst5n6cfnRe3wgdVhXztrTJM
	ZJZ/KVOlx+h9UYpRO9BRwpn7tdomK0bQkS3Gfj88x2WkPtSodImNo4/OLPM6YHG9
	tfrRkya4KGJvZLl1qAsR+/HaK3j0+S1fnPJf9pqFdd32biMAVi3i3LIrYzSY5hN1
	vKEEzJ8xiRLLSlUOHFyKGqf3vm1k2B1aCFp19eSPecAfMl/ATfGUVj4CZYq/uUqR
	uy6+13eYyRzTkOW+tE50BRAsuAP9ELSehUgogTzpwXad2CJC2fAWykONcdA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b72y3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e5ca8ffe7so3549281cf.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622969; x=1777227769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO8B9/Q2g6Cekw4Z+jMGvtIbLlF84pmBrYJu05mJ+9E=;
        b=NJ/gJONPg1veKS/k/Vq+pdYlTM75qHsQ5hyDBGcCCQzyPrUBl47RR/APWloc0KQg1y
         A7qa3UvVIIHdpLlewTQ1nKXgXssRsArZcfuv1PnDt9Ta3FSpDfgMwwEe3L2zm+QA1v4d
         ht7RuNlu0kjU0Qnic3X7GOb5Cihmd2Okemb6Pr1l/3ki6iaoqBtZgU99IT8frslie38y
         wm6wDTPPNbAvJz+ElIBw0yRQaeIpVQ/0P4f9oF3r6OW8Mxd1AWPUYfeUrr1EHi4xv0qO
         KjgE7iO0Iha6JGjYzDnTAyaWYpcHURbQ84g+jjktkDGOuFZyP7PicnCUBfyCqjGGvoXk
         ougA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622969; x=1777227769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lO8B9/Q2g6Cekw4Z+jMGvtIbLlF84pmBrYJu05mJ+9E=;
        b=OwkuXaJLDNWCUTfHOMvMcSqPhp7E0PS7l2927e9PVO5O9OVJW936T1i3JYfLTqIZLO
         ZGSp66MD0hndSPma11WzbkefZaaPSz+zyLOmnjC1rRdBdDz8/dcR7TrDG60wBe6uzIfI
         segW9BIXxe0eb6dXafxADY7c6kuhkMjEavJuI36YPmxF4J0QjOOxSnmb+GkSLRh0QVH1
         onHYdzgsj06AM1r25yXaXb02favjmmxa8Sq9EvzcqazdYx5YDGl+OE6Y9HawY1wm87vG
         9CoFVsc1C73Q2eqokehZ8bB3h3nuYHuLFmz0d6zQEeSe/raoamRBdVSVAU9jNFFpN4HG
         9SKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gqwwQoWwIuHhK6jMLRmdZrR796lhAitJY2luUpHeaLKMlqrD72yRQKTtB5IvXGenxPUmBipgdig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdMGG4H+qvWAeDTlA9bIKKB9CTbt+GY7XSZniMitb8NVTheDQ
	B8upnOx7iPB04/+OVLGcZy+YQDoHJa7vpB7Qn2UD3X7ksxUpRNOuvt0cwT6NQckWpziPl5dxh6U
	eRN7tGCPdy9PNKFNy915MAsBa2k6TxnBO4nUF6Z5gHh8PhxMwqpsA+j84ZbaoYw==
X-Gm-Gg: AeBDietFS04oznWrtlHQHEFZwN8vDZE5tZJokirGaG/xeJq7d3SWr8ZkdDpJecAps+d
	Wne1RGgr4klOz5DI88kgcUV1FHPUqkmsYPCwvBkr4KM7Ypw6tey1O/mPUcYeDn8UFzbbhqNiYbN
	/8Pd1EJhXcvSXDtjIXetpO9UhX2W/OU/5/OhyVJMgxcFx5Belisy6ncvazPNR6M/z/D3LWavbM+
	MKAJAqtMVa+bBgu5/fAgHjF/y4uvkCutZJdYVFkHqYWZjI4Ic/Jd3Q0tGYN3fQyq046DSitZnQO
	n3ORPmFIuET9Xf2tNJa2iCyUG0RASxEO0mHjs7xzfW+6RTEIbcwlgkGhZ3oS6VdVjU+tiX9Kb62
	YVEiw3EYcbFlTLPL5QuBKfDDLJjuAYP94UAW0kYp8AoBAmUozvhl20Y5OUdai
X-Received: by 2002:a05:622a:4cc4:b0:50d:8389:c3f4 with SMTP id d75a77b69052e-50e36c78259mr168044081cf.55.1776622968492;
        Sun, 19 Apr 2026 11:22:48 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc4:b0:50d:8389:c3f4 with SMTP id d75a77b69052e-50e36c78259mr168043551cf.55.1776622968086;
        Sun, 19 Apr 2026 11:22:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:47 -0700 (PDT)
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
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v1 09/14] thermal/core: Put of_node field cooling device structure under Kconfig option
Date: Sun, 19 Apr 2026 20:21:53 +0200
Message-ID: <20260419182203.4083985-10-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e51d79 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=5aU8Z_IAf-MFAndoPNkA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX4BOkTPFo9zTx
 gMDk/scI51XoHxZ/q5g3JQtv17YNDNl/Uu4lcx5USueZmXqWZBvOxZo+C2emgBUcAJXu9qQwrSK
 CnRCRwkOFXoQjdgK6Ap4KLGHuaX1IM5NveWEtcSVYBtkDOr7vdDSk8YQgMerCyjoHVITaZV6DYA
 9cXa1S16ijZ/u7MGgP8Ot3ZyIAGNG12BKv4Q5xD9JogrzxJo28eUCh1r9gF8fEX9TGc365X2/Mx
 fNnidj1GtSJq1rFb86fzNYZUSle+hLT9lTQWzYP8luM3RAquUflhI6Ah8yEJQmaglRa/g09gsd+
 CjhYOoRJDb47XBCEixLKXuZ4M99e0tZDHWWcEAlkUWMhx+7NWm0ZIDts/bPVWr3t+xRHmnFhCYt
 F2x51CaICKxmfxnJGH1PdPal5TLGzo8Nlldcf76o7pTsG/3N2KlkTzK1Np2hs/+U5MB4hboMbvu
 e/d+EHwwLN43c6hQiqw==
X-Proofpoint-GUID: bRhddvirzZ4at_V6nfwHwlV62xrmtSVm
X-Proofpoint-ORIG-GUID: bRhddvirzZ4at_V6nfwHwlV62xrmtSVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

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
index f7b8651c1ed0..a8e870ca2e27 100644
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

