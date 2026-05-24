Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E1326951
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652209; cv=none; b=IiYf3TyXSGxSkEdYI1kTAxSYDLt/TpFzF/+lAott++DWjl8cm68Uzdwn1eZ7ofkXiaEjJEwUo/F8J/jLPhd9QVmGdhTEtGMmyl/64W9MSzDh4FNQVJS6dF4tGNo+1twfde+phG5r1c+gRW6LoUxr5yBqeXAg7fWwOcYZ4qYm2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652209; c=relaxed/simple;
	bh=1jrpv7TRgP3YtH5fUnO1l8HHlwq+9FoMbp2VVKV5w1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLrpkxy0BKnyMcYa/it6XxE8Xxb7Y1eZyIhXHAH/3lS6OuTVaiSHtadzgHtUKuiElqxGb1IN0xaPife1UHEbHtVo8KD0DqTSQv4XYBy9rD340RRASvCsabfvWiWmALSScmErqzzz3Rg+10nxyNmD85ZwamCOVhoBG8UjdpizxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8c+vD7S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dhu9QJj5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8c+vD7S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dhu9QJj5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OIQixT1429632
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+1GAOpqSy/JLYxABsdTD+MSUQsRlkDKW4JqVBEYmEVk=; b=B8c+vD7S5cYwfZKT
	AMNYTIX/5KuFyXPZZ6M3/GPCB7TQP/u6h6zhEHmbdTwfFkiKz5R/NadrHrHqtngX
	n3dbFU3ujG6Va7sHLEeLlwT8XSH/ou6OhmhnTiksDPZCS8Lw1nJaEviw2+KTuJdb
	nuwS0Cp+MFk63hiKMpNrAj6TDfWHtBdoKlQtVyjfv63Fm5E3upTvA/JfsOCi9RC5
	4mK8sQTFPE+h2c6ypGXKV3IcAv4Tdfve/4cUdsJuuX4NdabvSg6wSP7OXQ3EZOmW
	gT7aWikpyc9gC4jGP9BfWExa0Ltd0pZ1DZ0wltbb4XZALipJeHBa/e/L6SWL/Idm
	WUenPA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgv0md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36865d109dcso8232823a91.1
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652205; x=1780257005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1GAOpqSy/JLYxABsdTD+MSUQsRlkDKW4JqVBEYmEVk=;
        b=Dhu9QJj5ReNiuN/X4IHf4ZtX3mlz8HWr5RYbYilptGIJgujn1g8Hx2SykdDHTzM6ey
         CGIFmFOBRU3uVM7Kpvt2UfufBhL6FB2oU9G7MvgZlhHI39SIDp+psTOUvr6HmoEUTAU9
         7tFNOiUgz5b9+wAG3qquUonjbXIaPqH1U4SRZZCnOwf/GBzLJq97J7OSW+sIwDct5/SQ
         7ThCicQ5JvRYEtjzt4oTS34AREnRHUf2EDL+cNYG8aHt1wBJxZw4o+yPrRq7mMRgeYS3
         MagSuo7jN8dnRoxkjcwXQkhejaRrH36Vo0qGFubCfRJ6lTEf2s1rwfGlsXrf6SHo6dMx
         SctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652205; x=1780257005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+1GAOpqSy/JLYxABsdTD+MSUQsRlkDKW4JqVBEYmEVk=;
        b=pXE/eQOWvR4sdnSpfYI7OB7YteZi5gx9rvm6uxoSHIyXC5PPpev19x7EZrd65F3MNr
         RHbR9JQ0dAi69TvRLkB1nEStB/mI9LGNobXUxZP4/yuHo5Y+/nK9gXjIzrhzwfsUl9fO
         ZReXWX8hJ9icvZR+ZTtj1+0psRnL41BX74UMcnNKMvSGFu2MuLQMabKKNfz1osacqYc4
         rM9ji7pLuTDGeRePhgnZQ+0RA+3d+PIe/HaXpCDixlYagEIGJCqytlrVyhrWluZBpqYN
         oEcUgaRYPFKi6GMqzKn9auucofDi4YXa4f6Yf82MjOqpOHRMehkL57lMG7MibfvovITK
         EPYg==
X-Forwarded-Encrypted: i=1; AFNElJ9B1ZDVZUM0eCricnCw1LGBZbgFsBDfpbxBL58S/ZRc0bBwRP3RkrgLlkpyd0HMgP3ei46hmCYhow==@vger.kernel.org
X-Gm-Message-State: AOJu0YypB8X3MTr5wh/8jejvwHzY4OcpynWRTPfSPolcLgdxzIDsxy+1
	Kk/VTgIpPYQ4pbj7j+55TQhaFb3kuKahoGy+BDzPAFw2UdA6kiHsQpXhFWpuFFtZhC4ftKUlur8
	NjqKH2fspP8DGRFzF4EDGXRNHGnfZEdUeezj1wUq6JWiotegA0KSrsQfWhayqWQ==
