Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B63AB26B
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165705; cv=none; b=L8U5vKHKl5sDtYCnAjfTFKQ7CbyieuPQmLJVlViw1f0CJqyWkP29pNCZ4LX9WMo8mc3cCyF4PZkqvZ/IIU+JyCEr1VE8ubJkUceBSDKKNkVMelsM784nEZwYfDzXvKNIyr2q8QYUM7reiIiFNy4BFcJtM7Gr6kPtulLcaNK2j7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165705; c=relaxed/simple;
	bh=/u+6N0EYMsj4Agunn+tkKmFg8PJnSQna9/lR0DG64k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHg/aX9GiKDPSsXqOWUzLh6fRr5ro61DSaeRJA1RL6AmsvntN8NN9TG7dmKBS3xCouUUgA0aDnXJRE4z3nJWqcZqjRad2xz0DSYzoXvl+zNPFdRw/r+fZuP4NDNeCt7zxHJ1mWGXWdGxMxNF37+yhfKdYxbqbDnrLDk5smeezIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WF4eQvzh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XoU44Ofe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WF4eQvzh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XoU44Ofe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEPHWg1750544
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JbENIRCUzy8iymZf0MtDthp30+/c03GDLd3xc5/hlcc=; b=WF4eQvzh7IFuw7KP
	iChuAWF8Obq2/A4BE162+7mNLKC2ae63q6URPSrXkaS3Rc1cvvt9rtvDqwWTssX1
	VqHjpToa4/nKAF4xy9TsQO7YjaqgE5VeGBL6Us4FISUOvQsbpzu94Tg5Id38BcpR
	Q2io9DZuXFiSW70FN+eQ+umdvq9bz0h5DXE7gd7oFuCxiriZ+ItIqC/8yLNnmPG3
	JCwF6z4w41cyupYDvcnWjYLnhqj139/YAjUb3iss0gFddZKyTWXS1yXUw/FMM3Nm
	Oif9xDUJ7udGYPNpkFW2VuHaCL1g/68kVgBilA0D5HJSC88R8DRlgKU0X1fTUuww
	Okd0gQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr419rjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so2162930a91.0
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165703; x=1780770503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbENIRCUzy8iymZf0MtDthp30+/c03GDLd3xc5/hlcc=;
        b=XoU44OfeazANJvr54XIwbFvZQ4q56FDC3E2yIBbYwXWNJXJ8HjGyRzQjUr6CK07dO4
         Gl51Z2u/NUjxuNP150pHKcCYxG4FU/HO97Ih0l2oAdQhwZ/W+gZdVXM+7nUvvJCZod18
         93tGK2A44cvLxcC8VqsvdR1r5gPMapW+ekLClheWTSLDGD3EKcz2w/fg77dlXVFylamU
         xrbBhHqgtbXEH6c3iqN1S3zQJaMR1wYb5q953ZIKn+7FGGY/tnz+EQV3xmLU1MTjd1vc
         artPRMWMlkZP21CWYQtK28BpiHGrL7hVibCW6qUyhCChZUQJOZhGclPgZ1s0oi5nL379
         6h9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165703; x=1780770503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JbENIRCUzy8iymZf0MtDthp30+/c03GDLd3xc5/hlcc=;
        b=JlPpj3CtdVjoex7YuNVl9zLCOAgWsfK9Bi6mirTaCDyDEXfECaFjoiM8n/a2Q7+Xpt
         n46hkdhc2BaOZNL/RbQYzQBgpzM/UJuDmifJ57fbZJjVDLU5qwm/1bk9m9ymorC6V6WR
         JPyVy/8RgG0tQZklwvBLv1Lb4eUXMwjRhvS/TuG9Sod8/6IiFc3Zu9Zccj6Ww9YxwTJH
         lyDJ0vmo7tYUYv2nojyNPZZ9yvu9F2X2gxGn9TnkJQIoxyiRYfP4YmzVzHk7Y3Mn/1m4
         Gh2P1SZ4aFNhpYIZSEsHzNTOIgCJrbrT7vRQn/2ckf2JHZS6mE42vkGtCictFBvn6EEE
         EqnA==
