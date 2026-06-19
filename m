Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FF3B47F7
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901583; cv=none; b=m3SHWMRcSD6JkklFHWZ61bWGQfEZUD5lRpYXYjorFB7mH8x7l+v2Xbma3pkuG6/eU2/giw/qpE4jS48bTK0nDmbez64cv8fMxz2PvJZf/xFHAHZPpjg/Y7HBrcnZNnm6JhBUcRfiamm1IL1M8BVINGLGw174bN/+Ju6ZCW0jFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901583; c=relaxed/simple;
	bh=IdPiTr+89NTOkDsqWrjX1ex8thLpD0pPowUiZVQhR5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PcgCd4FccOZOPWw20ggi8CIsD3cI3JAM5coCLW0WdyNgDzcc4h52dyXnA09buQ07jGJjk3ZSftkaj0IEKHWrSDV566NVzpl3g7v4DbuhwGoWsBHJ1RvP+3l6f/iTrncWRu/Fb8S7tB3O/Hks+uKFWdFO95opMQb/fiJsOWplBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XFPJxlk4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i4GY9UUy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XFPJxlk4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i4GY9UUy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHW36N1311625
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F6mHh6th2THC39sSiP8zXRHuvf85QL4Oc15TqVlsTEg=; b=XFPJxlk4sJA9oupG
	RcCM6FZueJyW/2xrOlYUtjQeX32x0nLXXAYcVQkn9W2PfiXKGIswaFKmWKRVSAGi
	FjqXYtF2/RpKtanqALxhGA3aUDIdDHrShs17In6bX6ahZRP193nQwG1VRDGW921+
	6lGAatdm5fphkC+PC0+P7CtfMzA7xXHoQyEMm104XoBmDtFL4+UmLnezxwlDOpXP
	VH6TtWqclMvG7U+sL5BXblagTh1cqNFZLNUaZDlNhthBHJSbLUu7aSVhWE8VD2Uy
	fue/yT+GYCNR0eWmq5Y3FA/IB5Yn/ukCBlhUp6d1jXOCTag8qIk4UbFzpEOQE9ra
	f9fMig==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6scy95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845319bb97bso2147150b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781901579; x=1782506379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6mHh6th2THC39sSiP8zXRHuvf85QL4Oc15TqVlsTEg=;
        b=i4GY9UUyoumqdz4okU+2IMbeUpHQnq+tHiSya7cxMXOPk3M0UiyaxH9qdWgR2VsLtE
         edQikUMADNM7d3uH5LH5A9Dp1sVmgVIQs7l00HjoAJX1yUtVoJiIaLr87ZBmwcqyi4LE
         P3GDT1kHe/2VOWPqOPiHU1Bo83YEtXnIgadZTjYNf2Pfz4AXOqlTQ86Tdpz9cIw+5D68
         3sahAz1MfigZcGqt4SGxGogo+vW9XPER14FkhlmPKdUQQRB63eqd0NKT91W/UpfHxI3B
         Tk2M9pjTIb9z/e8gygNdZJT7FGnIWdTgvUETdXIa72jvnx0HbB4wjffWwBOo4GYAhn4K
         7aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901579; x=1782506379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F6mHh6th2THC39sSiP8zXRHuvf85QL4Oc15TqVlsTEg=;
        b=YaxkxrTmGHwJsGpR+ll9A1kqpI6rMl2ESNjihAab8Pf5wexrGGoIEstJ84zm6C6IkS
         g67IZqCDt16uZ8sUd6IGDOWo2Ac49nanugmzaL4flY4CvTicJqYjtDkIDMeSKFQzv+cp
         5OjfzDgQyeQtcWSGMky/YhuQ6YO66hTR+63PnDh5kf+TAmgFpqT0tNCGrBFEIa50t4oj
         xtgSp4n00wElMPD+i6PoeAKcKoeO6R0RFglyBwLoKiVYOrSr4E74w4tfSau3BbazznCi
         zchZ7R4dcZZimh0GBXWwsWL9CEvMMhFgi30OfQloskdZeQtgz9CYCXqz1f9URERe/0xz
         X6Tg==
X-Forwarded-Encrypted: i=1; AFNElJ8BLMxcwBAbtzOIIxex8w+Kvv0KJgavGaAtBRo/hsIwfQaBzapATqRg6Rlppp2HHkMc9X3WGb3biw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDKfVv1Yj9kfrOQSczo0GzoJBmXj17HQo/lKTXepoSQy3u5ZR
	MK33I4MdhvDesQeoNsrejtiSWa5t5ayHJ44drtJHHkk5I2l2XzJP9HZ0759jYPRnZ13bASKxKZP
	iquM/qfzqa9+qO4ecAXU4lkgtihHzANT4wcq65aez2BgitVj3uPmyQWuhTvHenw==
