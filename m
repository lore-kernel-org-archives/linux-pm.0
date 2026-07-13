Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2B356762
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971448; cv=none; b=QRyX4VMcKZqMqNfOzQlffVETdofafXq+icQNzBx6IKXYnHKkZXqutYjCFE27i1dWOcTZCOPoF3UGnvejrl3Prxnqzqt6ad4N26gl/WL+MUAiRftTMYM+FeEasHG1pZGws4rKZcZbb42emjYjP/rxkv4n0Zu2WrWyQjIme/b9fq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971448; c=relaxed/simple;
	bh=MG3sAgTxM2yS2k98bs7iCxw+/UEc3/K3gbnTW3sIzdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edoycBcflKDwQ0KMSFW/AFsGU00bS0Rr9aMHvF/PDIkur42jlPmrYqRBRgJ7JWXDhIehpnMAtHRbUyco1ZYKkyDvVkeuHHfEyT2VBDEQ7qDaa+V/wvJ4EVBtWFdVvDwL21uObZwioUKlCeepM2z3zZlVgA8P+JFJ36wFRdcQGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJNla1oC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VENVs3s6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJNla1oC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VENVs3s6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ97fI2275365
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=; b=YJNla1oCkmh2/frg
	3NzRL+lxHZZHk2V5Sh3+gxiaa9sm+cF80ZPd5islSQqyjBB2vop7C9At2xxXz2By
	wLxgU1kcD8oWfGkD0itXOA0fVNvWPEvGUhV6qYvXok87FN1L1RNhFOhnIkAZLCBi
	pqTltNsyREvnrLHuP1Dlg6w4VsSrXNjJNKX899x26bVUGvVc2k4hWHfxWC3tCFOB
	JeyvBY/db+Dw7j1GzDsrgJX5C4VPk5UkVqzdt/GCOijMnlvFx2Uh7cC8hvmfp0jI
	ErM4RblIK3k/uvbs7Ho5jO7r3vIal20Iw4fPCke5UsNrFbbb0eerNUXweA/tlFNZ
	XT0pVA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p0hmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811279d51aso368007a91.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971446; x=1784576246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=VENVs3s6R34UVnQPBe+UCdUBLQHE9AYjREglUlLmrS4RSZ4uf5g2LX2iNUmzyNJPGA
         GBQHfIQK3/dtrNXg3nFjWVoaR77/b3Z25HjH+CEV2Di+SxQwacMrhY3V/RuDhs6BwWFO
         fKinw+ZQxbNiFzLC3EH+R9h6davGGTCVz50UOx8a2pWNTWPhyfa1wx1ZNC89pxhiLbcq
         P2dQBQCtIHib5bsOER5pQI/fk86SOPnBr1Tu/5ox3GR3/cMbzjLaiU9zYH4bc3mD7lqX
         FmIkDGYPP5LDbIhEksVOsqw/zOT+rbNLP58+7vRQHVX8RLJQPS65wzIzeGAZYj9xIuvr
         9ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971446; x=1784576246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=beqxTav0wKMF1lQ1CgRwoCF+JfGj709Yf7xNOpnejJqNVVaFgT9vcpTXYid/aCNkwH
         fifFdULVtxH7N8gE026HnHP0vr2BUyKNMHg0PRlpUDwh6eVSIlN/jWSYEitsK9yfMu48
         xIhXQ01N2IK+o8Z2anW8paTUCEh74VaI2Ot3zzoP6VEyr+POfLbedAcXMrz1Q0b1oibd
         /5fUniOUaoEaPJcHwCYWK85Ydeh3deUxHlGGNHGw7qRSNKBMbEu+3VjKgGfEEg5+e6O4
         SKKTPkVEO46ym2xlvEzrlMFLDL/Rg66qenGS/wYfVGuEwUIsJY1fCpMoZhuyUSDX/da+
         8//g==
