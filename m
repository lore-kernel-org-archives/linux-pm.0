Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27712486620
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938073; cv=none; b=X4FcvWK6q1m3UUUoKXK17ihtZOvpWtGoKS+2qpj8wbwYgDVjJkjmy+LeNRH0mAl82B3eyDuuzPfv6F1yCQuAE/CzXUOrOFwhPVB2jb2Tgmss20M2ITEKYcgFMLA+FuQonGKv4TgRn8b/Uyvdm7VE8g9CIe5w4g9D7fW1tweW0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938073; c=relaxed/simple;
	bh=hO4a+7Zvdj8XTlKgTW46Rri53omEFki2P6BPSZBNnTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4CNj1RPsQHTnwxhNDs6cTKs0qGLuL2CARb65fErhtpHNrwE+7XTflu2LLRxO/V9iKDgcRr8x3PDj3lfcZlgpBBdN+GwakPBkV99UC24VinGbtHlxzPcdiThaRKfggh5P8HXl0N+e23TmpNuJVitKsYU2VPrZ0Hq18iv764JSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TLcMsogE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PQEa/+dg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLcMsogE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQEa/+dg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929ns812063053
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 10:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X80dge3YPwdhyr08OpURaEYH+EmouwHvEjY9VNrf9Q4=; b=TLcMsogEsYyr3kF8
	QMxMVQ8woqb/qwbrVMi83HTbo2gHzIEWvBbBfRu1xFv4IyZmMJEzgLbvlSOEhecr
	/ws8BtT/1a8OCR+BQbc9K8PwG9cEc63ERrmTB931Io9MomcN8WpwO4CqwyhdKd31
	V2GShLfmwes4S5DI7I0w1hfcmXP0Hc5GvlYRZHdSCC+McMceelK22OWGC0DOoWt0
	Hrxm0rKWHIbDh/FK1zbUMEEwBzGmcPyEsYBVj4DcXogLgtTK5IvZHI0jtix/8Y3V
	u18nUgrOj7XtrXZLGvg0ei8Cpe8m6ASEJWrQ9v0ZvTuaV4m1A9FnjIJkBhcWXtgY
	mqI8Ow==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256ms55b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 10:47:47 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14fc5852326so436875c88.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790938067; x=1791542867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X80dge3YPwdhyr08OpURaEYH+EmouwHvEjY9VNrf9Q4=;
        b=PQEa/+dg2oeQ4Rr6vJflF8odZed0JEcIxzzPMcKt7GAbVcIgUkRqVkuH1FP6MSfAME
         PnZX9RTfZeI3n3LLlP37Vw+K8tES88gWYpYnzK5ud7dRdCuOH5lG0pzxQ4vgwaxlZaly
         +tMHU5AO6gr1Pq1FSxX7DVRTXccnO92Vhq1VqqGXMzgToBLmIyvuF89CW6FKwOvnqIab
         vicn7wtQbG3tzGD9Jyr63+P4jZL21PkP2JfXYl1REVnatQBIjrBFfkQ/m1hLEjUVxS/u
         pqPlRQs2UpJ9XnRtUf02Mo46ntsQR1veXsgkM7tJmdJGZefgp9YQQ3dYWAXj5Q77Be7G
         OBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938067; x=1791542867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X80dge3YPwdhyr08OpURaEYH+EmouwHvEjY9VNrf9Q4=;
        b=t/+psa3cInCuyVHh3RiCZOH9Ic/asqCAAdSI1of3bOfqitHFVWV1ta/UMUDz82Geso
         EiU+hyqZj5nxkojBMcZFCQlEdMclniOV27zE/vJSzs4ATP1o3FkLDD9+6on0TBuSlcsV
         E7vu6rnkzMMJSIZwKm5KkROo1n/eucXxDl3NjlZV0DdtjG0+UlWhsVCe2rEr5xpzN59Z
         pLZvnKEvwEf2cZlR+MAeXM9W0m4e2LrksPNVnc/YDsGfOuwk3gkV7uasmricF/NKTQGu
         uvISO+siP+HMb3CxALqgng1WG+tT/UCJe3+EkygxrC6SWt9Y0gWADwOmhsasyOvI0PEB
         YaxA==
