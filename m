Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D83876CC
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278686; cv=none; b=ERZ370L3QT1VJRWC9FCmfyRKWw5XC3sKo1h2PBf4Jg00ugCjhRwvIZG624mAffZjdMRNMj8/HsoNQVa034oEUwZBz+ZgrZqh6l6Lm96sLatFMNC5XFKmbQgzVf5AwsGCeikAP6QZCY4cK82mUiVeTeHMF5Dx5up/vTtbb4UMWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278686; c=relaxed/simple;
	bh=AzJCFYrrHNlxF+EH6JmtU4P4T/A7/7TBDP0aqga0oT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ihbh1/U7KbQn7Irikn7lHRKLkMasfMlo8/omXYLQDqZD7OlhPI/OnLx+VVL+kpDyVURWBsmMwxz09apP9otc2hsi5DfYviPjziErI1Q/BArSuZXxo8DVPCZL2rwCTGauDi66cxD4FqnH+NfgSblL4dEQIz8idNfunjaYQC+6Ypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OD7kXggD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KpbTdmMG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OD7kXggD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KpbTdmMG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C1VwN3228351
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 12:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LWX3F0GSTjVk/yY/cfgAK+BwJoP1KATjvYxQjnG9yzA=; b=OD7kXggDldNxoRNe
	iN8BT5CCDqb8d73qB1V7nYsqipt8t2osPgs9wso84XsOzczmG5bp5LKlcYO+Cmkb
	xqQwqK7C5/Jd6mxh6i/i9u77C+t5/jqNNF/AO6houAzuCdhLoG/OBVFcRj+Fbiz3
	GPHL/kpZXa2WxhE3FQuROTRJmEaJ01A4C6bozR45GRv2JGGN3Ohi8E1uDylw16hQ
	Qgt1JQDYZaDOUvmGToupSQ6y5aK3t4EOmSaMdR/f2To4qig2u8i6fFjEHXx7eXGO
	u0l6QuyxBKNNlxOb3M1yINyrwgD1t0Nq+QKK3+JP6k1phooXbHP5AKQHGbdXsUFC
	bJ70Ng==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwudqjx96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 12:31:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38827cee19eso1529682a91.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786278683; x=1786883483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWX3F0GSTjVk/yY/cfgAK+BwJoP1KATjvYxQjnG9yzA=;
        b=KpbTdmMGiVgjW+jZszx01dXNf2wAYxE46Yk8YwxMut+u3nJxIZ5H58ptTQEHSxacVh
         Rf4DRNeK1CapCIUYvwNEVtaWTx4sznlooxYpUeuId4VMGA87NM8PKC0geypackKTwUEW
         8Ww36BqsV++H0rGrrqjfWSOdHPSpV236G/jdQIbzVc3Zi17XowP/8xAh7ug3e+roqfd1
         HQwuSt6ReAOx3oCr9IjWBaM2dRAmwoS9R070f6CeNCRKmmIyYtDkVsFYP140eAv9h0Wt
         TC1vsSq9l49UP4RU1SqnSDlNB9MsNG2EUUf/pxV/b8bXfUmMeDKWfewUQgA099SWC8hU
         BFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278683; x=1786883483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWX3F0GSTjVk/yY/cfgAK+BwJoP1KATjvYxQjnG9yzA=;
        b=AeBGx9fT1of1CNOZNkZrz7onkPkn64Ulwa0E2iGrjQ6tf7D9Xq4cgHw2Oblu+/pKao
         0RThp1kLe1w2DROnnDJFC3cM5hkmg94wgbc9DJpm537bOdzRfv54Uom5XsDovLzAc18P
         DZ4e5sOJGd7P+s4yrwMOtgHf3EBZxeuC5JZtqmzvRvmLEZBN47fWb0L4EI4jp7U5xpf9
         VvRsC8aa8gEY0P5ZphvWDD3EQHYmXcAfbm0oYklbWYkJdDQm15I0edSCGOYRFlI5/pgV
         vDD2/XUNL4LmpvLBlxmQ5Qh6rZikm/LgixoOrnw765jDa+7/lOG/FSRj+9+x1Yc0Fpwm
         H9Sw==
X-Forwarded-Encrypted: i=1; AHgh+RpPIArlzY82c6y+UVUaxahNI23TTbv44xNpz7kACb+TYU4DS+DlZlHvZzg2e1qGzem4cssCH7opRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6DxQE1YYZnB4RKRdd5Gm77TaWLxipymXREyd1y4Zn4UqA5st
	0aSObbJ1669gJS3Qf0a2bPBCtTj35HCmiZt6M1YBtrAunvlqc9DQAJ8xTGgM8Zy3ebnY9WqX4XN
	FVrv53QbS3A3hwaVrbCe7RBcvVhv8MkabulxCGWTQ18edqt13cIoxweRaLoqLQg==
