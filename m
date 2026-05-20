Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C53DA7DD
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274927; cv=none; b=jCDb35xBRz3uxBXSo7Kt623woun5Kyp4BtsKKke4JQSM6rKIsmjJNJWiW7wAjJwbV+di5WJFOLD9dbiK2JkzR9a5bUxPVRwfpcn4CX45y0T7mNQm3hjxnNE+ZMb3T/vVOCuZOBFfTmJj7DRDYM01HyGFUSOJhhFcw+/Rrx1OgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274927; c=relaxed/simple;
	bh=EcsG3OcBHWatj218IEmU+YqnRsTeebclTu/zvz+F2/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dm7Sg/jN3ywTYyymyXNgkB6fN5GoWdMv8Lx0fFXRngMvChqKbsdDaKIQpDFzSDqy0ADFOgPKU680SNN6uHg1fr5R04ztQeee7aQSBMQxE2r/wjLg4uIBiF/ns+qv09ohTCOYrHlW/UOcSYpVInfnPyJpzJQbcPsClK1f2dm+KjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8WAP1M1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BDqtNqRa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8WAP1M1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BDqtNqRa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9nRtY446688
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lo5MkJYHpFxheGWji+TQIhnd3x4bpUJbquv575x5QgY=; b=B8WAP1M1TMjiWzKi
	x+De4qLwV0+bqyhb0ezjxxAWjTpfYNJsYA5p0A4QoEE8QtVJ4YYduaUuizLmkqPx
	av7CpLxMuMz4J9cMcSG/wS3Tm9eLhvxi1BsJ6jefrDTz4RqjBCqcf2/4Id7S07WV
	AIMYJlv7oijeTLqhmxEjf9aY+20bTW/7axyllnFK9/zXguAhf0D+YFpD1mBsNb7z
	9ZvCs1TOYjsdim+y3yXWQ/dv7PFvY1gnNoHmZ3iZMks6t85nSGDVEMY3n/wd6xDQ
	t7AoTb4hQRF497TReFYpeHYhKn24kLLz29R+yEweg/po+Ggnkd/deS9s5Qtle4ai
	7S5jaQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrg8hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:58 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69d0183aeedso4601697eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274917; x=1779879717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lo5MkJYHpFxheGWji+TQIhnd3x4bpUJbquv575x5QgY=;
        b=BDqtNqRappXhaXOcg0XpupLIjjlFNKJBogPtWCO3hS2gNA1XhFSFMa6lQIPiZJ3HYO
         cR8v9PNS5HXCuInpVGcd8g347vUFf5tn9siK2bMoQHOL6esX+/E14AgKRA55zL2wBZDk
         FK+ONRU3Ei+VVGV+u3bPdJOXXgSKkuWuzvWfCRLrmLnEoLziJqosjs+Xp7CYW1QtSbVV
         8GoXVYQxLRDppAJ3EKkMZ21cUZWcQ/HRLOlUH81DsnBqOZYuGzandSHQP5YH5fgdeXHJ
         HLvRyFEuWaf3y/D5y6AIlU6BsNdGEkugLgi9YSVCPd3MbVWNEBIP8K/9tM9Ms5QBmRj4
         e3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274917; x=1779879717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lo5MkJYHpFxheGWji+TQIhnd3x4bpUJbquv575x5QgY=;
        b=AFAI9wh3WveLDvFoWj5mpsX8MK2k4Y9j/pQudY/Kj5HIdDdplO8NNzpcwofOqTrSDR
         TXm5zEAjlx3mnwCBhz/PObzQppgwsrxElzl8lQhrBzITt3gBp6cBKM9W008GttO2X2Xf
         lbhs7uNW6nYdDIhg/SbI7J1XDRDk03VGIoLrJDJptE2LLgGupFEZWH3M8NlSs8QoKvkk
         G/se7rUDGhPR5ESAUMY8T6AUZEwzTjN2Fh+9OnhUi7F+8Wup9xMVstTo+MmFojs+io+v
         BaI9KUIloDfX7FXZWdyPmWAf8n93pBeN4Cn4nArTNwfBTAM+b8HJSmv8eGkJKfJzBvrH
         15nw==
X-Forwarded-Encrypted: i=1; AFNElJ+OON1DiIpcdOyHQETm4bQ0Yfgf4M4VnQmpcrHWSemfNEKrFfkecFbDub7WxRLlldlc86ujeWlbOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysegRXKN+ODTc45ysxsVkuWk83ke1+D3LemGoTm6LTinhe2FEA
	8Z1/8fM4cXjqOTKugnX36IzEutWQLCxg5J1zQTBEijQJfzpXEA/Yy3Lx+++j3E2E0FgwmLBqh0m
	sfIl1/+5x/vg+Z91rN15u2KuPyKEu9LKC2APBh1PN7SBAkjVZ54MNQrMI38ajvQ==
