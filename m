Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683572EC57C
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622969; cv=none; b=SSwB+aB8DSjeop2x6S7rwUlLdsyBcPDGpX4aAypsVhdrMpd7tjKD7XNyWloUXX4meK77JLpTLwmglRrtfo6v8pZmVHXOg+PPXOwwoBdeYHevvRfCC53JHkTLBklNzAf2Kf8WwbER8AH9ur7sXLG6uJMUe+n1Fkv9n7hUeanI8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622969; c=relaxed/simple;
	bh=x2HKTjy6kA5084gb2G+glaC9oZCPA24Zn7jOFG52TSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6PmhGQ2Tog/R+U9Xk31v3fuqieGRgiz6U+LRLH7IvoHvTh86Jqx16k9iOnH0MKBudHpVLJvohbUK93WlbhXzi3n0lc/aShRSk8c8kEP3YnVaUPxPb/7A2x4KITNTqeBAT2V+WLo8DZ+tPFmL4+RuykFx+EUtjdrdtFuef2063M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hz6ymiwa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cWWVu11T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hz6ymiwa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWWVu11T"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63IMobXZ2714401
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ks9AROpzFl6
	d4jF1iHD/p5RckBAUeQlMs5t0zXMHyzk=; b=Hz6ymiwaIWjaYjEIZWjFoeJbzrQ
	LKjE2R7S1XW1/u6l4dPrXPMhbwFl33qYnHPWK4DgqD8ClwFlKweOtPMdbSmSAHAz
	8P4BAvHHwe3BLq6f5MFCNhYYMVTxriEpeaGvwze8FxW5NdCokbb0ns89Bz6mxrCn
	H/RJsK762nGVyud3/F5P4O0sHBv6D05347TLNanP60Fv6s2rEmTSJjB8NZW0X3pe
	kCVZUVFWe4UrOha4++JGGklQQCQM3zbgA53D5JYwnVn2o6Msc2dr/kS0StXeHAoj
	6fX/jinuTmVEmI/IvimiDybLo45dKJ3ai38bbqfxm5RdqpJpYpwgbS4A17g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b72y2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d890580e1so48081131cf.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622965; x=1777227765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks9AROpzFl6d4jF1iHD/p5RckBAUeQlMs5t0zXMHyzk=;
        b=cWWVu11TPSGQDoR7NYw8rVnVpP/QFde1toOo1GqUPqy0fzNalv2ZHdyBBReY5/NwzW
         fR/IE6vEcvEXYdb3SoxFPIKM34bZzkrRCgxjn3f9RGC52lR/AZ5uxZTlIPIHjZWSXBiR
         PqtjDK+BUyzaA+Waymw3LL5VnnnCuNrawABZni6SSDr/Hd5sXuwgprTcqNkhdGLnTb9c
         bgd4nXOJfOzD+pHgv31LXWGW1vDAk1P96gCyTTbiZGzr1HsgMixkULiIoxe3NPlQSxO0
         g8mADAZ0tH9Nz6EOnPVN2XmjuCae0NPZV/qTLR7VapQ+Q1BFp1oQ3vi9vpZ3Coq932y+
         ZgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622965; x=1777227765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ks9AROpzFl6d4jF1iHD/p5RckBAUeQlMs5t0zXMHyzk=;
        b=LF80hAgUBpkcWm66aoXwCJxXObKUa6KYe7F9zzDIJCBfPtx6L5mlACL0yFAl0+PevO
         RqFHlWAJzAdjdHEdT26P/0DG92hJRarUTkOgr1T8+U3n0UnoYum81eA4SZsz8YmqJKUu
         hAYmg8OwT/IamvU+K8M3VTec2RLDQX7hbPihg0+z7wEz1ZVE3ihEx9X6or6S5sUvxVtS
         NmNXqaWnd7B2zf47DvJTm78prVsZfSi830hLR7zD3b/88iiatEJvKDd7BKHM4nMy3moq
         jSIH31P5fknmr+G6jgTEyT9ySYpmJmXG1RKA4hcXk0omTxKwBRdimcYygkofHcm/LOHA
         c6BQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/73R4x8i31wqevOeGjFLgP3eqs22oNGbWWhBkIbd0e8aDQuVGifVlc7SdM6tM7qIAObI42Nhkuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQL+4kl+JEQjXrmx+rYPHUqDM+HuHeapkQiyoCYaFf2N6Wq3e
	ZU0xMAkNr9ukAkOENjp4afgAJO+7S6vRNKiHiTETU5Wgau3AKaaUo2BO/6uHAJDjQLJrnsgOzVX
	LFGZTfAWJ+6F/KvHajclcvFc0cn8xz1ALy6AnkvgoHO7Cu2vbWzj5OAihVF9mFA==
