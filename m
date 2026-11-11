Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391271;
	b=VeXrHp5OJGtRG9Ycre6LrwteHqhPwQsjjlDT8El1lDVAmtbqA4snNOtxqWC0mCKtB1EU
	 lU60b27+/abjbg5JtHs062Q7yLY6Dv3hwoTWP3ScUZBxX5tiLtDTpuzahqelDumTVBpRN
	 zxJVx4d98EYgYk+JZJDQNo9R2UdGToZdwZfeSR6YMxCfYY1g97yjd5PWXcjlHt8VCydY9
	 Nxkcs6Edr7GDau3N4Xd0YWugPPY87ZaHRwgS5R+qVSJvePB8+QBMfxzCOJ6Y8mfb9wuD6
	 SNzaalHV/8sKgx1UWexi0ndaqsZK7SA0RQx6ENupeRnplsClSQOrzTK9JLNbU1zqxsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391271;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
	b=NdW5GPaCP12oElZ/wnUozf/DVIa6M1yuR9D6lWfBffTFBz76GlIConquEOg+ZvXErPFu
	 ULFN/Rb7fxjFRpqjhUZl6NykZg6TpetnCSZo0B5EzH3p9f8QJMLvt4gzk8j9DT2cNW1lp
	 rd/UNk+AyMDq5m2JBG3nzTFqbdsdDiNaZVRkJVKkd4QBu9TMUVQvJhtr0mvVTGIcgig01
	 DHOiuFqiKa6Rm3akznWOXbFTPMTU7Cl8hJls02QmFfHhxRow+K5i+lq+ABOz2qCwlzdvN
	 8BVQ2Mz9ov0PNAMHt8r4Chl8qH+xkX0lVqsH2dHS6CKM4TgvxIO5Lrh2QD4rutihDsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QCwbsGiL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kRJNyJJ8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92760A382E
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C92760A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QCwbsGiL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kRJNyJJ8
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB6ZBYU581257
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=; b=QCwbsGiL8deVshBN
	cKsOzIJQ73WyK29znFgl01Xga7/uvYUEIct+HpOK+0/5kHTK4MnBex1/1pI0OVHB
	b3mA00840N4d5bldQbmpq6bIpQ7kfD34OgtTDxuzMCz3UGIElEvQ464oqVZPi3x3
	mz/qUwxpTZpN1bnKMimTZr8DtNoXVQJzK7y4z8riN+BRA3x980sapxsOWy2Okjkw
	3jNTZtWfvuPmX3oEkGtYCP5lWJKopTF8cF6yfhcAdGoL7Zlu/yVHsEkq/76t8LVA
	+zpmnJ7I/DP9fhNTxQGR5Ajmb3lLGXtBB3P4XejoWrYygVzjMFxZcQzHxyk39kZR
	5Eze5w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7prs0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:05 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-847e2926d94so5987015a34.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 02:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794391265; x=1794996065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=kRJNyJJ85biOA/kKJTj60e5iBiRXfByfWAFvSaolxQmJlXBxm04riDm4Z2EzvI0wKg
         6PQA4+MQ/yTHu6OC5Z6NFcCRUsgXR55nss+2gPAEb/j9UOzHWF+zDH7wVn6LBjJPRq00
         PA6a0hWfPHZfVc75pYBIcKMNZ9iiQg9MUtDVOT2rtqFtGjBfQ4Q2Gfc61RZmm0hvjwxA
         Um7RBArQbqdq3BxAH4nmLZlkfE4+D88OTchpT8Fg6VEp8mZjSYnFvz5QaZSQl83Hr+Tz
         dYqUJAdG2rSSuBY2vavkuMWmYGIEH3Ef0u9b393zsbUJUuEG4ritq2T/7sbzfCFbnqVB
         Q39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391265; x=1794996065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=YiqjsmDZHN/i5WrN9lxqAMf+XTCD3aC7t5VPXy/Y9d1ORm74cDyWdS3+WQkfG843rX
         FDCEjNdo5eaWJLlUFyzpq2BjtEUaWaH9DVLZCKgSF6B9ZD0cTWMCOKZE6Tldgvu/PkUU
         JBhpRohhcMKRevE5aHIvc7S3wZpYQRZnmZuSGLL3bxRrGj7HVwJ+9wId27wue3YD4gZU
         D9tuehyLIAVREa7D4BTqGVJwLKrO6ZBIdDobaGHojWYiCYBronP6BBO8BJbFW07ymBhY
         sO6a0dHxw1XhO8Pnxx+ertrUleB/NAURYAlDKANNLeg1GdiZSCgUR8vNjX/AeycUcnGi
         ksKQ==
X-Forwarded-Encrypted: i=1; AL+hErE8WdebXoKe3RUJyCp3ln90d6amARtA+tcH99D/jAEV/nEKMLwuKh/H+6q5c/uiTIi4eDaCMjwVVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8PjV7jweBCYlLNEp5XqE82FRfG5G1PoJsTFNGdtCupwDmOwe9t
	Ugk1bCwpPQvuD+3PTRAKe7MSXO8JDdEJBv+xP4hhVmqpqK/yDeEbXxEkMxEdhhtnJbR+3e3IdkN
	h8A7uGQ9lZjQ3sBcYGi6wRc7wlGuRWbylXQohSxpMqZpeGBZJiqT10fZe9/9eAQ==
