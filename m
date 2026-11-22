Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329978;
	b=BewEyVaC6Qt99IV9xUdgbPIj0MKHbIRKBVyrQXD3bWooZHyIQtCYbvA4664l+UVU6P9t
	 8i6WYdKKBGmqp4n2KCwDJBKx2NUd0ak4R88rti7+BN5SHY4Se0tTbv6JAzVVbxyyOkp3e
	 2rwaLZ60TZcUVdJ/7gEfKZ5WVGniuGk26CtB3pAl1jaf2S/eea5+XzUiQvPSHsLMKMmf+
	 DYASirGvG4xJPczFwCtiYi6G1vx+dpL+xtyxzbB6X0DzjE0GblqHgJva7cWLoSdz3G0tS
	 Ppmbbz9NR5wSXsSIv/3dhA8DAb3sSvS4FyB9K4Eq6wQC4jCiwA9AlEqBH1El6yB7Kng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329978;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BU1KJppj+EFVZ6bNvS7g2mTTKyI1Mqe3Kr0MuJ8/KAA=;
	b=OGcaBVZdj+d1AuwSjLlCno5DqRt1LT++SfUJsQ3UHrS1UMPrstTu8bg2RY0ZqpZAap/6
	 CvZ4bVSgXJrcX9k/Oy889M/Ez53c8oAv/pGTBJEESewlU02pVn3RG+CY0NYmm3+Iq6PlW
	 09j8mlT53AT36uicRUQS+3BxHPRurqhYY+41I2WA5uWqR4iVSyn8fLRtkuAuMvxU42290
	 ru29IR2VYca/bI3EQTTqS1cz2bk19GktiuxiMdeucL+jhiBfrb5tm/m2SeQfpigaiAgiy
	 VMi96EDNcKNyzQ0HVoqM3/PWYJlQKHlU2tzXmp6SyL0f2g5U0S1dp+mUsMM7evY6YAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SWACsV7q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IWc0QVXn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A6606A32C
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA4A6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SWACsV7q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IWc0QVXn
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3l24x2086142
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BU1KJppj+EFVZ6bNvS7g2mTTKyI1Mqe3Kr0MuJ8/KAA=; b=SWACsV7qf/n5Xnww
	P84lp5jrNi/GbgHq/1teqN7WHATXVlbKhtPCSLMXE1pR20jhPjWcZUFODyy2EapY
	G6ArThlczpNOx/EYHpLvgBMwc0ecjhPWOSzUxEh+5HJdPnb83XNM7zmkEFrJD0UM
	CXBjweTwbt03aDPt9BvDdc1fJczUCBitHK76Qp3wuHOBBxOISuV48m9bUQr7d0R6
	MJL7sVT6lSztHVsRWd0Y+KFFMy3gRq7/x/T9DmG8aHgCSpHvSvL/C/igf6HCxw7y
	Mfx0XplrOyBF9Z43l39BplMHmg5uzN8524o7rvGeHXDuS56CYR0d96BVVOJk0Zrb
	tlUyMA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32mgaxh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386a0f79047so1240703eec.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 22:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795329976; x=1795934776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BU1KJppj+EFVZ6bNvS7g2mTTKyI1Mqe3Kr0MuJ8/KAA=;
        b=IWc0QVXn6ZnwawKBU9LwEXwElrX8kIpw7baWynhovZgmWbX6xr99n0qMrrZUXoxSyb
         Tu3V55siyAnjvanaVJrltvVCaYcWLrUq4qEnavTtKTVG8sIUtQZ+ThRmseNPAMfa8pYq
         WlF/1y+WaPXgzxPUhczouyjX9CKAEMgjNoCRbFqougdyuDL5BtkvbtwvSjAv+tQDiL2S
         baV96G5AeY7LHXXX/l81Z4ScqkOQ60/teISXKrRdPRqOgLsC9OJNMaGX50lRPJbkGJbf
         xsgSMHV9RyEbVkca8Yg3bfnAeJ6QGvISiLNi6w8NwuHG8cpaOftE7PdNfIbwDrz/E1tC
         2mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795329976; x=1795934776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BU1KJppj+EFVZ6bNvS7g2mTTKyI1Mqe3Kr0MuJ8/KAA=;
        b=h9RSolI7dFvW+Ge9Nyep9YFMmR43ff8B0fZHgrKTfDNucl4vE7VkjUeXLuVBCO9eWi
         zIl2ptX8dvTMUnCIdSQaF5BXMlQENbRWQzf0aSPT2ngN/jMrToBkhK5dOJik61jZfVVy
         TNMKbuJg2q1aO8hYgjjJi++jyJFKWeKl216rJiAe+tqERJcykfkNWFnWYVduoK0hg1Ue
         Qgn04BQeczmIlQ6Rfq8OPrYcSH9Fq37Z/omwlE1a8p5BNo1fV4Bd9e7ndiTsSfS0mbYb
         nREeoP+bjZBvfNvHjru9wUWO1aaVR/FFE1PVP9cKHFIpQkX9i0IJETEAN0Qhw3n5MPo+
         Gp0g==
X-Forwarded-Encrypted: i=1; AL+hErGWTG+aZIZwzljNLxlDZt75/W3aQGsVN2m5BEPw53Zerbjoo7ffFCTByrKG+7Y+dj2S98eKnD0lUg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+qlRa3+2TLGHYpYA+DJemo2gudzmwvUPmn00914DCxNrRC95n
	8lGVTbLWzvG+4vNB0gOkmV4cGDr/pEcKHX9QukvwLSgywRVyzHahsmuBGxa8BlLdMBE5AgYvil0
	M8og/x3Lg8rzh7ajwqs9v9BQfUFU1CEUP/dSaau2rYrH1mpNjvMCzzPFt2O5FJQ==
