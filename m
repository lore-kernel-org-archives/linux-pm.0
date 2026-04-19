Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3212EA172
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622957; cv=none; b=dnNmIoKsZr783We7IOyAcAg/B6V9IZ1ApP8/jTqYqyOQmTxUf77ngSDiC4eP60OmWzVEWQl5D+gDcIUxLN+yZWk753W4bzkgWHGAEBjMcS/loOXKlbYt5Wa+K5RyTv7JvQ60T28FYh5+5PFiq7jIPQjxxXP2z0ajZsjmpQ7ZMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622957; c=relaxed/simple;
	bh=93FmgykKd8+qRl6ufmaaI17F7IwkgOHYC9wLgW4PJIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjlOx/RFbtXV6Vy2gkjBiBO/PtDLS1JsvdD1uELyGPhJNFRl8Ulo4v0Ku6BjsfL7WkKmguNzhPr9DWDCgWPvWqws8s4T7yihnUcC5p7RccZgki5hS9B0koy/E8r80ieeR7345hxFiBLS884cZQfu+/53TD7z+Y8nwIBjEEVrZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxZ4ofnD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJSX7528; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxZ4ofnD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJSX7528"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J0U0Pk2910451
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bkLm1BqrU8B
	KmcLy7fB7L57UurxPvjVKbXp3ftbX+pg=; b=GxZ4ofnDylEpw1CGNXRFu3vEpbv
	ZBJ/NFOWuQRz3ZcmgmZ/NO3ZRBOu9l3GQjjfNOeuY3PvzXMe9qKmxgi+wgtSHwhj
	ljLaDqsUmEsPRBLrTJjiVmWOEb65c3VSKLROFaLtyBFOzOerlbto9jHvCaz79s8z
	b/vqfiLkJvadgLlWNrCWoLlk3yNm6JAF5JIDm+pJnV3PJAFz9RRlyV/spmj/WgSy
	e+WACatg+LooFXk+3NqpHK3nbTbYnJDYF0SjompwzyfqEnjrB5uEoVYN8rwJwNfP
	Lw9VAPtG21uXK3PQTr17NvriwzFPPDncg+8RdQRs6p6siMhC7GdKa3u7DpA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b72y1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d63962d83so15742381cf.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622954; x=1777227754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkLm1BqrU8BKmcLy7fB7L57UurxPvjVKbXp3ftbX+pg=;
        b=aJSX7528ZDTFbaWOlnqLvWkBpvnXtlnce3M8+BB/PRyVDPeb5EO+qZO9hvbuGL3Ty5
         9KNwrwvZwBq7JedE5m76N1qxNdxPZN6spMW+x2hAW+gA/0AxpW4QqdFgZ32TRHYNdfu7
         j+66uq4O0lsMSvfXPGgVV3g6thY60wKXs9SW12ldECvNnvBJMgBqdB7lv4/blyYP6KRP
         uE//YAZIYaEGzjJNpSzeqjbiLT9H3LTA2mjb8xknN56sqivKXbfzjESMIoLrGXdNbJ5r
         lG1FFwSTqdjIESmtqmtjW8f3kQO5eENlGeyH7S2uK0gKsav9s33bLzzeMrgXrVBspKSu
         69uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622954; x=1777227754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkLm1BqrU8BKmcLy7fB7L57UurxPvjVKbXp3ftbX+pg=;
        b=rHwOdLtGI/751h1K1P2L0tbDeiMjIkVgz3hQhILx9rG20A4/5NmkhCKVgT1nWPQXyY
         0Hk8DwG/RrHLE+d5KCdmEffTO1HOjTbAo7upNHKPEbYw01jJsJN9FIKhVZWQKa0MzrmX
         ykTiqBf+IFDozo4hQoe3Z72HNTkD6njbI9KHddZj6F3VY1y9HSEFdvnMTLkCiY6OtLWs
         A2eBriJdgaUi3UNLUjpqYHAQSIIK4N+HMZkeTxJRqxaZIY2UkZD2PybvLcbkvCrfAI2l
         69TVNvee/cfTCw+nex9O7W4Jqn6hqfl/7KSS0Pg32Mq+KCzMzUQ6ZwmHfeywKobEujLz
         S9QQ==