X-Gm-Gg: AYBFou2F4iNQUxZ0YVeVzHd7KB9gV9H80YmrxOqtd1KRq6AZU51M/N/BjS66jFzQieq
	IsTIZZytJwr/C8i+9Hb+McOHx7S+rxqI+AC5OhKpiCPHhPeGgNBhluR7CT/VkQHyJy65ZX3h8zy
	/3OjNNw0y/5Pv6fS925/LzY6GbjofSnGh+LBFd91zA35KXRqe5luF+ATr9XGEDk+/Tfmzg3zf1b
	udvCHhZl0Zdi3XWykwoLpNn90jCbUls0Q0RHs9hKB3Tzw+A6UJgJdcHMsQVpW/MxsJQal/r8Zvl
	GxVY1MSspcYS9uL61FWIJ4wYDn/PZz+RkTK0YFX62Bjb7d90E3TRuiEAEa/ddLF8Cg6tETnEDs/
	Zd18+Z1Ez26zFrFYXxols51X9V2UF2f9sb/97M/DFpg0yWMKks5433n4E2ifeyfy1qRUHTBLBsP
	dWSdcUrE5GYhUrK8me
X-Received: by 2002:a05:6808:1924:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-56b98d27ee0mr1503244b6e.67.1794391264682;
        Wed, 11 Nov 2026 02:01:04 -0800 (PST)
X-Received: by 2002:a05:6808:1924:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-56b98d27ee0mr1503211b6e.67.1794391264180;
        Wed, 11 Nov 2026 02:01:04 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm4686111b6e.4.2026.11.11.02.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:01:03 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:00:57 -0800
Subject: [PATCH v2 3/3] arm64: dts: qcom: ipq5210: Add NSS clock controller
 node
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
Message-Id: <20261111-qcom_ipq5210_nsscc-v2-3-7e2c1dda3ed2@oss.qualcomm.com>
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
In-Reply-To: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Luo Jie <jie.luo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391255; l=2069;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=V7tk6aEtOPhfOk+VPI7cIHGev2spKigLOSXp8SeaGFM=;
 b=FPdGwja/I0to/ZmRBr9rXIX0wX/bDKAU1xK3bC9dhG0h/+sBG00vXJCbM1eQXFpMhieJc78+d
 zQqoysUX1hbBKJPSNke8FUNppPMjsVdX2VfHSwBf+OW8jJwOM6o7cRU
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfXwJG50KxARG/H
 48SN2/kXVRC2I73iBVRpghxvKXtOcmLb1GKXmqGiOJMm8lyaUdb/nHCcWCXVjh7rUcXMBlVnEYX
 GYelQp5B7V2GrkTsxEOI+OniUosFLpg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX/0vZTllQAn/j
 RfXlhCBwkvBUoee32hMIYAism/EvM8DYo0cRxtWEwfy421OMMRwyzBfzUtUm2mViCgaW8viQmve
 2LwMf/uwePM2YQsAV5MOFh07RRwgb8J5ytjh7n6rjV4GERV2yTO8+S2NreuQCV7pzI4ojs3NiPL
 Js1ffokQENvQMTSfupkuOhluxRb+/jGFdfVGDlYhncc0jRaGyI73TSPUteBxZeCzOZ7Lf1W7FaJ
 Z0+D44Tf18nUlHlafe1gE5DJo8GR+R6vOZ1TrO1idVW+mjeRInHV+g/WLx6okLth+a8rlywnVtm
 MyMA5n8FFbrl5yX8ac+lt0OZbhY64Ik7VePkFA7Wwia2//AofYbfweG0ZloB2btRn8OMg0lPaO7
 /mIp2VbmDvYlZhiPZ5xufP1mZEWeIxJ+R5swmIH4+aG6BAbhQ6beT8Ulr27c41xYypP+L8d2vJ3
 61KXYpNEc+WXzlAuYvg==
X-Proofpoint-GUID: IfxSw0wYALds5ozP2m3otx4wlhQCD58Y
X-Proofpoint-ORIG-GUID: IfxSw0wYALds5ozP2m3otx4wlhQCD58Y
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af43ce1 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6SnK136Pe_QpXSRpRBcA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110039

NSS clock controller provides the clocks and resets to the networking
hardware blocks on the IPQ5210, such as PPE (Packet Process Engine) and
the integrated EPHY.

Note that the CMN PLL output clock names are reversed with respect to the
hardware block they actually feed: IPQ5210_PPE_CLK is wired to the NSS
hardware block, and IPQ5210_NSS_CLK is wired to the PPE hardware block.
Documentation is added in the DTS file to call this out and avoid
confusion.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210.dtsi | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 0c1ede0f73b2..11915f8eb156 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -331,6 +331,46 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		nsscc: clock-controller@39b00000 {
+			compatible = "qcom,ipq5210-nsscc";
+			reg = <0x0 0x39b00000 0x0 0x100000>;
+			/*
+			 * Note: CMN PLL output clock names below are reversed relative
+			 * to the hardware block they feed - IPQ5210_PPE_CLK is wired to
+			 * the NSS hardware block ("nss") and IPQ5210_NSS_CLK is wired
+			 * to the PPE hardware block ("ppe").
+			 */
+			clocks = <&xo_board>,
+				 <&cmn_pll IPQ5210_PPE_CLK>,
+				 <&cmn_pll IPQ5210_NSS_CLK>,
+				 <&gcc GPLL0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&gcc GCC_NSSCC_CLK>,
+				 <&cmn_pll IPQ5210_EPHY_RAW_CLK>,
+				 <&cmn_pll IPQ5210_EPHY_RAW_CLK>;
+			clock-names = "xo",
+				      "nss",
+				      "ppe",
+				      "gpll0_out",
+				      "uniphy0_rx",
+				      "uniphy0_tx",
+				      "uniphy1_rx",
+				      "uniphy1_tx",
+				      "uniphy2_rx",
+				      "uniphy2_tx",
+				      "bus",
+				      "ephy_rx",
+				      "ephy_tx";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#interconnect-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.43.0

