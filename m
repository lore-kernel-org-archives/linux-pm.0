Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD53F12C8
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494130; cv=none; b=sEgZxAOwN58iJ2jLH6ne+dMPpo7TjlDZNWYDdyW3ICyZ9Jmf35uTe9AwD56JwOnlsd2jd3NqR74sMKCe0DK6/PihKuT1B6TOqhei5hc/QVM47yRmfMotJWWLW+YBdnn9sglwvV39sSDC61/Gw1jSe+UhSvVYxRSibO2wbbSyrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494130; c=relaxed/simple;
	bh=8jCvvQvR/TUK8TVzkPQrR6iOrXuHBCo0rM5hCiElzIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsA40PsGhqV+7g1bm0Cj3hXfXV4/afxmkjckUt5Bbnjck1vvHFHEmC093GbsGiTz9rKjdXdlEac8mZN/Fa/+QZx+sZxd6vyImchkbY/8Uboq0TtgPeeXjGLXsdR4x8AwhvEcSjGFd7isoyHOxCnKdB9fmDo9hYgfPJxPRh+RWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCf5tq4Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJtrGoRQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCf5tq4Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJtrGoRQ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC6cB3972795
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=; b=UCf5tq4YVIpM/623
	6V0sPxSZuiceUJhyQTbrMmSWE0V6VC03wx1cCSMjw1l2YYy+9z2H4nfGXTMSuDnB
	O2H2RGVZ3VT7StgSyMbSJqaUxmGxTxAFAZLy2dx05JbqAiO1bS9/JuPA9UrwjnFR
	v50CH6/wQKHcIz/ccPqw2cPrO3khhTzopI5LDabMDpH9c24LxSYMx8l2an477odj
	tdF97BqzgDdo9OFQP6UfJw63qxXYysoEz4JAF6FT3e2C6pkDpfCtqYb4IXIeuwW6
	lfJB8fvzLuQIfnN3VErK1hIIp9jNoYh9khFKmZkrB2ZOAcKFV43wOERcIhZcc3sS
	idPNuQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsecr4ye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc88e22f92so16834075ad.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494107; x=1786098907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=;
        b=RJtrGoRQJLGoEmgPvck02QZk6QPdeVzNYWFUEyN/XpZx2axULtVOlo+m2/8/lcdUg7
         LAO7cYWaMN6q+NDV2+sfm/Sl6gif7WOhQi7NYlHdKIaCzNclEYSt9rdDERq4VHHCDfJZ
         LgIpk3mi6d/AYFzARC8alCBPjovRbFofYeWi0w8xaNa8CtS1V1Ob5ARZHyoApBWFgcpQ
         97wdzxibhJ/j61VJTYVbjktFXNNRB1FAMmpAX2/g6HcXzws8Jm8KBILWiC+h66FReVE0
         SKAXW6z3rOW7RYulME+ERkz7HZv2vqmKsu8uu4iJs9gm1pjkQ1VS9YOqrkZarZqojq9l
         Pnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494107; x=1786098907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=;
        b=fcsxo+qT1oSGKCi4FcUyPUx4uGpLsc5CVdYi9BoTL6qFoiPpU9PPWZ5VoM3l3t1/I4
         Zl0VB/chn8KM56OR8wHBA3aiFYKtSAls/AC5ab0/UXFvkGqT1IXAo6YZlFnpzZSIK7il
         scg8mScfSfJ088IlqZz/Q6AiwisMGZh+fgDs5I0ZB373LzMb8S7VweD0Gib2QP/ogvgJ
         bqiQ+mImCFg5bmlq+YR1Vx/+W8gNagaYjolnr1+QDMqc3ojaPoqc9DiTmABfDNawTYYY
         a8pFvAUOpJXN/CTEu/IR/E6EXP0f+UnXPYO1tw3x4XHvI3AdCsZZzxuWuJh/H68eVraE
         12IQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCFZhmzjjCxtgstXFlZjs+sOQZKUMbCDbgLfQNQhHWT8IQ6I8yqwqlroz3X5xr41W1lT/Qw/bK1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGf7XRPOV2RN1PILpMOKiZSfwFSHcipo/V86H+18dLF/U+JeV/
	w8UhAeQfqSU5Tx9zqEHlgvp4QoQBlu074YV/DKLptjPnFvHvcL3UNhO8DTdUfUOouypXBbB9V3r
	tAPSMc+kY6P36T2S73Zu4JaDXfT92bzZL5Xh15l68Dd2GpMap5UYkTXb00zqMjQ==
