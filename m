Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22F4DBD81
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985880; cv=none; b=DwthY+h0e3oF/iHHMHnV8rltsYWqF+IB/NQZbE/sXxt2+b35HGx0xvZYTJsLjyvhwPEK4yoeKPym21Cbb/r9E8uInni5KpZdFSRyqeaVX6JX3qcnzObsTZH5Y/M5Ze9AHIYmzK0ueRhB+VY8fLQPJa6+vZVQWTuq2+79XIR6h4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985880; c=relaxed/simple;
	bh=2njLzbY8Unn3mSyRXWJM2yX7i/tGL2ovfQ0evn7w6Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIqJVk9LVeOY7hN0tvOYy/EphuOH+Od99+yhD4ZUNEpSpGmBJCo/mHjy+alpUq/8dflirhYiuSEF5/9ZaGZWWYlBn5DxOU9YkN9s0J6z6YPjUULWlWJgOZqTwQR75/arQnnu8Z8+lVrhvNgyeb7S+T+2+ckvMrCapI96JjNf5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o36jjQD3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QngBaj7X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o36jjQD3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QngBaj7X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66242spt3460370
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 09:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	80z04yj5XQg07vhnxx5JXgiciswuUX0lR8As09BTFfE=; b=o36jjQD3Bx6YOqF8
	rEKAliIE/nMjk4c36ZH4TLHrbtzcfZeS4o6tHTwgeO4JhYGuQ5j4mnKRdf7pRdld
	RhEd9thLNmtwlPpyRUaGNbZ0WeeJV+zwwsBvoDSMC9UHPb22Tw+H9cPRYhhFTVkM
	IXen73KBkySaO7TBkgBXYRI8dvu278pgnDxvAr0cAu5Ge9MZLlGbDr93vIkPSepI
	WLyzbeUk4AIRuzAH8AadjvNWHYP4Cjjp2inxqQHatPrwit4X8v3lk1PkEVO2pj8V
	HMdYIA+c2tUCehf3cpH3GX7wwQlExyPlWWdOueeYX8qPBYg629p0f46MlBLgViu4
	nhv/Kw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5gmb17wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 09:51:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-847a225cd91so1704075b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985877; x=1783590677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80z04yj5XQg07vhnxx5JXgiciswuUX0lR8As09BTFfE=;
        b=QngBaj7Xs8OjrWAlH75xP9aXrxPTchQduEe+3so0oRO6AEuARoGcMBXIImA13jsLoj
         qmDeAdpYIR+h+lktZcoGalHGPZDWlfpOZG09VKMXSkmIuxPRRy9LeEX/CIGewIAJHft+
         TU2oi/EEAkuZZ+n3NrheVoprmpl1omQcUQZo3JzAMHpdu3y1HzfVobbYABky8ZMfhZQi
         hRGfdl4aLFVGaPYjRFRdagH9SKjc1ZKFt++9qsA7Z/jFlku/R3PQuV2vV/C5f36mBtnn
         3meCbJJlUo/B+XUnz/PgpI3BdfUPyE5eZecmaMvhvLr9fXsetNZZlQ45H5yxutRJ+Nod
         OPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985877; x=1783590677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=80z04yj5XQg07vhnxx5JXgiciswuUX0lR8As09BTFfE=;
        b=cKBD8SXTKjVl1NSDSaOnHF0Y/4xPsbIeXjgerU4pw8/OnSDORUpYVf+s9O69go5Iwy
         qfXxdmQ7M4cV61hoxlYRJwSJLeSkWImWexYcUDt5DfJAZYS7/XAhvMSSPC8FB3w9MdO7
         b56kF+fNd2Kb4mjG+R/1DGLimMRal6npDY2E/8WTwJ1qthTcqmNN0et9VuwApY0bE8OA
         6w3nGpL2VUoyJHOKb0bijJwh06J+sOJiWx6j+OdNJDFHPEzoGJXC9paVHfnF+gUALPxI
         P//LQ1wFG5e8F3OYvUhv0qjZtBcpaS7mtRvtVni4WVCRd21TXccBhtK/is9KwXNxsNIX
         A/+g==
X-Forwarded-Encrypted: i=1; AHgh+RpywIw+hgX+fUC16E4VKN5CUjVJW6G5ucxfuV2FsPgkfNLHktjKGjisp3rGMUS+au/aRI+RaQPm/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfSwwCPyvPPYfs7ZqLngO98Usexn1Aapd74eXilS2LQ3/ngYv
	ha09+y9ZmrgCgRPLTS4l4zov4vlJ/igeaQjANYPJWT04O1NGZw4QGXtTt4zdBrMS/Ph+ZI0kIin
	TbLWWKdsn3RJuHvx78tBXHHe3a4VBLtjLIYb8KqIqip3kmd18oZDpM8kM3ip5Dg==
