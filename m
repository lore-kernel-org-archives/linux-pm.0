Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04602357A4A
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971455; cv=none; b=Sxv4dSQlnNBtS2VtY0unvq4JeUVKBAHBOugZgapgeRSo0Ax26lULu2HBdux6TWlPERZl1amt57/5E6nbng8hw+of0xT/7Pi8RyMmrZY1AEetKQ8lrGbdVEhBRlLROF3yP+7F42+YY05gUxlBk/lPwJgQxHTtt2zpisu89JY2fYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971455; c=relaxed/simple;
	bh=2njLzbY8Unn3mSyRXWJM2yX7i/tGL2ovfQ0evn7w6Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eh0QKrdmqM8IoC0zjI2VNrISVDbhpRAA5BJrmOzIRMEAYyi3G9PhmA7Z4RfhMzcoRZN3Q9M38qbhNDwTldmHcjvHjizSoUtAoRFTzN2lTrOHMPnkdG46E558lJXldh1FY5diinF/bl8QP3ssRghf9V5HULR4GQ6FPwCyUJtxuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWn5V02X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zm/2Emxa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWn5V02X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zm/2Emxa"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9SlC2435365
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	80z04yj5XQg07vhnxx5JXgiciswuUX0lR8As09BTFfE=; b=JWn5V02X9ypYGC+V
	A+zorkxzF2DjOnlCgUkOKHYuuvXSdwx1C+HbXcQPeQY9i/O9wz4oTcnbZVds6xSy
	MQLsJcxJwqHy5204cRC5HQcfjAbX0MOG+vwk8Ykzk3F/OwNFD6fgbQ14EKVZ0EQp
	a/fIhFZ09TImiezwynwbao+Kq196NC/6msx7HoZ1ci+iiYm1PNzf6KLge5Gpc/0o
	WKiwiNN4IdQNY0BTvwR6hU8T4N8MG3I+dhu/q4snnfseBF9zGnp+owTBLzCfm5D3
	x/LvEzNKPE/h8Yy8yrFzXFsLimUrWoN3i5COey6YVoFXhTwrmNmeH0UwZ8Mltoqb
	MgaXnw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavtdrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-384419c6c74so4778258a91.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971453; x=1784576253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=80z04yj5XQg07vhnxx5JXgiciswuUX0lR8As09BTFfE=;
        b=Zm/2EmxaEoBP4yXAgfu1ILPXKx3310vg/n15dhnn5bdMmfRebRXm0miDDPAzoWBuLv
         HpTBWJTBw6XImDruyz0/LJn9z6DSQoNQNlsgyPPcz22I/PjpdGhx3ddpjiHCokm8nnHl
         S0Hcxwp7lptPVOcrK2UftjvrUN2khUqdD6kSlawtigQ9wOB/WUazNt2Lnl3YU8mM3nN+
         PuIVKLudqJIifyC7nW2c9xla0HCkk3hAkdJv6buch6ZQSTJ2UqsJGeoYptvLtsFpf0cu
         i7Isth29vQDJJcGW4S805wzoTdT1h7Pa7zpBgNcAFiTC5v9lU/BZsivYbg+LLo+XDZiS
         bRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971453; x=1784576253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80z04yj5XQg07vhnxx5JXgiciswuUX0lR8As09BTFfE=;
        b=loC3PYht8htm78nqKp3fPI8hVcq0hSTugVNLMusVfUYVt1Cef62J+URv9ZDxfNjiGV
         doBeFss0DIyHvtznwxJcDpngkViO5OoMyhjqWTQ5X4ociFU4mGYktRfnScoVSecwWD1j
         v3vK7otE3+CEGzf5PRJXxT6EseV83HsY8OZh03O4lm6wXhggTv5sY26kGtmAZk/eLiYE
         INiOuDI9K8lIWswKx7F1kBdlhG2wWAg+m+ibjos6NI+hUh2f2PQl3q988rdp8ViplNJm
         zQ3ZJH7yd2O3DSoy+ieWFQG5qUTWU51kkKdBzL4oQiUgxJZHt5EttvmXsSpv7lxNCpR+
         KJlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGKG3HqKxDgRobne8Cdhqmm0Oa7H3MD2RPBk6CqPxqgzDwI0/Y8IJzed5g7Tct8ui4UKgP89AXYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05ZgnmuXIxSVqutbSg8Ux64mcYcowiQpISaxnoAn2h5tlbwfb
	5azkoBTDyj+uUaq8OUdjbvBte1oYNEoBOGoj8dVna772ksBu8exBaKa+/p0RQb+NFstQBey8L4o
	K+/WogWfKMYlQ2RiaVTrtohlQ0TAkjxhDthSjbbjDApu7fwkqNjsir2fnW66YRIox9noR1A==