X-Gm-Gg: AR+sD11mwulG5ok2b/f6rLVWQwFavWC59IvbJR4AqCoTsLZAQkPjZ+hbcgnSXuX3ml0
	iCpyXbE8rSS4MAe7t2wBwZh8OgugXrErX/wZWeeQQknmHcKYHRqtpBVixnJAhr4N/8Eeu1EJn6I
	rahvx/hhzaVuSAupLB0xGvcWHXQkv8e42f1Sq6NsP0f5Kobzb0KUnlsgXNCxtpnZmtg6GVweygc
	Sl/Ihy7QS+uSP9dTFRmgDQtW0lP3iE9U61poAX+wcBntcLDfIbdPLTwJUitWGPiadcqN4ZiCGEi
	NkbzvQKZjafKv5nPt2kmmId4qSx52E4Ju9j+X7nuNfCH8igWYeHkMJ+ehSSwotp1FD8uwOyb0PK
	Yf67GmsvajPS1ahKc6f9WksgrhZUxSg==
X-Received: by 2002:a17:90b:1e53:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-3903c54cf2bmr33627432a91.4.1786278683125;
        Sun, 09 Aug 2026 05:31:23 -0700 (PDT)
X-Received: by 2002:a17:90b:1e53:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-3903c54cf2bmr33627337a91.4.1786278682604;
        Sun, 09 Aug 2026 05:31:22 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm51842997eec.18.2026.08.09.05.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:31:21 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 17:59:05 +0530
Subject: [PATCH v8 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260809-b4-qmi-tmd-v8-9-b15d47adc379@oss.qualcomm.com>
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
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786278595; l=4803;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=rRz7gXL0+aFVZQwwc2LHNTbqyQasNRn1gIqhoME82bE=;
 b=dnr0CFEvt7TUyY3qz7hT5onfOLg4TvRGcRSO7GTc1NNT6ts6idR94a+TbptlA5o2XyhJ1OXxM
 fC8vUyVmkccA3esDyJYQdrK6Et50R5bld1kePlyaidfoGdDhvE7y7uA
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfXx/erY2FJzDah
 2YlQGLu2YKrkP3POgAixbpoo7cxqHtzEfrfhmHpPcbXjasNc3sT/lzi54htTTfoEKATyBgpzm97
 Rr6kqxsOWa8WF8z3TG3EiyZ9lo8LtPE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX3W1r405z6DGv
 y4ORY5b0nJnCrT9gUYKIQ4UAKHsUp67ul8F1oS/CqX/bFfPvx5UgnNcFhg8aRGFq6O3ro7oEQeU
 S4DN5uIThBGGz+vEYcsOqVdil2lkZeL19Edwwn/uw8dbvVs8kqtjXnozlydQ2SrzcvNHQuVjfoT
 389VXdUEx1cLHXRQXtridiZKNebDZsvdJYiABj5HhU6C7Bx7Ln4Pk2USfgakr9N6hNMUIHgRc3t
 KXS3Cm0f/o2IKy6RtpgoznOzal/1d837shBToSP5ymbBl9YSp/yrVcQOrMIr70gsf1fwvVOozsp
 d08C8O9T3NtJ24n9USkltxzMXkBDVFErwYwmYvBqH3FvWKgo7WZHUniJvKWuFITr3G7mBmaujeF
 1tGbjQo5zBmz7ESF2Qcg97Z8jplM1Dt8nKJhfK12nqYmjfGbEiExj932xouqkqpFskRP9ciHvr0
 JHlz/MXpGgUhOv0lHTA==
X-Authority-Analysis: v=2.4 cv=BNCDalQG c=1 sm=1 tr=0 ts=6a78731c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ND7YSEQ52W-Uskv0B9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PgUDblMa4q0pCDpQCFXTo-t_hOm-WwiG
X-Proofpoint-GUID: PgUDblMa4q0pCDpQCFXTo-t_hOm-WwiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090110

From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in hamoa.

Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Update the NSP passive trip thresholds to 105°C to align with the
higher temperature specification for Hamoa IOT.

Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 16 ++++++++
 arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 ++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 9fa86bb6438e..5d9e1a1b0668 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -1685,3 +1685,19 @@ trip-point0 {
 		};
 	};
 };
+
+&nsp0_alert0 {
+	temperature = <105000>;
+};
+
+&nsp1_alert0 {
+	temperature = <105000>;
+};
+
+&nsp2_alert0 {
+	temperature = <105000>;
+};
+
+&nsp3_alert0 {
+	temperature = <105000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 09527dcf9576..ba453c8ca80d 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -23,6 +23,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -8971,6 +8972,8 @@ remoteproc_cdsp: remoteproc@32300000 {
 
 			status = "disabled";
 
+			#cooling-cells = <3>;
+
 			glink-edge {
 				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
 							     IPCC_MPROC_SIGNAL_GLINK_QMP
@@ -9558,6 +9561,7 @@ aoss0-critical {
 		};
 
 		thermal_nsp0: nsp0-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 1>;
 
 			trips {
@@ -9567,15 +9571,30 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp0_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp0-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_nsp1: nsp1-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 2>;
 
 			trips {
@@ -9585,15 +9604,30 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp1_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp1-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_nsp2: nsp2-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 3>;
 
 			trips {
@@ -9603,15 +9637,30 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp2_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp2-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp2_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_nsp3: nsp3-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 4>;
 
 			trips {
@@ -9621,12 +9670,26 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp3_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp3-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp3_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_gpuss_0: gpuss-0-thermal {

-- 
2.34.1