X-Gm-Gg: AfdE7ck/2yrxr1sbsBuhpKsFebBXuPTigCtnhf7lxzB9KNQe7tmLh4ZdoVtDLm+btYP
	1v3Soc6H2+7TQynKF3/PUgB0Euebq3HTC5dyb5b4EVxbTvwLxdtYy0rgiGlPPSEpDKmtblJqGMX
	HU//77ddDV8cdg1eq5XzPBjPa2ZR6wnj8BQpjTy31zzmX8Uxij2NXMnJq8CIE04saNrzj2+6tig
	mF+C9HBFyo0evJy2fPXLDuGc+4LYe4mFe2w0rKnvC8hKNPGlbGwc0HtA/D3VrBntdWqle2EkEEU
	iKgCBAF7PJbIl40OtK1Li/sRV0uQ9OF+w+N4eulL6FP/gJhuGLEEZ36WSxTaVR3WziBc961x8qa
	lEYqcVdzcCfSojoeqfKza1jHGCybm8zyHi1BucGy2bk5HWA==
X-Received: by 2002:a05:6a00:1994:b0:842:4bf8:cfdb with SMTP id d2e1a72fcca58-845508bb9ebmr5453500b3a.32.1781901579407;
        Fri, 19 Jun 2026 13:39:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:1994:b0:842:4bf8:cfdb with SMTP id d2e1a72fcca58-845508bb9ebmr5453467b3a.32.1781901578740;
        Fri, 19 Jun 2026 13:39:38 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecd779sm94190b3a.53.2026.06.19.13.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:39:38 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Sat, 20 Jun 2026 02:09:10 +0530
Subject: [PATCH v2 3/3] arm64: dts: qcom: glymur: Enable SPEL powercap
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-qcom_spel_driver_upstream-v2-3-a3ee6837c18f@oss.qualcomm.com>
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
In-Reply-To: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781901560; l=1091;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=IdPiTr+89NTOkDsqWrjX1ex8thLpD0pPowUiZVQhR5A=;
 b=a2bYFX9QFXmQuG66UEE4ITsGt5ed+HmoW0IWJj74zrTxkNoU9kGJLeQw3wsZuLdKvP3hP65MT
 7uCQ512DOqxBlAyCwHfh7lyRTx1Oc26Tsmis/sl1EK4aeBJRqVMeny0
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-GUID: FDFtyat614IZIDPl8pzPKcw4eUu4tGVp
X-Proofpoint-ORIG-GUID: FDFtyat614IZIDPl8pzPKcw4eUu4tGVp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE5OCBTYWx0ZWRfX/VuznWoHiZoV
 yc8G6AZyLziEDE+fRioGqQWnfR4y8x4bI7Q6xLTz4DvWAeLP4fThYkR0h+I8MnNYlUau+LOQWKZ
 oWcIwHsnue7/a+57cTKhxUu4O3CL1khr++b+BgpJTpCGotHptAwYPUbDKIgTzl+TYW6Gn9wEKyv
 agxH5YHdXDjrQ7YULSvsN9MpxCsNcDUdOUx3kYGW44FW1oyhG6dpp7Vr2pn6cSsPiLvmKIuRwnm
 ny57y2h31pK8IX1+j4i+geNBN9siV+UpFMEr5WleNAFjKcz2iLgkTlhobLZ5KC2H8zTBGsqFOCf
 uDM9OMIxnxHiapvpyQDD6pzRan7wEL0t4dL3zsGlBN3m3s3t57jL7lOaQDjFUhWgbhHl2lN9g3n
 itRCdFxXw8QWLozKZYpBFc80t80f/sPc1wF8yg6qs93EB7miwqaaoRFLaLDp6+mL4g32fIGpTj4
 N38QyiQRjh4NtvF/VLw==
X-Authority-Analysis: v=2.4 cv=H6LrBeYi c=1 sm=1 tr=0 ts=6a35a90c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=O8dm-XbEgrUGq90DOXoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE5OCBTYWx0ZWRfXxg8HM3VfbOD1
 UD2QfaIDXX6+N35Kzu6mk8Shb6xKg6PkN9Kd6QiuggAMoBGWPY8YiVwrRXNssmPhOezQl0kFjzM
 kBq3gRHT053L8tHziOn/xJU53x1BTfA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190198

The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
based power monitoring and limiting capabilities for various power
domains including System, SoC, CPU clusters, GPU, and various other
subsystems for glymur.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 72c7dc6e4f09..9cf9180e4f8f 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -5033,6 +5033,16 @@ spmi_bus2: spmi@c48000 {
 			};
 		};
 
+		power-limits@ef3b000 {
+			compatible = "qcom,glymur-spel";
+			reg = <0x0 0x0ef3b000 0x0 0x1000>,
+			      <0x0 0x0ef3d000 0x0 0x1000>,
+			      <0x0 0x0ef3e000 0x0 0x1000>;
+			reg-names = "config",
+				    "constraints",
+				    "nodes";
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,glymur-tlmm";
 			reg = <0x0 0x0f100000 0x0 0xf00000>;

-- 
2.43.0