X-Forwarded-Encrypted: i=1; AFNElJ9A/ZX77DZMZtAfDEtenBzZHB7jADFy5Y3TYMwhxbRsyEaBz6quJR/kafLPJhuDPIZ7/AcW1Gc1cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+QlrqIczUOJPoyqLISLxR+VlvQHobjLJwidHwrjjf/SE11Ma
	0pYGedxavVE9MdFhXyZMn51lwuClbtL/R8akVjxj+Azb/nVAM+eQQ6edLpnLCtw//qKS2nv2+0Y
	C8osYwPXVgZPzv/oElKf26OslUZtIpTTbc614i9FmlRnAQCF9Zm0/Mf1ezCvu2A==
X-Gm-Gg: AeBDieu0HF5a/CRm/bQtQg3Zd7cVYduwkCOLFcN4j5atwI1vhAxJfYTII8/bU7kLUgp
	AEB8jTBQG3/n18twQJV1qVu1KM0C9bDEWeXFdgcngYsbXA4AAZUr8Men+Fwsdj6r9mU+eqKneXy
	noTxHkvaZ1btlxbaduZlWjNe2HEE2xd8qCkOoQTRAtY7dy1klSjjgVXLx6TNWBsyiyvEHngKfFc
	186b1ccsJoDJzrYxDnys+QF29EHlScm3xmFFNu44cZx497y9Ru75PrwgPIbIjaHY1BAY1PGLT+t
	mXof10/hM2cithDZJEPuhBXYkaAfYS2baEOQ3UfagP52ycS+bD6fn1dDdUJhq1X0LrVGrJq4exv
	Rdaftd2l4XyzNhaFYwFWUsTpryrVaZ50/MwBOvG9G2V7Ppfei3xXGCnPRsuHx
X-Received: by 2002:a05:622a:429b:b0:50d:8049:2f22 with SMTP id d75a77b69052e-50e36b865f5mr151261811cf.3.1776622954601;
        Sun, 19 Apr 2026 11:22:34 -0700 (PDT)
X-Received: by 2002:a05:622a:429b:b0:50d:8049:2f22 with SMTP id d75a77b69052e-50e36b865f5mr151261391cf.3.1776622954210;
        Sun, 19 Apr 2026 11:22:34 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:33 -0700 (PDT)
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
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v1 02/14] thermal/driver/tegra/soctherm: Use devm_ variant when registering a cooling device
Date: Sun, 19 Apr 2026 20:21:46 +0200
Message-ID: <20260419182203.4083985-3-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e51d6b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=B_SRH86IfCqB-oTSwgEA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX1Y0rsrtZs8j8
 6oFiW//tt4s399Nc0GqgqVliY1nA3bYnG/5i3lEe26yQ3R0kVO83+eydUyuw+pHM2/Pr5jE7a6G
 JOZz1pl+RIXuqIA5ELu6I49wg9fj+Zg+3eKLnVUgkEZf36W8vfcaY59cL7vdbPYmHfFznxoxNMk
 Eg/NH2zNo2FKGejBPFnjxCf/25DfiLE7RxB/Skch08CHs9RYrbca9meqbMmYr7kwoWFDfD93CEi
 YimZKWk1QmUCD1ODxXjOSzfzsujxgzrdiYQLXik9f+wONqSWKmcoqPL5vpZpY4JynY2JlyhpIJ0
 ScK3dVLytewp6Lu/aFlbOURrsoMGo6qdN5LxYIftciUoHBpONKxUfkj2qreowm2z+iNilhGHBum
 vAldGII3Lq2b5gM96jHJDDZ9ar2ZkiTOhvzSQFeLAcbDgErhIGqK9QF5cmpNOBMDdLdhk0vYT5e
 crE5a4kVM6/I+ewx2qg==
X-Proofpoint-GUID: cgIuEKUoCK7fvyU2kesTnjr6lgMaHK1t
X-Proofpoint-ORIG-GUID: cgIuEKUoCK7fvyU2kesTnjr6lgMaHK1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

The driver invokes thermal_of_cooling_device_register() at probe time
but without unregistering it at remove time.

As we have a devm_ variant, use it and the cooling device should be
automatically removed.

Compiled-tested only.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/tegra/soctherm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 5d26b52beaba..9d3eb3be2db0 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1700,9 +1700,9 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			stc->init = true;
 		} else {
 
-			tcd = thermal_of_cooling_device_register(np_stcc,
-							 (char *)name, ts,
-							 &throt_cooling_ops);
+			tcd = devm_thermal_of_cooling_device_register(dev, np_stcc,
+								      (char *)name, ts,
+								      &throt_cooling_ops);
 			if (IS_ERR_OR_NULL(tcd)) {
 				dev_err(dev,
 					"throttle-cfg: %s: failed to register cooling device\n",
-- 
2.43.0

