Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EA390CAC
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262757; cv=none; b=bhyzoVjSf0Qbh3ZcZCfYI77UyJ7GlLLv7KdqZbceJgaeZFMP4+tM/9A23wSUR/5J8WrjwZs8x8+4FSdXeeMpF+5YpYWSJrZyU4Q98z5NtVoqr7udqk3J8TYdsXCMBfvhxK2maJmNkfQNesssQWQbKBS15yZY0D5UVoylCNR2o74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262757; c=relaxed/simple;
	bh=WeA/Wy9c5MKU2UD2GwOeQhDQz66ME3bEbXly4eAnD0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYb8qAOlff3YFw3slTGg1nrqwQENlTODbY74kqNgX083s3AowUvHfGi/7wMQNsFHGsVD2DhdoWxTuF0PrjAw5ckrNhgjf2VOQdMKqP7smDgRHfBPjcH6mJ0xXUR15f86jRJCFapWCw9+FWRotOkkYD161AQ4Ujul8cwWfE+GBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KTd/gwOO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KGQPDJFG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KTd/gwOO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KGQPDJFG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N83rQI1364245
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5iJieZ8EQcjhAmKwiUQKT3yTUvEdnOkURgGJjmiy/Gk=; b=KTd/gwOOf/EbbgJo
	KxFuHjd/VrzWTBrgK8XsL2VryXdmHIbzRosiY8lLFhGaVBdMZsqgNev+0Tkw3Hek
	9j9aAUZNnXxPR9H5XkEvnNeKmNwMhrug9nZ8LYwVc3CQaDFWpbfB9EoVETmaMTJ5
	ntWzCoHUp+5IqgXCCuZMj3wEsLC98tTHY87DmgfwhD+IO5Ec+QEj6E2LGI7OdDFv
	bnyPLSfPSQsBWnFWwb/8GBOFs+KcGv3anOEXpYc35Tui5Q+nYLT4kC7E9+GHIhZP
	wct3scZPldZx0s4hQZnTYJsSBP1dKoLhQvDKkU6xSUMan2PpRcsJNXT/kTPynRCD
	ERooyQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p78ktv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aec07e8aafso5220355ad.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774262753; x=1774867553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iJieZ8EQcjhAmKwiUQKT3yTUvEdnOkURgGJjmiy/Gk=;
        b=KGQPDJFGyWEZmrjNV/sZ+sVX7h6BoCPR8V73Ui/ndfnPIKFacG3qlOyVNUh0JRA/ID
         B85r20/A8BU7epeLw2FIl0JvYLAB4JAhl287OKc6cT3jRWCao18JpHbzEbh2VFfpaXXg
         fZJ9OrCTyceDq6danJMsuxBSHJJuHnsyVYdJW65FzE3A7thieCO7ZCELJ8UwDCNt72R6
         Rnwv2jOy0veCFaaNbbP06L5r97V0BgdwGzuk7LwV61eHf/4TZ6Xqhnigc0UK/22TNI9e
         8crgAYQ89bI5y513xmAMB3sTJipiATkqyhgBW0Pmle/wKnvdLlhCv5Agfifyn7ChhI5w
         L1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262753; x=1774867553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iJieZ8EQcjhAmKwiUQKT3yTUvEdnOkURgGJjmiy/Gk=;
        b=tZEJVoUszPJW7iZb2g2Me5LpmQqtJw2ZSOS3rDXM0I39aqIdeNVV58qnVP80oG77iR
         UFy5lujiT2l0EW5JE6o7HsuGWBDZ/3Ok+bLpNfxukVrsy9CvyAPmkT8qBSQPSFXSmuYa
         pJyyWXDQcbsTolltOR8Eu5ssCs0ZEHtzRjbMb2KDN6NBk7iHNKdg1XRpRELq0Fqdflv0
         +S1o4mIzOzlXkUV52DxfIGyMKgSCyKR0inOIDjWFjhJBiS+jWG+vKM0HnvgU+OEgp35H
         4VbEOiXnB/jTw9CllD6Ht/mqQj0EBHlHlNTXz2Uoxv2uLxxIXUuHmlhDsXIn3Ipe6CsH
         I0yw==
X-Gm-Message-State: AOJu0YyYOux5SJGeXiWP+vyAlNqvI/yEcDe2EhBD4RaCHGh9YAVLD+I9
	6cqNeC5tjJNY9nAdJo5Z33+5FEGwRk1gqC08x2ajGlRejpor1oakHmuMsLZSXkernZ6JoakB9G+
	I7dlkzcXGkXwSFuvtg9CDvotfvzoNvRxtMCfpDC2ZGcsCobY+FP92yj+BQ5EF
