Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284D3FFFAF
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756427; cv=none; b=poNFGPTkEAVZ/61iTXiVVrCiTkWwOarI5dJ0wXanjVz98xE27E0Qf5/w4uT0BpThneuFTOd7eYoCbSFafRjkUw7EX2FQdAxQddbuKF7tVl5o7QbCT5Z/J9lotHv2Mgx0+wrRtQuoTeyl9ady5SGC89Ukt7NSdmmbKGvsQ4/TqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756427; c=relaxed/simple;
	bh=dqfpWW9qO1mWgm/b5TpnrkYQh5K5GceW3wq24Rk9mNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/MBFwEa6EHgpUxdt053Fcp/Tcm8UV6M8Ipzrxvz6quC2JnpMUXiGwXZ7kEEROheF25e1tlHO5NqmLwYyKYFcngUq5c6r8RoUFHbFdCBZAjNBZA6lqtJtOhtrLRwYbh0RVKuDbQLdcMm/09gRGcusBfNUBjH2toeQZul47y9j8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ecZf9+2j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N3fejHKe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ecZf9+2j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N3fejHKe"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673A5MtQ3654632
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WzBbR9nM8pT+2GTccbbrCOLwszSN0IBgJZFwajyv8Ec=; b=ecZf9+2jEeJtdj9k
	YKSvvDyLtFKfskXttZv78fF59Lrxyq8pPRaNKwiSFTn0JuNeRJQHAnCgdeijBNAQ
	fKvbnwz9814ooQ0ldPNiSlqlBrGKwmZYSs6ckd7ocfd/LJ6C3HD1ri7gWRpdKjZp
	sB8/s/7oqfWY6wIw8LMPtwJl0GKZ4f3XeAcL575QELXtMVYV2NRqsuAK9HUpQEK4
	TGSguvF9pLtUjgsTFniBFNlbdTxgnjb90MoubJqW5NT7J+BxmH03FGeCkfVWytF9
	jpyFgruLmI38iewj/jJKFoQzlTfo3tL8s5nEiiuojzHNHdSZqGsjbmAbSnlCCIVI
	eTwT2A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhb1b2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:27:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3811279d51aso6178397a91.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756425; x=1786361225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzBbR9nM8pT+2GTccbbrCOLwszSN0IBgJZFwajyv8Ec=;
        b=N3fejHKe4b6MIfUkyyyqeO4KIY3B+PcIoyMTNGzpaRo192EzmtmGNv/w40P2eFyV2s
         9kLgar1w8ec4sHnk8t6Mh23gDkKO5DTbhVYt2r1Z1tQqoBRlJQeifQZp3pDOJuihjH/4
         Fo505TdbTPZvf9Kh7F2E+HY2VPLE+axFZwQaFtGCxgV3AYwNJ9jhtM6+E9IhM+UaFeZi
         rNkHhElQxpSVeOTJpjCLwcdVG8zgrr3VrDk7TEsXZ6lcZoIcghZUHSON9Ikhti8UEhq5
         HA/9ahm+YsxImhHm5fVFgNDI2yKioTlZlYSTIypLhcbeWAMY4zI/QGbEQEWHDWJr/DDx
         VTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756425; x=1786361225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WzBbR9nM8pT+2GTccbbrCOLwszSN0IBgJZFwajyv8Ec=;
        b=mPYnISOQ2DFWj1inMZ19mTJZc2KYPw4555T3tfFtqZ/yqsfh7cyRyiWCUYrGrZP/bR
         CJHqwZyFKXK5qDxqQwL+UnnYPheNeeGD+ZqTDBM+rnYQiU9GbmL6/vdqFdU/ngdueFCD
         ZyR/MkpKCIq5k00fuq7KlxCrKFGQhneQTZ5diBu/8YDPtjjsp9Fsa9Aty28EmZwjB0xB
         dxTFDx4N+stbSHz5X+mRvUfjYRzb9Wv8Vwjq2+AVoJIWxGXt9BtFfHgMfTG0PuJLQAQX
         m5ZofX+zU9wAVMCc/jaI4YI30qEyxVtaW52l49bh3/VvzutegtoX5EIbw/nMFIR3kYUC
         BO7A==
X-Forwarded-Encrypted: i=1; AHgh+RrqEuwXG8zULkwQ499VkSq5wdFvAmkTD3Ga50sg3g+F3ftRYnn1Ch9EI/MwAd77SfC1lKH3fQe5Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzRLp3UoBtPMiFXIZeBTzeVYOSKKTm1xkXsNnkoeXexCjYE3+
	YkQmgA1mT3sSe1G78Xe3xh3l9KUhFzUU9KvadHGYKnTi9sGv4hxBn6Bm8smwZj+yzOxHoQ7og3g
	Cz03fTcUAARhDEt8fIiXGAI8WvZfYG0GMrJK3jVyX1/uMfhZW6LlYpIQF2oCyDg==
