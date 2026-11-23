Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429551;
	b=fllACnVKnhkM3ljRqiRd0Zy+W7WbIWrizXXV3S0XAfQty8dVqlNqY2a8N/4cXqsshZi1
	 rjmH+1NTYc2bc7PzXFSbyT+f3AVwEp4y0Ey3ShIL1Zi4+cHsanVIwFInM6hGiSugBl7Y2
	 bNjvdm6hdzs0jjRIeFH/8f59EibJYp8vI+UKfxV+Pkeq7Etv/Rpt0F+7Chevvd660zG0c
	 CVHUiIMww5YmGvCXfErsVdlCLTFfdCreFPRPKIa7TLrcGHm5hIWtz3rTA1gluo5oHRJNG
	 LlLzbBTG5HPh2MjlWZa/+xFmWLx+p7UmyHpVNyNpKsn32ewjBL6gt8FBOl7ev3hv1cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429551;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=;
	b=e76nCpJUR+Ol3SDQlL376NgR7xAbblCKnmmvpraI7fHQU1/GZYELT7NamI6E6yOCvaLg
	 zERnsw7OODSfHZzkYCBwIiAV6VruGldp1gSRxcYnK7sJz4wi0V69/5Qsk84BL5KyB5brw
	 pvvluO4DXqiwLCXryqCeMrCqACUP9or0e9r7rbLZQk687zikSd0vBmfMETOHBULSVUP4j
	 6P5tn4vvTeCF/eWrHCCgvjwNb8YlPHdrg0zGCHZIIkQghPxL4hbcuuHwr8Z/DAUgHs29h
	 fR07+bKa/wmEdEhFAQuCSjjVs79Qbz/eKBFy29N9wq+dXhiH2AuOBXTFMqXb5m9e0DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FCwEvqXU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8zGynrN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AA606A6B6
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 037AA606A6B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FCwEvqXU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e8zGynrN
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G1XG1899220
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=; b=FCwEvqXUkkteeyjh
	1S1Ho07mY7+MKpmHGjEpw/u01sly2+/FTvEP3DbYOaNMFdyedfCc8KpP9x4lRn+9
	A9GvoI3DZmwdpWJy7r5424xDBZvy9bHCD2b4MJVnhGdPCaMGywtJC9FT0qyGlyV+
	bjZVkDxJfYFsLjwgM4l7A3g07KPRdR6XcdRDPUFjrpV4ADTfOqjI4cy2TRrxtL0L
	k0tF4GRKq+GJzOwgd3Yob6c3gzAJmcmbno9BC2LCe6dX4WZiMeOPxPjLe9DpAkKQ
	6wyyiVcFN7ERh2eHiLdm9ZmEZiukHkjJ1FJw+go9wSXTvq1YjNAf0r1CP0fvc5sn
	6oo4BQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k0xm4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94960bd17b5so529070385a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429549; x=1796034349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=;
        b=e8zGynrNkJF/Ka7jkUNs3W2xbr22U/K+qfrV82Uj3K2D5z1zhv3c1ZjhGXe66em4Er
         I3+fN7Pf1rj/xTgz1nYhQ6T2e/7LIQrMLycClEsS3ajg+jO1QmGWtiREX7s2epLFJSmY
         KCxqRpiEqT9eEc6Flm/TtoydTyEIqVe1x3iirasxDyKazg6nIpCH4ta+FudOJqofGFvn
         A4lUe9nVetnxq/c7qju3fB2b7vVy2dr+9CXpJSJhczi+qUgGW7pJ6SHb7y7C+wlMiRej
         UKzNcKOj/X5lUMq1JoYAu8dMhsyxXo2t5qeNCAWCWGxEOQF8sBTfB8O88g0f0HV5m6no
         BDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429549; x=1796034349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l725BNYLpyce4ybNAMMn0uFOEMIGFpqz4Kp5oSPcRaY=;
        b=WH7EvBmik0pGukTvFrDosNFNPIushOvPb43IOwjyuYBGIzCn39hF7WTvnpW2lHnRpQ
         /7EYegPDSbVczdeH5mooQn4IRHJpXfwocuY11h7JDbsfb1p6WbAWWGIyUaGa5ahoj6GN
         I6F4GWcldDrpXEb/ReznBl17e0iv2ZAPdQ4EOP6RCP7z2PDADp1db9n4x2AaOJQqfrc9
         sjx9uTYH6/y+ZvvMCALntOcZOcV57q+JCe+n8suRODiDtjlO1nWRQINX/lwtwwJmAnBK
         JPzz+VC7FaFai46AZCtBcfaTUIzJK3SKhGDTr1lyhlKP5fFNIDoCvV8iuLPE+oKXCF1d
         LhLQ==
