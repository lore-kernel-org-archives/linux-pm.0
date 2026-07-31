Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E2420E71
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494110; cv=none; b=GVkoCm44OqOpM7Ynb3YkIgwXsjnCS6mk+ogtsc2zf0+/FJBphvggBnXn0wvhSd8UjR3zYxml6CbI1DhC24bbIJkwteqMUiSRYMiGziDJy/T+KbCtnZl8l0jEKCBBTpxnr7xH7eTr4xw5wbeFYPGfrONivDMgw5yHRq1BOd/kG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494110; c=relaxed/simple;
	bh=69/Nw/l2Pjw5IjdOIVkv2Ao4l0Ioh5cQnspi7SqHb80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLb9SPzhukTxuE4K4XXSgeo8hLXMudYzTqZIfkPw+AgIh/ZPYakK/gjEbYk1xBhPOg+73y+SlqLcV8zr5lsQVFmlfyFZIBSv5QM/wfSzIEl/00CAbU6Q1vfEX66XUSn0e5y+OpZwrVdt+mh6m9rMlHJ4n67C20jiH0DGaYp7fTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMNagxBx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZvNw00bx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMNagxBx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZvNw00bx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC5oG3512560
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	meyc3mG1hoZYt2I76X2E0RPX3lSg1aWynwrQK2v/AGc=; b=kMNagxBxI/rKNogG
	P/wGNu21KU4baHrUWzcNsmQgPKU7tDHmuwQljuOV0R35e1lX6oT4Gt1gYq9pWAB0
	fxv2enQg0SWyxkIR4Td47nFi/jm7/B4HKABPpKnDRdsJDMLehVhUlX/A94/RbHUT
	izlUqb7hX+cRE4TxnmtHCtWymsyu372vpVxp1dZNcLruK/A2OW91VYl5isLmo94k
	gMIzyWGSthzlEK8hLZ24AclxqADxgUlexZqLB4IRoUcLBAtbw/zXdSxsmoWYkkum
	1osaZtSMLt90zxS2cv3LH1YeL7SpXUTdI8ZLMeMcD9k5NqBA1QVHGZVyWsRvq6Nu
	eYKFLA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsf2g4g5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso1110281a12.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494093; x=1786098893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meyc3mG1hoZYt2I76X2E0RPX3lSg1aWynwrQK2v/AGc=;
        b=ZvNw00bxx8K20jwKH6vJ84A1wabaMZLj8M3vc8VfO6Iy5ijEd8NFWqYieJmUeEqsNq
         eVhtQLPhBvnq7cmFhhgomgCg9vFMFB+tvMzf84gB0BmNQIWxIK8K8i6Kvr+09CXESCZL
         vG8/jg+UFMBM0Y21z5w+GuODtVBC4ApzxfOE0CJkabpTP2DVj8W9MYAwV2MCZKoH/g/o
         oCO9VO38C2b6evsmaZjuqF53/B1NQpDchgQWHehzUZD/pst8SrO6JEFeePlxvPAce6oN
         Uoos8/3thgmlzULdpcczcR08R43CSqYjv6efR06c8EK2kkG4aayKDM+kMktuS9Ja1WJM
         LU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494093; x=1786098893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=meyc3mG1hoZYt2I76X2E0RPX3lSg1aWynwrQK2v/AGc=;
        b=FbqRyMSy+YHrogecvq+bRbppqZP3WCFmHN88jq/Y5egAFH/5HjSGk1ngjzoIY6wiIl
         vIzsXykA+tzT10E96a1xNyP1YfUHARQhQZwCRQQnOluZ2zmMpzdX/27dS6jdRUyd/jsA
         C2YOP0/CAG/PIxuRO9sFiW4Yf1dUAJwgrQzXyLHuiyJDr8sNEX90F/ikuuSi7GW8tSwd
         BQ7Nro5HgzZFf2V2DL7dqGaZW1Biw1ECBmsDLLJTS36v1vXqQP0wloCfaJYTzDvSDa8D
         9vkUwN/UX/FMQQy8ZwSjhXmHC+9xz4FZOQY71iKkWWdYdDiveYIdSzB5NFu2adO6jQjk
         Rz0A==
X-Forwarded-Encrypted: i=1; AHgh+RrjWiac4+ojMIPHQDVvLDJDvC1o21dbNg25zzp2tCsb8AZoikrMfFp6cB0CadDfNBe8prqhB7Z7Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4EkIR9A7P67BxUY4HTvw2PZJ+oPxp3QdnGp9nmKMBTR+D+Cm
	CwKI6Ct3CL8EJYdetTE4glzCcHUzsiXcZll9WUCW1eoVOa5rmmU0J/r55IGcWAAHBFBqY3/tLNk
	01xDQRivCdZqEeTdnlvbljOBRByPVRphpArU48szZ9UJTIHnaDKFkEMIS3giLAg==
