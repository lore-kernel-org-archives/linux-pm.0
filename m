Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B543EF0A0
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180456; cv=none; b=M7rNfUd1ruv7+4RKi6SNp3ujhKo9gt7E/yc8D5BYOtBD+EgK9gFz9O6TF1MwzMad6vUU0v0iGR+4UgYs+5P+EKpU5lGHR/AKYYXwFbWC9tEADJVUkZQ8QXLoRKtrXzgvvmLmKODqvnMxr1orDwMXlJKR4Yr/LTlpR1Eho8aELh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180456; c=relaxed/simple;
	bh=awu4K4Bs14uU/g+Ooa99QANFRukd+lo481ZTjtFUCoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFNy8MThodTU7J6GRvy4TOky6SYHQ2iRSV6xWj4kwsomSekRRh4h1k7jFP8z/sr4d8RB5XpQWKHqQe3FHedxf2XjS3cifE1uO2GUZKKh5Cy7hww11FiEVaG0RfCwmbk21C5ruBAdVzP5o0o9eVsTkSC/HVw4Uuo17JP92HRZBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ah+Fyylo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K/8sP2Xx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ah+Fyylo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/8sP2Xx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J5xUtM2438146
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gmjNenISsu5vkMKrPVIkZ9GWLjHD1Fujb1tp1hK7UKc=; b=Ah+FyylofomzbuiY
	AFE13VtC/DuYRlcdGqG24sO3a5fjK4XrxBTI8OIqs0Td2mtzlreQKXp6uBHNiPRz
	sd3zz97LmJlwuejSHqMX4ppwwQnw+htG7fo1Sa64Xo8h+TL/m1MNYYpdDoD7R//P
	Mm0nCoG4k3GiK61r26nv6M96LqDyleEChAUOliDYq0tagnzb1Kql1Gj4ImDw61tc
	WDf/GyOYhgytNqr9LgrAdBWNU7CdRZ3qtVIxP/jxsGMCDkjusSPDyQOhhPGPLIDk
	sOqI1amVgyvA249M2jQdCRY7vBZmoFCwqBboSkidSpcozSrt4e0sCZ5teAltNHFu
	bT9X6Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e834v43rn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8386367b23cso2358120b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779180453; x=1779785253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmjNenISsu5vkMKrPVIkZ9GWLjHD1Fujb1tp1hK7UKc=;
        b=K/8sP2Xx4Ig/iy+VjSDGncKPvRj3t4NsW2R5MokpNVNk32XvkYKofFV98tJAzam8K+
         EnkIXeKV9wOGCQBw0GZG1R2fet9/s3yeaYAjLbSR35xQJa09/HnWDF1Y8qhiY4DY2Pqd
         kQo+3hyDn4d9erf/30NZIJmWPw7ZhhST2/o7M2nQr2JlutnQoLkSCYzY++jrZBJ7Azvc
         J13P1G4DWVbYy0bdO8lsNv/YraHRDzPZ+Ce+D3HZM7oNPu65jhNTqifYwRQ+rYK2j97g
         lTtWG63S8gBrmNT+/D37Lv3F7oYWznWT8TM5cIbJwhS71Vqm/3AwKkVyz+MK1ZKfnLkB
         fkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180453; x=1779785253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gmjNenISsu5vkMKrPVIkZ9GWLjHD1Fujb1tp1hK7UKc=;
        b=EpjFKoJe5ThyJeXWaXJ0Udd01k2Y4jJe7vi3r6mwNtJ4ZtlMox6dXgFlkGtmdYswvT
         NdSy+IHCMeL5ozjLCnIiLtcfy/MCwp69duYfP5nLtnmDIWM25lE8+qzp9l+zyIlICw5u
         kboG67Tq79PnI4IjV8E4ovHip02nL7l4V1j3nlzlFM+81VTpW7hkcbKiHwHavSGXTVjm
         xXCPv6UW28z4QgB88jbwoMjrmnuUnAVy9ossOhpwtNAHN/NxXrClY8bF8NpusKm2V0Qa
         jF79oNWD+i0WWwQTrZ+U06/23M3/+xK+FUqvpzkBp8EdCIMffKcL+UyzqiWMok9JSINw
         TAbw==
X-Forwarded-Encrypted: i=1; AFNElJ9jtuoF4KVGATiPM8bhu5sdej1LfxtVOFh8sx33PFS6MzG2WYYYaJtjXUKOUcx4lM/tXk3SMdXmDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytoFC2xlzeHW/jCLE3R3HHVa1ryNJiqo86AsOQrIwAOOi2vPnv
	E60WhvwK17keEXu8sGvTB5QLfI/CX1gtxW732bPH4626jt9pBocEH3M9lYH6lil5tw8d3idSYSa
	ttoyNjIrn44+alnMJSCtjuuZeQAo2MsboTLGM2usx6izYV6sG+y5byuUTrqv16w==