X-Gm-Gg: AeBDietnlisHwpvuiEqk4rfuPX6RUpzvqkOrenwl7BuHbIrmiidtuaAM5skEKmmFpd7
	m3rBEe2E0Guc6RkyHT5mo5BassrxTfAy1JToddV3AzLMeqnrieKMdrd2Mn1ojueFX0pSGxOBET1
	afy8wrlk7b8N4nfPaKDwztgyv+667RghKgrOwcrS6XkA+ZimlTMGeh6slOHg/VN+XKLkyfZf8H1
	9lwMHscz8AyApa3GpadrZA9KR4CI68kWzSBu0WaYXoxSwWVKTT89YTWXdsGToTdn6vhXy5LXlm9
	Ntn0jGaCAxPyt9UftVrhRhGKG4txygMeuFV4N+tR5J/bH+bteOJu4D46V2lIMFQoggeo4N7KlWB
	2f8s2C8eCVlP8Hi5PyfQ6yYeSDj2AHAPLuaDfjRBMi3hno6Wi0GfGG3bDMzlG
X-Received: by 2002:a05:622a:1820:b0:50b:4a84:aa94 with SMTP id d75a77b69052e-50e36b86249mr168984601cf.7.1776622964782;
        Sun, 19 Apr 2026 11:22:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1820:b0:50b:4a84:aa94 with SMTP id d75a77b69052e-50e36b86249mr168984181cf.7.1776622964258;
        Sun, 19 Apr 2026 11:22:44 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:43 -0700 (PDT)
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
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC HARDWARE MONITORING)
Subject: [PATCH v1 07/14] hwmon:: Use non-OF thermal cooling device register function
Date: Sun, 19 Apr 2026 20:21:51 +0200
Message-ID: <20260419182203.4083985-8-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e51d75 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=ggIEzLyBpZPC2L1Vao8A:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX0d87/kNBfTar
 brLaGD8qDWFf2Tk2JaB730IDZYSOIxT1rkjkReJP0KsKBBm3bZPNT7gxldqBMzzl7/TaM6bMIs/
 r0hgwBm+jAdctOWDoRmzVYbl3HqvYTuIsDe/mueiG3Ja4THxzto0nqshaAKiFAIx3dbl0iy9FRr
 S8b8cToLgXoS4jnm81Fx7tyd9R285SYB3F+2PC9ZS8aq4h5qz44/qeqA/U5QeQNV5X/ElcOX6u7
 ld6nog7Zpq2n3lBFbcoT3RxJ72LQw1r0PngD8AgytADa3xvp4MFZ9Ocw14j7/ntkVZFJizOWSBg
 S5dElvshICEgzdiqwEufxTdw7JRcQi+m7uU0INiRJGL70Zmt+pEIcol/Max1I+gkE9onMbt7z1R
 OLeh3ckF6F7dZn61pTsN7YjpxhT4Em7ty+uWNunfVoLK5zTEPJwMPgtmdRYhPXvcyrs/YNH8roc
 ENB2F6rmwYlGxGgQaLg==
X-Proofpoint-GUID: zGiQH8BHjg4CFKP99lxoIYOOyOWjmE7u
X-Proofpoint-ORIG-GUID: zGiQH8BHjg4CFKP99lxoIYOOyOWjmE7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

Make HWMON drivers which are not based on device tree to use the
corresponding non-OF functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
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

