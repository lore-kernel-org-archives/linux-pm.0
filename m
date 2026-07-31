Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DF4582E8
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521310; cv=none; b=npb2fq86vJaWL1laQsDqR/uQl7M+6fMxc+EzpV1rNZovQKJvzfiNFhuS8mKMio644ye37l4LWPfIEeJO14B06JlQX5hlxE0B7IsIUNo/aDo+E9nu9KY4NrGmAJb5asqi7QEDWarGdX1TajsqAKcfj0g77lH824TvbPHeqY0VVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521310; c=relaxed/simple;
	bh=mO+gDYYOZlpsCThsUuBoelFkdhsSXI+BY4fE278O65U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVszyMInuCxrEtgHrD0bR/vrGEDLLgRXBF4UD/9XN/lEMLtPbiodhnxQCh6c8z1F94mawmj+LAAswYUh53C2J2JNJuboojQXcHKmYY0Mth6lHg90Tn7xNkoyWd7XQAyPD9F+rsT3SjZffT/HjmWGdzVblyH2ZJg1zvgtYN8SSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ERK/nvUp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KoZ/VKR/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERK/nvUp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KoZ/VKR/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFNrtD700496
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rA6ZQIWHiF7qqcfR+J75sTkMZyZ9Cf4arjw2D7g9ICc=; b=ERK/nvUp7ENbBrW+
	tC9ilCdIJXd8reBjxq9xGETLAKO64LNZbSIqcEEVEMCuxRvjZye39bd1g0KOlGjh
	cBy90mUPRZJSNqdI7yPc8wN/gHUfmD75/HmLRqLUsZvUmIqQSTG7Tzxw/BncaFw2
	82Woyt8prQgvzbaiUBgcm8aqHLKaTQHhalIJrl9OUA5ZYBQ7CcGYz+CIEATPw74n
	PQyEuZtKkbko5j8FUPsA2vyLEdE6tgStANbcqFcdzoU2rEYB2hEK2e00qVHO/7r0
	LTJI2eY9D1rio1xLIU+nJJ0iO8zo8doqyTJ1WofKYd7Dxz7q1vvruinYiarKE4lX
	DBhNiw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u1ru1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:08:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so886184a12.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785521307; x=1786126107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rA6ZQIWHiF7qqcfR+J75sTkMZyZ9Cf4arjw2D7g9ICc=;
        b=KoZ/VKR/I+yLsGsNuPnqL5yqaXhTUYSujaYXg3VafHNo/PT2J5d7hEW41yhZvjY/r6
         wBRFechfsD2EXE+ujCOovoslHFNz2eyCKpSr9SUDZs0YcbOrTARknBnj/pRVs+V1kbiH
         rRzBS1nj8Ck2Hdujw/nXudxB4f3zd9K9XLUS0qBlzz8h4m+G+uwqvPEIEfw/I5cplGEA
         qUlV9ZfOSCvYOKyvGdAyZrA3qW6iH5tM2KAQzYitGwqS1mWnu9gZohdfaT+wyb7O2y8E
         VoQQa5rqjz+E9iRN1aRAkC1JFng3wba5b1LwFFnFu5J9nZ1eU+/GKUNyg7J09tAi9MLT
         lwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521307; x=1786126107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rA6ZQIWHiF7qqcfR+J75sTkMZyZ9Cf4arjw2D7g9ICc=;
        b=YpvQwIRjWy06MWm4MZFmHOlGy1nNMFyWP80oW+M3aFeD/B98g1g5R4MVQXslaW03kT
         9hxOle3c8OJmbxnxYs0+H0EvAjKkiY4pDggfhLLwIOY+CO+5qDrkoPGhAB5qOmPboN6C
         GaNp5zdrM3bE57w3hzfoio49+e9inIUChMnex8/6oSyMrSVrarW9aAKx5nwFXo0ZuWTQ
         Fz2EIQN3+KCrLyHom6fwxBLOPYkAv1GBrk8YSTaW+OdYAR62K5dyXg3o9rCpoyJt/CWi
         2dixtF8UWztfn7ug6EkG6Q2ZcZMwrvUbptWCIxBqlnpo0eSBjOTLY9wZUVszKcWTK8j4
         NyLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqqpbbvv3zaiKA/ldaVm819Haj6fAGFaZaIReqBPE1zpsmgZhw72SvcjNTO+oIqEgsLdQqeb+ChbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygUDgJoOuCVwnrqIfyQcnSxMz0GuFhblwNxgmXRKULc/jCe6Qn
	7IcPiIFq5+z6XTGJjN/37xufFud/IW1y4HOXW6mFrfZI9jbZJ5VuAlBBTib6dfsdk3eDsKCVImh
	xDKdvqa10tU0B4v6LCnjY3GCOcZZiAz325MAJAn2zf5kz+fZWXhVG4a3yUa35jQ==
