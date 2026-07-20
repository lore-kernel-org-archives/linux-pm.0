Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65753E314C
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544639; cv=none; b=X1zV9jAL0QGiPhFi7QkhFIsDpWTuY2mqd4obFYt9vxOTJn5ezwcYmISNZLSD0OyikaIHn9Js7s3SEMtQJFkJchh+C2H/33oV3pvF+Ew1+Yi8bcXkif+s1gz8PnQvgcPzUeWY1AXrC48AoEtaoETBDkaFCmOMAfvhgsA9e/VEL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544639; c=relaxed/simple;
	bh=MG3sAgTxM2yS2k98bs7iCxw+/UEc3/K3gbnTW3sIzdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaYyFTqP3sz+xyoqeC9hME9ixt9LGmXZmM4lrtm6S6CA++g1RPTsuzNyOu6vc6FXWHij3iUGZ8kGnvdhXYX2DF4cr7jU9a2UUvBwCjdZU+EqVSzdn7b2SdYLx/Rx7evYzprKFSvtuidPIinBchA+uLaYeyO4d5QBrDoa3RPXltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L1257ozP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBEsLkWc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L1257ozP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBEsLkWc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9vwYZ2321121
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=; b=L1257ozPH0mfcfcb
	i2O+W2nNr5Hhx4iKoJfYtg3iYZ7JzWfpY5BAxole7OuY9s1nn0ae7lvHD0tuPYrr
	wG8huGQ/Bghw28HszxwRTg80mqOH+gjT3MipdzJQ0NIOPEYV97p9TmlJIjjbBP0n
	QNWwcKwjEuuP0ObCGJEObGXG2YLV0hmktC9xSwoRN/qOED2zT2ochr2bDNnqVlHn
	AHBfG7oTdJPBrwrP2K8GF27MODHIRa1zec3MS6LxbOH2ZpFQC4EVv0BVRaxpstX3
	brmhEjFzeJ7RghMHLXP6kAbArSDYkD9dyq8UWSULBlp0GghibohuvexHSC9e1e+n
	TXgrOQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0kry3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb6dd278512so1158163a12.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 03:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784544628; x=1785149428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=RBEsLkWcR07so4HttWIcTjBRFClGTeziBJrWo9ppo0iiookIyVgsF+d9aSGovwRMGW
         ub0BZTAmE78MnEb7pZP+e/MK4jQ6XitTLPEnifaCpjMZOjAXObAd4R6p4M2aWgxjpm17
         dzslZAhJozEskRtaCw4J0GIKbVc4xGmOYa/w4/K1rVnwDQEJrS3aNpRJ4y7JFSpMwq67
         rA8qjSts/5o3TFy9uAaYqcNgOgETQyMq/MFp3/kxseIjY4pDnNcWxwL/sJVUbUm9mYdj
         Y7A8eYwdaEO5SnnewYUBJkepOKPhF1ZVp5BRWYLjId6tpY5c7Xdv4HKapC4F/RuZegN9
         Vb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544628; x=1785149428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=RUh2VFtTzGrZZMQGqyg7Xj/ZUP5YT7MCdUEkibbGUDcDNIHYDoXMBKEIGGCgPaG+zX
         X4JAQBgcUK5dOEJXmeBsBDVQ7JABVDG3mGdr2oZZlRdEzLjwwIJShoTz2BAIFZL9v8yM
         l1BH/gj2Z5ru8pVqaJG40fRxH1tfEvb1FI/aWvNd7Q5nV4HPhDtf1yXjExTrlPEIjHwe
         CZib54Q/TYXjfZENqQxeKoe2M63W3Ud8VRVFuFkq05kmmk+zgnjFGliQ29zRxsgO1uMd
         9znOclxk6l7/gPfxi5C0JEgyPf9UNhBoBoqNdiVQKIKIFv+I6iLd6LvOCA6yFy2BoJR7
         21JQ==
X-Forwarded-Encrypted: i=1; AHgh+RquuYK4VkcPTbW8SAkNtsErz9tx4VM53ixHexPu9HJrQCP6yBP0kZyhx8G2YPV8193y4O3iUJS4Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPFk8P7N1jNDldYBr37gzZjY2cAIWf/5yL9I1ZQLo7T39cdix
	+mk+zKU9Lkw9EGI1bQQP5LAXjxEnjVhL/4FWmmXFwxYx4N9Qno2P/e11LBWqJ2R0g5PMvKHDmKa
	c8yQa/9GsfmMS2vuk/gFsVwYh5jkPZDzUfWaLMIB3XfG87hP/F5HplIhaVZPdhg==