X-Gm-Gg: ATEYQzyTST0H6jqzqtcWK/Ci/3APfKSPxdo9mVsWS4YNdM0D5VffCAxgkooVX7exblx
	zJ2PXkIKlRtmbVBey5kACajM2yf/IoCEMM6JCf7ADyrMhPbqMa0cclb3kxiDsOoqFI8XCQjloMn
	4aWwMX25nXTtC6vOYApLgwbjo6XgixWpX5IIgvvEeNOGTNGYPmd8C5kHgExoCpYzkzmf3su4xcX
	44JvGzAD+fT/F97r4ahTXgOLqb1RdzrHGGocgphB0xppJeHLnV/fGjt0Pep0Dkg2ld3F1Yurh8n
	ZK9jFRvjMlE0Mp15mNGvlYpirnlmYFv6WiRJwVNye3l7zYDSZsBfRCJYZI5SP7XUHl9v5Hsjzk8
	X+3/BCmaMGBqKTFdjEMi+/+JZWx292leWIE6V4f0CYsY2H4IKQxk=
X-Received: by 2002:a17:903:191:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b0826ffc53mr106427685ad.9.1774262753165;
        Mon, 23 Mar 2026 03:45:53 -0700 (PDT)
X-Received: by 2002:a17:903:191:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b0826ffc53mr106427395ad.9.1774262752623;
        Mon, 23 Mar 2026 03:45:52 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08340c2edsm123454225ad.0.2026.03.23.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:45:52 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:15:16 +0530
Subject: [PATCH v4 2/2] arm64: dts: qcom: monaco-pmics: Add PON power key
 and reset inputs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-add_pwrkey_and_resin-v4-2-abef4e4dcc3d@oss.qualcomm.com>
References: <20260323-b4-add_pwrkey_and_resin-v4-0-abef4e4dcc3d@oss.qualcomm.com>
In-Reply-To: <20260323-b4-add_pwrkey_and_resin-v4-0-abef4e4dcc3d@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774262738; l=1670;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=WeA/Wy9c5MKU2UD2GwOeQhDQz66ME3bEbXly4eAnD0s=;
 b=Svn6C5I/dHV9C4ehkYF7aQh8OUHsKtYahZmSzLguhV9MsNFMH2T4+nmhaTRLEo+Sj0SCRDHiH
 LdWDSKM+tamDfjCSFmmsmLEUwxub/1iaEfJ6RSIRWZCNGhUtriOqFQa
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c119e2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=f3aK1VMAgMfWcFvZUCoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: zyQ475SBtgaOA8y56O-cTdf_u89t4bHL
X-Proofpoint-GUID: zyQ475SBtgaOA8y56O-cTdf_u89t4bHL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfXwlAo1K6maPMG
 0hV1YbkEtdfyRqG+T7kJ0ANM+gAePBtOHygXv+2MYLYzoM/YuIj8PwRgw2w3SzKmnHWVnGiiVGv
 +py9eE1yzYSgdP+iNagfSSc2bZD07tg2ZB1KwavC9wUYMYbLt9RIOUVOccnfivM8ZtelTj46YRk
 ItM1Nfn/rDpVXtexICe6WfujMQA7SFaUkFfLsZv4/wh095Ud7OEnNz81BHG46bi4e6m2V8wXfNo
 aN1MB7yZm5eCUVcDrgZpzXeOoW53Qn7DqOvsC8ooMZDijXGZ6gHKuVOGKTBMm+eBR8YMKWze13Z
 gbhYk1t5WCFy5SLTw4nqXNzIXxQ3az+C/nVvh1z1wu5C9/9MVqXGWcNubCCCk3/V4xiVm28j554
 EmFUCVDiTVPTU7LryQv1e7OPWD+VPFWLa5UPlyhJEuw1pZ0TkCWSeC05oGV8+M1dLO8n3zBAKML
 aIrbSGmmwtbqJaynjIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083

Add the Power On (PON) peripheral with power key and reset input
support for the PMM8654AU PMIC on Monaco platforms.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v3:
 - Disable the resin as suggested by the Konrad.

Changes in v2:
 - Add new PMM8654AU compatible strings as suggested by the Konrad.
---
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
index e990d7367719beaa9e0cea87d9c183ae18c3ebc8..af4c38309efae89479f9a11fcb970a4c18f03a91 100644
--- a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
@@ -13,6 +13,26 @@ pmm8620au_0: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_0_pon: pon@1200 {
+			compatible = "qcom,pmm8654au-pon", "qcom,pmk8350-pon";
+			reg = <0x1200>, <0x800>;
+			reg-names = "hlos", "pbs";
+
+			pmm8654au_0_pon_pwrkey: pwrkey {
+				compatible = "qcom,pmm8654au-pwrkey", "qcom,pmk8350-pwrkey";
+				interrupts-extended = <&spmi_bus 0x0 0x12 0x7 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+				debounce = <15625>;
+			};
+
+			pmm8654au_0_pon_resin: resin {
+				compatible = "qcom,pmm8654au-resin", "qcom,pmk8350-resin";
+				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				status = "disabled";
+			};
+		};
+
 		pmm8620au_0_rtc: rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;

-- 
2.34.1