X-Gm-Gg: AR+sD11iSKbNxhDRyH71G/fvXrb6JTEUWFzQXWsbQ3tHq6ru2D/1gVesfItxTD6BiJs
	CPwAbGKvczhZJpZWScukdvYyZxnWU/wFZNAfTKQfau7V7bSxlynFWEPIDMs1YZUuyn+bjIv/5uJ
	nhdTJryNIRKQyQyOlULUntDtxDA56rdH73EzSTMpwb1BxDWmSKEZqSzokvSoNuzBAoFTk16DEJb
	TfB6kY4uIxErCsc1bxoQL6vZc3LvUQhWeSjCqiyBdFP+SvWOkIfeZSgLOliYhQTgt8v+ilqBYtY
	IYTN9J0N9MW9H17O6HMJgQhPp6437b0OJIZWAz2+H9vDbWX1FC4YF4qOYuWkfE3x4zGQfK4bj0Y
	bZPFGsFGlmGbwZ3nlKFM=
X-Received: by 2002:a05:6a20:4309:b0:3bf:b68f:4685 with SMTP id adf61e73a8af0-3c92a5e1636mr780916637.23.1785521307193;
        Fri, 31 Jul 2026 11:08:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:4309:b0:3bf:b68f:4685 with SMTP id adf61e73a8af0-3c92a5e1636mr780875637.23.1785521306714;
        Fri, 31 Jul 2026 11:08:26 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fe9fsm7069923eec.25.2026.07.31.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:08:26 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:36:20 +0530
Subject: [PATCH 7/7] arm64: dts: qcom: kaanapali: Add ADC support for
 Kaanapali boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pmic5_gen4_adc-v1-7-9c49b2eea6f9@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785521244; l=15724;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=mO+gDYYOZlpsCThsUuBoelFkdhsSXI+BY4fE278O65U=;
 b=EFTeLqmSx1yGoO6t8ls2EKL+GhTNvI7RXj0a2ZMC8/Z7MTaKFhCR8HSfiQTkUt9/CGOXxdFpR
 sZixAzZT0jfDmMrjiuKE1nCLBR3gDmxNyzh5TBSLixbR8RWCfH6IWMf
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6ce49c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=suU82zYbK_tq1bt87swA:9 a=F6syS2wt7qVtwVF1:21
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfXxXukUI5TGjEI
 Sgvro8CQxqwyVJBco4VIB53G73THBdgkL8U1HWPkqHZxQYOfFYFIQEIrFN6HBoERRcV20c37fNK
 WPCRkF3UnEUHepm/KniKSCCXFAVS2N6vm8x/AKdrH9y5oNVO9nA0pctaleKuCf/zoNeMP+KrPuH
 qBW1/c3f1WIcJ0A5XRt9vAZARW/F0Q9ozn6axp/QQLlHaPnL1FEVKFHN5cV7kZR17oddcFkwM9r
 bl2a9e/ecy3v2FhLG7CpjPY04Rhtb4MbFilTsommY4v1x3iOaeEcibDtJRleUKaJAc6JFHrOBiz
 I1Y1vVh6wKW465bl6w2iIy49D3X/pjbTiqaoc1XIRAD+T1COy+JZlvNDlYd0PK0ClGQmokXIitr
 bsLxU2jfAmskiNBtN6yI+PWD9eHa8YxwBP9jrfNT2Vwkc8F70ZhyX80n6g0rhl0UsoO9ogLJX+v
 n/B/YgFfhsJqKbrafIA==
X-Proofpoint-GUID: fW9wWbLV7lMDAI8cRiLqlJ8VVKOdSNk8
X-Proofpoint-ORIG-GUID: fW9wWbLV7lMDAI8cRiLqlJ8VVKOdSNk8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfXyCb9DfGL9xna
 VYBhpo2KHH3yhlSs6mKVOxMelrpBko/UfjgOrEEy0pJ6ik2bqFEoXiS61I16KhI20wuNpcPjS1Q
 R3Tbfk3vhBrxB3ZvsmoHoNEMKvWH02E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310139

Add the ADC channels under the PMK8850 ADC node for the
other PMICS on the board with ADC peripherals. This includes
die temperature and VPH power channels per PMIC and channels
for available system thermistors.

