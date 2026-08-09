Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793538737B
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278669; cv=none; b=EOOi4MV6bY7/vXWPyzjtnV9Ps//phPGGyRhRiUrSHqPUjECst/qYSGJHgjbSMtn+Ts9lUPgHkaEslCT48x3OLDo0WX2fwFKRsyQjOr2eETmF2zelu+hnMgVGud9ORU6WbwD1uB5VNSXmu4KrBn8PeVYYlMo7xUQmQNQTST8zp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278669; c=relaxed/simple;
	bh=8jCvvQvR/TUK8TVzkPQrR6iOrXuHBCo0rM5hCiElzIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxckM+IX6oqAvtKtFVrGGT0boIzYkFf2uF/SM2S4I6SQC4tRRJY0jsmlsJt6IRpSNCVwJojvDzEBF+WtA8LJKyc62Lke2sJPkllI+9NkWRIZ8UCcwhIrSEwlKgYzEfFSUYNhWzh4oQ0go+xFtPlFo97oEgRq7019eCavlLgwXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKjeGSC9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MUKPAk8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKjeGSC9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MUKPAk8o"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C2KJa2999845
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 12:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=; b=KKjeGSC9o/KyuPay
	Qgho/MdJ3cKTjaPuA1ylcfETISzQ/YkfhuTZh7tfNEEFPo1fAbX1vvcTm5GxF7J9
	C2NWEZly4V1J+aM8IW3rUZbkNQq1di7MvgB2ld8j/ppTnlOGdFmJ7gp3u7ZlNl3y
	cZht1aG7jfoilXwpUn0kZNflZDXwpU6PxOTNbSYYl9vK4exScHM5pE6sSgryu3UA
	C7i+ZPOiAnQ5Ok/es/pLDDzLg5+eXKnTOHte4fjhp2mMsyWOzBNcEu3cTvV9gUM2
	BIcXdjih1iv0RzsZsrsbdA/rvAApRR1g/WTD4OuzXRM4qnVWHTfRg5LoAVDNlCgw
	qr67bA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7ax8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 12:31:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7621655eso2080918a91.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786278666; x=1786883466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=;
        b=MUKPAk8oM73NhyKsBprCF34eYXP3Ux7bv/1tDNNtwf0wBY/dKIwdeupUGXJllBxQfX
         reFwE8O41gv4i54gnXUKMTV8u5g2O3BgtcegfjCGxz9fKHy/K/n2JdEAz03AlHnqNdtC
         1hWdNrloc4RZDEX+VNBN4Gsqht3PWk0Eiu3/F+VwhS/CoSBd4blCm9dvrxtdDxXorktQ
         0mV7LJKWbapaYy/HiSuP3KwQ2wzpHG9BTTgQlGFN+d5D4ATL0yW0uqxXMgth721GYhLu
         0HDJuXWuWGPDe1mdKEMW/5dcfYl9M/fMjMD+/0mNHX45xZ/9W7/FBscSqGZvTci7Gqpq
         yfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278666; x=1786883466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTHLwHQvEfPrSw7dqgVln+HLO66Otor7GBfQ5C0UNnk=;
        b=eqxa6xMubN9j66TSlsNsBps4i0ieeaQx36EwBnCqqDcvn44raf6zs+GXT2IW8fISMP
         iT51Z0lfovOAMEk15ZI/97jZrlQpDSis4tQHdDbmCDJt0XYHoOw4bWwe82bP01zWiuff
         76HrTWPPdR9sLC+Tsnt+XRM/gyh3US0FnMgRp9mTwJUM2rhnacLZXvfm2AixvdHAJSM9
         bAoDDeEWIH/L4WkCtaQBkhw09C7QhGAyZam4350R0xo26cx6+Twrk6gz4yI6CFu45D86
         JEwSfcKNtXY07GwxvCzUJuBySEoMdyLqWNsgs0HFwHg6P8FZzCcq0o9OLiW1Q3Gpqg1r
         u5+A==
