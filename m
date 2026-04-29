Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D736D9EC
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479293; cv=none; b=UyHwM+IbDjnH5kL5+8llK3zi895/SCPM/4cMlAEtNRdhD72S7le1yRkRJ7+ezHUR9EEmSau4X4/nLFjDAuPR9qsClK6vs6aZEBsrUDS87ZxOkII4LAeF9OOG6vk0Vh9LiYsJy/xMgYyBvPY/fsLi9NtodZrET38S9Z3INmCOdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479293; c=relaxed/simple;
	bh=j+dZZjvhX3/uWmfqgcfNW8B38xnfwi9TQ/BZm/YnRHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5CsS4HP37/wRM4soMiF4+8dOnQTzME1ofvqLdMD3oJm/TP3Kz5iDqkRZ7qxIkPegetICaetdgU98UEY9LhrNSX4V6g+r62cIPhP6gHBrdQ+AvWGaxY5mDN1eoVIYXfS3sc1zZa8F3SVFQyIiu+zroHQF1eOOf3utb4Y4fNP2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XzAoSMb9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=knCW1bVJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XzAoSMb9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="knCW1bVJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFE4ce1728556
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QzXG7s0ro7q
	CMWOD8nEVlnf4H7DSkLvufeY3TSsikco=; b=XzAoSMb94Jjx2djznZFI/GiHPzd
	0wpZslkvTKqC4BPh//sY/9WpNVsBGp0oPuKHEbotnnc6k0UYD/fHTfOuu54JNhu0
	lPpo2S1c2EFe7EK5QsyhN0NlJXCKdj6MZ0VON0KiIOh46xG5MN+QWzHBl7uEU3WR
	BlHj7KH2YT38M2YkTYO2LyfcgR81kQZF42xIX6WPewnd8dOPXvca3VIszrjbBVRn
	3VtfAeLClAoAz8MWBStYLSLZk9O/O0zoOJ9CMXt+dpYD5dbStbuyoRi1LVwnJhV8
	OQJSWjnIYFtB+I0U1wMPhBNgR93rI5rDKpTdFOuGqciqkCdtwVx7JjAAMog==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5ksw38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:47 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56eeff9a2e3so22070264e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479287; x=1778084087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzXG7s0ro7qCMWOD8nEVlnf4H7DSkLvufeY3TSsikco=;
        b=knCW1bVJ5vlV8ZV8bGUgxvBNLJlgU4ZxgkbC0qDap40gXVuojJeAnOE/mG1EO1TjeI
         /e7rV0oM+7/8WKZ7e5ct1Z59bc0Y3DcHtL52UNYUEUzVOaZBfkiUxYAmppjgMGkYboXN
         hHZwhtUAjZyu8xeGzhmpASVIUmKFOKBLtHBRtDgNBTQA3lNis60FKRas4DCkubDzpHin
         u1wD57/0aBT31XZBZ4Istu7SiUwg9xE8fbtknirHww4cFWhH6edQU/7lZgJdjElGWHqR
         roAW0nFAoSX/3fiM2uAPT/5nQQ5675ssP56R6uOpKJs0qjGdgOQgEhaWwuVFkVWtnSE/
         CQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479287; x=1778084087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzXG7s0ro7qCMWOD8nEVlnf4H7DSkLvufeY3TSsikco=;
        b=nS1KoenVTz2MN6JVCrVsj0bfm0q/1nT9Qa2d2n3nNeyJuGNXIEG9u9ojokegr0o1Fa
         rvsxh6UAMkbL0LS7FaOl2dXgda1UmikIw3KnP2FlRXFXXK7oJ8Hgl5w0ZFZ3A8gkhtqk
         07IQEJ6xaZswxMrzXRubH61vF1Oz4LduGHbvg6Nqn8aEi44ipkHaFPpvx87zxCoHEVDZ
         nYPS4gMs/SsnPVczCR1+F5Z8+X68kFGtXsCqrExxE6fgqe0v/bGm3GrTE8rqcsCVjZNe
         el8EnO0gvqsOOYRD0vW/69foSQCW/sEpDlSbwXySa1bhsyhiGgExW11H83seqqSmw2J9
         ONqw==
