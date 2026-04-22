Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC453932DC
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879812; cv=none; b=AnyPLFRU5lW5iKZe92OgdZXMUh3aMPchGT//sAYoBsDIYwuX2QpWW2ErEqXa1P3fnDkDRvOTkZFOHv8w9P5Psjger+Fs9C09s34OEBxzoLqz8k/ky9X4IMwIbFi0/vG/R8L9i4gigAFC3azPybegcKE/DFSPEFG62L72kskmjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879812; c=relaxed/simple;
	bh=j+dZZjvhX3/uWmfqgcfNW8B38xnfwi9TQ/BZm/YnRHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0SOurNMcpsxolHGFgN1br/hcjiT+2jeDIt2UtJkNcef32GGu8nQsQxn6fW9KtRLq6nwNbE4n/NLkrZnsS9ANJjr3lqZEvMGLbZrquSuJ+ouINLCl49r6wWFyRCGDxRBCm+b3CwJ16dwXOOpDtv5qwTmiiun9KvIzxK0EOpv704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bpw9HLF5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MI36/NnD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bpw9HLF5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MI36/NnD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MFagpQ664172
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QzXG7s0ro7q
	CMWOD8nEVlnf4H7DSkLvufeY3TSsikco=; b=bpw9HLF5c+cnx3KqIgepiGc/Ugt
	RYsO3AcAmr/xeHdHvtpjc3pcq7KpuxDWzXxaSaL/VQCcSwYcwq5DVDEMvAD9P2Nl
	LRqEWfQo/t77fqiZjGHYLfRdKlN549wg8O/czZwhug0olhqGzwHiu7yG2gDxDWrh
	SC6oLDft6gxf0UXyHKzIeaMarZvawjxPKxvwZ4f+wHrOLuN+GA2FWcifOocl0Bvz
	/tHrISfLO2NY9dttgMzIkREus6/n19E8FZy357AUS5ZEEStPOir1xhT/TSrm3Jrm
	sAs70KMrTp/F0TjX/VYlbj10rIZ+3LlX6xbJRDehT0j2vYEu2zsupEtbJEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgsw0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fbc70cfbdso43681731cf.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776879809; x=1777484609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzXG7s0ro7qCMWOD8nEVlnf4H7DSkLvufeY3TSsikco=;
        b=MI36/NnDjM+Of2G2VYVxsSLcRdvAumaMUh3okIZBczf87x7dZUdOTYKyU/+wNxXMYx
         oPSiTckQKY2LQaYHIv/SsZhccsiV+fuM+YwF7qavC3F99hluLp2WHAv/mxgAYU4WZWfg
         3sa3eF51O9z0N/fV8YlER31ZAQmSRnjmxDHgcpSVajHItr/pBhWUZUKYEAnkVvSA8D8M
         6dMXF0hHAn3vxAgwNuJNqmKM2lO1yykDmYf2uuWgmkRtiZo3JAdCqv8e04NYUQ3HKnS0
         8NXZxNZVKX+AcTQzMkVlqhfK2f75BVYMrUnI6IW7S+Uc0TQMsZybsSnx/+ZxNkPrSZcS
         NAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879809; x=1777484609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzXG7s0ro7qCMWOD8nEVlnf4H7DSkLvufeY3TSsikco=;
        b=lahKX0IKEgbNZJy6LJiWCkIawEdyLlkAoNmYid+H+PoLkdUIBs2qiXmq+0oy8GMzQh
         0cZT4pr93n68Nnrm6xNYjWf9HvhyZorejumox2vdtyYVY5TJ58KImbB0c+x96V/WZRfz
         HGV8qE1VciQvjJScvaEZvpgjVLCyWx1B/0ev4E5q3vBTlZ5UJbNIJ42XVL2YKp7sqG0U
         SlqXf0OQpBYVrxb6wSoPtx0po4p9FE1KLGZLnh0mzdzVk26u3Jioe20vQ+0h9d3XLjW2
         6fKtaQYT0rsiptMw7l6wMGC53HGms2VhCDDnSTZe+NEfxJb/6lteLsbyTP3TfhRV4BK/
         +pvg==
X-Forwarded-Encrypted: i=1; AFNElJ+cS7CcStadtDnXZwWcscI+vS76cCf8Psi+xymquwQ2cupSzKtzRyb/vua68werFBhB6qUi9ecqaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBuw+CJLgEjmGBSKfPx5m70fyWuW87NQ58o/oPm6k/mBw0m83
	4GwmXRmhUEu6WFg6IvA4vQn99bMQ2oLEZjDfKVnh13N0BpkEIDGnf1U/+TIZfbY0hQiDf63XG9v
	M62Wbv3H/ozA+i0RlCo2V6HFtA5uYwWQt9LtnFWXIN7836LHGy5TgwnkT/GTgeA==
X-Gm-Gg: AeBDievEVzT6toMfbwz5BWI2sws2H8c0QbrNJsXqOVbtIszuSKJN/OeppHUdvENQjeZ
	H/hirWXzTLyP9wJAd2Nqxxda/oT9CvkcT3dtIqyvmBzk6ldc2T4x3RiJyECm9M5CN3jlUZQJYEU
	mKRCIn9l2qrorcJRUKIfp99kS2bYOGWbawIKayuZ61t48aGk+S+9e/93V1g5EoG7ngs1PgoiEs2
	rUA/4CmTxiJ/hTmrdV1fAw7thQzDbq6wO3WFdvWOf7rikmXH7INQf+pSq7P/FkcboZ6IzyoLuS/
	9Gvmm02zMuTAEdupdF/DFPb+BeiiJbPwN/3/c9Os07Z/+3pXtxmqk2Z12y98fW5BT5sRhGDT9Hg
	GNmUWcsOkCNkGCbbVTZ8O9FDoF3OJNUuNrDy9P3cZ59K9SQ+Q0kIb3oDfqSUF