X-Gm-Gg: AR+sD10y09Lxd8frPLVgKSVsM2C0mnlsP9a0JXYChxg1OqWdFOTj49jrhYIM1PvUCe/
	Btenm6gzOwbcnHozt0RfsVtgIi9Sz9Wt3QNfe3P2L1F+3HVSI+a0/kWv9ZW1pxjYohxjRjO4/nz
	viTi94INmYiUcLur7VZT6d3pnZE/ab9GLj/g41XudG0JBnnEHWpsDXMQNP472fnA/Kooc4QrALd
	takUi9/zJoXTs0Clwhrhp8/xHm8ZN8vJriHhIpahvDa0Dhb3zEArqgNcfFaHhsBw/MYgBTiEW46
	EtDlkOhaBaYdEuUE8swP3Af7XJqQI8oUbs4ZofsUkttARc7M+Az6ro/GatwBJ4UWwYt8D42r0JU
	rSS2EEK/ZpXDwVJ0=
X-Received: by 2002:a17:90b:54c3:b0:38e:655c:6516 with SMTP id 98e67ed59e1d1-38fbc0b2364mr8410642a91.0.1785756425013;
        Mon, 03 Aug 2026 04:27:05 -0700 (PDT)
X-Received: by 2002:a17:90b:54c3:b0:38e:655c:6516 with SMTP id 98e67ed59e1d1-38fbc0b2364mr8410622a91.0.1785756424510;
        Mon, 03 Aug 2026 04:27:04 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:27:03 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:56:32 +0530
Subject: [PATCH RESEND v7 03/10] arm64: dts: qcom: shikra: Add cpufreq-hw,
 EPSS L3 interconnect and OPP tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-shikra-dt-m1-v7-3-7fec8e777076@oss.qualcomm.com>
References: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
In-Reply-To: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=6550;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=dqfpWW9qO1mWgm/b5TpnrkYQh5K5GceW3wq24Rk9mNg=;
 b=hK2XA/TSa7ZZuBj2l71hDOePCk/GHA+1sD3cB1ZaTlldo34f0FimyYfm97rAZ9Mf0I1OQ5iX9
 mYxbaK2Grq5DP1c0sGWdghQTY3EypfDlQcpexjB7CwM5Y4SBkEZQ69b
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: Wz3F_en0h-pgDkW8RtBDzHXDThaYh2eJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX6PK6BIYuqwiA
 I+fXsvsZtil3CoF/9jVNg8jCBIxb7uQM/ac9MBzh6iXdfUSveUuhsNXxPxyDFdBHDYs4XCIELhA
 bm9Wj5CokhGseiBjHVLEGUDAvVMKBAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX5v3714+HKe89
 nh6nSVuT30Ozon140fBvTyY5Yc4uscNhflKAVxdlc7t0ztEOa6N8zYC5IyqUbB+orN6Rx3sTIu4
 OfzQOyEyReTp4E/vX+FTKtkPMqguV1oZYKi/7njjD8CPNTvA88HDjpA2amfF8f3cGEZbjQ91rqp
 brWiBdFZYqHPqUyUCYpLvyfB/yQonayuA/wQyz4cAK6XTZt4T0lKzsz27bGTbkUkBh984fPAjjj
 yJXccjNEK7lB3ZnmCH1YcgjlqYIv5t4PjpgHfgBcnbwpu2ulRH3qhcsuXGRmKgI8ATg1ntoPtl/
 S0j8SYq8x1zcgGX5L+0/LpWO4SU0EJFBGNDaqwUgTjTMHLQ2tVgY46coo2G/TYcjKd19J5fonma
 XU5A+8AbsTXfWZMFoOpSZEtGFnLK2xMfQHju0wn7IuOSMz7JG9OOguLMybyPJHldUy+JafUvSRF
 wAlHCc4YqqhxFx85uXg==
X-Proofpoint-GUID: Wz3F_en0h-pgDkW8RtBDzHXDThaYh2eJ
X-Authority-Analysis: v=2.4 cv=bKEm5v+Z c=1 sm=1 tr=0 ts=6a707b09 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Hmkr-C8MtNtjzj7I6joA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

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
index 3582352dcff7..a01e26d9ee6d 100644
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

