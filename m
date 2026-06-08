Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427A372071
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924272; cv=none; b=TLw0geLRuVBK75ZD+IfYLXwn+34MzJcRf58uaqXADJlJL0RecwNLLgklyEpMOycCVty2bUmncIE8V1PORv6dU8IaFTDCL0D2sOlzneyGQ/0p276W7y3VpunNxFq23/cdJEc958JqefyAZjDvPXEPnfg+8uNY1LvW1hP6X9a83XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924272; c=relaxed/simple;
	bh=SdbwvMMv6a5NmwXe2VQdI4rHXib/Ucc+Z0MDFPUTd6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3U5vuB2+diddTtmkz5e+F+zDgMCHIDLdqxSUUPL4x+qNGxspXD7XRZ/URzG7Cg3OAgYDCqdKbtCl4ft902oeclt/TfADagNgKmtMNm+RWup68W3fmi/iXTrYaoVJ1j4+1+j+98lPBdT/pmPfeJSmHz0mNaQKk5SP/WgkvefmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVr4ZqOJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R3d7ol2c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVr4ZqOJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3d7ol2c"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BkUe93115530
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYX/1SfGtE4IOnpg86dyCjedLKkwcW5STf53i5veqcQ=; b=kVr4ZqOJ0E0pr3sh
	bZYwCmFg/mRb2QTxq8cLdXHnbouR3GxdLZXfJwnVHKSfOYWFiB5MsuKaJfuZaTgt
	+cCN5q+xF7vTyN4mLQy+DO82er5E/eKNVhXoga3B9neX+dNV4nrBt0aEFVOK31bt
	mVIb3WJhLAdVoJFj69KEY8tnQrOvFsbsjLPNjDUrsGs195lLFSUg076kHNOD6e9y
	/a2jvm9jofzSZoRzHFIAdpyzi12oobkhLgjB1O3ai/Rrlq4JqOJrwa6vY6KyiuuS
	ZByAuUk+V3ZLlXO/Jo2ppBK78zUPJAkFJCXLq8w0HErdZt0kLtfVysXMKUYeneHB
	Ecz8iw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m0bde-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:11:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf335549b8so67974675ad.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924270; x=1781529070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYX/1SfGtE4IOnpg86dyCjedLKkwcW5STf53i5veqcQ=;
        b=R3d7ol2c5u0SWauYvsCezPLY2pgciQyM6r9EeGEI8qAwvUgRo5Z2wmVf20Fnmb6O6Q
         3JTkdxfW7Cx/MbX9Uxw7cna11N/LP+o2CtQKHQnQMrXGQjdryV/OiR0NmBj/OgzWPYwc
         VVgZNcIrv/qQvPn5dwWB3HDn+x0oKZJC01kUMlMOrnJ1fRfVYCfzMMsdNkMODyvjXsOA
         ah7pUiUh7cbTJ5HgjGr7JkE3bjWpfwMe4lrqsMsqd29hAeuNwVYol5I3vsyAcHCnrbSJ
         I867qd7JlbCxGSlOsFqNoVPnA/pZwAkPTicMifuh106wEzJ8m1oJnW2i9MRd4YX/y20C
         rBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924270; x=1781529070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYX/1SfGtE4IOnpg86dyCjedLKkwcW5STf53i5veqcQ=;
        b=bapIqaEKP2PiZ78LaGTKqxK+FjKxuoYwovSekitlMiv9ROearlJMyTmWDifp9NV+G2
         s0PKe62hjYSYD8/nbpEMjDqUEpGwuvsMCvPBJndA0t1KRp544RRL1gn7SHj2vsTb9R+W
         IghIUa9FT0kgZYQWW+Szcr+tdvuQzp76nc7bYCy3T0pbN0cGOdYuJoMcofICL1RsNLu9
         Ux9tiWD9KhEt2RdWH1iwZ0Q+OgSUizwlCVC1HdGz0A3Ff+hdpVNyOX3SEVh0vBQXb8Nl
         PNxYem+a/92Y1ds9JcXdSEBY26R6kfKAAlsKsE7wI7/Qo2hGzRAfY++HbEsmfdcFUdGk
         x5CA==
