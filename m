Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEE36A37E
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924266; cv=none; b=aKfdJKqvjuzof2m1Cm2vA3PnHD8z6qIbAMO+wVC9ovydG3kirOPREgedVwsvbhap9bJyUYQiQgyNkU9V9KV45u+2LnCAPSTB/B8iS/of/vbNEru30rpNjgj8dMjR+WOKtr2Pigu+iY4kTbF40jO9Ppmv9y69VgSehlObuPQwEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924266; c=relaxed/simple;
	bh=DQT/zNqQq2aLAulWAmnNWMK9zqPYRi41u9uyToFunqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZF1qyDG5Cr5H9lxz4y6KJsOFc/BZWbDnAXudCfIPnvwDbXZJMbxaSqlwUOrcB7depjR8KmUXVQXLqmJR6U8X5zs4VoWAA5tpW71wtcIsFtVxaxEYlzCH6dhkpLSZR3yvJ1o2nsXO1frzBGsE4ObwGsbXs9iA+PnsoaAWEIXvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLjpSp9x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JslgQqjD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PLjpSp9x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JslgQqjD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658CTt9F3658786
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=; b=PLjpSp9xJ1iVcLha
	SlOxzU0r+fTsHCyl5swAYh5dVkL6iFaZ6NoZoIkbWl3MHXeANjTcE2sxDX7ZOF4d
	v3PKnHzVa2MLrarxqcNqxMDtrD/5oe0ZDdBpT7X+10G5eTzgWL84kSrNaqflDIMd
	yPGGeVtXIu6rSt1M8YlcrU+z1XINGRRoxgyA2DWUkhDH5/fWUYf4rQsDJIR06POM
	FDUhltg+qaqLLN5NFYskNya5WWIYEevE2uGhqDBQcVW0ggG2IR9waWRVJfzAUmK/
	m2lP0d17m5hjXUfxyIdPtS/enh0mS4h4OT0Hxox5ItBZg3HIC5UFGDm7Ycuie9q3
	CEtT6w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsv8659-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:11:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso46321685ad.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924263; x=1781529063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=;
        b=JslgQqjDHl6Ovg1PmSBz2tiIfRliDYN7Y4DTMDMrBkVBtvhg0N6Eaae5RcgAq2Ra9M
         Yb+kWO717cW/huhgwSpb4VafJZK7P0/swNc56cecCw7SxtOOb5F4WajGz/F3YoZZ0Z+H
         MPbG3hPqKuR+xmWozhhFiOGoz74uoQARGTaihCzYCZJAfuAG/1tuJh5e+TbjoTP+hEoZ
         uoqe5ugyenzH5wOlApAr4T4qeD2oc/i/wqWh5Th9bb/YZ1/dtopxGUNHL4QGTYR7j2cG
         XbCkjsA2UIX87McHPVdmjiVfByqb9xnX7qyVyrjbr3F9VSaw9naxi/VayxLWWoV8pRKl
         57pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924263; x=1781529063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=;
        b=iDlyT7hW+2PJWQrG9PzAj6G7L48adERmfd7PEhKIALZMoDU1ZeDsUWGasBiWVN3Od3
         rTt5xYHRXCX7mOhe8IUtFomDO5PCTAAsy5bQz1X1sVh/3uuBBg9s1hDJ2pjx4E74GH75
         rw+WlFruWf2hHoipPlLea8M0xFkYj0f6mPAgdmoAQcT5l5+aF7SAlLW7Ju2ekVSWUkb/
         hUEG8Q42IzBXcQmKcsLqse7AsM80vIA5RUdg49i4P/catfwEC/gGgxZcjqcZDHrk/zBg
         hjNQGNymoZHWputccrH7Rmyul1GDHPGJJoxStocHfFJrCJSLBqs+UE9664qC1AGBHkWf
         khJg==
