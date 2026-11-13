Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559495;
	b=OHd7YO/DsYmhQI3lBhMD/n88UKtg6wqdu01KVXLCR8TXpOtsG9SadxPcdbLQkChwYp4k
	 896D/ysfrN9miyzY+yyqr62H89uf9CiYaCj7LCaEcaiklPtOa9aKquD8raxf/eLCtFjlq
	 5ExlTYmsfbEoCD+NL3MgVK7uSrZ2lGnciCQfwCg4iL71DVg3RLu1Kz8vxGQFwrm2F07cY
	 +85QgodLAxqp1kVzuuuvD2SDzZrlSayppFJYX3bvFpy749IxNPr9HzsmuMHDzWZ+5ORlR
	 ike9lB5Ww6icZmL+bpbcJvLs9fB8nz0qKY2AEQh8RfRalLsakRzW2057ztZRDlqS7hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559495;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qAqr0y0c3ANATn/bhBe6uVlQ1yjBVTFNuYpOZthfFyE=;
	b=hcfo4KRbVIgTO6mrr7ybToq/Ci4aoKgPNzLjzoEapxsadTE8TmdtC3x6LOklmIlymZWT
	 Z43MeSo7SxJbQGLcBNDfKjIyjnPsgfHTajP5EXb16Ls+OG20miw3GkosB6XHWtlXyYuzl
	 ioDU0vbzKh7lYqPY6IdUnBWBoKSvipYUa2z8BWksPQC1+j9Uclz7/U/BIDG0nF4n5+GQc
	 B2/0rFAXx4K54bMdVjd+1IflewEDLdesZi5UFs7AyLKzC3vHBzEsK5cLBntgrJUrI81oG
	 johpEb0khhLa3QgbVhCRVCswTjPRsbHwD4lR4eigH7iDfyfvHC4YzljNDdrHvyqXMBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UjlG20A+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hD3uiBlE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B560A380A
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 734B560A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UjlG20A+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hD3uiBlE
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V8wn619218
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qAqr0y0c3ANATn/bhBe6uVlQ1yjBVTFNuYpOZthfFyE=; b=UjlG20A+H4dhVO+R
	Uc5ldBRge/eh2a5re0i7cVdw0AyV86Ef7wD4BeBJHnowM1vgCG5rigqRjVmn5dW7
	TOa2CwdDdD2N3kJGgLpeOv12n26HpwAhKIDHqZTAtwQw+2XBlAkWjhS8ZAmKyee0
	K2MSGlC2/Ocug+W/BgHkxtxfoVaNe+k+aKAWmmS/oDIm+lDgreHTwMvKxL2V6yHX
	zy/hAH+k+BT3AZQYu5tnwis5XdkIA4ffECcRZms3F2s9jP7HsCK/p/ABZwTcpGUA
	8/Uupk2LDMv4ieYyBPa+XzHJ+5SYnotZRrAOiy+nq0k3IcByWryf66knaUUJrkGO
	eSqAFw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs048w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36d1353fdcdso3309793eec.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 00:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794559493; x=1795164293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qAqr0y0c3ANATn/bhBe6uVlQ1yjBVTFNuYpOZthfFyE=;
        b=hD3uiBlENyAvxPUPrfuQgWnTnTQdOtYzhEs75uOg78fiBrC6H5ff1LTTKvvlStRl4H
         W6E8HD5mvbNMjBGDHXA1O7KTfyvUFDHB4y1bRO7Y6Ok96frHgyS2DMmH/s1Pmy6JZSNG
         6TVLwYx86uqmdRPLelXKI6j1iotgYt0refg8Q91Yex/iI5HmZJtsBhRb3+inWWSdovYG
         7HD4zm9E34ZzGMxxpfSLVE7aipeyiqFIGVX9soYXWCBMIc5DPO62f6YFYvcEgUukCOgp
         pz3JfjvIzSFnCMdUZXZ8XBkxuGsFv8vkrgXENGkEsca4uJ8kX6W6tAVzLmrHcYjFOGbl
         qSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559493; x=1795164293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAqr0y0c3ANATn/bhBe6uVlQ1yjBVTFNuYpOZthfFyE=;
        b=kM+DkL8smsYZEhzu8FKvlK6TAbr+RSKOgJXKxw16jLtgMowPcZeY1uXrt/U0diVIRh
         AK/0S86CCKupcJ6D42KTT/8DmivlbbaYSmDEFf2Sg20sMvwUkgP7O2vngpfO1wN1aEjI
         0XWZ1G337v+T+nmEfCL3DFcQsvCiJBuq5/HImyV2mgk3XZkER8xdMBLLQLxbMlez1V94
         SS7A0+ljFFRNiml9c5hLF8LA5RCwwXxRAcCIpr41iQ+6jfepRXD7LVTdYCGH86XoF+8i
         HbmSoAUKXQWpH372GnovAH7TUJRdryqMroHhb24xpy7eGRV4OP/K5lHLeGjjmvvGqy5W
         C66g==