X-Forwarded-Encrypted: i=1; AFNElJ+7yVqqqz5RB/RsGhiibrvnpqwy570kabPXGiE4yQnEEOnUsOG0OUCJEEIIaaHlQcpvbwg3wz/xng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoVJ+ihTY687sLFRmeaNWeZ0R8VEAKfwQXo/EoTNbXRCGU33j
	28i7BZgrSQf3KTECivtZryqvetkt1feSZDaeMlfkjtXAh6N5dKO+Yl/aNB9R7Nlkp8O15ZP3qq3
	mFnbXRC6sjilDkdoByEDfiPLF5xcEvDojAL13Ors5QH3wBgpPgRyhk7tzDhi8bA==
X-Gm-Gg: Acq92OG9hETd3omb+nyw9k2IPP1mPVj6o4SP4EDNeGGbEpAazRihXRtEeZTbUV57GtK
	ZlkJvn1LtqUAZFcAitviLtOJ73Jwrbv8PFDEoTQVcsWAnG4BibUy3vjMQkrB0HHOa2eDHoPOsX7
	+SoqJgfn0OzVQXHgeLND8u92Z+Tbpcw9eTQ+wNzbjSxRoBPNM7SDmXEBnzJKGiW0VAeG140uVtU
	0Pqn27MXMIKeqAu0VfYZYC6iL3soq9zMtZNpS1Un6KiCWA/ZVz6yEhVri3gpjnE/pg6tw2tpsKR
	I65R1GRKkMf/0BkID0mBawJDm4FEdHchHvqbCogI7QUzjw+pGC0MEdCgd6h1ySk3Mo/wzGrYkA5
	bskbZg7dlQe5bZ7sVKksVPZ13ou/xHpQpXzpyooRypHZr86Y=
X-Received: by 2002:a17:903:b8d:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2c1e835b26cmr186250795ad.35.1780924270074;
        Mon, 08 Jun 2026 06:11:10 -0700 (PDT)
X-Received: by 2002:a17:903:b8d:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2c1e835b26cmr186250355ad.35.1780924269600;
        Mon, 08 Jun 2026 06:11:09 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:25 +0530
Subject: [PATCH v4 05/10] arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3
 interconnect and OPP tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-5-2114300594a6@oss.qualcomm.com>
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
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=6222;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SdbwvMMv6a5NmwXe2VQdI4rHXib/Ucc+Z0MDFPUTd6k=;
 b=vMMhQ7jkOlmaM0mICeNrh360/X7K0ENo2PjsTS6mSZztYyaieS7b77nX0N85ym5MtKkCPPRTA
 amnFZbdniqcAp4zZRutDc34p1pncc9+xSy02FwCPNvJRn2JsTkqecWg
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX5jOG1UZXNkjk
 2yI3k6JyYfyoJW6NUIALNJwTaKUZY1Rq2Acujpb2epUWQBpItvjBsdq0phxa7/VfIu2I5LPfrjR
 9Ks7ACj9ghU5Ft4zA1SqlCoJz7O7Tsf3YSnNoB0MBxKjb5iN8XYwAW6rfaGDEBnPdAk1uxGeicV
 rvo6kiWaQnR6eBAI/u+pVp2AD+o3tgUVZPxFex7xw3kU/QBqwlJeCucrMb377TLU71GjNWq9X9G
 LNwwiZs6xEsThwF8hxs1jwHSFsTznvnxgnKBHQwd1je/4A+QoIC9Tcj+MA8yc41VPcYz7Sa8pEQ
 XOFNkCYd1ucaNwreVCCUT+b7XlFTg27dqYsXsGzHK96LzGy3DAHe1BqKh+rAoajDgHeN/swUMds
 VmmBdQBefFMm0+HF93eFJV/fd1fgLCNf+zRcqqPg/ww+DV+3IFKncTSQbfuQWu0ifXBrOI8iGJG
 ITbLmQ5lXinObT+AyIA==
X-Proofpoint-ORIG-GUID: 8RtNa1JURghD95qr7U6A8AYh-AwsobB3
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a26bf6e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Hmkr-C8MtNtjzj7I6joA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 8RtNa1JURghD95qr7U6A8AYh-AwsobB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124

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