X-Forwarded-Encrypted: i=1; AFNElJ9gMXo7ktiQ51pIWAxjO2cT82XI1A6kCfOT8fElH0DtI20howSVYjlFiUtC10FtBFa3Cs7G4bX3cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAL4xiWaMa4RoP022V3B5EQj/uLKb5gvBwVNC5W+yfcONwGZj8
	RNjn+OYJa5T4bnPWhlLFkSUI8ls1BPfHqdPw1qrYfkCiWuKc+74JYUgF/JV2HwPbjhrkmjONVaz
	V1peUuF8rtL88F6ODTkUmEq0rIioheHNsk+9uTyTH9tJdIdoHPsrWsmAI4B+vEQ==
X-Gm-Gg: AeBDietq1CbEjkL3Nqg18csqpdYZxJyO/B9N24iBAdZ1wPIsdj9XWMWtNf0QqpPi44q
	z8WK54+eTcfJPbH5sv/cOxAVOOOSxKvXUcjDAQdeopWBaeNvg6M2P0TCuRUMwjgEmvLENtXtOjn
	uGZfD8/OyJMCBRXrMzyH/tBUOGSkdz1lneaRG7/zoi2CDVI/FAqIqAkWmAbFGRNmvg8GQexyjCd
	AIpz3grQ8qkQRdyKnc4xDzoPwDKdVnCzVLAVL/9mmdUR5BEVlYmzdjJt8rSN0sSmM7EFwOShIC9
	R32kY1iDGxD6hQmMtf1fr8Lq9QbFC3z0RreCPrh7CDCiEt/4OK3OC8E82JyotJGyjLLVX0WaB8m
	JnZHJzfSPPjUihWkjSoksbTiUCvjLNSw8NUyiM7LNutSomh2swmF+SE2+L8NQ
X-Received: by 2002:a05:6122:288c:b0:56f:1bbb:83d6 with SMTP id 71dfb90a1353d-573a566e5f1mr5070848e0c.10.1777479287077;
        Wed, 29 Apr 2026 09:14:47 -0700 (PDT)
X-Received: by 2002:a05:6122:288c:b0:56f:1bbb:83d6 with SMTP id 71dfb90a1353d-573a566e5f1mr5070740e0c.10.1777479286228;
        Wed, 29 Apr 2026 09:14:46 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:45 -0700 (PDT)
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
Subject: [PATCH v3 04/11] hwmon:: Use non-OF thermal cooling device register function
Date: Wed, 29 Apr 2026 18:14:17 +0200
Message-ID: <20260429161430.3802970-5-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfXyE+c4R6qgl0d
 WXPO+M6ihgyvp8QrzUQgdEJ+/lTCmxT1iXpE6BJ31GyX+W4QjINJOC8LzS3x6/xLVZIZtDqcSwK
 wybNKCgVqqdOTwznCl4Fmbhf/lnb1/KkocTdF8wHEq9IQOf4dCQN8rizE4kSgupjyvuVGBq9j5d
 feKcq5W+i3zFDs0T09Xrfz/WWy2MB4EtYRd29Qmow7BjzP7XJ4mgDX42WIyRHw5Yb7rI8lEkSZ6
 wjkK17NxiwlzqLNh8qzXwCyzZlzsFwuuOA9EodGGMTGSXwdy3Hf1JD0ZvnmR8WkVoF7VXiZ1Ssf
 S3u7KOPq89JsViMkHqGkOjQ53tfVyVl/frPiNIfv3x8aEnZDynFnLKoIqTi3Vloz7zZbe7/4e/P
 Tv4cpCsTyaumjbhcZnybm0jO1nnCKJ2VlhgNjYwYuwlq3focf5vn+FIPBoqHhu0AsQDRbDaK6Wg
 krLd+GceDfMNQoEtPnQ==
X-Proofpoint-GUID: _VYBviK2QQJT8eB2IkGl39BspXMgBQlL
X-Proofpoint-ORIG-GUID: _VYBviK2QQJT8eB2IkGl39BspXMgBQlL
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f22e77 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=_jlGtV7tAAAA:8
 a=ggIEzLyBpZPC2L1Vao8A:9 a=tNoRWFLymzeba-QzToBc:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290162

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

