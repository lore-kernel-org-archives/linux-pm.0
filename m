Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CE357CE6
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971496; cv=none; b=IByrVcyVe9rKvOU9CITU0SLHFqvGCm03JwLNjQ3pd9juPlwVanJThsRtXiKAVETOgdfKorA/MVhHAhQHiFNl6yOqTPk3vUpqGJLBD4EJdcaJcy0myqZMtcDsXQ3ciiEqeUpn7xWN+20FO5dupHXXn6ztysvs9ZwAH4sAzU2hbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971496; c=relaxed/simple;
	bh=+7jXao5QdK2z2eXaysNpqQ6Z74zwWUjbRQglo8sfutw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7Vx6flzJUfmSfM1tr3tdI1rq3rtUsFSKwbT1i6s0Ob9Jj0hcyH++jMWV4zEA6uWv7F8M9QOe+F3MrMDecs3QhASpp6h5SCpWzLRFaqzO6EN4khICe24Td0Z9Twh4cs21iP8qdDa8KJS+1hKOvQnxZQNA7VLDUtAxnkxpwIiuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MFsTExGo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bK+Z7fuY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MFsTExGo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bK+Z7fuY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJAecU2159230
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SKwU9QhOKN6x8v4UcbaTA/MBFjwqaAwujUYoMVqaSrI=; b=MFsTExGo+Ip+A+7h
	vjqGlAd4i4c0Z6su4OzGsKOVtxH7w0ydAQd7NYw9KiS/8EXee26aj90zpqj+1Z76
	xUr64/sfZ9uCWx3jH2t48fdF2z8vhuaSIk9ma2tLvW+oibddvGbJAZ4p18o+I1KD
	Ixib7eBvXTcVYlBVREQjuJ22U7xPz+WACNw/DDX9LjT+Gf2RBmTtgcFkBAv+ysSG
	JNMWiPWEOpfbtVnGRu2mf3/kcdh3FNOiOzJyuOTGdbYbUxr5y8gL+37ekTqDdLa6
	RdLjh8KFsNXxnrTOGff5cDmYXpG/Gn66UoY/sj40M+iY2Qm9HmljM1ckqUYw69e4
	vBSC+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qtfry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38db4fa2e25so4425666a91.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971488; x=1784576288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SKwU9QhOKN6x8v4UcbaTA/MBFjwqaAwujUYoMVqaSrI=;
        b=bK+Z7fuYxA9d1mQ849KmJjkGnvFW1zZwGQgAxV4LZfYZlifU0RKyk4MEIQJLp5crNr
         914/7CKHWWJUFieecAgPo2sfgxifVGq7OXpaWNyp9Ph8hhH5Li3ZF8Cd0gQGKmUpYH0L
         WxDy0UjKX17uA8m3SurZ+g3a6NnBhKblaf09tT1OdchSzxbwqxvUJgBufH8LB86fSLtW
         VdXPrstFcuDDSmLiYFkMB/HfNZ5TKJBaUCPp8qnAOM26iskXN/RkcWFaa8uFY7lw4jM7
         yu3Z6vO5SYk0ktIHNkfUM63f2sTzvE+z5bdm4rJVJXiSTVpDfUw1QMQVAIY/wGz1txdg
         hyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971488; x=1784576288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKwU9QhOKN6x8v4UcbaTA/MBFjwqaAwujUYoMVqaSrI=;
        b=s34asobBStQZMaGtX6Yr/GZxJiHeePenIHWCCEJM31VlraoJCs8DTjFxoCuaJ97ndR
         SGbl97gYsQn7DAIaNm5RAso9sPh2wesoCM2OtsfM2WvgCgz5i/xGdlZS4SiN5gUeYdFP
         t3i2+BwOR0hO/EB120fWT9nhFV3xkyNXPbcmBWSxLoCPwQkgnB8QDI+qnjaPRzzqXzom
         TsVgEZ4PGuilUEHMBdE+8prPubvGlSzmyMRk6u0DMpOfvRVQSGcYUxdhO/hXW+NL6A9f
         Bza2Bd+i3PXrOQ3gKKYjeOqbVO2aSJEkfhSIWoa1AHS52Xb5U2EfxX2teiQDfunaOIIZ
         +/Aw==
X-Forwarded-Encrypted: i=1; AHgh+RpILjEZjhPFIUuWrYeMt56zX89aNnLjvPiHniIoG5GqgxFSKZ81ihvQFrEGClmiFqZToO1BxJnnLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDhhwyuJCibtx4wn4YTt8RswrAQoE/25bJwEJdVwJV3d1OP5F
	jzgi6Z3WTlIQ/Z8cKr68YgaW2EwsIJpirYubKfb08hSnIql4GOpMVoRb8ownadipsYascVtuwIv
	oIRDZqdQnFKaRsn0Efh0mSWji39qUBwfhI7JKOUDovjcNwhb54ByFDoqZW67bQQ==
