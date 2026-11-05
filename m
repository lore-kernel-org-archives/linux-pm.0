Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884083;
	b=nLrAmyX9YAVDzQo/vsTrbltPePLuRFyl/nQsn2GpP7NalvO0kBwW3NbC7mdpQUQZY0r9
	 0cVhEn+q3a2uvOMSGHCrG8FFX7NvwtZFWdtUBELdhDzJQvMaAUwlgrLKDsKmlHp8QtZYJ
	 gzhELMd6xOx97sG4dI1whA8LERNS4vRdoB69NCaEVsc/tERNGYDC9c+vSm86x8Xm5zh3v
	 1m75AEYzf/ErK3TZUTD75ZjkrN8D9gvvMBGXj/Zin4kcDwUwR4ZwOOEF4IojoX3mcqdZK
	 KEN+KWRxJANzJIKWQH3XvoQuVmOW1ArMpHeIfUliEOUo5W5etrX+/UlQK427XtPQl0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884083;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=;
	b=rZ5AVWpjd3g0QgWFTTw/u1pqyOKlziBOALOf2pDSsjwb0O6AM7fDkhGQJSh5jZ0CDADo
	 xETgrdv4dkDSu5XPH7G20I6f8vaB5Mss8Lsya6BZtR64aSGTsSQzExrdBaMsrDWbT1qM+
	 TZL03U4Lnc3J2er73xY/8mFBtEGXx2eI2ch12pAL5keR4MJwO6RTk0Ff9FWHFRJZv6noe
	 81vAESQ5OPVWGhj/lc2m5jIQHIe68mgBU5mdA+RY/r44c2U/f+jzRwdMwtd05BasbCRhk
	 iFYMKYzKmuOBx0Y6Uu6ZPOfN8bjsAC5wnCVjnxKmh5UFVTZuRkxHBOOB1KVlJH6ARUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaZzr4ca;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N08j2xod;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81047606D836
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 13:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81047606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaZzr4ca;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N08j2xod
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tKRN1053141
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 13:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=; b=eaZzr4caNfA80xtp
	g2HsggaQu97xrwVSS20VSQ8gjMwCd5sDmo5XHW8UXEsKgVVjgJuvuTqzutn37+Ef
	C94rOF7ZBUfUMOVrp7s82MyN0agJRballvBhbUcq4+lt3nuQWCb8e9qCy0IVAco9
	u6H2sdFqEecNCdwoW/cltn7Sbgt30zXGEUlbt7KsWrxHJKGxWjZfd4e/s40nk1aC
	k0VLx5JU8dBb35xIsllywrJpD5jCQ7GpSZ9eB3WCn7bMHGUdWut7dGYTFyQ6HrMx
	0yAZ5j5Thy9iHsxe4Jfq+HyIzoiu2f7KUHkJDmiRyCmTO0dTzW0NLa6ih15GvQQa
	q3AtxQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9f8ty9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 13:08:01 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0e757e70eso26074847b3.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884081; x=1794488881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=;
        b=N08j2xods7OqEbTkgctzIPuFCUMrU/paJZfPRGnSKSn+khp2itY3yxzllgIvFOP9jA
         J6oVNXBxl/HYLFwsCNSp83pCHDJeOT+OkKvZy/xyEXMB7HxQg1UJ/lKSoiKTHdRWBfxD
         NLaVYjPXy5GTiQJWnkHTmicHNX2Ss8zEmyPia9XwnPIXM5HpOMUL0gWbzmEOAGgdWAZp
         02gyaWZFELSV5Kk+I0H2dr69KAoO9/khnAkupiIgI7tu7KzJhmeFiIraSl0cCV/idJoh
         QEHpfFrheLZvzumwyaLlDT3ErTF2nxpivrcvBHSaBOU6wkK45ETpgIlrTh2obBsiNHcV
         +giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884081; x=1794488881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTGW40gwwxPzKGaZzuQ61MAtSHFXdlURtLrq2mZDOeo=;
        b=CjfCU+6sM3b0B0gJL5A8kHTHMQtf861jxHArl2GHcXXxg/D3T9Av7rar+g2QzqlUYq
         g4FDrzjUDC1nC1H6y3EcWNVzkP/vRGSfkdz/PrSJ34E7Pu6tM86wI5HLs/r8mPfju+KB
         0p5TDYebdZUSvds94FQ/vh6ItVRv/DxOiOhg1JDUPa6ZY/0Os9NwDbDYtzdbZGXj8LxZ
         gOAsZ2Qt7Sby8NZFxcSbIIznUvlv4dMwwR5LSa3G68qaAarE0nGGuqXYpSywEnaXU5jq
         42pAcG3Mod9a8lcmWohZuC8gMVAnDRWrmlKL2Ol57U6x1GhwVe8cf2d7t34M6KXykyRG
         6WRA==
