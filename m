Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783637DE97
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318550; cv=none; b=koWz4gysVrFNNuyVIZur70lIr9I6x17X06neM50D77SAfeJTzhXaEJhyfLXNeQLlpGjVyc7D4qE/ka6RhOYcm3sqSh5yL7rGZN9EG6dfWqBxN/duBLE08nKzEBIYMnutW9acPdho5DwNm0zXPSGekPhw5G0NLmT8UlQMVa2dguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318550; c=relaxed/simple;
	bh=SdbwvMMv6a5NmwXe2VQdI4rHXib/Ucc+Z0MDFPUTd6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gv8herYTr8PLU6TmW4bZECIaTXNS5yZE3wLgKU/ZLFW/sWpMeURioP+v1kRwxmKPdPq7gureXNCrYMbSZraMLuOxc+pXAw3evH8ZHpGdH2OxcBodQtxLfbrlRTg4FmyLmRrI5rha0EaS3Xjhy8f7H2hbhJO41/Zpbu2ZCbPg/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VaZWt3qM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O8eW87zT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VaZWt3qM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O8eW87zT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dPkf3563542
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 12:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYX/1SfGtE4IOnpg86dyCjedLKkwcW5STf53i5veqcQ=; b=VaZWt3qMs075MwW/
	EFszoNLKNYW6QQWSS5sPXw0QnRbSH30vD16hoZ7eXoKr4Yrzqh8JTG0fLdC7h0Lk
	oFrmk72M9GnUKPTAr0/4g9GGNy156mofOnyFVxWk8MX42lLN0LOnZm8wKqEV1pFF
	XQ7UhZQvk7pIQqqm+gU2Mm+dOkRGbTVmWKh8gd3M6D2r4zjx4YSQa1kM+asEIUWk
	Mrpyj5shc5OYrWvxoqEPsbEStUtUvno4dGWkaZ+nDrc3PLzMMBQv2DUvz55OxTdg
	G+WYLemGOlychDYkMwzgUcmKUGEw8yhw+48Z7RUbzFNA3D3HVtfnixDdsjEEKUXC
	MjAHmg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6rxs1sn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 12:55:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so14272915ad.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318546; x=1780923346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYX/1SfGtE4IOnpg86dyCjedLKkwcW5STf53i5veqcQ=;
        b=O8eW87zTDxgNNeTrcsM1/qBauuhfX9W6XCsNS4CvKEofpFpVGTLDVTNHvysnB0sfHm
         F3+Dl69L5e/dKNx7ynM9+FPwKABmbkq5lBbkRLPN5MYlwERTxEGyMWU83f7ClYY1X+ys
         8D8MF0CCzJHjMQ3/rT8adSWPxV19STncJWs/otYsVIWCSrGK6/OoURnhzwOf+51bEuxg
         olFtxjgt+kQfxlxOSWguCDoRu31IR8K4uOHYLymMLXYEcun+seuaOvVciQLfguCIo1SH
         ieKG2d2DKvq/yuereuHY96LNrBFuzh2T3KTBervntC4PU4ulXWniNh0JHoVugIHHh0aM
         2s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318546; x=1780923346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYX/1SfGtE4IOnpg86dyCjedLKkwcW5STf53i5veqcQ=;
        b=oOHEhapLpcK32Dya9AvT5pdnA0IX2eMozzn7M6JCihId0ClARk6iQdHdaBS2QCQeka
         g/X9nl5j4VAOjZ/xeUQTOVosiIcM86um/AWEJ/j5Q4zrvKo9ayVq23xAGI+V9Mj+vkcX
         +wDFMX3lOsRaZK0MeeGGCLhKO4BSOMRYIuZ3wY6epgwnhJIPjts+HINxdPV/q7V5PIaf
         vrDdtiLhFXdh+a9euwzwZnFJtRNM4DCzPFQyYgzphbduyzfdRsTZiH8gTWBb3BCnoni+
         j96eooYlcubnYKZXb2NOJoYLF9bGi52O+QiR0AFm0JHZ30thXECYQyV/nSItmPc2dbu0
         k1bg==
X-Forwarded-Encrypted: i=1; AFNElJ/c4nnrnt4G7KLGUi5Ur5zYosr+RfupAGy+QBxWJKwHVtpCilm/xXr2ps9GjClyggFqIdybNQJV2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyySQERkl7lUzKsBg4awbjakoufLcEixlsUW85XAAi4hN3ng5iU
	FTbuteBiAMJ3vlYjWJW8/6B/o5t/izStAl/WqY06WUizjbb1eS1cltNQtueCihei4yzIRZMGchb
	jv1S0pZ6Lx6geQM4y4jd5lK7pCnUFIsIixnr715JA9KFD4upbr5oIHx7xoA+2jA==
X-Gm-Gg: Acq92OEbkeGKHe7RFpx0r41FYgsEzI83Q/UMhdf+tCaZWA5iBTN+QBdgF8AhzFS5+31
	x1k1J2RRMRIf7IG/XhdkAVtMvk1xFZOuRg/SSt2Ux5mipgx/w8HKzLtU6yXxw+4Ubq22b5q2lNs
	C4IB3NLZr0ph2s/5oVaikmJJBR8bjfWmZVWjxiN4UcG5hhcce4XxfAkKbBbpyx2o0c7iEtArmrC
	/7Uue2yH5GJdtG11TLbdi9sxrE4H84B+R6bG6fVraiEqNGJCD6UspI5qBahh9ntkWSTxq79KeJF
	w6HcM0AGagU4+iP1S2XAPjVfJiHOBRBbF2UanNz3odvPFevtoVpIrxJpT3uTPUnLfsAxwgueLz7
	BqisngvVaIFjIbLsEEGywo18MtIYQSGY2SG8kaEXW6Rgfe/A=