X-Forwarded-Encrypted: i=1; AL+hErG5nzYl+jDjkxCDi7z0JDm/+6qCqRpywO8I3stS7fSVxJgX3qBrod0Bf8KcaFaTNofip7A5jbEOew==@vger.kernel.org
X-Gm-Message-State: APuU4Z8hSaHZL/58birurA4TGbvQqMDJHBA388nKol0UmkZJJfl4b5EX
	hV+sWlOZgu98PvWef3eVBGA2dxQ0ZEEs6Nxik+2bJmNL/blCgV5gBR8g9iIrRtxmXlf8npU9T8l
	lazSQPPl9GMvDSS8GAa+WFkCKfaszzl8W+3DvtPlgPRJkQoMFdH7h7XdTdON2jpYF6KLgVxun
X-Gm-Gg: AZFdTZfH5uNP81bVLMa4qZcx2xgXAIqiaooqwfSdgEEL6s4xBkp/xorFSvor7rLU9PQ
	8F5y+VwBvjWx16BcLQs7ScPHEOY/af7+dgo3lOsbgMc6g4ptn71EO0kQUrnsUd+NRIeRblE49/c
	fYmBjKLUG81uTzc7GbmuywAuIBDBkHPBJzXNrZTaaVDxBpFEIWJBUcvPlloJ2DNMtJ2GX02vC7x
	nAd2iXf2o8tQu7RLIpJFgFmlhvoB229gXBwUk85bMZztCcBOZypzDt0/qjimypmxZV3FH9njQjV
	bpZCvDMYfPn9meV06X9TrpnqGoULgjJTiMQY7B3rdLubNT0LWv/RBKDvUZNNQjIK+Y5pjFzptHN
	6l8ebcBh0DzQ6JI8vbMts+0pzXsGZjYPodqR6S8KXw7LcpmsYpldUpcJKHRvdIFxsHTwFoNlgpC
	DenQV8wnUodK8lKhm+T79Zplj0HwyQ2mgoI3mx1yYD46Mgx9Rc99F4LkZFaYBsFFJfuxA/C90PO
	SKQjKxl2tAohX4ThM3iBXP3ftlS
X-Received: by 2002:a05:620a:890c:b0:949:6e5f:7395 with SMTP id af79cd13be357-949bab350f0mr1756203285a.79.1795429549261;
        Mon, 23 Nov 2026 02:25:49 -0800 (PST)
X-Received: by 2002:a05:620a:890c:b0:949:6e5f:7395 with SMTP id af79cd13be357-949bab350f0mr1756200385a.79.1795429548752;
        Mon, 23 Nov 2026 02:25:48 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:48 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:39 +0100
Subject: [PATCH v8 8/8] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
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
Message-Id: <20261123-monza-wireless-v8-8-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX+qKsEVBqpIP4
 HS6ckMjoYs9n99EKhMZlfjgEaMcvyOp9i7PtyrW4mk3CIh/9zlCPkn0yL+7czCtz+h6GkcneLRt
 PAQJP5Cyv9Pt9sO1FqK6+9PM8mVWvvk=
X-Proofpoint-GUID: pRELY-pG54Pb5xlhqalkTjk3bx0JpIB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX1lG38OpoQwiQ
 ygQQGCgxSHXOhnNlwas+ewV3/S4leyOIgddsJQ0m6kkKCIh3Swbk9w3EqU3EkNe58VPtab+PVoi
 PYRikq582SpveTEmR/5/LfPeISitJw4+Cmlt6iYisZBSIq0S9Y3/R+JV8LWhYbqG9bJ/Mk6M8U+
 R9793C/RR7R6Q3JABgMV3NFlJXA151NBGRrKx0eww1lgqtSe/5+jpjtBhe3I5U8X7zs1egjkq2i
 adsf2TgEAfJkriyBUFhn6duXwg+TP8fZvOu2RCZ7lTUb5uiHzMnqCHe2ObD3CkhV1IYK8g96I+H
 xDqUDmqcIpbvxncpVDhNH0ic48bY0zf93R+6Z1sAySn/WSEZOKhOS/q8i3BNgyOpsjOYc3wL5Mv
 l3pc5pBx59jiJgk30xYP1HqtYnVOWqUB0IfkLDfY5b2MPkoNTZHCwEBM83PBW8n9wENRSxG2apD
 W0ZPNpdwKwxDG63GJ9Q==
X-Proofpoint-ORIG-GUID: pRELY-pG54Pb5xlhqalkTjk3bx0JpIB0
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0414ae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

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
index 9ac2a04b302d90728d2302e81ed4b27b9467c23d..132f28df555b3ca3bbb411fd38155cc57f22698c 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -180,6 +180,40 @@ vreg_nvme: regulator-3p3-m2 {
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
@@ -548,6 +582,22 @@ pcie@0,0 {
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
 		pcie@2,0 {
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -706,6 +756,12 @@ max98091_default: max98091-default-state {
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
@@ -757,10 +813,10 @@ &uart7 {
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