X-Gm-Gg: AR+sD13dOnvJFwOGmkjF6/qs2dr9eyfLwPZsfSBFs6BEqWgsNZbDoV7+gKDZOUS0sct
	8tvlNQeQvNe9TeCkgnuQ2hpiJU89OFQ9jytb6527q2EuM767doa8LhFiAGdQ+BsNgb00Xx/ltVI
	bnfltgXapTQPHX7Rx8ENdmjM5Z8G0OVXM0p9OtFRs55OwR0xQM3pYF9vqLbElRsqhMmvEIavNlI
	SL/RORv9j2tcxgFxq1ZT3S+XRX0o9BLscCuQt54m825h6vG2WbvOVSQ0/RgDcRFOP6TvZQbauoY
	qbj/qci/3ljJSzkgFUc0ztxMDx3weoovBayOVxhQU0AhOl/dAtHgzJflsj2JKX2Ow203s60CTAX
	mQJP0n8ua41o3l95DqgEtSzcxdGtyXw==
X-Received: by 2002:a05:6a20:918b:b0:3b4:c9d5:cd5b with SMTP id adf61e73a8af0-3c91b0a1441mr1541747637.13.1785494092755;
        Fri, 31 Jul 2026 03:34:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:918b:b0:3b4:c9d5:cd5b with SMTP id adf61e73a8af0-3c91b0a1441mr1541700637.13.1785494092261;
        Fri, 31 Jul 2026 03:34:52 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:51 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:45 +0530