X-Received: by 2002:a17:902:fc50:b0:2b0:badc:c9cf with SMTP id d9443c01a7336-2bf204ae7bbmr122797495ad.13.1780318545914;
        Mon, 01 Jun 2026 05:55:45 -0700 (PDT)
X-Received: by 2002:a17:902:fc50:b0:2b0:badc:c9cf with SMTP id d9443c01a7336-2bf204ae7bbmr122797105ad.13.1780318545464;
        Mon, 01 Jun 2026 05:55:45 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:55:45 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:07 +0530
Subject: [PATCH v3 05/10] arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3
 interconnect and OPP tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-dt-m1-v3-5-0fe3f8d9ec48@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
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
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=6222;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SdbwvMMv6a5NmwXe2VQdI4rHXib/Ucc+Z0MDFPUTd6k=;
 b=+M7Ud8kM7L4e55CMSE1hv0BL+CVGSQob7zyKGUrzMGQY5gzV3SVcf5lC+O40lDndGOGe+J8W1
 fXclXiu31hQAoUjixE8YxmjEBLpg8rpEu7SSpNxKQKQKl2L6LnZurTz
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: gFn2dY9WWWBuurFEOfYtStomY5yesav3
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a1d8152 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Hmkr-C8MtNtjzj7I6joA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfX3T11AvuzyUKI
 HyTAt4kEljVcr/KkIGEIBgHgvZwg0aQL1+octRR7fRF8cZF9Hqelj2njfvCA9ceRNuQnOFOuIrN
 FZneKHCn4kirLRLds0bDZg5gVVvVjKULDnFjnFdbZmjsgS5YggsxMTa6utFGaZs9pI8uJtHQ5vy
 JpMwuswllaRDjPO79qIAXHieqQm2qC38F3npB8ylpylAEPuUjNKrVM8SbASs9/H/ekJd/9L4+nm
 JqXAyWQbr73SysgMaputOMmjDFdCwk1mNpDnu6pvINaUkA25PUWOIIpn94ag7YVsepjY0mn4Hov
 xFaiMQpprRRjxiNCWVbvquZ+bI2rWkwr85CQOLWHYs8jdXfmEbG6HsXG0Yadjo7oQ5Xl4vo5o9G
 fUbAoQDFgXPuH5APoySlqEtfCa6SKnjWNHXMOTK46kRujmb90O3B7XwqGVd01QVoJ3Mnh0M+F+E
 BVK3fiMg7crE9MNGQsw==
X-Proofpoint-ORIG-GUID: gFn2dY9WWWBuurFEOfYtStomY5yesav3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010129

Add cpufreq-hw node to support cpufreq scaling on Qualcomm Shikra SoCs.
Also, add Epoch Subsystem (EPSS) L3 interconnect provider node and OPP
tables required to scale DDR and L3 per freq-domain on Shikra SoC.

Co-developed-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Co-developed-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Co-developed-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 125 +++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index ec1bfebed226..309ebe515814 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/clock/qcom,shikra-gcc.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <dt-bindings/interconnect/qcom,shikra.h>
@@ -44,6 +45,14 @@ cpu0: cpu@0 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 		};
 
 		cpu1: cpu@100 {
@@ -54,6 +63,14 @@ cpu1: cpu@100 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 		};
 
 		cpu2: cpu@200 {
@@ -64,6 +81,14 @@ cpu2: cpu@200 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 		};
 
 		cpu3: cpu@300 {
@@ -74,6 +99,14 @@ cpu3: cpu@300 {
 			next-level-cache = <&l2_3>;
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <489>;
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu3_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 
 			l2_3: l2-cache {
 				compatible = "cache";
@@ -132,6 +165,71 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-768000000 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-peak-kBps = <1200000 17817600>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <2188000 25804800>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			opp-peak-kBps = <3072000 30105600>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <4068000 38707200>;
+		};
+
+		opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <6220000 43008000>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <7216000 43622400>;
+		};
+	};
+
+	cpu3_opp_table: opp-table-cpu3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <2188000 25804800>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <3072000 30105600>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <4068000 38707200>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <6220000 43008000>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <7216000 43622400>;
+		};
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
@@ -1820,6 +1918,33 @@ frame@f42d000 {
 				status = "disabled";
 			};
 		};
+
+		epss_l3: interconnect@fd90000 {
+			compatible = "qcom,shikra-epss-l3";
+			reg = <0x0 0x0fd90000 0x0 0x1000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
+		cpufreq_hw: cpufreq@fd91000 {
+			compatible = "qcom,shikra-epss";
+			reg = <0x0 0x0fd91000 0x0 0x1000>,
+			      <0x0 0x0fd92000 0x0 0x1000>;
+			reg-names = "freq-domain0",
+				    "freq-domain1";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.34.1