X-Gm-Gg: AfdE7clc+SAH8BboSDemMQY3PZjygrUV66F7873QUBjSh8b+k0cjxzl//8pnXUfyoqA
	iKF9DA+DWIiG4ld+57UCMlPUu2s2+KL7tyUUSu5YDis+0aOIGymwlY3kPIU9WCifMauQ8Af67Hx
	+orn9twTosPSRSiTAn/QOh9ZcgGZO6SHcvCUDn6Ld6qkPfotwYo5uxUZ4sOe+YcVIjs1RPCeGHD
	EP6UvXBKT86PMclot4y1fgbhp3vsjHQcyd8rXotCGnuKhvhaTl9grzsq7eWt1EE8uafDQeOlf6Z
	bCwZ8216kZYBP8bklCGQOGk2NW0O0kViUvot5l7b2cfGv9drfEaSeeqPuCu4ENuK4gpLpFIDpD4
	EMU8qGFKkaeRvQnt7BPCdneSkoQ==
X-Received: by 2002:a17:90b:5384:b0:389:8f6c:4d58 with SMTP id 98e67ed59e1d1-38dc777c40cmr10073061a91.34.1783971488414;
        Mon, 13 Jul 2026 12:38:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5384:b0:389:8f6c:4d58 with SMTP id 98e67ed59e1d1-38dc777c40cmr10073028a91.34.1783971487975;
        Mon, 13 Jul 2026 12:38:07 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:38:07 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:59 +0530
Subject: [PATCH v6 10/11] arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-10-bee265d3499b@oss.qualcomm.com>
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
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=4938;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=+7jXao5QdK2z2eXaysNpqQ6Z74zwWUjbRQglo8sfutw=;
 b=U4p1S42eMk4DYtvOyUp1vR7XP0JO7iQHpuCYY6lILIQaElTzxjT27Io2ZhUhpXcDnbzPTtTZS
 uMXUJbntRXPAuogNgvUXZV2Hfx+RJh/AaAIJ4YTlBo3I38CyB7Lb9pA
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX+YR5VGyPloPv
 5a6DVgjergNkpmflZbaA2wuEfH7l6dpZM3Y6t7rE1HEv3Ag1m5wAWqRdAnUXdXledYy0eTCiUI8
 ioVTjJ3GaZ/frSqH7dAjZQoQGXKaN+1Kzvamff60msdwG/VlTzx46VQu3Eu+GEWq6vF4xVkRH6r
 Z7G2Ou7Lj71vPQdygFonaJAcF6M2twmPY6nqlzk/oJ1JzvgdLl/bTGrPwkkFwXoUBxpYzZajZhz
 0g722M9Xt8Th18s6YLVFKakx3EWNgIeDieLVmFfTnxfswf5HJ35VLQhNnKcnzEhcR4XsRZIRV2Z
 pIqZnrSA36Kx3k3cjwdVM6eXZGu5jcL2/ubhFSLLH/qyURMBeo0ooAwGK/iuu2Juo45YLCwhkqd
 4+uuJbeg9R8/eT7EhgAPUZ8jioL6grRoGXnmjow/JgClUKLl/AGI3jHeTI9IT4/YmBU8eAcs4qM
 RrN/mYuho4nX9+AY6UA==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a553ea5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=4qNR6o1dbhOseOkXa0AA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: nFp1Rnx0x23rJMlf-amFjjZzbnjbzDLV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX18+HgabzBdxe
 5Bw7oqQI3EKQ8WvOJdw9LLMgflTcNQukLt2Sx0nrc/gYA1AVta+uaqTaKEZUJmBSoC2Af7y2sdO
 lx0lwR6a9KpOlsKQKpxX/+3OFtrUWXk=
X-Proofpoint-ORIG-GUID: nFp1Rnx0x23rJMlf-amFjjZzbnjbzDLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130203

Shikra SoM cards include WCN3988 WiFi/Bluetooth chip, with supplies
provided by on-card PMICs. Enable both interfaces and provide the
required supply and calibration data.

Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 74 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 82 ++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
index dc3861489f64..8e30d451ab41 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -11,6 +11,10 @@
 #include "pm8005.dtsi"
 
 / {
+	aliases {
+		serial1 = &uart8;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -27,6 +31,42 @@ key-volume-up {
 			linux,can-disable;
 		};
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &pm4125_gpios {
@@ -154,3 +194,37 @@ pm4125_l22: l22 {
 		};
 	};
 };
+
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+	pins = "gpio88";
+	function = "gpio";
+	bias-pull-down;
+	};
+};
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
index 73945bf42112..62e37409ac8f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -10,6 +10,10 @@
 #include "pm8150.dtsi"
 
 / {
+	aliases {
+		serial1 = &uart8;
+	};
+
 	gpio-key {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -26,6 +30,50 @@ key-volume-up {
 			linux,can-disable;
 		};
 	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "wcn_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&pm8150_s4>;
+		vddxo-supply = <&pm8150_l12>;
+		vddrf-supply = <&pm8150_l8>;
+		vddch0-supply = <&vreg_wcn_3p3>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &pm8150_gpios {
@@ -168,3 +216,37 @@ pm8150_l18: l18 {
 		};
 	};
 };
+
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+	pins = "gpio88";
+	function = "gpio";
+	bias-pull-down;
+	};
+};
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};

-- 
2.34.1