X-Gm-Gg: Acq92OE+93SMTY8sVjYO81Lnam79KXS2V/7oCf5HUGENdlXOdbtOji3KwvCF87wHY7L
	FTuJNYCxieZAN2xNYC6U2sOhpeN4lfwkPNqSkE7A+XwyjeKKWQ66uOV5CNshJsd5Wa3tdzIEgHP
	K+Aby/3h9t6ZprNV/ySMluBIYxHhzHPhP9uVtdZ7qjiCiOHhroVJYgwdut0C3zMzHJ5fJcjgyIP
	qnL4w6ldvpNvJtf87KOMbDrkXrkZVnVV/DA4ybYypJPKA5SqQLfRG+4FuvLG1Dy7HT0N8GmMmB4
	MJFMVIIGFXA396SZg5oDealgKr81HQYntH/XoNsCUeu/Y9GIfDtdiEGk0RykiY35mGCBwVG910F
	gKqjgtcauxSyuW2RgrqLiMHf3WqRga3EO/KMr1JvHOtq905voZTnHhZcEg7BR0DQEjKqaGgX1AD
	0fG0kh1KqfeZiPRzepH3kQm6vnFnutI2KSAmOwQIpKipOyyylh11X5p/GZ
X-Received: by 2002:a05:6a00:a221:b0:82f:9985:d4a1 with SMTP id d2e1a72fcca58-83f33d39e74mr17617257b3a.24.1779180452707;
        Tue, 19 May 2026 01:47:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:a221:b0:82f:9985:d4a1 with SMTP id d2e1a72fcca58-83f33d39e74mr17617228b3a.24.1779180452217;
        Tue, 19 May 2026 01:47:32 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b1f5sm17434104b3a.31.2026.05.19.01.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:47:31 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 19 May 2026 14:17:07 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: ipq9650: add interconnect-cells to
 GCC node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-ipq9650_icc-v1-3-4d3554c94257@oss.qualcomm.com>
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
In-Reply-To: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779180431; l=803;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=awu4K4Bs14uU/g+Ooa99QANFRukd+lo481ZTjtFUCoU=;
 b=7ZMNxdyViPnNTHymAwSaF0IL1IQjiaFvVsHJhxVSzfHAVVcwNaoQPYyjjgqSG6KGULhNCoP56
 mOp3b0/r3mGDMn/YLmAwFBosyuDyEBFLIRCUCUStmPnreBKn/EaAtDP
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=F9ZnsKhN c=1 sm=1 tr=0 ts=6a0c23a5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=reN9DiWUbCtN1Y_qNI4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: i6adKF9pITsEmLpzcQORyyAf-BxoSPlE
X-Proofpoint-GUID: i6adKF9pITsEmLpzcQORyyAf-BxoSPlE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4NiBTYWx0ZWRfX5XU1ZGl+qB+P
 AQeW/WvRGUOF6YOE9s6LeAdYIRhKVl3yv2ITPDoNFJiDE1LkjYKxq6ekUs4xO7/OiFmXNlTrbKr
 qSoRqs9IOz5TiLONMyYT3Lbtnh1mvFg49IkRHU5v8PlKjtR3pjS01rGyu2/d/ETjuwEDM9FSPLz
 0f7yE5I1i8M8Ia27xtMmt2LdRD3pJhLjsDDXVF8JXgwV540/3AVp8tcyFIzKFiRu0Nzuz0uHvEc
 wRu2WACyHx1Uo1Q9y7FS9KKfAdsFQPNcov7YoEjlBeZxYqZRNrvP93GyxW1ZoVQP9SX7PXFedAn
 PlhmV5zEj1sWbrPAbWUx+ABjG586dR0AsbhhPnJVhN3zUJLeOgqVEswentuGuQtfWYJvXsgrHZW
 I5AhxskggCCRFGte9/OYqMYKGJ/UtTzZnTSaFcCZqGAv47k/5XpVHFN0TdZa34KQ0TDQxWuc3np
 qiyQER/VgEBUjVDDO1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190086

Add the '#interconnect-cells' property to the GCC clock controller node
to allow NOC-related clocks to be managed via the icc-clk framework.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq9650.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9650.dtsi b/arch/arm64/boot/dts/qcom/ipq9650.dtsi
index 3d3b317c6a3c..4c442773de53 100644
--- a/arch/arm64/boot/dts/qcom/ipq9650.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9650.dtsi
@@ -225,6 +225,7 @@ gcc: clock-controller@1800000 {
 				 <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#interconnect-cells = <1>;
 		};
 
 		tcsr_mutex: hwlock@1917000 {

-- 
2.34.1