Add thermal zones corresponding to the thermistor channels
to enable temperature monitoring.

Also add io-channels and io-channel-names properties to the
temp_alarm nodes so that they can get temperature reading
from the newly added ADC die_temp channels.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 312 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 312 +++++++++++++++++++++++++++++
 2 files changed, 624 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index f9b5b5718b90..41636641f1ce 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -8,8 +8,10 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "kaanapali.dtsi"
+#include "qcom-adc5-gen4.h"
 
 #include "pm8010-kaanapali.dtsi"     /* SPMI1: SID-12/13   */
 #include "pmd8028-kaanapali.dtsi"    /* SPMI1: SID-4       */
@@ -163,6 +165,152 @@ platform {
 		};
 	};
 
+	thermal-zones {
+		sys-0-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX1_THM_100K_PU(0, 0)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-1-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX1_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-2-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX2_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-3-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX3_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-4-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX4_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-5-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX6_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-6-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX4_THM_100K_PU(1, 7)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-7-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX4_GPIO_100K_PU(1, 7)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+	};
+
 	wcd939x: audio-codec {
 		compatible = "qcom,wcd9395-codec", "qcom,wcd9390-codec";
 
@@ -981,6 +1129,14 @@ led-1 {
 	};
 };
 
+&pmh0101_gpios {
+	sys_therm_5_gpio3: sys-therm-5-gpio3-state {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+};
+
 &pmh0101_pwm {
 	status = "okay";
 
@@ -1008,6 +1164,11 @@ led@3 {
 	};
 };
 
+&pmh0101_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 1)>;
+	io-channel-names = "thermal";
+};
+
 &pmh0104_j_e1_gpios {
 	bt_default: bt-default-state {
 		pins = "gpio5";
@@ -1038,6 +1199,11 @@ sde_mdp_vsync_p_1p8_active: sde-mdp-vsync-p-1p8-active-state {
 	};
 };
 
+&pmh0110_d_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 3)>;
+	io-channel-names = "thermal";
+};
+
 &pmh0110_f_e0_gpios {
 	sde_disp0_rst_1p2_active: sde-disp0-rst-1p2-active-state {
 		pins = "gpio9";
@@ -1056,6 +1222,152 @@ sde_disp0_rst_1p8_active: sde-disp0-rst-1p8-active-state {
 	};
 };
 
+&pmh0110_f_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 5)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_g_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 6)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_i_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 8)>;
+	io-channel-names = "thermal";
+};
+
+&pmih0108_e1_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 7)>;
+	io-channel-names = "thermal";
+};
+
+&pmk8850_vadc {
+	pinctrl-0 = <&sys_therm_5_gpio3>;
+	pinctrl-names = "default";
+
+	channel@103 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 1)>;
+		label = "pmh0101_die_temp";
+	};
+
+	channel@18e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 1)>;
+		label = "pmh0101_vph_pwr";
+	};
+
+	channel@303 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 3)>;
+		label = "pmh0110_3_die_temp";
+	};
+
+	channel@38e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 3)>;
+		label = "pmh0110_3_vph_pwr";
+	};
+
+	channel@503 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 5)>;
+		label = "pmh0110_5_die_temp";
+	};
+
+	channel@58e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 5)>;
+		label = "pmh0110_5_vph_pwr";
+	};
+
+	channel@603 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 6)>;
+		label = "pmh0110_6_die_temp";
+	};
+
+	channel@68e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 6)>;
+		label = "pmh0110_6_vph_pwr";
+	};
+
+	channel@803 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 8)>;
+		label = "pmh0110_8_die_temp";
+	};
+
+	channel@88e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 8)>;
+		label = "pmh0110_8_vph_pwr";
+	};
+
+	channel@2703 {
+		reg = <ADC5_GEN4_DIE_TEMP(1, 7)>;
+		label = "pmih0108_e1_die_temp";
+	};
+
+	channel@278e {
+		reg = <ADC5_GEN4_VPH_PWR(1, 7)>;
+		label = "pmih0108_e1_vph_pwr";
+	};
+
+	channel@278f {
+		reg = <ADC5_GEN4_VBAT_SNS_QBG(1, 7)>;
+		label = "pmih0108_e1_vbat_sns_qbg";
+	};
+
+	channel@144 {
+		reg = <ADC5_GEN4_AMUX1_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_1";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@145 {
+		reg = <ADC5_GEN4_AMUX2_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_2";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@146 {
+		reg = <ADC5_GEN4_AMUX3_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_3";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@147 {
+		reg = <ADC5_GEN4_AMUX4_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_4";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@149 {
+		reg = <ADC5_GEN4_AMUX6_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_5";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@2747 {
+		reg = <ADC5_GEN4_AMUX4_THM_100K_PU(1, 7)>;
+		label = "pmih0108_e1_therm_6";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@274d {
+		reg = <ADC5_GEN4_AMUX4_GPIO_100K_PU(1, 7)>;
+		label = "pmih0108_e1_therm_7";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+};
+
 &pon_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 
diff --git a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
index 55d02219ef4e..303e7b316901 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
@@ -8,8 +8,10 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "kaanapali.dtsi"
+#include "qcom-adc5-gen4.h"
 
 #include "pm8010-kaanapali.dtsi"     /* SPMI1: SID-12/13   */
 #include "pmd8028-kaanapali.dtsi"    /* SPMI1: SID-4       */
@@ -80,6 +82,152 @@ key-volume-up {
 			wakeup-source;
 		};
 	};