X-Gm-Gg: AR+sD112Tp/B2reQd749ieMH4XDbfl87efSUEgXYQSM88YJrPTUvF82hiP2dPU5aRuI
	SqAD2EwuIxpwQHKOMaLons158ckIK9D3o1rgzMpC0CIQjcnzw+u7kzb/ovTjasJXZPg8tMhC/W8
	DKwk8lcFNpQRlyLtUV9IqlLGF0QLlH50lseAcyMPo6HDpo8EFH8/QKwtdoXINOkxaXVRfVaa4wy
	knXf1mU5Erjw/r37CcExrpealfNSqvjH5KwAUAjURBna36LjFGIgNxoXAwDW2LcVH50pbOTf7wH
	h3dJgxR9Gn2CP7UODwVqkM2HXKMBD3NKRM5nKValOV/WJZrp+9xjeyWA0TUT5xDGsDxMzX6vyRP
	cQ/RjzGJk5IsEj5mL5bqsLjsDEQqEqQ==
X-Received: by 2002:a17:903:4683:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2d046d70b30mr15627975ad.3.1785494107457;
        Fri, 31 Jul 2026 03:35:07 -0700 (PDT)
X-Received: by 2002:a17:903:4683:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2d046d70b30mr15627615ad.3.1785494107074;
        Fri, 31 Jul 2026 03:35:07 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:35:06 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:47 +0530
Subject: [PATCH v7 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-b4-qmi-tmd-v7-7-3befd44403d5@oss.qualcomm.com>
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
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=1994;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=8jCvvQvR/TUK8TVzkPQrR6iOrXuHBCo0rM5hCiElzIA=;
 b=95ug3fuOSgVxrn5ZroqFPVPz8oce5m8u2Db2rhrpdC/rTCUQuE+HE6RrAO/i6tSsH9u36kgiE
 UCzR3CMjg3+BJ6ptUwwbgY02X9A9rc4A4eRU3uk0DIlOd0DDFi1cdTL
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX8cJYZSWdIqz0
 SGO+89vP9GFO2gA6APuWrA8KEK7zlLLc7u1fvQkS09gXxjrQeW9kT89KeMarz7GFKo8nMxiBTh2
 IOmdxBDx/Eol4vfYpbkPnzwybNG3+acdlPMYUT3jJDxDk4fPKRPckl63yshdDMhoTy3W8pHjcWa
 wsRg08UYQufvDPQoQGWT4T9PgRApSCUWBIxpu8GqjZxI2AOs5Xgy9KlM3qHUspyBsTX40VERe6q
 Ba0d43UpDgu0Zu0lR/YOa9T7T7nFR/jsddpIfP0o0Y8fWOXY1n57km6S6udR5FFDiL48mE51BMf
 7e+I7GEG9DfrYvnermRVtujFFOJNMZD7XvWLxx055Ao2QeAeNJtqFr/PYLGykvTx1Ijh7WtsTua
 q2xZMw9Wp7M4uOLnJ4VXWuIQTt2KTLpr7JyxkAKbbE83/ysI8tJQbUs3tqUwidmp4fuzHnJlJFQ
 BRV9P7CQCFucY0H5YDQ==
X-Proofpoint-ORIG-GUID: ZQrNDzKrvys6Ap50su80XfOXH0BFuhkC
X-Proofpoint-GUID: ZQrNDzKrvys6Ap50su80XfOXH0BFuhkC
X-Authority-Analysis: v=2.4 cv=CpOPtH4D c=1 sm=1 tr=0 ts=6a6c7a5c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ptpooaJMTZRctn2qr1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX+Z8aUIz/lvQA
 U1SWT7VsxCJwuuQ4RaI4xlSjN3x1xOkKWy7nocbfVJWrXO31378XSLc7/bDHD+HCoYr46RfpTd6
 g/fc0u78yLz8BRomcjvqyHeZ4LrAOu8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310079

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in talos.

Set up CDSP cooling by throttling the cdsp, when it reaches 105°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index bdfb70ca9740..0fb7cb8e9f64 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -21,6 +21,7 @@
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3840,6 +3841,8 @@ remoteproc_cdsp: remoteproc@8300000 {
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -5497,15 +5500,31 @@ map0 {
 		};
 
 		q6-hvx-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
+				q6_hvx_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				q6-hvx-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&q6_hvx_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdm-core-thermal {

-- 
2.34.1