X-Forwarded-Encrypted: i=1; AHgh+Rotnp9UwF7MdFLo3QliGlPNtCThOGke5LX2qbBwHpPOnllCnNWQOikEIkdve2SjGTsslylcO2+7Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxktSpsU7Km80UNwIbgyVYx1PNiswbuwrRN/LrdyAzPT3GJXAQ
	FuToD2MIzQq5Qa0GvSvtr9KuNhE3Bg96RR7FcgP6kVu7yJWKELlebBGoT6Z6l4MrN28+RuzAAsU
	T8Z+KR0gEeEkOUyZf6c5yrSjJ0ZKC5a8xfAgEClW0n7AtxuGnpuIUE+gXXoEOAA==
X-Gm-Gg: AfdE7clZGsAdtGuewLOxN9X31H+Nskd24H2X898xIMVFf8n/0QTSMXXVBGGESOS1YN+
	FnmxmGVfJTQXDUt9jn3LHFrWeAfbR40qqSARGBHsxUtsXJkh6f8ocQ6q5HQ223LnJWGRURsOmxt
	gOXomxNYWohJWdfOCGCAb9eDoz/i0lQhqwZr8RxhV8Bqtj55W9kYmAto468RbEh8X2kwnIgRGX9
	gM2phYJLiQXVHITj46zWh8tuvUTy2fIt6LLBcaqXFn1pONfmL0BmXpSO/5Ud3jf6ULyCG+IzQX3
	01akdbzOTdxapegprxEMsf33aVAwMBullNxbN5+8ex4Kn3YBSpopNcg8bV+LCG/MOioHkOATh6b
	3q0FvETgcrIpT6ZCHuZmo7x24vA==
X-Received: by 2002:a17:90b:35c4:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38dc74cfa71mr10093762a91.15.1783971445871;
        Mon, 13 Jul 2026 12:37:25 -0700 (PDT)
X-Received: by 2002:a17:90b:35c4:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38dc74cfa71mr10093727a91.15.1783971445373;
        Mon, 13 Jul 2026 12:37:25 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:24 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:52 +0530
Subject: [PATCH v6 03/11] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-3-bee265d3499b@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=FgXZj7vad2zgvA0RfnbjlrO8hgDk3pUjpoRSx0IOZh0=;
 b=ohJI347iFWs4U0QCz24SLyaswuGcNatjjEcjZ0P/Z5bStmRHOkpTD1QghBUSqS6AW4VqA/afb
 NMa8uB/KQEZBospBXUY9lZGnuTiWhQQKjydmq6jMo44RFV/g51mTMx9
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX9o1m1T4KWBZ/
 JintkSKFgmxZBue1mRpW5QHXlyitToSZ5F9awJ8RU7GDy2UoEcfF5hce0oMyF1/EpR8QTLcPVfE
 J1X80vrADCTDzZFdHu/np5RgDlFgiFk=
X-Proofpoint-GUID: HmzeeTMFE8gV5mk_PNKnqht-vXaIVQXC
X-Proofpoint-ORIG-GUID: HmzeeTMFE8gV5mk_PNKnqht-vXaIVQXC
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a553e76 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX8zBx9u2eKRkX
 KsLAq+rMic+i7KN0hR0rxLLv0QT+GVnFaG/L1/7HQ7aTo6BzLa1t3U6eXj/04vL3/G0SSFYhkaS
 fpvo/X49gcaBE2VZsNGD2Rd1B7mCPMT8Fg2isn2A/eretBsb8N4ufw9lWjsxVvJ3JspzPx6idD5
 BupbJUfJqaaaq7zanf4ko+IrzCiect9JxgaU6Ha+U9HYv5l4lZvnSMgflqKMy7ETMY2ICs7P32W
 AXReOqlx+asMy83MbsCjtgpHmtv86EQq9RlaCzy/byw405QEACxiPwyahX3RKVvCIqcfKhrMvrG
 nh/DL2ttonWUFGStESEI7hBqczFjxY5X45lD3tMP9mxkkx9PaapmhfHfU8VJQP00sYi6Vyb6+Dx
 LCnOU6QTAhWm6vwrjVEKEeuhlB2Vz4fR4VYqKfsNF/yyJDyzWF04J1Ri9sjaklm2rXMsMeh7k1m
 Q1YqYk3xwCV8TPLXRkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202

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