X-Gm-Message-State: APuU4Z8IB3qYSQYuxD3f5ZuCHw7SrVSEqXGUz+T9d8kRyVxb7vu6RVVq
	INdMW8OwY/49bBYnAgmTVQV3B/k7KSu7fish+Ua4d1LzIpt4yJqaSpKvq82MatRM4/ezJPOs9Nr
	NcXPwH3OmoHrleyg2jJnkhkDwc6k8fJD1FX8MQff29Hx0QZ4QLfcREZmnxC1uFA==
X-Gm-Gg: AYBFou2LpiL6cLb15LWV6qlrN5GYnY8g6rV/OVtdb54k54o0iJXw2UFYSrwRJl3GVhD
	p9rQHD334TrIEV7Xog6jDPqNdGR7MSpM6ZldOL8wsbBrQz1L2+eUFrI8lSEd7Up8WjWPSSN0huU
	OlgcMS/UBlXJ2/FGj+lV5u+tIuh0VOiQwSnfaz2tbXiqfaCsu6sDT7AQ0XHfpmz7QIQzLCRn4Gm
	KNGD1LziEz9mUq0xx3+xQ6AC/wzoTR/lO+T0JJJYGUenSHPAuK7NGttIJLBxMj89BP4OtI1iNKi
	LuPF0IQQbFb0J4xhjKlKn51EXZL5LO5vKfrvGtaQZEdSCQIwz0Wi/+JSPl3274HFj3hS4hLWp/c
	dYMmPLF5uOyJ6UIH8Ewod50jHxpQhctyWDssRL5eFwB69//ZVoWV1i0AoPe4Fwjswd6mpQ5LWNf
	BtnrU=
X-Received: by 2002:a05:7300:c7c3:b0:376:972f:afa9 with SMTP id 5a478bee46e88-37966387a09mr1646206eec.9.1794559493246;
        Fri, 13 Nov 2026 00:44:53 -0800 (PST)
X-Received: by 2002:a05:7300:c7c3:b0:376:972f:afa9 with SMTP id 5a478bee46e88-37966387a09mr1646188eec.9.1794559492485;
        Fri, 13 Nov 2026 00:44:52 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm9662357eec.20.2026.11.13.00.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:44:52 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:13:48 +0530
Subject: [PATCH v3 5/6] arm64: dts: qcom: kodiak: use thermal hw-bin trips
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-thermal_bin-v3-5-878df6eef8bc@oss.qualcomm.com>
References: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
In-Reply-To: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559450; l=6059;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=el2uGrzjfzzcr0/E7ywUdoy8ioWHrdz1v5pBik7reFk=;
 b=J+OOTjtl5hfULeACGvJNuVOUjQzTj+1UZ/UcpG9FG5Jz7+wEC9Mb5ILgzp6QYEbYJ7L9J223N
 aGfSOSxA1dCATYNGI13oipI6FVpvnHivYaV9eiAyH0VNeaGuVpXEkuJ
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX4hunCozXmpv+
 tpJa7cQR1MaEiztIZWrSTJl74DOpi8DQknCqoZsfREMClllUdVcOH7YJE0Lm4oJWJRMA1LCM+OL
 z7WMZ4p205dYtWkBV7XpgJxYzW3Rdy9vRCpTrz5rOu5udmuD3g4FjW9DzbpfIxThsfljrLMdgtM
 jg6YQKBAvV8QyuMm65SdAt3tAu9URXsyeW6zhTxg6paq+siFOaTXa/uQvLXLENRPCEjLQkddFsz
 Jwt042dkV1X6fAyyC5chQJDu/kD10akj4kuL9iwquQBRul8gT7eCG5V5TSl7JwOea3qnr9c027p
 7dJ9pp/1eIswVyOw4XDA3AllgQTGkLION6LVoFBuiojEs5wdVHbUbR2Z+DTbQAN9/4vrw2KcjlM
 dyVllF5Wpm2lcnMLZS6tRyFUFQ1PxdyyMILjgk2JWNMgylzyXPRR+wTfSwfEz+6JvC+9PFcP74k
 f+6wTzEyoiZl3R3EyOg==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af6ce06 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=PCFpqnHMHODqJTmB6Q0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX3Bs5T3qZvhm6
 JBMg4DxV2+Y1LW2pedRc2kGxFfZ+H4ILolZGT+fudpPbKYR5SHWx2jYScdU1ZnQ3QiFq86KopLT
 6djK3NwLLt3K82LtO/WZBzOMZzvZULs=