X-Gm-Gg: AfdE7cn+2ceZDeeHG2sj/3Bb3RKt2J9tCvZbuRVq22XcwBBxxR4zoUJ64frtf8yJHUD
	tmaFmkotZDdcjF6aJSzRA5bGRekjlYzZMPuFVb1nlxtc1gDBRnyYrDv+5D87Gi8cE4UI9tTnjMY
	/K9MR9PgQ34YXJW8LnHyMqG+8aZWr8cO7V785u2wqjlYkhxHastIQNOodN8c7OelqBjBrZcUjiQ
	+jC31yMiR7bZVLnaYnHeWD9cO92tntCtxkXROV8/WDNqywUWKtYrnzwnQPuQck8jNBD4XBN5DAW
	SzAyDG2SjJa7fccLamGm9NO1hfKUTKy9HZvSXAvpzx4xMvTh11brIDTRyye22IuuN1n6/xl9ACo
	Le9mxGYKHRmKhz7k3IqTnBxuMuQ==
X-Received: by 2002:a05:6a00:4091:b0:845:ec1c:71ff with SMTP id d2e1a72fcca58-847c51b624dmr4280322b3a.46.1782985877195;
        Thu, 02 Jul 2026 02:51:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:4091:b0:845:ec1c:71ff with SMTP id d2e1a72fcca58-847c51b624dmr4280282b3a.46.1782985876615;
        Thu, 02 Jul 2026 02:51:16 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:16 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:46 +0530
Subject: [PATCH v5 04/11] arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3
 interconnect and OPP tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-4-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=6550;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2njLzbY8Unn3mSyRXWJM2yX7i/tGL2ovfQ0evn7w6Vc=;
 b=HIxDx49c7/YmEkDy6wYs09L9p6/XNNX2RnpN0zUoWovMOFCSP5qDk3MAter7ZV59RFbBuWsld
 CBMuZZMrmtECLf/JyVSP9xRzd10tbQQQ1xqE7JLG3f0GazIaRnHcITk
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: FfgaJmL2VSeOBz2Gf0Vjf5X2PD_0cW4t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX2UDI1dO0CKy6
 BusIUpU0SWolCPHOxXzXd3oqcZP2oVoc/dJGu43+QpPXgGogeAe9bG5qr2nVwk1e3kSbryATyrV
 gRG8t/7Ue1IdL4EG68LOLVbVaMNsxb4=
X-Authority-Analysis: v=2.4 cv=aJ7Ab79m c=1 sm=1 tr=0 ts=6a463496 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Hmkr-C8MtNtjzj7I6joA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXzWBUK74QWOum
 pBnaIaEMe+PtLrevWSjsGF779C4UVre6NdKVTBAD6KWLHHnv4uu25q0R53Wa7g6vGLYnG1R0g7u
 uaYnw1KtBQlyHMv5nzvcP/KmbiDdfbqxRcryroaNk6p/SeA8rvr397AO/rt3P/LTZdmfWAvfggU
 o46ORoxW9TchC7bk/SXvsgQb/A9KiHFQ+B9Dw+5P9VFdrAcXiplfwEMYvdvShHM754m+eRqj4av
 0SmPSM0m7LAq5Ufl53yHAuGeMOqQI3JhmfSm0Ozg1k8XZQY2UgDk3jc3LfMtEzZvn2et5KdzUxu
 Bs/EJEcHnBZ+UbR+kSycqB8FB/Cx5TodYCmBT4tB2qRQAfIdH9aN+iR9J4O7BilVXYB2JSmufRq
 ShrqLZMAas/JG4jWGhe6Mtu8NkrYhKQg17j7qtgyl5hLd63V2mZ2egk+bPUV0ta2RGZtuf5nont
 +oRsjSWGYhLUJYNV0Nw==
X-Proofpoint-ORIG-GUID: FfgaJmL2VSeOBz2Gf0Vjf5X2PD_0cW4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

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
 arch/arm64/boot/dts/qcom/shikra.dtsi | 140 +++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index d66b97dea319..26ae21d4c7e3 100644
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
@@ -132,6 +165,86 @@ memory@80000000 {
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
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-peak-kBps = <7216000 43622400>;
+		};
+	};
+
+	cpu3_opp_table: opp-table-cpu3 {
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
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-peak-kBps = <7216000 43622400>;
+		};
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
@@ -1820,6 +1933,33 @@ frame@f42d000 {
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