X-Gm-Gg: AZFdTZdMXs0+OExdwDdtceMHq5zFZdpwczSLsMeqEH6aaN+8te0vC3jiQNf2sLO9a8A
	GQBSSaH1kefMWihiDPdu+O4A5ewLRYY1CRXPvN8+fMg6f+HOpV9nQiavfwD0l1ecWU/lMsWfkHR
	rxQUVSzEwxlNSw01QceRIiOLkoLK5PpiG4vqkrurhoQPbBw1RZDdfxdMnGrAa5Kxm6X6+k620ko
	6eOC5sJwicgj9HzgeWZ4PZgk/L3TYEYYsKHS85636V8xnuxipZdyEpHNTOlPdVQl3EXmFK9yOKh
	sOV9kCxshEujaSWauLBkOHr+92qFMmXIPZ3K0YG01RVwZYMGWkizMzq0iGyJ8koEZsA5/6iFFzX
	Y07dc7Kv6delGWUvwapS8nPstdYsJccuVs/zgkEI1Zi/GDc0Zq1BEZfZBNpRCe+oRZxEVdGYVbH
	vr+upfRthv
X-Received: by 2002:a05:7300:1c95:b0:385:8851:fa4a with SMTP id 5a478bee46e88-385885211c2mr8048096eec.6.1795329975679;
        Sat, 21 Nov 2026 22:46:15 -0800 (PST)
X-Received: by 2002:a05:7300:1c95:b0:385:8851:fa4a with SMTP id 5a478bee46e88-385885211c2mr8048074eec.6.1795329975209;
        Sat, 21 Nov 2026 22:46:15 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm27598615eec.10.2026.11.21.22.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:46:14 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 12:15:53 +0530
Subject: [PATCH v2 3/4] arm64: dts: qcom: glymur-crd: Describe the PCIe M.2
 Key B connector
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
Message-Id: <20261122-pcie6_fix-v2-3-2e0fe615d90b@oss.qualcomm.com>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, alchark@flipper.net,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795329955; l=1688;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=oq8zhKS9moEyY2HIBaNOt8Yw7IX2tNA31iC0e7kAduY=;
 b=6wZ35/tRdGHjnolfMROOPzdthaL4bnmCxAVAPH5KXtRoRWFfo7Mcz6FgTU/YtTRrjGO3/yi/+
 /Nn1XxCSGp/CEfyu93Nc7FqD98YaAAdFCfW4DADs29yQk03MJmnWHC6
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX3jMpMtTNdXHg
 lJw7fK18TXH/qziclofcNzU741JmnFLs73eYaQKncmtE3ZmwR7E1rkQCRVrmQI04uJsL6J7qpJ7
 TYDCEoC7WjH5ZD+FiqIJEV3okOVFhCxF2G9Lqs7ySdLD2jRZE45u9Kt6BgyML9c0atV8stiJWA1
 EeNL2+JO2Ke+A+IQFuV6aB0d90fG9vcxGNggZB2b2OcmjzwQsWq/eodpq+qQmT5Qo0GeG2WukG0
 kQELXLev2m+yi/8H6qZcKZA3+ibOjOy63X7c4Bv82Hah2VaURRgW3ztp+SpoFypet9k5/hHXsnS
 JX+JWtes9i4BD1+xo/BQzoyNrfPM7JEGGg6K3bYExM9MAw3DqDa/AqaQPCmTU9f9ey8iF/4rHsk
 3Q6U35ce8jHZKGWF/LnmYFQ9GgCp5l/5gXlVn2HfUj/HipboA1EM7tkakeQzwt9menBzw2fiIAc
 vjCe4myVggkEX1I9CWg==
X-Authority-Analysis: v=2.4 cv=OM+yTiaB c=1 sm=1 tr=0 ts=6b028fb8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX4QaxDrLlQcOs
 vapdZDv+TqBsAtO2BTDWjmCQbUvjPWVFK7mkeqLX0+jagCRElxXfs9n48RMYigTQu4DTuJ/1sYa
 h0Rx/+Tdgj8Gh1Zn03LNlV6H4iZB/e4=
X-Proofpoint-GUID: 2RKusAnm4ml0Q56tnCWcb3SDTkJLpvc5
X-Proofpoint-ORIG-GUID: 2RKusAnm4ml0Q56tnCWcb3SDTkJLpvc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220026

The Glymur CRD has a WWAN M.2 slot connected to PCIe6, whose vreg_wwan
supply is described on the PCIe6 Root Port. Describe the slot as a PCIe
M.2 Mechanical Key B connector that owns the supply, so that the slot
power is controlled through the pwrseq-pcie-m2 driver and the PCI
pwrctrl framework, like the other M.2 connectors on this platform.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index 3a9cd5f3ec2b..a66ba8c0ac8c 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -230,6 +230,27 @@ vreg_wwan: regulator-wwan {
 		pinctrl-names = "default";
 	};
 
+	wwan-connector {
+		compatible = "pcie-m2-b-connector";
+		vpcie3v3-supply = <&vreg_wwan>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				wwan_m2_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie6_port0_ep>;
+				};
+			};
+		};
+	};
+
 	sound {
 		compatible = "qcom,glymur-sndcard";
 		model = "GLYMUR-CRD";
@@ -654,10 +675,14 @@ &pcie6_phy {
 };
 
 &pcie6_port0 {
-	vpcie3v3-supply = <&vreg_wwan>;
-
 	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+
+	port {
+		pcie6_port0_ep: endpoint {
+			remote-endpoint = <&wwan_m2_pcie_ep>;
+		};
+	};
 };
 
 &pmh0110_f_e1_gpios {

-- 
2.34.1