X-Forwarded-Encrypted: i=1; AFNElJ9Ri/OvvhliFwgHtHjHBUyMreEvoEQRpO4M5sxBbfkuXSPH+RXesvRovsQPWCans3B8mj9xooIasA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgcxFHg96SjCAUQVfa7JWUVr4QaT0zEDyHa+PljTuUUHZ2uJ6
	STpYWeIWSpKNMd0j9dHxjOYazywzIK3mq8xWmjiQmcCxMZ/AkOmbdqxbXO4UWx3fTI1t7loxcCB
	MAzRNoVvFFfY9ptFNouNzmMk81Br01xnAzyjwEQAQEpz9l8wM441nMFrMPrV10AodQ19RDw==
X-Gm-Gg: Acq92OEkNclhUfwCemL6Sa2YJl8VfxpgDoraxK8VeERmVj3nyMzQAcjlAhNI5/l/Q37
	jLFO5WBv9kQBeINItasamsln2T6Oad6n+OgnAJX6ZO0ZNubh0hJMqmLMQfbNvdmqtJ1XmFwrkX1
	DPyAa+mxbf/1pdOW3/nRbDi8K2KHUlG9YW9mJNAGxj9+YeqA2rvr6HX2JMsjDDE9hWAJhiADDRB
	Xk+kohfD3AG9abKHU1Ki+eC2Y7SbSp5efxtYnMVCeUt+k0cHUqThDmYPy0LDJ5djjpV5ZyMhrMy
	hlrLM5+DjK97tEHDq+fhRcwfoOQrvHSVF7XysdGIzJ9BellU6p1p/8SqEVfSvRky4IE2+oQOJEC
	oxMLHH4FClnI8L7WAsvP9a4RXb2NcNdVoU5fbfk3q5NM14Dw=
X-Received: by 2002:a17:902:da8a:b0:2bf:305a:310d with SMTP id d9443c01a7336-2c1e7f92548mr183184325ad.24.1780924263465;
        Mon, 08 Jun 2026 06:11:03 -0700 (PDT)
X-Received: by 2002:a17:902:da8a:b0:2bf:305a:310d with SMTP id d9443c01a7336-2c1e7f92548mr183183815ad.24.1780924263007;
        Mon, 08 Jun 2026 06:11:03 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:02 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:24 +0530
Subject: [PATCH v4 04/10] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-4-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=7ByKGzzDTD14i4DIQy9VognEH4x590vwDySV2Co3gPA=;
 b=nsZErkUbo/EXqASccR2ilHGqPbl/KdmXeGHwHAHGIBrjgMHzdglD4X0gd5IuKNYU/zbDE7RJ9
 FBjLaA0SeQ7BiEIweGWqNmb6hg54PGGtv7fa6AVcuinOiHZhiHZeSj9
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: eYIDzdk2YdQtQGBgeBur0fbvDjfov2Tj
X-Proofpoint-ORIG-GUID: eYIDzdk2YdQtQGBgeBur0fbvDjfov2Tj
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a26bf68 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX5OZocdCcYJSv
 jSvoX8G/ePFDSoQdOX955SSz0Obmavpm47sF6qmPVV0njxY0WogC+7SkRnTzRnfcbaWiU8z/5Lb
 XMKWTMoilzARAk4iq9eyYL+lxFJyVeyaHn+AWHorThWWOHt1pxUEUCimoiNf63qY3JIp+IaA1fG
 2t6wP1tBC/gmuqJxUfiYi+1Xw4CJYw74sT6DstnQlC8PG+VSg2PqBBFwz1as5Xb4G3N+8HqWo6r
 prG5K01Dk8K/ly99ubvNJkTh1nmtya+cCwTxjYtOyRY8Mc+gMHvE51hkPF3kDpSBjnmKjkbpNPa
 VIMuF34BxyOh44Rs10AZbic45xJvDGHr2eYQwM4K4r00WRbzKkqIgG8FM5tx7CvPYPT3HQkBJeN
 RwDBxr9S3qf0NgzbqiScl2KbgYAdff2RL47RBzIX8Hck4/pNRfw4AlasHlxDh594/+RoCxIt9WU
 XREXXZEdL0eRkd/CYfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index e6ec07a865f0..ec1bfebed226 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1