X-Gm-Gg: Acq92OFM+nBgsV/BU7AfV7bt1265C9Z6ykWDkgS/TVFIjcVfyRQsdyuJidIOGknSiVx
	2sQS0luSPeegdPsT7mL7ylwO/NwY2Yu/kOkFkQUoG/TJ/7KLmToMqpM0kh8VToS2cNZGB5uwdpF
	87GKX3lCiKi6rdUs5GPrrYbGLjMrB4z8Ll/Wa8kXbG9M9IjpshoPIjfG0hC0Dg/mY1j6krM9+up
	VMDZx8iUXc+2kDk/nfvNxjbf7UrSsSLIr+aImSVEORgUd7cpJNiOV3ZL+rcP63S/rsLs97L4dWh
	IPsZBDVymyc9szBGc7ocdKmpAVvqGjYYyYwydt6jxQhSTXt7vPLSoJ7P9bykERMr6EP6xpucBwn
	sxz7RqpjOSRH4xu85d/Wart317uTYMGkqDKFa
X-Received: by 2002:a17:90b:3906:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-36a676f0275mr11474968a91.2.1779652205501;
        Sun, 24 May 2026 12:50:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3906:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-36a676f0275mr11474937a91.2.1779652204868;
        Sun, 24 May 2026 12:50:04 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:04 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:11 +0530
Subject: [PATCH 07/16] arm64: dts: qcom: shikra: Add CPU OPP tables to
 scale DDR/L3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=3982;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=iQFaTcU385uMezstExNkoozG8a0UndMZCSThcpHp83E=;
 b=PON3Dizzx46ZQQ5VJgOoBHEuQy1rR1kHnIsqcHLl0kNVPk+UXYFXfwMSfVTNSbOpVCtB9/WwJ
 ii9jhrh9EdgBreGG5xBBs8S9G+TMNTKKGVE0zJ1s0XCsPeXFNMnm6zM
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: O0gstJCo8vbX2XqQkUcZE5wosVjuTgck
X-Proofpoint-ORIG-GUID: O0gstJCo8vbX2XqQkUcZE5wosVjuTgck
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX3Cuzi10Bd5A4
 fNHIMD3qoLleYjO18KEXFitF01FO7Zg/7TMROiMdtF2OcdD/OcveZuSVdqx+7izl0j5L3kC2/8T
 GVPtYYT+lSUqvOu7/QqjNBhjv59vKqukLio6ZT72Ng5s/wd2eQy63MaTt9mL967jMHytase+tzR
 ZNYEF7k6OoA8zJtrbTzb+8xmqgb0beetRrRYbdWV8tq49p8jslbdRz+0cufabiUXjuxNsORyfBx
 /kfOx/ZP/zRG0ateAPShi2Ea3mkc+FTYwMtE+ldQBrgXNQlhCnC4EHeSKUl9OE/nbH3hRTI3FDr
 zqvD0eoWktUmDUbz0BY7zxOM37x7AoqlQ5SBBi8V3h+WkruMSOFjEZbZkDrKVIDkcxzKJ2V6RnV
 fGn1NyV45+TlINHVNPeca21lA5QIkqUZkrP8IrtzmU+8yJrZlQJKp2/mdDQKfQuzpZ9T1auKz0P
 1Bl2JYSnSrGwmsHYZOA==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a13566e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=16CLMFVtXTx66dpeFkgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add OPP tables required to scale DDR and L3 per freq-domain on
Shikra SoC.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 84 ++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index ebdb4bc15d76..bb1821e95248 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -48,6 +48,11 @@ cpu0: cpu@0 {
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 		};
 
 		cpu1: cpu@100 {
@@ -61,6 +66,11 @@ cpu1: cpu@100 {
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 		};
 
 		cpu2: cpu@200 {
@@ -74,6 +84,11 @@ cpu2: cpu@200 {
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 		};
 
 		cpu3: cpu@300 {
@@ -87,6 +102,11 @@ cpu3: cpu@300 {
 			clocks = <&cpufreq_hw 1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu3_opp_table>;
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 
 			l2_3: l2-cache {
 				compatible = "cache";
@@ -144,6 +164,70 @@ memory@80000000 {
 		/* We expect the bootloader to fill in the size */
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp_768mhz: opp-768000000 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-peak-kBps = <1200000 17817600>;
+		};
+
+		cpu0_opp_1017mhz: opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <2188000 25804800>;
+		};
+
+		cpu0_opp_1094mhz: opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			opp-peak-kBps = <3072000 30105600>;
+		};
+
+		cpu0_opp_1497mhz: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <4068000 38707200>;
+		};
+
+		cpu0_opp_1612mhz: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <6220000 43008000>;
+		};
+
+		cpu0_opp_1804mhz: opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <7216000 43622400>;
+		};
+	};
+
+	cpu3_opp_table: opp-table-cpu3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu3_opp_1017mhz: opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <2188000 25804800>;
+		};
+
+		cpu3_opp_1190mhz: opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <3072000 30105600>;
+		};
+
+		cpu3_opp_1497mhz: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <4068000 38707200>;
+		};
+
+		cpu3_opp_1708mhz: opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <6220000 43008000>;
+		};
+
+		cpu3_opp_1900mhz: opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <7216000 43622400>;
+		};
+	};
 
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";

-- 
2.34.1