X-Received: by 2002:a05:622a:5808:b0:50f:c26d:f309 with SMTP id d75a77b69052e-50fc26e288dmr48528591cf.9.1776879809461;
        Wed, 22 Apr 2026 10:43:29 -0700 (PDT)
X-Received: by 2002:a05:622a:5808:b0:50f:c26d:f309 with SMTP id d75a77b69052e-50fc26e288dmr48527861cf.9.1776879808984;
        Wed, 22 Apr 2026 10:43:28 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:43:27 -0700 (PDT)
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
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC HARDWARE MONITORING)
Subject: [PATCH v2 06/12] hwmon:: Use non-OF thermal cooling device register function
Date: Wed, 22 Apr 2026 19:42:55 +0200
Message-ID: <20260422174305.2899095-7-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: IKFHnO0PRoZ5oXoAJfGBaYWvbmz4nV2J
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e908c2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=_jlGtV7tAAAA:8
 a=ggIEzLyBpZPC2L1Vao8A:9 a=uxP6HrT_eTzRwkO_Te1X:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-GUID: IKFHnO0PRoZ5oXoAJfGBaYWvbmz4nV2J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfXyzYbaU8WZVLQ
 690S8WUj4BHVqZOsralnUzg/+EfqjJm/1hHvSaaIrpQOAqgJitm3Vey4Tep3A6RAPCY7gsSm/Ta
 VOzmFrmczelfPoi5BLFHIJMkma9vKj+IXIYsKC0ofJ6t02c94Ai7UXAK2+KxOAIXzriJnn7kRiD
 cu6iR2C+adnjMJQbiNyzCOSui05bdSH3CGRjHF09bbbU4IEH2dYuZ3Xc1iBjYjYqd5umpuUhs3k
 G6M9IXzDUqbgOxgcVviKq3TO4PE/dzh5ACV2nim92mHmWcPmAhG4NJdtfPQ6AMx1p/GzzhCzQs2
 d5JKGfREDzjLpbz991gaSngEF4wDRZUxXYDdxphT7wF96diniOy0xhcgatlPZDokdJhr2Hb05C7
 9G14GrTg1hB9+WV2bDOvA2TOX7Etcr5W63Sa89BmJd1jBgaRC7tdYtobJ3zHHoFVmQRSGsq9UKw
 ZkNM4DJwGD6vA+tDE6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171

Make HWMON drivers which are not based on device tree to use the
corresponding non-OF functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/cros_ec_hwmon.c  | 4 ++--
 drivers/hwmon/dell-smm-hwmon.c | 4 ++--
 drivers/hwmon/mlxreg-fan.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 6cf5ab0f4b73..77dd9f28962d 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -532,8 +532,8 @@ static void cros_ec_hwmon_register_fan_cooling_devices(struct device *dev,
 
 		cpriv->hwmon_priv = priv;
 		cpriv->index = i;
-		cdev = devm_thermal_of_cooling_device_register(dev, NULL, type, cpriv,
-							       &cros_ec_thermal_cooling_ops);
+		cdev = devm_thermal_cooling_device_register(dev, type, cpriv,
+							    &cros_ec_thermal_cooling_ops);
 		if (IS_ERR(cdev)) {
 			dev_warn(dev, "failed to register fan %zu as a cooling device: %pe\n", i,
 				 cdev);
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 038edffc1ac7..47b373ea6db4 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1161,8 +1161,8 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
 	if (cdata) {
 		cdata->fan_num = fan_num;
 		cdata->data = data;
-		cdev = devm_thermal_of_cooling_device_register(dev, NULL, name, cdata,
-							       &dell_smm_cooling_ops);
+		cdev = devm_thermal_cooling_device_register(dev, name, cdata,
+							    &dell_smm_cooling_ops);
 		if (IS_ERR(cdev)) {
 			devm_kfree(dev, cdata);
 			ret = PTR_ERR(cdev);
diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index 137a90dd2075..860de6cfd8a4 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -583,8 +583,8 @@ static int mlxreg_fan_cooling_config(struct device *dev, struct mlxreg_fan *fan)
 		pwm->fan = fan;
 		/* Set minimal PWM speed. */
 		pwm->last_hwmon_state = MLXREG_FAN_PWM_DUTY2STATE(MLXREG_FAN_MIN_DUTY);
-		pwm->cdev = devm_thermal_of_cooling_device_register(dev, NULL, mlxreg_fan_name[i],
-								    pwm, &mlxreg_fan_cooling_ops);
+		pwm->cdev = devm_thermal_cooling_device_register(dev, mlxreg_fan_name[i],
+								 pwm, &mlxreg_fan_cooling_ops);
 		if (IS_ERR(pwm->cdev)) {
 			dev_err(dev, "Failed to register cooling device\n");
 			return PTR_ERR(pwm->cdev);
-- 
2.43.0