X-Gm-Message-State: AFuF++lSQ2wEAIaatoMF8tOcQDdCCXFjdS6jWGoCSqv+JJwG64YI4v/d
	59C8bQDRsZZGcvzIxKr4pMPo529IT7Jzpr4ZF2qg9O7rG6Vg8sA5VnlGrZa4islfux4SBmm89bl
	INQuf3e9pq4D2YFG2416/BmOJDgwAnNw9EkWXg7z+0pLy55TbJSwt+T+x7CUznA==
X-Gm-Gg: AYBFou19/wxhp9vXybWepT7UvQ4V1+jEtVZRINSOoNtD5G1H1rx4Ep5bbd1vcZe/qCQ
	QBr2B3v6XtlYnBvxpkzgiJrEhf8U4tkPEm6MP9MWs5YO4UqNsKAlQ/D8bUuL86h9081lKIw/bvy
	ANU5RZoEkPm7IBc8SEK9ScUKA7XWCbn14RabKfIGp3m480kQO2d8SoAjKxe1fb2cZRd1hnmpLPH
	juzTialR2MN6zok71JFuPawA90OB6VyeUyP8AYNqG3tWzDAugQZpiEbX/OTGwTUaWXqUq9sWHAy
	iDV+JndhhIawP+97OghLlbfc4TNxkNxuWF2HIamKMVQdj6aSGR3aaZhUqOzDTPEcgna9kmYJwou
	2sol2XZGT6DtrPSWt3Tagf3VoEKC1
X-Received: by 2002:a05:7022:f90a:b0:143:33de:978f with SMTP id a92af1059eb24-14f5d5b569emr2136111c88.43.1790938066885;
        Fri, 02 Oct 2026 03:47:46 -0700 (PDT)
X-Received: by 2002:a05:7022:f90a:b0:143:33de:978f with SMTP id a92af1059eb24-14f5d5b569emr2136041c88.43.1790938065480;
        Fri, 02 Oct 2026 03:47:45 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm10645191c88.4.2026.10.02.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:47:44 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 02 Oct 2026 16:17:00 +0530
Subject: [PATCH 5/6] arm64: dts: qcom: kodiak: use thermal hw-bin trips
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-thermal_bin-v1-5-5a29be7e8ec5@oss.qualcomm.com>
References: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
In-Reply-To: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790938020; l=6011;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=a6O1KIPOWA4+uJZpjWzOTBPzZdII1cPV5WSWpRYZeGA=;
 b=Xg9Vec9RxuFvMmQmDajHyuKWJVuqSXQ+8kNYhVM9X+xDYAvo3PoK3tiKi7zzMyUEULw8nNOZG
 o4T2BQxRXCzCNpN3zQwcyHERf+6ziW6GXRSswQ4lgyiy7B96IRtn5J6
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX92NkEuVLeXEc
 ZedDVjBieE7X86o2gZgMJgDGg5P2sk8mzI5TW1if7Nx3diEfLC8Oe/U9DmjADq6Yo+iWOBQRBJB
 9epl9yZTFD3DIgliY69j9qK7/qOmfc8=
X-Proofpoint-ORIG-GUID: eJd-QDSBtQuAO1D-nUuTAJrsDBFB3xWA
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abf8bd3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=PCFpqnHMHODqJTmB6Q0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: eJd-QDSBtQuAO1D-nUuTAJrsDBFB3xWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX565iavR3CbWn
 HxLTg42k/hk3swQ7fIfjF/lFlp/1Q0OCD5XjM9s+DS+B7m1Yfyhb+gozHHSTejcs7L1fRTPuEdk
 MB2IjUTlyIoGka72d20F1nh2tMbN+nUb+vbFvDHbG9vSmFzTVzQzAFhXPHUCSpowgJ8Ka1Bptaj
 VtOWl1dlSvUh2AfY4AZLoQsAAGqBQDRRXCT4/SIRoOVoIjW34ZDjhqid+Aqq/4HIRkfEQ+MTh/h
 Xv28wPYVwibwtIHf4ApwdGWFZwfCpVxgwH0zAYrSpqBPx98aLfBKwpWixPY1CzLMAmwvc/O+I3u
 Bm0DslUtGRm1TYUf87QTcObXiIvGqBWbRcrhHFmJoiERSPEzWNE4beCOPKvT2UPrsMjASWBEPQw
 8a7vDuDVlz3c7iNgN7ZY4JfPp8FQzwFJyGa/L4cMwfgE24FE13EuUtHGy8dzocz6pkHOSclc6CV
 Kc0/y7DVLlkS/O36Ezg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020042