X-Forwarded-Encrypted: i=1; AKwUvBzhwsLEMeHaZ1qUMsaHyTRhCeaD+1zLzmXh4YtZxQNvM64bXpt6+7aUOfdB7XswNknUPURMpARNqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qJsQNKSPcduy0DIDCkzBETwhhoGscX9oN3UvrNwwpFnjg/Mh+
	7rfX8qfZ7iG7CLGAw6h0vmYqQ3mAyV65yLxeCSaUjbauNtP57Gwd2F8Cbpoh64MMmqAFpJQTjcu
	4T+hqbJw6k2h17UJ0DIdQ2F2MRUba2U9P70af7loqnVd1+D8bDPHfRExefukjBw==
X-Gm-Gg: AYBFou3GBdloWe/jzp36P1rSMziLbXP+mCYtbGCgbhTjmi2IQGoEZytiXqCpbmLo8SY
	702KrN2LjpfMC3IFwoXhpX4RWKO7QGtrYp5nKFnFdobm0iaOdd5YC5xtV6epIyYM49Wui5bR6A9
	h7BDRXjLtqOJClk2aJUgXkvhBtEyqhuD/7vNCa7pgiJj6eJl70GIFPk+/6gyKrydpRmix52YX9G
	Qxhz9QCH70hYVjRsBO/isvd8eWWru+o1E4ginUL5T9jalQ6BwMjLSAmDotflN6wdfecMYFyIXyt
	8v4ABLqeGynAs9mVBb3reMgyvlKO92XhSGEKOVkHQcavPH6zVmV796tl5Nv5/xwk2UHVI3JcoN3
	K03LwEI+geoUqQHqjKNSvB2MSTAa0Xq/IdE1wc5a3z69GDTyuu4pqA4rQsGSooFxkVr957XtbE9
	TG62Y6vXeki3IuVJst
X-Received: by 2002:a05:690c:e3c3:b0:8ab:42fd:2cc2 with SMTP id 00721157ae682-8b2b65acc18mr115155957b3.3.1793884080855;
        Thu, 05 Nov 2026 05:08:00 -0800 (PST)
X-Received: by 2002:a05:690c:e3c3:b0:8ab:42fd:2cc2 with SMTP id 00721157ae682-8b2b65acc18mr115155817b3.3.1793884080451;
        Thu, 05 Nov 2026 05:08:00 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bb4406sm38915937b3.40.2026.11.05.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:08:00 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 05:07:14 -0800
