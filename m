Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95604FECE0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536580; cv=none; b=Xi7jHZFQ2MfBZUUHO28U1iAxZhnpny2/1wP684RN4i7ylElh7+wFU0OosprNlNbXM1y9sVhiLF6S+ai60BfsWzfvMaY3plRxGQsNn0XO8LZTObdSrpRdEinsZNL/SW07ydojr/gPrytcCe1X8D8MKzMmBvjQlfPERJUKXaCy4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536580; c=relaxed/simple;
	bh=i8r9ZnGm7UzMiQFW/7A3fSPuq52yoy955ncVpzmNaO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MtTtBHW/TVaNjBRE626yaT7RNugidQxydEkIxy4r1HRPxsQ5lm1vGvPbaG0gY7fAyCyadxSrNoY2vtBUI0Xu8DbMDq77Y88/JwD6EjblQnqreI+e3GqHKFTL/Y+ltnucFRkyLxNzLIKvpX+LbKIdJtj+yhlRSuqyMRzl3otgxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=THofIXlb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jt/JwmTS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="THofIXlb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jt/JwmTS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dglgd3719489
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KamRqdSZl64fR7Veb4ozRWlQeNymX8Nh+XyeNQ1IdNI=; b=THofIXlbr4V55jOn
	Mu2NH13rB70VlQkKRxl1826j5h61trEXAGB6wPHU/hXllqH6PNW4Ax8nu6bm9Xsg
	4AM5SFFges3J2cn1vyvfJefGyVIIaKAZ55XJWr5OUnFPAbT/QBsGsyy9bZDNQ0YC
	4BzTIDFkYGKcnElrzhw0IphkqqhpOx62c8a41QbTiHrRcBJTTulxOrv58nfpbndJ
	6+pzBFiG56MNq2btKw7pDJooE8ocaUDwFO2v8nsWsi7rwZs0swY7WQ0VQMDHXJyn
	IhE88evhP2kJ+lOlNR17MH/ArzsFmNU/T3GFlGemtXs4J0Uvt5X8Ny4FyTv95/+x
	ISsuwA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd2p31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:43 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-73883529f72so957681137.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536563; x=1789141363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KamRqdSZl64fR7Veb4ozRWlQeNymX8Nh+XyeNQ1IdNI=;
        b=Jt/JwmTSGXmVl6wYqeLLxfW2ZD7oAyBx6BE7/143oCSTsrMS5p9VaW3b2OH5nOGqEp
         6q46JPNMacL3hlU/264RFWz90ma7lPFYlTXLh58QowgVvYq8xNiVqYAIGE6trj0MDbBn
         tQlwAfNkQmoFLulL4UlgChcN2mnCcFGvomARQwPssYzox4zro4sQ1LFfkE/kAxVENsqk
         CkCsQZIHnHbeQLdUnc8MGE5ArYh6e5XEFfwYxH8gyZzIE7KvfDAQFeTlxBT4B6MUVKTL
         Hw1H4JgTo250YPH1XtUrFPN6aQgmAPho51/4HBB+KsAFEpx3b0yFjFOh0LwoTBeuZ2wo
         5tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536563; x=1789141363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KamRqdSZl64fR7Veb4ozRWlQeNymX8Nh+XyeNQ1IdNI=;
        b=rcEp3hAbPpdgXqLZfftF4SPr+hMT/WzDQcO2vroGvYm6681GapwJ4n/EFDBxSEVHIu
         Hrw+1c76djhv4Wc+53rHyUkNwNT3sk62zjc7+CyYM40pk7Z1k8NkXdAxV5/OpA8uNGpL
         3WTnGYeSPjYX54xegApJDriWOtXJxevkiPf+5/z43qh4IashbfUMlnTgaFpzjL9RMDQA
         a69yqHVqdERAR1vgcmLHXAdUi3eFTP/Yf1ZaN9VlABSA6aD+sEBX8H34dptEFAwzFowY
         GyISBt1KeGHBruAc0zuO3cH1FSrmVi06OGlWc6uOjjoCe7fQtcWTNTZbNvJ8TdTc5Jio
         ui1g==
