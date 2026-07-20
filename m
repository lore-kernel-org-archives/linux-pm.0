Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A53CC315
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534675; cv=none; b=Wvx5+LgVUJ+TnKcEIdAMjtDQCPvYaYJV6beB2IUHO1O+abGoItxfroqAPJKSnifsv2zzwASuVfcdch+vsaTkmt+ItcUXNMTlNYOIizvx2RNllAQfZDb2Fy1gFdV90X5MXslEOsKw0jvKKeDHHA4GdJc9DSftb64/1LZzpMp74Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534675; c=relaxed/simple;
	bh=aKn+BDqCAE7bj2HMXtEyzQOTzNrYINfaywFfnH4EjTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGvUnD73VOmHwWX+F60NO+1y06igpHNjWHxJA5gld09xaOD/z8Rfm2UvOPZV5BsWNGv61xJ367YG7PhcIHVWNYJEGdrTJMO/tRPB/VWZLOH8asNepG5cEFQO/e786sEuTcm43ieoTxwlWXlhk88Tc21cKz8HwnwSEJMS8gM3dAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INL42TvZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HiUBqbIo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INL42TvZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HiUBqbIo"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K76Qil1712940
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1p0kWGiPSRzk+9UIUD5rcX54pJsmPtFGx4DYvuUbpJA=; b=INL42TvZ4ByF1inS
	lv+kBeeFSQnhn5pcFZNmkypaiMO15lrp2Zje2RWjXwjQrJmt04zxAJIfnFyzbW75
	u7Q69HP1y6Z6E2hw6tYI1mSXXYaKt6B9+49onvqoNe1Fm7R/jxlpXRKepCtCltDz
	InJkwJwlImitSgfcYkso7vLS4QMTXaeMOJ5FlCF+mFl+RY62zEuPUAcpgMZPRELn
	lFGWnZrF6QLnCRsFgc4xvPKW1LHErkUZ9RGLKP5avRqmUoo/a9XKiahoOFXxFv7B
	IlfpzNVUp8sfB763Xri6ezOmVnWQederX4mcjRkyQvtGO7HL6mnWonHx8uQMcTyj
	CJ5Rjw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c06wk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d7886cdso82821261cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534671; x=1785139471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1p0kWGiPSRzk+9UIUD5rcX54pJsmPtFGx4DYvuUbpJA=;
        b=HiUBqbIopCMq8KOaYpplnl5KFWF2/rpbnk8ruzC5MiKXenSArU23hJGk+xYeKNG4+S
         T9DJbeXuC4lv988oV1nUxgx8fac253NSrWLnCbjmJKBLENhuQwRwiRgJ5mcDXYeWbjLx
         1q4eOTmbUlubjv/w1pGiAhruC/K/6M9AaZsU5KXc6cO5npjRXXGRXZTev1N4Mv+4BC4X
         ThAaE49cIfLpxP6DIe7b9gjBj0QzT5mQIp6Dqn5V+A9Oz/BBujpeh+eT5z5t7z/UQhRm
         FOzGjtkIl7hYCsnk6c537bj0wmZQC24P0EKY8NhNzCdS1jEZRyZBN7y0qxLhP5egUFzI
         W7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534671; x=1785139471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1p0kWGiPSRzk+9UIUD5rcX54pJsmPtFGx4DYvuUbpJA=;
        b=IbUQOjRI4wiMNyH/hvTJ/fCiUDf6iy9o1ZfoFAf/Cq6sq6ekAQJgUMuPWoh2QrMZpc
         YnCrp9r/0HPd/GqRI1HKLf0abGiRQRMjv5KGDssZO7H6tHg1NsDd3xv4FTTAZwVYFNXa
         RGCtJbXoyPbisGbTpVyaPhx2luPe0lV/B48dF+a3mwng6QBVgVG9AiAnumuDCoNoErSb
         QkyW7T7ABvsovKtaGMD3jy7UsSEzdKALep2S9OHoMZZsSCnMWOEt7XD+bG6aAAlPOIax
         ftrwWJPRib/sL2kzJ4Hx2wBQDGhBX/M4u6n2NKFzgtXjpjIvvggdr7ZapyfNoWcNecWf
         9NZg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf+AAFaxYh3yL0D9hRd8zI8plvHsCrzn4CoYIu/3UiArG7o2aPSDrkdhCw1yAMw1LaI/flneDpuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uSyiLT0+vmykTHUSo+Y46NmfwBmlwq3k9LSzsXA91k0HnTjp
	S1vPdvn/9y+aQ16iuHzU5f+n/IES7rAElLiC7m/PVD//HyN3s+M+cgT0RSiKgtHrD8guDusTp7m
	2ZvkAh1rCzo9VWiu4ivO9UMusJaaPiC0N0UAzQc7039qmib9/kmpw4TbTybo0Lw==
X-Gm-Gg: AfdE7clMZ0raSeN+AzUOUYFhPHC6BUnNMfyYgVDLt3keClAWYGJ0P5M0TBnjZeSW8kD
	tLJrzSKoxZKFhQotiQXHZaAwJKfX0yGY13UnFqPubdW3T45ZA35bH0kAEE/+HL7lr/yu8zWOQsS
	2Y/zF2sY6f7LczNpptFN23EFgxlBKxgID7D3S9q4R8IvUKG1+cxgubKpgQ8cyuNcRpehGwpT/Vh
	sFfj7ZcCE1Log1S49ZZS0oj+ukRb9reRugf7C0yLfD4Zwo8wZSu3OGorOj/iEDesHBjYVb0kWat
	4BHbQugYXfurmEAGcVY3F4dFG5hS0geT0nxLFquXeTgVbqzS9ePPrm1l5Eb98tN7+dJRAPGNPlI
	PJr+5SzNcIinIomXaPXyoRQ9Xt6f+GkZKqV8MYrobZ8FOw0zfybtdL0u+CCzAMZitr64RRqSVe3
	QcYFXoBp+COjMhXRgHrS7jlMJNpWFkfd2hsgYjz4nU3vS6jHhacW8=