X-Gm-Gg: AfdE7ckcjkDQql1om3gsoemNkxwuvVbMiylSVHDKozNCSmu3Cz61VR71kOCKODR8ZGV
	CXpVRKT7hASXKqZcRSEGKBLLPm0y9l/D6JOWTIJbHPF1kLKYLSRrlJmB1B8uLX3bGqGlzQ1dYeH
	vn3inTbZvBk4+g6kS5xEqafnMzgCGG3Syfhv0A9dQfxXo7N5HFxrZGjQex80Lor6SPJ+fvQBRZy
	DCcNCQpWYkf8Nzhgdhd6OAPEvS2TBARB+jd3gAY2s9uoBQ3iSTh9H08Ze/h7q/we8Fg0mNBSE83
	/zxM8zAiZO4KlAsj3WFbmc8HKgHQFZsK+OAFZfB4L5JwTbfJlLhQEHOSWzsoebzgQnqcnRDJynu
	2nsGsf1YKAONnDA8=
X-Received: by 2002:a05:6a21:6b17:b0:3bf:c12c:2ecf with SMTP id adf61e73a8af0-3c3ada993b2mr12765708637.59.1784544628363;
        Mon, 20 Jul 2026 03:50:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b17:b0:3bf:c12c:2ecf with SMTP id adf61e73a8af0-3c3ada993b2mr12765676637.59.1784544627938;
        Mon, 20 Jul 2026 03:50:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb5159b11a5sm4343368a12.0.2026.07.20.03.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:50:27 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:19:18 +0530
Subject: [PATCH v7 02/10] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-shikra-dt-m1-v7-2-7dc99100c6dd@oss.qualcomm.com>
References: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
In-Reply-To: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784544606; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=FgXZj7vad2zgvA0RfnbjlrO8hgDk3pUjpoRSx0IOZh0=;
 b=Q9H9pLf/05l54JnlLMphYehPBHYQCGivmk44SyaH7YIRKDjrxdBXLR1Al3xgZb3WlEVZ/10Uc
 cHaaOTz/bOkBz0aOVyTfncgciS3E1/+1NFxBwX3khoGWz47Wj9hXDIY
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: Y-RgVd7XF3d11Oil1t_Bfzqq4dN_mi8U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfX82aa8JSWxqU2
 aNq6aPmdL1ht/UcuqEdiuEo36bCUvpidnr6c7CxBskAWRG1mtqk8kHN8kPdH5iVxZ6xC6jFxCau
 GFT3eteUosDjkSBYpMeSnWi6+L5EuTU=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5dfd75 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfX+AByp1PTsqa8
 SSptsyPGw2i7ucMEU5mlaqTDqFWTcNazz7mkUJSOpe+FTOqeXy5+A5f8zrqDnQS0H/tncN7vdML
 0QBHfV0T/B2GrLLhtpV9hWpDcoKX22zkGg7504vYUDUo4XG9qQmB6V68gcJLJt2+f20moIIKONl
 wnypdZNtLlrtrnXh2txLkXeAoCaqY/Gqt344MkflOJ6nBAPBm2VENMUyNr7X7+2w/hyEjjOGMlH
 mFuY4JvZOWtzY3pnwKTgH+EXa36ryXcKpeFL9bHkWENEdC2S2om/8ZcL+BNd2vU9ZvtnEei0bFV
 6cltG7qjynIiomzXVkg+ldd84BiA9OYRZ211kzopQeNj4jRBId6t8NgNY8ygjGPAEhp0uOU8wd3
 DcsOHIsh3sRICmfOCmLGLHz2+wICJruAT857+sskGpT+mAbF8sXhrOX8RqWERgg5T1fQxkuZKcP
 9Nws6Zcf70zsLNta3tA==
X-Proofpoint-GUID: Y-RgVd7XF3d11Oil1t_Bfzqq4dN_mi8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200120

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index f0fb55b9deb9..d66b97dea319 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1