X-Forwarded-Encrypted: i=1; AHgh+RpgJXvOdvT2Fx1dQNDmGBJ/HKDrZZz+kZ9u9SJJKMrw3xqrdtA51PlFVDPczxmQ2aGTPDq0XwwUTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrq+Ou5OB7aG06S5Og/N58dytiMLOIzYLzaNvCHve+XEaFE1f9
	CouR7yUN3GiXnJBJ62gyY2uSmBjXpjMPi4a/Ff6fNUWDUuTjYn7w9M34QUcmoQwZldWmvSn4INM
	LQ4g5HzMivaGVNIYvg9gGVylyLAbjvymYqelneFehfxkso3YioPm0EiOwvzJelQ==
X-Gm-Gg: AR+sD10buTLOGP+iF40UjJwqlRiiItxoetOURFNgfl7I936wGGu0OQ4KCxiMq0/0DLF
	I6AxG0Uxebcky4QyHWhgehEepC26Zt+seqjKXQIQN66ITphRryapzoRpkIpVR4vRijmIxfwjFAQ
	km7+x8+3Du4S+pz/N92laD8NYTyPA1PncC9fdWKVi7pdYKzlbIFRf+cOmRsbdCJMHhScSbFPpwa
	0W6XJ8qLYhmVYH1VV6u+QB0pgQYgIH/LpwrocAJ4Ia9vy1APNRdzDaWP81eZjjZPw9MEOeMXlZ6
	Fsu4jUsImNIXu7ih0Uqg0t6zOnM8yRR+WQfiQEDhLSAyJBKy87jRGBxh+ESscUawET85ZL20txi
	bbkykowucw7SN0jYpqO9pGc+ledU34Q==
X-Received: by 2002:a17:90b:270e:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3903bb0cf61mr38221152a91.0.1786278665667;
        Sun, 09 Aug 2026 05:31:05 -0700 (PDT)
X-Received: by 2002:a17:90b:270e:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3903bb0cf61mr38221073a91.0.1786278665146;
        Sun, 09 Aug 2026 05:31:05 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm51842997eec.18.2026.08.09.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:31:03 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 17:59:03 +0530
Subject: [PATCH v8 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260809-b4-qmi-tmd-v8-7-b15d47adc379@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786278595; l=1994;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=8jCvvQvR/TUK8TVzkPQrR6iOrXuHBCo0rM5hCiElzIA=;
 b=Dzo8noRQqafT0JE0UJvGyqUhJ88QaRVYCMXY5JymlRwW5SCK8s6Nm707ESfmHwktpF+H7ffLa
 QakIG+rMiq7C/HacL7NIIvzlG4+jejuQ4ZFXIxwn8P0EzyBOLwU4vkS
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX5dm3E/QcZWg9
 7Co07HbAGMo0YFUkvmfoJbmeL/P3sq3xWf1QZPA8PEPSrdZv2pp1K6Ywi+LCWitUltnmgsOKk08
 Qw6+Ov6gODZbXk71oBQmZE8LMbEj2mg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX5lER2yqsrAUy
 A6RdF9OZ7ELP1+Qpfgg4p9EIy0mVDYA0So9TYHChZp3NO7SkP5GalI9YPo1eXYcxpPHPmzSMZ39
 YJqgv0imttLY30LN64cpdC6n7+JDs1fx4cw2b9yXSdY1KIqI3GUwEjRWmI+y/5tiD+Il2EwcPXL
 ue2MyFWE6Tt4cKAyF35SSyQw402iolcOfQID2ApGjaR7RQMkWXcnWZ0pQzmBudIWKxJFpDxT2bS
 sGnI5Cy8zNsNIUYEUZlnCMy+gdpY0HEa07bpkchEQXEKQFX9F39zAmx3LYqjfmDGt425oOdYyWi
 ez42R2VikSwYfqH6Oe4Cu4hF6GkpkHMjPnJLbduO0OTsP0yNRnzcGilZPccZSOPO1bva/wmi69L
 vwFnbZwwN+jhPcGJ1aeOc5kPKcxNAVcVWbIcdMfSzC8wFR1qVnQH98gsw3YijolsPKWZSHx9KW4
 xOl6qJIyW3YhP6MXMMQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a78730a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ptpooaJMTZRctn2qr1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ej9-BoNUPX0OcHu2dNXl-HEjwGcg9ZYe
X-Proofpoint-GUID: ej9-BoNUPX0OcHu2dNXl-HEjwGcg9ZYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090110

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

