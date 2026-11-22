Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329983;
	b=HqnqSxDaXiE1WCAX0IsTcAd1CLvdYQTbAr0CJaLyWdWs41ThfFGtR9P7UkObMG9EeFQ+
	 maIkQhijZZxGuJ2LWu7NM0voaRp7+GwbefF62b0ehvPjF+XtfUmDBODs5Ktrt5gDHG2oZ
	 H70K3kW/3TK8qZd+LV63AESI6FzgovMcqbPIxJVz+c6ZfOQpZxckNPCKF2MpP0XF4ABQc
	 cP1wEzeAW+C55AR8z8jej9h5D1D+LG2uN+B/HGwC6d8187oh+kWCqAc7Z7UE0TKn8Aq4P
	 gzUwGydBBe7YUPQp/IsP+wt7nP2//3IkCntmn9xVF8pfTrRmIle/2LwixG4gvtrTd1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329983;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=T2hwzlMo9LCIhFKqcy+WnAbtHTyj+Ik0hC26DXdFkAA=;
	b=FiTgCHtN2lYkVSSCjDP+DNHouadZdd6RrNoyoOigwBgqBfUfHNOzgu9vOFZ0An0sEi9x
	 zHh850wJ6/OMXvkBV0S6AfPQYGv5PsJRHDpmW40/My5dIn1vNeA74ZI7jdwXwBIrflRaP
	 /biWZXsv4XxhY/aHmnblQ3MHmPmYZYQBLRRxgWVNenaDx1/PuvhctsllWUyxs0WL7Wpkt
	 wzbFTdVzx0X803kyqzJqP1Uskp9IdTcOA30vdR2Kk4IKyYJRNpkzK8DF6s6oMUzAweJtx
	 E5yvaymQ8YRFb5UpG2ga357FGpAU4sVDlmJSbSm6VRIjsHAU5fAkXoYqDLh/xeeN/ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LsfZZWu+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TK61b0c8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECD606A686
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FECD606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LsfZZWu+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TK61b0c8
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3kd2p2085254
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T2hwzlMo9LCIhFKqcy+WnAbtHTyj+Ik0hC26DXdFkAA=; b=LsfZZWu+YdfgIrH2
	Iegjwju0OOrYTkgJLKR8LbyqlXyDGSDloEDfcc5Tu91EUl3+CAakESqAG2TdEpCa
	9+lYy8oHhAlDTUs+Qdz9TH4Nx9OBNWaZ4A2g7m5TPGfaQIVf1OePi7ShwRkWenFN
	d1UtK8PvUkRSDD7Sm7IkMVQigJ3KT9w80lF9ThAYSVcu53nuhZTUtSo2NLkuqFxp
	AkpEUnz7V/FSpzjq5HMmQxmolRNA5QUqO0K8qEQxdvmjxFytJFL02IzH4syCIuDh
	GoZbyaHBwIMp/SOFyZsfmwMfuBjtfFMug2Ydn9vFyxg7sZ8hWVhparVv533OdLl5
	ARP/EQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32mgaxhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-370230d93efso7494252eec.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 22:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795329980; x=1795934780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2hwzlMo9LCIhFKqcy+WnAbtHTyj+Ik0hC26DXdFkAA=;
        b=TK61b0c8iBVlnbrdhc8BzLOSPoDhu6Md2Ytf9hBXeloBPL0VUwORqibZiGAcmv8fFO
         7W/Pl3Kgu2+Fxluyy0IovggQgjikgc9uOmqMQnomCoAUiUxyzefykUkaTkO/n2XqJwVe
         sEuBhgc+EXAQCwy6jjdtm3RVIYDwlDkshtA8R6K/TOChSERgB/P+y45BB8ekMssbtQb+
         xFu+sbP/2wKAC+ZW5HDoyr1cU562pDKuP1SvH0BIrndMCKTdGoVDcbZgO4TYhLQbxw0x
         y0soU3SD/lt5rhmllR9A9FjVtetR4lKf2Vg1JPaGgQDGJQE5tyFsVdrzNpLOEz5GtaZ4
         +bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795329980; x=1795934780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2hwzlMo9LCIhFKqcy+WnAbtHTyj+Ik0hC26DXdFkAA=;
        b=Y3eDWhqmi8WtMvQqvpAyy+YrMGXBLJW+uNLiI3J90yCz6ZhvPuB0BXScyxp7L0r8sv
         NeMJV1mraSpxI+HF6BFr0zqDfRq2XtviukrXyEIv2LISpOoZBYdPcApdZ69/yNWM4O5z
         t8NabxwhL4JImf08oW3deFFkrL/aDpCySPbcqasad4W3clR5z18alsfb/sk8dcPb/aMf
         Jh1PR452h/EtgXZD1kRWOYvoqpQJVk0TCeX8NCLz1Zu6J+Qhn4m75aeD1ac6Mk+vQV8d
         mpjl91zZjWaCrZAeIrdb0b8I2nZwPsh/z32jiMtaGelxQC1fJu50DJenIYkmE34UdAvA
         i9OA==