X-Gm-Gg: AfdE7ckoZoeH4PfzJhtiFpwihMd+i8uNB11Bom51GNzq0zJrXcrrCDIpAArS+N3Q695
	2h0JZImG3G5ZKLTxe39/qqSCYy5MmUol837OnjOK88eUrffQYZUuktAjZNh51C9gQuXpemJmV0I
	BHuOu9ePFvpMmxCjYesjasWOkDZDHvkJAJG5K5iFDWBq5HWswJ3b37+5qs1fSoqWAGd0j7lgc4/
	MzpKeI9BlPW8mfv4qdFjmQRE9b4PCpHcLQyHfocSno5BE7u4QQ0vYVV7ou0Hd/33KVf/KoX+uwO
	0W9a3EPiC3RXPAZMxi9TWT5MYx9bUs514/e6rQSD9EnbjJ0mC3BDpAmHAFDkWDs3GOzTm3V0cP0
	SzL6p5Q1TvXTlbPsbIZWrCIe2QA==
X-Received: by 2002:a17:90b:5212:b0:38d:ee84:b1ff with SMTP id 98e67ed59e1d1-38dee84b2c0mr5005195a91.40.1783971452576;
        Mon, 13 Jul 2026 12:37:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5212:b0:38d:ee84:b1ff with SMTP id 98e67ed59e1d1-38dee84b2c0mr5005174a91.40.1783971452128;
        Mon, 13 Jul 2026 12:37:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:53 +0530
Subject: [PATCH v6 04/11] arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3
 interconnect and OPP tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-4-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=6550;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2njLzbY8Unn3mSyRXWJM2yX7i/tGL2ovfQ0evn7w6Vc=;
 b=PpALKD6bGo2xoagIRxbo0HRDKK0Wlb9kBKidGU832JO6I/DwQpQCyz+HlbFRlwcQybQsyVUDx
 vkceNVsMKIHDOxK+P9qSoFc33HH9aAioWFxfuHdyhVuGiVndVLwekM1
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: V-0lvfogj49DcL-j5a07UusAiMmmAre9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfXzzLYcfmm1qTb
 gJOgF4HrtJRTZU0TuK9GM/zVtfpoAj+f8RNNE/Oy/bcp/j6DhFfmNw2EeVk3zkT6h0pJD5CvSkx
 SBmcEJzxqyUjOCtkRlJ3T12KZ1zGO7A9f+0Spqd1LQR4I4A4Ex2DPfgCNwznrk3MxC9OlVifxoB
 Zc2uJrfu91SQGbqOm5X0guvIlhsc2CNIHSdJ6h9bSXKhsOkE8IgY8Pzx5uXkp1NwkiilwsGDnJz
 wqriGODr+9mpoeE//kiGGUQcW3Q+OnOQK7JE93KXCwIz6HB30Skiu4xSg7sij340SN4eKpjhtJx
 Vc2YEHSq9cCw7TCzIQzLccbWudXZkPO115Pz2kAaE7nqtEIjbNr8qlH0rHKlQFX1JQnIprKV3Tb
 GJYTC7q/Maz8BM/Jd5uKNk5h754nAR4Pik44FG2j3VNwPSMxVDIBV0CXY0W8W6nz10Ht/6bO86b
 WTna+3rNOPPJls8SXyg==
X-Proofpoint-ORIG-GUID: V-0lvfogj49DcL-j5a07UusAiMmmAre9
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a553e7d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Hmkr-C8MtNtjzj7I6joA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX3WzTlbTG/mnQ
 A0e5Ci2HMs/ui480IsVHmX0p018H1JyQTCUoQ8ok3s+iTl01L/dzu68biE0QBSIDE1xRj1/dXFx
 xV3Isys5bqewPGilbgiwAx4hms78Upk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202

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