Subject: [PATCH 3/5] arm64: dts: qcom: ipq5210: Add CMN PLL device node
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
Message-Id: <20261105-qcom_ipq5210_nsscc-v1-3-d4fcb5c32b51@oss.qualcomm.com>
References: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884066; l=3090;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=zgBS2poww2eN6YQuXDkYZD4TT7J8e+5Ik+8ytF15e2I=;
 b=UdIpfLGICBaQV6HoxWOkTqQoES5p9W316Z1SYI826I/noIEYzLwWuMevLT5YLOFBisc173p9/
 f8meW0iEpsyAG172l8qgabRvvW8HrrZtom6UnsPuWtdEZYVeBI6hdLi
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX5UIT+LVkQ6lD
 K5Tk4/oAeXqbtr+ruPhBOCSiWQo0kbhYHQb4xCFeU6bUs52llIsMZO1g2kElX91E+j102qnJLV0
 FzTLo7UMlCVzoCUnjFQP7bw+JJVHXI0dp4jHPdIKL83IcBxEaiCTzHgVjo8IX5V8HuE6e+DOjzq
 NaApWO136F0FsnzFfdwGAhbFtXAL6NIUSadq2SJt6fXmqS7ZeAaYqK9mdCxcyZB1kDEAX19p8mD
 owI6PE/hLn5QEBXkQpb5+bZIh6lNzXEpI43S+PzfaPuzDmRbnsJJoBvxoK3kSmEeUaNXur8LfxB
 AjArr5pNJVdf3gw251UKohyxBgyqsxjukhggcy+taTDczIbFDASwx6QiBklAuPysldOFNPlFEdc
 9eGasJzicJJE7eCNCz7GYywUWgcyGoNnPsUqewoJRry4FCpohjtK3sjr79hFfq7kp6Lu6b29aoo
 cR9ByQ+nvf9gziI/b/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfXw9dkbMD4JdZF
 WxsOwGfMItZmDb+1EuAbB0ZQiKkF0ZbxnvL11ABlqqu4Mjh38oG4UuYQMbEbdAQC1/iF0ZmXT87
 09HJMlArpnzT3VY41ViLycdUPX33F8E=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aec7fb1 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ihdlGfXGyWBHLSVGZBMA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: 00O5VWZPBN9lxmXps5fqXfEDiDzh13Ie
X-Proofpoint-GUID: 00O5VWZPBN9lxmXps5fqXfEDiDzh13Ie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052

Add CMN PLL node for enabling output clocks to the networking hardware
blocks on IPQ5210 devices.

The reference clock of CMN PLL is routed from XO to the CMN PLL through
the WiFi block.
XO (48 MHz or 96 MHz or 192 MHz)-->WiFi (multiplier/divider)--> 48 MHz
to CMN PLL.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5210.dtsi       | 26 +++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
index 941f866ecfe9..61a53361138b 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
@@ -20,6 +20,17 @@ chosen {
 	};
 };
 
+/*
+ * The bootstrap pins for the board select the XO clock frequency that
+ * supports 48 MHz, 96 MHz or 192 MHz. This setting automatically
+ * enables the right dividers, to ensure the reference clock output
+ * from WiFi to the CMN PLL is 48 MHz.
+ */
+&ref_48mhz_clk {
+	clock-div = <1>;
+	clock-mult = <1>;
+};
+
 &sdhc {
 	max-frequency = <192000000>;
 	bus-width = <4>;
@@ -77,3 +88,7 @@ &uart1 {
 &xo_board {
 	clock-frequency = <24000000>;
 };
+
+&xo_clk {
+	clock-frequency = <48000000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 2cdc10529c48..52d851a0dc2b 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -3,8 +3,9 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,ipq5210-cmn-pll.h>
 #include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq5210-gcc.h>
 
 / {
@@ -13,6 +14,12 @@ / {
 	interrupt-parent = <&intc>;
 
 	clocks {
+		ref_48mhz_clk: ref-48mhz-clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&xo_clk>;
+			#clock-cells = <0>;
+		};
+
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -22,6 +29,11 @@ xo_board: xo-board-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 		};
+
+		xo_clk: xo-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
 	};
 
 	cpus {
@@ -130,6 +142,18 @@ soc@0 {
 		dma-ranges = <0 0 0 0 0x10 0>;
 		ranges = <0 0 0 0 0x10 0>;
 
+		cmn_pll: clock-controller@9b000 {
+			compatible = "qcom,ipq5210-cmn-pll";
+			reg = <0x0 0x0009b000 0x0 0x800>;
+			clocks = <&ref_48mhz_clk>,
+				 <&gcc GCC_CMN_12GPLL_AHB_CLK>,
+				 <&gcc GCC_CMN_12GPLL_SYS_CLK>;
+			clock-names = "ref", "ahb", "sys";
+			#clock-cells = <1>;
+			assigned-clocks = <&cmn_pll IPQ5210_CMN_PLL_CLK>;
+			assigned-clock-rates-u64 = /bits/ 64 <12000000000>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5210-tlmm";
 			reg = <0x0 0x01000000 0x0 0x300000>;

-- 
2.43.0