X-Forwarded-Encrypted: i=1; AL+hErFFBJp04qdUMREQ2rLa+V2Sp3yvXVDweNVgKyvbhtYGY3q6qjpC3lZ7eZ3Bx/WK8vR+vcL1qib0Jg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+W8j2zeA8c7/H6PUUFeuZ4evbn09E2Q/LsH9cEpvupdv+10Kzp
	J7w0okpT2D4cvYgt+GBS64PGZH5ZxbvXeYlSXhshdX3273/WoYHDY/q0K4TP4uWD+CclCy447o+
	oAE1ia6ayry+yjKkinhkbf1Mh621Lz2XjSUdEwamV2w8o7h8iAT8MOzyH2hlfqw==
X-Gm-Gg: AZFdTZcwRaB6xY9BC8phXgxwoB7c2pSpqzDfZAEaFTRUKzgEMyj5eSkbMOEvkj/u5jQ
	FR55jHSbY3vP9CmROZAmmvkHclGILnP/SZUPQURmHazPdyGYfFeHbluNkWQBTUT3AV5dcqqWgTj
	gqQrgGkHtghIGbHD7eG7isFsUpQLLqlg2nRbiHYmoggjeJokMc9j6sdtrJ4wOOp8+eRM04v/VnX
	QOOiPQlWaZUNR6mLlN2taMd0+S35xqBB1elSL+TI+f0x5rAe0m1w1/oEJB1AX4BmCQneqKObiK2
	LQdYOqKO53Is+aQv2oVsBCnNqS4qmdI8dlAgKhAVlIB7WqZId65pFTzuVc4xMOSwmSqbHNn4u47
	nS2qbvEsBkDu0/6aFWDUPIlIy3zdjsxBIcOz5mYSDx57zhqHIqTopHih4fL7QIvkdfDrKSKBnoW
	lgkQqy0+s1
X-Received: by 2002:a05:7300:8288:b0:384:f214:a408 with SMTP id 5a478bee46e88-3857044f2ffmr8905144eec.38.1795329980503;
        Sat, 21 Nov 2026 22:46:20 -0800 (PST)
X-Received: by 2002:a05:7300:8288:b0:384:f214:a408 with SMTP id 5a478bee46e88-3857044f2ffmr8905121eec.38.1795329980032;
        Sat, 21 Nov 2026 22:46:20 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm27598615eec.10.2026.11.21.22.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:46:19 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 12:15:54 +0530