X-Forwarded-Encrypted: i=1; AKwUvBydqhKGmsTjKtu/hWEvcy7v4NJydf9dH0XQxsNZOi1qT60n2W6PBBKdQNyjhY+G+dR9xpGWpO8PAw==@vger.kernel.org
X-Gm-Message-State: AFuF++nMFZ4673HO2ZjBduWywekIaFv7Ed+S8EbdMlCIzYR9l2M3m60H
	7gc551oB0aH9Bg1cXTM6p0czZxZuQb6u0ULX0z5JNbwFRGqEJ0X99X+nmf0T/IJgQ+n6hq19bZQ
	xsIFFroSB6BW0+w1heyW3F/6fjsmCdNh9vljetSixPjVjuXRBqcm41dp2sJRlwA==
X-Gm-Gg: AYBFou3wrsVle7ahcdCPL30SFi0hixgkD1GP9inZBYDU1VRJk2j/Jpp6wuFOMVrVfM+
	1cjsfCoy/GXA0eTYlvfjFY91GEIWAcpIsVj+0C3GgKOG/vbSYwqkFXgVJV/QlgD5ePuJp1Cjvve
	QugK/aaJhv7VFNdmocmufMhX0G6hVFBf/nSF/keKUcdF6ZAeU12yd0DqadnQaUSthFQnoe1u5Az
	C65lt2oqzKbKbAjvJMyJU/5i5Yf1hqhhMCV2rGAq9i1NdmzIvkrpkOpHgKNNTtvog0UXCSouQB8
	o+76SjH3ptN/PZ9A8Sw5An7/onAUokUV4FT/4icLBO5VQ0KlUxDuf/Uvdi2/IA5yDA/4uoM1LAF
	vbkmCmuqCVnZCAZJfJs9kWNTv3rrnBVcVc6B5288VUb3Ea9uR+imMGkxfKRBXMtpIiHKD6zkhBC
	gGq60xlRj5qj3Qp0Tsi6dicUsfUqsSYlqLQwYTcj5XADeUaB4vZVs=
X-Received: by 2002:a05:6102:291e:b0:77a:7620:81b4 with SMTP id ada2fe7eead31-78a4a839bd7mr2523635137.4.1788536562890;
        Fri, 04 Sep 2026 08:42:42 -0700 (PDT)
X-Received: by 2002:a05:6102:291e:b0:77a:7620:81b4 with SMTP id ada2fe7eead31-78a4a839bd7mr2523620137.4.1788536562532;
        Fri, 04 Sep 2026 08:42:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:26 +0200
Subject: [PATCH v6 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-11-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
X-Proofpoint-GUID: PMBuF5sxxAdAnozHyh2UKNGXf-ivqNFG
X-Proofpoint-ORIG-GUID: PMBuF5sxxAdAnozHyh2UKNGXf-ivqNFG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX8hfzCBHz+3Yi
 iQ6fjD0lzwa8stan3EebdmuN8U5V+Kgok8hvXfScBZFK0bqITYTfyw6wbq6yygI8LZZ5utg3mp6
 AlAoeEyh4zJO/kqkgoAIV6f9+80YPFs=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9ae6f3 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX50HHaoQAUnQl
 ArYw7lKjV5Ol8qQZCAk5WZdLHylTVBzLgorzy3jEw+ltqiN1PZwFzAPFM/QjSKkdDcRljeUtegD
 Bc+HSR98XamA3A0Bvzx52dOo/j2fyc4nI3yapdwKgwvnqne6Bawyb0Bv7QUgN/iUyg9f/usEsXf
 sID5tyhdww3vjG0NBXJLpHtnfsqDo3mRjt9lk+hPBQHfnfCdX/dKtEjl+/wgsIWb7iEvK5IRP3T
 GqbqU9TbWAB+PPcvMlFMpir3uMIhecPyIirTbU8Tam9Lg3wvUaasbuIoGDO3uTWDvbhAwf4bA00
 4UkEhkYIMF9SE1cr3u7a2f/iSZWhxII5NXl5k0kcse721PYUP4fq/j3X6F1HjQTiA2EhcYtGsV4
 X9VGRZri6pYQ/Y3n982JrQUzN4eGVAFTwFK6cCaO6fsDnPvOG6VVtVGv3z435SCRC7ciTYhhGEE
 NRzLN0bHLgyVwuxpTdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

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
index 299d0da15a1501a03e56025f928eb456e4e2a7f7..afa6f0ecbf60210055ae17d756091523b91dc98c 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -169,6 +169,40 @@ vreg_nvme: regulator-3p3-m2 {
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
@@ -429,6 +463,22 @@ pcie@0,0 {
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
@@ -523,6 +573,12 @@ max98091_default: max98091-default-state {
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
@@ -566,10 +622,10 @@ &uart7 {
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