X-Forwarded-Encrypted: i=1; AFNElJ8CEL1gPOqKAwwWdONf5OWWpMx7hRuYtjflv06GY0/Ms281/FuYik9NoGVScQfr78fCQh+zi8A8Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJq9G6x3q+v8QusK3hdq3J21F6qFKNTuJ1n0ix2972knsgaHo9
	2a9t7Qt59/rSV4f4YU/qZDsyqIWL2PYEzb8FVu31ZjXpuMuWEDQjDpeLaSuhHVF5zeu6wwZyfpf
	k750xfzW/rMipw8mQqHtaEQKHu3eB60CRmYthPzDhWPTyxoyVZ3hYcyMfvXPhJg==
X-Gm-Gg: Acq92OFaGvoEx7wsWSiTmr98veu3acAiL+acwV0HeLT9pOg9Wc7kDDEq2Pb+gTtqCWb
	fHs/moO1xmdStC5FFrfp14AcCmqFhnXljdNUjBMqliYKRwc5w3tMiD7082kjkL57mELbpiTaN99
	m9vJNCEuI+S7Fox2L+n+Jc/K19Lfk5QQxveP1lQqo73CtJ1aGHv/eaOX/ZBiawf4o0YqiScmkwg
	m/5GrWJ0pihYdluOGBBgydf7YuriRpF+61juXqwZXmGWngGN/E3v8U/2ydRtE03ughQotsUGIFs
	+xLhUrR0xzxXgblYSwHtPC2cPf3G2staZt0kwiy+FKBQ+ZBXdqLeDBBe8U8J3B+F/wDqEqxYVQM
	l4vQGENgvKMeuM5jgKSwn4UHx/+mFq+AUOxGHUlONkWnQONc=
X-Received: by 2002:a17:902:cf12:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2bf36779df6mr56555375ad.5.1780165702758;
        Sat, 30 May 2026 11:28:22 -0700 (PDT)
X-Received: by 2002:a17:902:cf12:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2bf36779df6mr56555105ad.5.1780165702177;
        Sat, 30 May 2026 11:28:22 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:21 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:23 +0530
Subject: [PATCH v2 05/10] arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3
 interconnect and OPP tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-5-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=6222;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/u+6N0EYMsj4Agunn+tkKmFg8PJnSQna9/lR0DG64k4=;
 b=9myKuo37YexO9g2IzaFvvP7iNfYf5KdcUYkVnQ6WclAoVhDp9gps9x3jcFCOJAD0slQ93h6l4
 9IWuhd5Ia2qAn3MdvTXH2w7K61Ch8TaQ0NQmfyuc0/gJwhFQK6Fvb5w
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=fOEJG5ae c=1 sm=1 tr=0 ts=6a1b2c47 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Hmkr-C8MtNtjzj7I6joA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: dZYG0dWyB4OxhUC43qdV8hcR-IgiTYbk
X-Proofpoint-GUID: dZYG0dWyB4OxhUC43qdV8hcR-IgiTYbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX3n1uRHinsWS1
 fpKTQeF68tkQZPXNls4/zwERvGOBkmpV1SJDB57Db+7B1ykaa+9uj4B/e0O2XRqVuaAqSD9iEm8
 4XUotL0aTqeeU1ZNLL9AYym/ckDzEhM97eGnF9KV37Ow0iJEdHY48pr0mjAf2aPFA3TCQCFXN88
 7Fipz65LSiaL1XMP+g7v72z5i21g46EWvAklV4TY0z9HSW7uaVs6Nqyv7EMyzGjcRfSx5opIkmx
 5+KQgX2ZWjtBazqhITtNYFTVv22f3nDKD7+bTI3wrRvjRIkga+jJFfsBL+IKUYRRB20/B0UchpM
 IH3SQt4+MdYTGMXUTIy7lOXBsx302nIoyTqF/PnSV6oohbNAlAuP0bZLpagj4+HDN0JJYZ9ZVR4
 fROc9JC3A1YZXbCii2pmua7/s4q0aLMDWk9QWTGxGEktDCKhSEm1uLb5klZerIO7LOcYt7/wK0I
 /3ECd764gcYtyxlLFgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

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
index 3cdabe718714..6c0cfd73cb70 100644
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