Subject: [PATCH v2 4/4] arm64: dts: qcom: nord-rrd: Describe the PCIe M.2
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
Message-Id: <20261122-pcie6_fix-v2-4-2e0fe615d90b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795329956; l=2116;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=xSU3owBM0txchkN3zsSOuMouYuY186IHzX74a8nKw8s=;
 b=LYm+5o9UAUI8UWrXpqljfX6SY+ut9AqqZn291W8ecTKj0wkOtXq/jb1fUcTPjNXSwpQLR2gaB
 sbkBZnRlP2uDiMw/ZSgBxEKMOyxnuN4sk8q70Lr1TGFdxZA0ZaxVyJK
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfXzLT8APlKeqRv
 Jk1uQDVBvigyr7Px8NBmnl5dtj3uvrWjpsVBNeks7Qh6dIN+timc/fNLIennHQQwQe4pwOKcEde
 X5l4/mAu8yF0PnXp1ZFbUVY6frSPoldDaRyWTicAnDtpxhyGBMwnjmERp1Fq+q8lCgA3gHUiQPk
 HAEWsvHTiIu9TlVa0DKXsBFvjGTJSOcSAmzvn3VXeSwyd78VvBJtGj/qzkTmSsO1/vYhTmntlPt
 XARZ+SzBlNUUapx4dDxv+WOBhJEEnc/uH+hJHcDYzpKm9f3xs2r9W+U2H+PgN7qvmcnOQI54ZC8
 wYXAd1V111hK7rqcfwk7tpVZVYbmCrME0B7UCt5H8x7eV7xgEzfcut9FEciszf+CWWZJkDkXOpR
 4fwtULeqDu33BeqtswZoW7rTHH2ydAAlUtrtlFHS3R47fySVMLKbmX8G+8WTXDpmH/KwGylZILn
 51YIIBLNpnsHeai1uZA==
X-Authority-Analysis: v=2.4 cv=OM+yTiaB c=1 sm=1 tr=0 ts=6b028fbd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bvY3E1ByFFb03tV5gjAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX+/Nz+odBUaqN
 jLrSh/HUlTU8G6tegmJKL6ps0gDe0d/BUaooBLgnTulyCtLeGbVOvP4eRX0TKJyqoigsTlrP+/+
 /QLGMlg/GZ208kifU6KLmeyVKjSZdgc=
X-Proofpoint-GUID: h2OnkTO3S6VO-EiWjZfKZzJ1bUX6atc3
X-Proofpoint-ORIG-GUID: h2OnkTO3S6VO-EiWjZfKZzJ1bUX6atc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220026

The Nord RRD has an M.2 WWAN slot connected to PCIe3, but neither the
slot supply nor its power control is described. Describe the slot as a
PCIe M.2 Mechanical Key B connector, so that the slot power is
controlled through the pwrseq-pcie-m2 driver and the PCI pwrctrl
framework.

The slot is powered by the vreg_wwan fixed regulator, which is enabled
by the MODEM_SW_PWR_EN GPIO. The MOD_FULL_CARD_POWER_ON_OFF GPIO drives
FULL_CARD_POWER_OFF#, which the Adapter treats as asserted when the
signal is low, so describe it as active low.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord-rrd.dts | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/nord-rrd.dts b/arch/arm64/boot/dts/qcom/nord-rrd.dts
index 827d3ba3a238..59a0210e7fbd 100644
--- a/arch/arm64/boot/dts/qcom/nord-rrd.dts
+++ b/arch/arm64/boot/dts/qcom/nord-rrd.dts
@@ -100,6 +100,40 @@ vreg_wcn_core_vh_1p95: regulator-wcn-core-vh-1p95 {
 		enable-active-high;
 	};
 
+	vreg_wwan: regulator-wwan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vreg_wwan";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 54 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	wwan-connector {
+		compatible = "pcie-m2-b-connector";
+		vpcie3v3-supply = <&vreg_wwan>;
+
+		full-card-power-off-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
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
+					remote-endpoint = <&pcie3_port0_ep>;
+				};
+			};
+		};
+	};
+
 	wcn7850-pmu {
 		compatible = "qcom,wcn7850-pmu";
 
@@ -537,6 +571,12 @@ &pcie3 {
 &pcie3_port0 {
 	reset-gpios = <&tlmm 11 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
+
+	port {
+		pcie3_port0_ep: endpoint {
+			remote-endpoint = <&wwan_m2_pcie_ep>;
+		};
+	};
 };
 
 &qupv3_0 {

-- 
2.34.1