X-Received: by 2002:a05:622a:4d8c:b0:517:58f6:29c3 with SMTP id d75a77b69052e-5213ae554d3mr132426181cf.32.1784534671536;
        Mon, 20 Jul 2026 01:04:31 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8c:b0:517:58f6:29c3 with SMTP id d75a77b69052e-5213ae554d3mr132425861cf.32.1784534670986;
        Mon, 20 Jul 2026 01:04:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:13 +0200
Subject: [PATCH v5 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-11-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5dd690 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: BE2nYF-Sm3bSS3qE6f2oyOqzwj4NVSO4
X-Proofpoint-ORIG-GUID: BE2nYF-Sm3bSS3qE6f2oyOqzwj4NVSO4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfXxPbWOX0eetT8
 Ay65pXzmbGl3tY62WpdzhoG/HyNK/L2Rf66ucvpm4TTtRBevzRRhq8dx/DAax1/vuN2VfVVxxVG
 M+uDyIZRGiPNVnkUhZlMF+w7XlUKgbo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfX/heB/PzmCnFB
 7dr6LYvZBKnI7SB7dlqIJydM4yl0lf1EZImbETvtFnLB1LyRfkEhKSZ4aQ0o3QlKtN65leFtYgN
 1pzM5hl2cnlKkaWrgirx/lSxUYePkyOn5SwRO5bBG7WtznkQr/IdOyqt7U0fQoL9BwrpkTWtD1L
 zxkfj8L8nHZDRCdnIDLBlVOQAK0gzIGsMbTnImkc45BLGqdHnHxAAd5ZM8S6TInIdrV2pUvCq+t
 rbHM7u2eZ6a5H0qfknZWuENRvQydPQyyBLyS1Zbj2JtygD2KIAGjgbROCTC+Jfu+ytMZnP3xQXk
 hPxsqD7tV1++mP4kJdxUc8vli81/eSiboZIXSskghRKboopRZrqYfzpI3H+SYWL00HHJTfrJEX/
 jFgaO49HCvG/0uv57smAu9W3r3NO3etgDzvECD+Tw3oYtEst38dHryw2ILxO7MQQHLnLEtT0bmh
 0MFu1vU++leF9t0J1ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200087

Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
Arduino VENTUNO Q board. The module is interfaced via LGA and is
compatible with the M.2 Key E.

Add wireless-lga-connector node using pcie-m2-e-connector binding,
connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
the Bluetooth interface.

Add pcie@1,0 downstream port node with pciclass,0604 compatible so
the pci-pwrctrl driver can acquire the power sequencer and enable
the M.2 slot before PCIe enumeration.

Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
(gpio56/gpio55) used by the power sequencer.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index f67a554adf956696aeac2348e478dbd0b74f0e62..5e41e637c1c705ce0f3847aa71b229261a1e3664 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -155,6 +155,40 @@ vreg_nvme: regulator-3p3-m2 {
 		enable-active-high;
 		startup-delay-us = <20000>;
 	};
+
+	wireless-lga-connector {
+		compatible = "qcom,pcie-m2-1418-lga-connector",
+			     "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vdc_3v3>;
+		vpcie1v8-supply = <&vdc_1v8>;
+		w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&nfa725b_default_state>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* WiFi/PCIe */
+			port@0 {
+				reg = <0>;
+
+				lga_pcie_ep: endpoint {
+					remote-endpoint = <&pcie_ep>;
+				};
+			};
+
+			/* Bluetooth/UART */
+			port@3 {
+				reg = <3>;
+
+				lga_uart_ep: endpoint {
+					remote-endpoint = <&uart10_ep>;
+				};
+			};
+		};
+	};
 };
 
 &cci1 {
@@ -409,6 +443,22 @@ pci@0,0 {
 		ranges;
 		reg = <0x010000 0x00 0x00 0x00 0x00>;
 
+		pcie@1,0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			compatible = "pciclass,0604";
+			bus-range = <0x00 0xff>;
+			ranges;
+			reg = <0x020800 0x00 0x00 0x00 0x00>;
+
+			port {
+				pcie_ep: endpoint {
+					remote-endpoint = <&lga_pcie_ep>;
+				};
+			};
+		};
+
 		pci@2,0 {
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -501,6 +551,12 @@ max98091_default: max98091-default-state {
 		bias-pull-up;
 	};
 
+	nfa725b_default_state: nfa725b-default-state {
+		pins = "gpio55", "gpio56";
+		function = "gpio";
+		bias-disable;
+	};
+
 	pcie1_default_state: pcie1-default-state {
 		wake-pins {
 			pins = "gpio21";
@@ -544,10 +600,10 @@ &uart7 {
 &uart10 {
 	status = "okay";
 
-	bluetooth: bluetooth {
-		compatible = "qcom,qca2066-bt";
-		enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
-		clocks = <&sleep_clk>;
+	port {
+		uart10_ep: endpoint {
+			remote-endpoint = <&lga_uart_ep>;
+		};
 	};
 };
 

-- 
2.34.1