X-Gm-Gg: Acq92OG+Ag5fLMunDcpy05I2Uo1kUAjCfJSZPZJxcJh1OWs/JuPbU0PTvs2KbcbTWNG
	DPeIuUnHGjdzFhVvJ/6cNdy/ZgL1ypQYjoDkKl6AJdjRgya5XCbcx6oIXUU3UKn3jY0NaOEKhan
	czh8CP9CH7kscVZrKKkqfHs0b6TEtbofLCBdULKAOakwEinINdNLEG0rBBjqCsNB5AnJbLW9WJo
	lti0VVlSI2ZVg8HDHsZNFrGvDr4lz2tVHFKmPX760zlcsZDPzLfHTHUW+6DTu/Whdgv/oUKIPog
	TkozY1bxFtLYbFh5cSlMF0g0iNmRax1R66T/2Y+tI40l/GaG2iWZ/PiStXQieDkujFwriVQ0/Wk
	OIsks/uYZMk+x0Xb4zG7m/mzEj5bkLpES4UFo0Axl5CAseLR/8djW0na+fXSGTxvWpWd99aob6K
	tnisAcx9LbJPNvC1rg
X-Received: by 2002:a05:6820:6ae5:b0:694:96ff:d4b with SMTP id 006d021491bc7-69c9437169fmr13536920eaf.26.1779274917425;
        Wed, 20 May 2026 04:01:57 -0700 (PDT)
X-Received: by 2002:a05:6820:6ae5:b0:694:96ff:d4b with SMTP id 006d021491bc7-69c9437169fmr13536729eaf.26.1779274915807;
        Wed, 20 May 2026 04:01:55 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d48:e1ec:d837:6344])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm840310266b.59.2026.05.20.04.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:01:54 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:01:44 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
In-Reply-To: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: DAF7Pd1rdL39On-kgwdLnlPt48ODpVWq
X-Proofpoint-ORIG-GUID: DAF7Pd1rdL39On-kgwdLnlPt48ODpVWq
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0d94a6 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNiBTYWx0ZWRfX68ShkOFdxxoM
 oIHixsSyyjRELMPw++1YsfkwFHynxPVhizUUcMSZKRag6yh1GnQzZju6H4X/aZKlO0YUaacDKgq
 Ei6vd1ek3FTdXiXLCndrqnsNWkfczyNXE82nLt+1oM6EgHSqo/WyfiRI5MA88gxOlDddPfdhAIT
 lPv7Wdw43ABdGQ3G3ZbjEKnjDGe1jOZBhp+MXIf9DHG46bHOUae8mFAAqA/ESITvlGocN/OtPnb
 v3JgdcAOIEnDvh26QWFOjI1XXea79IM/dO18XrIToFlmuPKEC5Zk5Pg1FBdyBc+FyZbX0FcMW8q
 vkv8nXOnAsqyEkev3ZFcCdHQ2MxY0wos695vnE96Q6SYWHGmHsyJ/kzlrbFo71Dr7Wwh6xmpT4s
 muorRvAd6G+3k/Vjp6VD8BHlKfZYeCMpy5QzeZTFnd4ZIgNe5uojSv5knpbEBpL8pI4Xj+FM5g0
 BOAJDCS5fMRZGLFnVqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200106

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

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
 		enable-active-high;
 		startup-delay-us = <20000>;
 	};
+
+	wireless-lga-connector {
+		compatible = "pcie-m2-e-connector";
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
+					remote-endpoint = <&pcie_bridge_ep>;
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
@@ -408,6 +441,22 @@ pci@0,0 {
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
+				pcie_bridge_ep: endpoint {
+					remote-endpoint = <&lga_pcie_ep>;
+				};
+			};
+		};
+
 		pci@2,0 {
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -500,6 +549,12 @@ max98091_default: max98091-default-state {
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
@@ -540,6 +595,16 @@ &uart7 {
 	status = "okay";
 };
 
+&uart10 {
+	status = "okay";
+
+	port {
+		uart10_ep: endpoint {
+			remote-endpoint = <&lga_uart_ep>;
+		};
+	};
+};
+
 &usb_1 {
 	status = "okay";
 };

-- 
2.34.1

