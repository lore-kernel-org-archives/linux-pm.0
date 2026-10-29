Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264581;
	b=pK0hX7vzBCfs1RggokWXXtesCYkv/3N/dZdu42nD6fENYxLGm2lC2hPGr5H/rAyzFW2O
	 WVVIO64G9VJECvIzS4V/QZ8o8cc8hCES7ISiA4qGyVXIHV9CUA+lXj1s8qsYwLl1i4m0C
	 4QAlfhLVYSDEb8MOqk8RsXM2RsBpaxMlbYeMDONWpahhWh25nMR9ibRlBTB69S7s3REso
	 /0rCbSwjqfPk9I/cV+CzVLPEvVKM6IMTEjW+9pv2ipbMq2NthUrs5MRUijjuBs0yIEZnM
	 4YDUekAs7OHMceGcJtwzzoE4TmMJrYgDgtOWwDHX3EY2EFugcuBQgLwNolKRgVs5t3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264581;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W0iJhYwYFHxApioBxjUjHv9EZd+NjU0umTau3U6H/X4=;
	b=C4sS5CyGUcJ1wL/Izcj94WU5kdwY29HH42qfnGeyiTCA8qeYhVFOL+9WQUHTQeE4habm
	 Fsw8ZCQmpUT+kveCpEEtytr1Y0hj13Cx1fUFjUJIVFBBqI9ngfoFRSaETvDnt+mbCYVUr
	 AZnJr3bMK1Gmbhnp2ruxeARqEeNjs4ohJJX+QvT0pMMfno54doAzZLfER/5tygaYmmr4S
	 TSBf/lQ4j87dpTwZHkYmigr+2ghwXxoUWBlohWzyLOrJ4ehNFHP9rUK6JtHf+0dydwWWZ
	 qd1oCL4sKmD9xJF3cGCm3YO2AFFhT33U2OKswzaew53BUMqubvwn29D6p3dxuhXp5gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="UGzuI/fB";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Avg+t/AN";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B6606A326
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E8B6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UGzuI/fB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Avg+t/AN
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vmMA690940
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W0iJhYwYFHxApioBxjUjHv9EZd+NjU0umTau3U6H/X4=; b=UGzuI/fBbzLudgIS
	gXr14iwDFjdzVTsZFGYigdgyuhuNl4dIWN4tkZxbHkqFlOdGYV5FD/wfbGCsLe8m
	5LbnXlm+FB9lTB4HzzK+MWPVUnvRybey86pXLOvGcM0Nu1RY5Rz11JBe7zUaGgOH
	FdX36c48cKPgTzqhwC3NR+TlESLZ/CNMZxHKc39P3KzUF9LE4wLBq7o5l4/NE2sU
	qF1luJhDxxIIZzKWk8s/DKfK6sbDO0PhVT6l0fy72a5J30ErkNG3/vlguxL7Axse
	m7PifjR8kQ2+P73kPBopA+kO5+x7eYyJG5dz0YrGkL6PpfVSBsNu5RD5wFRKLlAw
	fgWg/A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneuu4db-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd65285537aso810527a12.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793264579; x=1793869379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W0iJhYwYFHxApioBxjUjHv9EZd+NjU0umTau3U6H/X4=;
        b=Avg+t/ANgx6+Qx877ZYXmCgRoLjaXtbjguJ34Qt7ONRBapfvgUFN4rwnw4qgNCCA+r
         +w5js3gbjjWRux+FXN7lDiv4lclUVjOI91tWyY3ihmznhC6sojrnJ1i75ylYgeaSkNbf
         x1uTVU3xBDmAo2Fi0MpYHtCCpVkYpvWO9MuVIjVv4jUlORTd4JkSXZ0yGq0hVLLSWh/c
         KryrxSwHqosCSSGN99ulgzTQUDqH9VHwVAgg5b2TmVg9b0iHqTZokjAe6vOcWdaUVALG
         14NeBZAO4lUb+B59TVN0R5olE9N6uiyTmw+0hr5QLQXubhKLUTIVTEC1LCeciuWsU3yc
         515w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264579; x=1793869379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0iJhYwYFHxApioBxjUjHv9EZd+NjU0umTau3U6H/X4=;
        b=l7o5Y/sHSrxMKheDd+GVHwGBUeIBZSM0lAUifiiAzSGZB0j8GWx4QlX1QLpGrqYmpd
         zokMcwGLj5cYYQH4qpHZNrNN+wngCq79BzFgqrGS/o1yGw6yvM/kvQ+wQCkv0o1R27px
         AjCk/WjtfXLgkwj7M1+yvBhL+ECvK92y1lY86dMIogZu4XcppcqL/m70RnL53UDv1Tp0
         tKcjGXjNHEJ7ZN1udpzWAEXewq1bdUCr450bWOPW82pGj5QCzFnNtK+v4l4AiZGseqXq
         hgonS2NpuRpIkTzwPcvGw+PbvEn/vnp9dn3cHy38B8D6YPne3B95gBTQGFEwJOLvzN5+
         HMbQ==