+
+	thermal-zones {
+		sys-0-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX1_THM_100K_PU(0, 0)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-1-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX1_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-2-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX2_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-3-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX3_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-4-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX4_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-5-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX6_THM_100K_PU(0, 1)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-6-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX4_THM_100K_PU(1, 7)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		sys-7-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX4_GPIO_100K_PU(1, 7)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -717,6 +865,14 @@ led-1 {
 	};
 };
 
+&pmh0101_gpios {
+	sys_therm_5_gpio3: sys-therm-5-gpio3-state {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+};
+
 &pmh0101_pwm {
 	status = "okay";
 
@@ -744,11 +900,167 @@ led@3 {
 	};
 };
 
+&pmh0101_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 1)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_d_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 3)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_f_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 5)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_g_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 6)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_i_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 8)>;
+	io-channel-names = "thermal";
+};
+
 &pmih0108_e1_eusb2_repeater {
 	vdd18-supply = <&vreg_l15b_1p8>;
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pmih0108_e1_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 7)>;
+	io-channel-names = "thermal";
+};
+
+&pmk8850_vadc {
+	pinctrl-0 = <&sys_therm_5_gpio3>;
+	pinctrl-names = "default";
+
+	channel@103 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 1)>;
+		label = "pmh0101_die_temp";
+	};
+
+	channel@18e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 1)>;
+		label = "pmh0101_vph_pwr";
+	};
+
+	channel@303 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 3)>;
+		label = "pmh0110_3_die_temp";
+	};
+
+	channel@38e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 3)>;
+		label = "pmh0110_3_vph_pwr";
+	};
+
+	channel@503 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 5)>;
+		label = "pmh0110_5_die_temp";
+	};
+
+	channel@58e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 5)>;
+		label = "pmh0110_5_vph_pwr";
+	};
+
+	channel@603 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 6)>;
+		label = "pmh0110_6_die_temp";
+	};
+
+	channel@68e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 6)>;
+		label = "pmh0110_6_vph_pwr";
+	};
+
+	channel@803 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 8)>;
+		label = "pmh0110_8_die_temp";
+	};
+
+	channel@88e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 8)>;
+		label = "pmh0110_8_vph_pwr";
+	};
+
+	channel@2703 {
+		reg = <ADC5_GEN4_DIE_TEMP(1, 7)>;
+		label = "pmih0108_e1_die_temp";
+	};
+
+	channel@278e {
+		reg = <ADC5_GEN4_VPH_PWR(1, 7)>;
+		label = "pmih0108_e1_vph_pwr";
+	};
+
+	channel@278f {
+		reg = <ADC5_GEN4_VBAT_SNS_QBG(1, 7)>;
+		label = "pmih0108_e1_vbat_sns_qbg";
+	};
+
+	channel@144 {
+		reg = <ADC5_GEN4_AMUX1_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_1";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@145 {
+		reg = <ADC5_GEN4_AMUX2_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_2";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@146 {
+		reg = <ADC5_GEN4_AMUX3_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_3";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@147 {
+		reg = <ADC5_GEN4_AMUX4_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_4";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@149 {
+		reg = <ADC5_GEN4_AMUX6_THM_100K_PU(0, 1)>;
+		label = "pmh0101_therm_5";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@2747 {
+		reg = <ADC5_GEN4_AMUX4_THM_100K_PU(1, 7)>;
+		label = "pmih0108_e1_therm_6";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+
+	channel@274d {
+		reg = <ADC5_GEN4_AMUX4_GPIO_100K_PU(1, 7)>;
+		label = "pmih0108_e1_therm_7";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,adc-tm;
+	};
+};
+
 &pon_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 

-- 
2.43.0