From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>

kodiak-based SoCs are binned at manufacturing time, with the bin
computed from the jtag-id and feat-id qfprom fuses.  The tsens driver
now reads these and feeds the resulting bin to the thermal core, which
selects per-bin trip temperatures.

Add the jtag-id and feat-id nvmem cells to the tsens nodes and convert
the passive mitigation trip points from a fixed 95C to per-bin values
(95C for bin 0x1, 105C for bin 0x2) using the new
temperature-bin/thermal-hw-bin properties.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 56 +++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 347815e5983e..f3bb9cd8f393 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1019,6 +1019,16 @@ gpu_speed_bin: gpu-speed-bin@1e9 {
 				reg = <0x1e9 0x2>;
 				bits = <5 8>;
 			};
+			jtag_id: jtag-id@180 {
+				reg = <0x180 0x4>;
+				/* bits = <offset width>: 20 bits at offset 0 */
+				bits = <0 20>;
+			};
+			feat_id: feat-id@180 {
+				reg = <0x180 0x4>;
+				/* bits = <offset width>: 8 bits at offset 20 */
+				bits = <20 8>;
+			};
 		};
 
 		sdhc_1: mmc@7c4000 {
@@ -5782,6 +5792,8 @@ tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 				<0 0x0c222000 0 0x1ff>; /* SROT */
+			nvmem-cells = <&jtag_id>, <&feat_id>;
+			nvmem-cell-names = "jtag-id", "feat-id";
 			#qcom,sensors = <15>;
 			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
@@ -5793,6 +5805,8 @@ tsens1: thermal-sensor@c265000 {
 			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 				<0 0x0c223000 0 0x1ff>; /* SROT */
+			nvmem-cells = <&jtag_id>, <&feat_id>;
+			nvmem-cell-names = "jtag-id", "feat-id";
 			#qcom,sensors = <12>;
 			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
@@ -7136,7 +7150,8 @@ cpu0_alert0: trip-point0 {
 				};
 
 				cpu0_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7179,7 +7194,8 @@ cpu1_alert0: trip-point0 {
 				};
 
 				cpu1_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7222,7 +7238,8 @@ cpu2_alert0: trip-point0 {
 				};
 
 				cpu2_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7265,7 +7282,8 @@ cpu3_alert0: trip-point0 {
 				};
 
 				cpu3_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7308,7 +7326,8 @@ cpu4_alert0: trip-point0 {
 				};
 
 				cpu4_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7351,7 +7370,8 @@ cpu5_alert0: trip-point0 {
 				};
 
 				cpu5_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7394,7 +7414,8 @@ cpu6_alert0: trip-point0 {
 				};
 
 				cpu6_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7437,7 +7458,8 @@ cpu7_alert0: trip-point0 {
 				};
 
 				cpu7_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7480,7 +7502,8 @@ cpu8_alert0: trip-point0 {
 				};
 
 				cpu8_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7523,7 +7546,8 @@ cpu9_alert0: trip-point0 {
 				};
 
 				cpu9_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7566,7 +7590,8 @@ cpu10_alert0: trip-point0 {
 				};
 
 				cpu10_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7609,7 +7634,8 @@ cpu11_alert0: trip-point0 {
 				};
 
 				cpu11_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7724,7 +7750,8 @@ gpuss0-thermal {
 
 			trips {
 				gpuss0_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7751,7 +7778,8 @@ gpuss1-thermal {
 
 			trips {
 				gpuss1_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000 105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};

-- 
2.34.1