X-Forwarded-Encrypted: i=1; AKwUvByrmJJBhNZNjVXzdByxAT/dYxhh0lrSZjO5iraqGwdv/DRF5PzH4ID2ohwQ8B3ibHyHS9k9VlJI7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLk2tJ9ZFDFoegBREp9dwTAdGP4fRDR7PQNH2geNW1wg03dPuYI
	gIqaVc9r0e5+SbO4DvlpFTaKWWd5av8xzsg+2Wsf9/Q128RSfHl9cOX9ASw4+TLIxoKu5vqJ1KG
	M2VOA/dyAXTXKXihzLczSCdApu7aJIun9ZBT6RnNZrEgc3okubMy3Hncbj5LadQ==
X-Gm-Gg: AYBFou2ulunOwK4qTiXkzYH+WX3HCnSk0V+EAXyLSte3NInr01lR/6Cm7EaBakhD6AR
	3JwBvTr/IrHt2sgglOpksJ9HUFm1R8g1luk4bkNjtsGOWUAzAhXd0G39tHTcBHImtnam72/i+Y7
	KrhPB9OvmvUk/QdXiXs9Dj1KaDaS8/1DnRG2XGlwryRyitYhlppBEoC78CZlavzNybqANhAMHr2
	ghjEQqYWEtsL0yAazK8cpT0b8GGsJp+j4+xyDcjSHTiHjFduLt8QR4ctcYUIiRLeEGGnn1OFR2X
	C6uvNkE1u+UMVqHretSrKfSriPHAp4TvBWeU3MA9SDnLdaPZXgcLLJ0QF9W96kuXoeuQuEEBVtt
	43HD3c8pzzmhGNtQge7lKlnVQJ9jbQ+Gxk5fLOQBNO8txoWAYassV3XLCR6gMDRodtS+4GxcG93
	DsKrk+flA0
X-Received: by 2002:a17:90b:46:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3ae5823c672mr3892948a91.56.1793264578110;
        Thu, 29 Oct 2026 02:02:58 -0700 (PDT)
X-Received: by 2002:a17:90b:46:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3ae5823c672mr3892899a91.56.1793264577591;
        Thu, 29 Oct 2026 02:02:57 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ad710sm3197385a91.3.2026.10.29.02.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:02:57 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:31:04 +0530
Subject: [PATCH v27 10/10] arm64: dts: qcom: Add psci reboot-modes for
 talos boards
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
Message-Id: <20261029-arm-psci-system_reset2-vendor-reboots-v27-10-fa4b3ff1359b@oss.qualcomm.com>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793264459; l=1558;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=WI51nMUK6qgMXe/JMYvx21HtG2tpC5q/6iKj1pJYETw=;
 b=gGvS3BpXvoO4+rAnmMB8gWe5F/jUrTtj0OtL+qKpMHz1TeSAYRy3TL5xGqfr7v91arFxZBUnY
 IUqkMdrzwNlAtyHZYqier3l3JTqGKtZc+5XnqRKZZeif4m/l9NQFXFW
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX9X9oKpMbTfCJ
 K+kVmTogm+elYlpUwlwkwWNbA06d0peM9+rPc46ttUncHqlmAwb1zU43jrblDwmOU77NnV2A+C+
 i/ERGcnT7qObH/TxKR1OFrMIzcLZ/SNgC/0haRl6zwzonExQl+wUjdDk/E0FOb6O3uIZlCFCsav
 2A4e6OAuwfKkDY6tdL0OXkrKu00KS6aBm9WA4uOIjNJbTwej+2n/bEGC0SHVwg+vxpNSL0rHKvw
 UwGGUc6tVs16uaUnuk1fakQJ2OixXLK6/bkDCNGZLQ/nFuBgl25+F08Hfhf/YBrIAwYE7z2NjnY
 cVGFLLY4qvTJ7iEFKyVpqLcxcfRR8tKxBRzkcNbMFgvW2PfOZadFphENycMv1AiNegxYUyHr+K8
 QkDkV/0q2XovXbarzJawuKaWnyRdjEgqjOAHsqzSdA5ENG8fAfWVdYWwx77nP2OGsP/VrKqp+Kj
 Hlr4N78DI2S0x2Gh0Mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX0yivAyg7ekUq
 4FuxJ/IFwE5BC5oW/eWwQENqV3eR+10arnClvnPMBJNtQtWkjrz40Je1fB1/wWKafmyTidY757g
 owDfmvOv2fRQOF02FvonGz5I176GXak=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae30bc3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=bjH5yOvFM8yfI_BY5k4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: i2HsavtBPgsTYbExCMS1rnjMQ4Zn7x17
X-Proofpoint-ORIG-GUID: i2HsavtBPgsTYbExCMS1rnjMQ4Zn7x17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290034

Add PSCI SYSTEM_RESET2 reboot-modes for qcs615-ride, for use by the
psci-reboot-mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via the
  Firehose protocol.

  Support for these modes is firmware dependent.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Song Xue <quic_songxue@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/talos.dtsi      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 142dafb04324..30e4cb642473 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -497,6 +497,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qspi {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 8ed6f2755705..03da6400c5f2 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -581,7 +581,7 @@ pmu-a76 {
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1