X-Proofpoint-GUID: lhIzNL1kBeaOmcKLK9P-ZAFaa1tYbzTN
X-Proofpoint-ORIG-GUID: lhIzNL1kBeaOmcKLK9P-ZAFaa1tYbzTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034

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
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 58 +++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 10e9a5279ed6..79553bf43a7a 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1028,6 +1028,18 @@ gpu_speed_bin: gpu-speed-bin@1e9 {
 				reg = <0x1e9 0x2>;
 				bits = <5 8>;
 			};
+
+			jtag_id: jtag-id@180 {
+				reg = <0x180 0x4>;
+				/* bits = <offset width>: 20 bits at offset 0 */
+				bits = <0 20>;
+			};
+
+			feat_id: feat-id@180 {
+				reg = <0x180 0x4>;
+				/* bits = <offset width>: 8 bits at offset 20 */
+				bits = <20 8>;
+			};
 		};
 
 		sdhc_1: mmc@7c4000 {
@@ -5810,6 +5822,8 @@ tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 				<0 0x0c222000 0 0x1ff>; /* SROT */
+			nvmem-cells = <&jtag_id>, <&feat_id>;
+			nvmem-cell-names = "jtag-id", "feat-id";
 			#qcom,sensors = <15>;
 			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
@@ -5821,6 +5835,8 @@ tsens1: thermal-sensor@c265000 {
 			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 				<0 0x0c223000 0 0x1ff>; /* SROT */
+			nvmem-cells = <&jtag_id>, <&feat_id>;
+			nvmem-cell-names = "jtag-id", "feat-id";
 			#qcom,sensors = <12>;
 			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
@@ -7164,7 +7180,8 @@ cpu0_alert0: trip-point0 {
 				};
 
 				cpu0_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7207,7 +7224,8 @@ cpu1_alert0: trip-point0 {
 				};
 
 				cpu1_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7250,7 +7268,8 @@ cpu2_alert0: trip-point0 {
 				};
 
 				cpu2_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7293,7 +7312,8 @@ cpu3_alert0: trip-point0 {
 				};
 
 				cpu3_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7336,7 +7356,8 @@ cpu4_alert0: trip-point0 {
 				};
 
 				cpu4_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7379,7 +7400,8 @@ cpu5_alert0: trip-point0 {
 				};
 
 				cpu5_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7422,7 +7444,8 @@ cpu6_alert0: trip-point0 {
 				};
 
 				cpu6_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7465,7 +7488,8 @@ cpu7_alert0: trip-point0 {
 				};
 
 				cpu7_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7508,7 +7532,8 @@ cpu8_alert0: trip-point0 {
 				};
 
 				cpu8_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7551,7 +7576,8 @@ cpu9_alert0: trip-point0 {
 				};
 
 				cpu9_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7594,7 +7620,8 @@ cpu10_alert0: trip-point0 {
 				};
 
 				cpu10_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7637,7 +7664,8 @@ cpu11_alert0: trip-point0 {
 				};
 
 				cpu11_alert1: trip-point1 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7752,7 +7780,8 @@ gpuss0-thermal {
 
 			trips {
 				gpuss0_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -7779,7 +7808,8 @@ gpuss1-thermal {
 
 			trips {
 				gpuss1_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature-bin = <95000>, <105000>;
+					thermal-hw-bin = <0x1>, <0x2>;
 					hysteresis = <2000>;
 					type = "passive";
 				};

-- 
2.34.1