Subject: [PATCH v7 5/9] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-b4-qmi-tmd-v7-5-3befd44403d5@oss.qualcomm.com>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
In-Reply-To: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=12091;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=69/Nw/l2Pjw5IjdOIVkv2Ao4l0Ioh5cQnspi7SqHb80=;
 b=edLWO5Z7+F+QGCKLW57HYzllSUvNqZZZBQGarQPIvaJ/aZ9fYVA+Oa3onmIDgfFf7Vr5reFX1
 BafK7ROf/0aBronokgrqfMgEI4QK6+evXHA69VRts211lO5toqfVm5i
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a6c7a4d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2Vcc7Fol4T68P4ep610A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: SPOTagSuSyzCRF-ZRCguGS75S9kP05MG
X-Proofpoint-ORIG-GUID: SPOTagSuSyzCRF-ZRCguGS75S9kP05MG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX3Vomd2seliRM
 sVPxweBBqLgL23UhkTS7c/9muszgsZXt1P2x2ASw1qI6QpEaOjNRKL7pnr3ukRiXYFs1sOtnEfF
 Vbvm+I/1LUdXvb8sP82bzyhpGoxNk0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfXwI96obgPDSp3
 0gezzGwgC3pxmI2zDqDbR5qH6II15x8ajrsEpR3OZEyrROcifMWZZ9oUQ+9asUnEQPR9SyGms8x
 m0NuQ41Chv4BCRcVf6lVAVhL3MGE/kYw0L4zIrepAt6CKHPI8HhMeklh2aXuGztrBTqosSsfyIH
 OjbvnBni7rICreaw4vk4sqkGGuzGhXUQ1pKzdn5zAt+f18dVU7LyxKIK8ufrnmRpQp3dddU+l8R
 OvUyjtADnL7UPbT1rPQuijEPT8e2jGoNXXiOtMNHFRE2SqY8LSTl7FI501UAi+VoxJjiTieE3DU
 BxrZc/PXjGwrSvNpCX0m9mrZTD0yiYoI8vdOEhO+rpKI2MRtaK9SapLw8caW2ofBiCKWpCTo0Gp
 5MZYbdsRmYsv+nFiGdvd4hSWCaL+WyMQd7xLiW23Z9v010We/L+wSRtBa7dKqDTUZfLdSpr13+R
 i25Bo8X6GLgdzMv2/3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310079

Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
when it reaches high temperatures in kodiak.

Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
for modem when it reaches to 95°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Since the remoteproc_mpss node doesn't exist on non modem boards, the
cooling-maps that reference it cause DT compilation errors. To fix that
remove inherited mdmss cooling-map nodes.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 125 +++++++++++++++++++++
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |   8 ++
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |   8 ++
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |   8 ++
 .../boot/dts/qcom/qcs6490-vicharak-axon-mini.dts   |   8 ++
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  10 ++
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |   9 ++
 7 files changed, 176 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 7e73348fe0d0..53dcc5ebacd3 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -30,6 +30,7 @@
 #include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3431,6 +3432,8 @@ remoteproc_mpss: remoteproc@4080000 {
 			qcom,smem-states = <&modem_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -4803,6 +4806,8 @@ remoteproc_cdsp: remoteproc@a300000 {
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -7732,6 +7737,8 @@ map0 {
 		};
 
 		nspss0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -7741,15 +7748,31 @@ nspss0_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				nspss0_alert1: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nspss0_crit: nspss0-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nspss0_alert1>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nspss1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -7759,12 +7782,26 @@ nspss1_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				nspss1_alert1: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nspss1_crit: nspss1-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nspss1_alert1>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		video-thermal {
@@ -7804,6 +7841,8 @@ ddr_crit: ddr-crit {
 		};
 
 		mdmss0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -7813,15 +7852,37 @@ mdmss0_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss0_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss0_crit: mdmss0-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				mdmss0_pa_cooling_map: map0 {
+					trip = <&mdmss0_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				mdmss0_modem_cooling_map: map1 {
+					trip = <&mdmss0_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdmss1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -7831,15 +7892,37 @@ mdmss1_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss1_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss1_crit: mdmss1-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				mdmss1_pa_cooling_map: map0 {
+					trip = <&mdmss1_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				mdmss1_modem_cooling_map: map1 {
+					trip = <&mdmss1_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdmss2-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -7849,15 +7932,37 @@ mdmss2_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss2_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss2_crit: mdmss2-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				mdmss2_pa_cooling_map: map0 {
+					trip = <&mdmss2_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				mdmss2_modem_cooling_map: map1 {
+					trip = <&mdmss2_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdmss3-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 10>;
 
 			trips {
@@ -7867,12 +7972,32 @@ mdmss3_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss3_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss3_crit: mdmss3-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				mdmss3_pa_cooling_map: map0 {
+					trip = <&mdmss3_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				mdmss3_modem_cooling_map: map1 {
+					trip = <&mdmss3_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		camera0-thermal {
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index 82ebd88f9aba..e3ddf47ce421 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -24,6 +24,14 @@
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
+/delete-node/ &mdmss0_pa_cooling_map;
+/delete-node/ &mdmss0_modem_cooling_map;
+/delete-node/ &mdmss1_pa_cooling_map;
+/delete-node/ &mdmss1_modem_cooling_map;
+/delete-node/ &mdmss2_pa_cooling_map;
+/delete-node/ &mdmss2_modem_cooling_map;
+/delete-node/ &mdmss3_pa_cooling_map;
+/delete-node/ &mdmss3_modem_cooling_map;
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
index c8eed8ba93f5..8ce0cf23deee 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
@@ -22,6 +22,14 @@
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &mpss_mem;
+/delete-node/ &mdmss0_pa_cooling_map;
+/delete-node/ &mdmss0_modem_cooling_map;
+/delete-node/ &mdmss1_pa_cooling_map;
+/delete-node/ &mdmss1_modem_cooling_map;
+/delete-node/ &mdmss2_pa_cooling_map;
+/delete-node/ &mdmss2_modem_cooling_map;
+/delete-node/ &mdmss3_pa_cooling_map;
+/delete-node/ &mdmss3_modem_cooling_map;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
 /delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
index d8a9a7e47bdc..abee1af19c23 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
@@ -23,6 +23,14 @@
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
+/delete-node/ &mdmss0_pa_cooling_map;
+/delete-node/ &mdmss0_modem_cooling_map;
+/delete-node/ &mdmss1_pa_cooling_map;
+/delete-node/ &mdmss1_modem_cooling_map;
+/delete-node/ &mdmss2_pa_cooling_map;
+/delete-node/ &mdmss2_modem_cooling_map;
+/delete-node/ &mdmss3_pa_cooling_map;
+/delete-node/ &mdmss3_modem_cooling_map;
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts b/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts
index 4f2e0109f49b..d3f558596ca2 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts
@@ -25,6 +25,14 @@
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &mpss_mem;
+/delete-node/ &mdmss0_pa_cooling_map;
+/delete-node/ &mdmss0_modem_cooling_map;
+/delete-node/ &mdmss1_pa_cooling_map;
+/delete-node/ &mdmss1_modem_cooling_map;
+/delete-node/ &mdmss2_pa_cooling_map;
+/delete-node/ &mdmss2_modem_cooling_map;
+/delete-node/ &mdmss3_pa_cooling_map;
+/delete-node/ &mdmss3_modem_cooling_map;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
 /delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index ac89724ee099..891941906a46 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -28,8 +28,18 @@ &ipa {
 	status = "okay";
 };
 
+/delete-node/ &mdmss0_pa_cooling_map;
+/delete-node/ &mdmss0_modem_cooling_map;
+/delete-node/ &mdmss1_pa_cooling_map;
+/delete-node/ &mdmss1_modem_cooling_map;
+/delete-node/ &mdmss2_pa_cooling_map;
+/delete-node/ &mdmss2_modem_cooling_map;
+/delete-node/ &mdmss3_pa_cooling_map;
+/delete-node/ &mdmss3_modem_cooling_map;
+
 &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
+	/delete-property/ #cooling-cells;
 	reg = <0 0x04080000 0 0x10000>, <0 0x04180000 0 0x48>;
 	reg-names = "qdsp6", "rmb";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
index 3ebc915f0dc2..296c72672ec5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
@@ -7,6 +7,15 @@
 
 /* WIFI SKUs save 256M by not having modem/mba/rmtfs memory regions defined. */
 
+/delete-node/ &mdmss0_pa_cooling_map;
+/delete-node/ &mdmss0_modem_cooling_map;
+/delete-node/ &mdmss1_pa_cooling_map;
+/delete-node/ &mdmss1_modem_cooling_map;
+/delete-node/ &mdmss2_pa_cooling_map;
+/delete-node/ &mdmss2_modem_cooling_map;
+/delete-node/ &mdmss3_pa_cooling_map;
+/delete-node/ &mdmss3_modem_cooling_map;
+
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &rmtfs_mem;

-- 
2.34.1

