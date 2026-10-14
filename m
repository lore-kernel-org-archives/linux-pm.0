Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FF4E73AE
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980446; cv=none; b=ZJW0DPtiQvC+6ncRxnh/0U0G2oMW8WuLyU3fCHHqGjQ11Cp9rxnC1nDmI+33wwZLa+LO14q2tFKkLcC+Mpks3QwZd1QsdyZnFXm/px0cmHVp5Fm0YWn/x39hDQWTuFlzoSTY+7v4AUaTl4O8Ez5hJ5178tskAr5uauaFp+VOlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980446; c=relaxed/simple;
	bh=JJ5CjXDytQbaIFGLRV2r224O4iHIwhrXeTd5Z4WrCMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbEHj8GO0nAze3HnOQgw+cmQvyKMDDhlJwhwe8wnXlI5SqkRNBtZFb6Wvb/A9VDlYy7FdQRML+T0RuAJiG8FYgJIsjE6roELMtfkZJafLwg0HYXiO3xv+pPwZ00BW9shKVF8fGuPZUjL2TXv3KqniLd5hTiqrMpH8FGanEGYJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqMRQdmP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNnjFQyW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqMRQdmP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNnjFQyW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8IbEk3017940
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MGWXnicbf0/
	6KAzz3oLqRWlws+YJM/Jk9a++QSaRd8M=; b=jqMRQdmPJboQ/tnllPEvqc7c22h
	M8ByuC4XP0TJr5Z3X5ljqrgmrYLswsBG+/D3ZrB89CbaQTiYgb/JE2CWD1SpQ2mX
	ZaslX67lS9IYf0626+WkS0hAd2ZxjGSmYOlzTTnpwbwtPmtChVPoxUZaqvPUb3EV
	ABpbgxwM2MjEegCAqGEWhJ6EIMas9sq9FQBlrjcBNnKnuSlQ9ly/nkIFzoKws1Xj
	vS75KMHlg4K8IIlts8TR54+eCynl9HMDxFlG6tpT55cIRQBemWjWW+26KNNNiMs+
	6ReTtOL07WJg6oieNY0BlNY1zMhKQceHCNAjbECDiAYDRe1JVwhGTT5dyZw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b48an-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:20:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88635fecfd0so336390b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791980444; x=1792585244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGWXnicbf0/6KAzz3oLqRWlws+YJM/Jk9a++QSaRd8M=;
        b=UNnjFQyWkdskHC4kl45/9rjXm1KlREm73o8H4aYDnq+R31rIhKnsQNnRECHwuKr67/
         tJn3hQ6XZHgPMuoTW4iVzjUZTc55qVNjlvHEKoHceE8VoXHAnt13vI+mdI+5JA2x6UTe
         SoswAn6NH814Xw/qT+YH28syevt8g0UE35MyuFkfagZYijIpVaDBI565+OgVprbxZB82
         v1TD/2J1H6aSF+f8uH7gfSMYSHX6LCHbcfo0qONvxrTpBbNhDdI1QkI5Z/kex6IIijIT
         ggieahNOIDGZxxB+pegBGiTd6vHZO7qD6FUVj/60CteSbajQX+4NyLSfb68jiD8jNWbO
         Mr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980444; x=1792585244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGWXnicbf0/6KAzz3oLqRWlws+YJM/Jk9a++QSaRd8M=;
        b=XcAFV+zqRepzZyvW+mDBV0i1wS9e5XS0yjDlJ2KyJ6S2KQEDYzKHFR4iXCJEXwMSqX
         eusUS0ac5bopgU+W7JmynLJl/3aHfOkhCCNyTrNf189wTPXxyxf/OVz2uhc0djz8ApIz
         j3mVqb3a7dJ8QJU1Ckd8lqQoDaQ0jSLqAxsVezf5LUHbN/fnIHDwklbRPvR+mcQFtOTV
         BGRGbe/82Vb2dNW1h2smszYvzqa/P8K7x3cnRXDKiiJUkHQw3PfNrw5YQH/kt5Et353x
         yEPApl8SX3k+v7OblPlqo5r9paQYbDFRffZ7vd7FZt3jOTGEbirf8shRBJmcAZopITZw
         4GCg==
X-Forwarded-Encrypted: i=1; AKwUvBytYLxiW3DXaDoRv3t5l+KV8kFd/qWpuWieNbyBydKrMC75Hr1We7EdZtjsWE3ZrNy+TsTpm1Oeag==@vger.kernel.org
X-Gm-Message-State: AFq9FYI0dgLyA8LHd1L5lDNlafDq05Dy0xvECtr8QZUqs2uq9SxuHKK7
	+uGKZCq/LAMp/RpzJD0/JFI5cjE/EywKqN0o/hUhgtObyKLUYYtlRFcJAVR9d9OcgbrFYdYEXj2
	PT6HvGw4yi/x1/HQDwWNJUsecViYIZCcsOoTD52NUOCmwwDmGGbQUe0hOeqiTeg==
X-Gm-Gg: AYBFou3WCh8QCUtkw0yTKMx1KLgZFfVDkOZPVOKpZJLIsLCMZ4sMqLbjFd1aq07oTNU
	Wb3s/Vuyi2IT+qbhe4/xiWbFrzMQ5+vcln97KB/77y1DiWmlv4leXSWxHF8LRB1uufk1jfYTewd
	EJQyl3uGTU+c6IYPP5OIhV2d9GHPxq6BD2BlbAFIiibLUmayHXlKIqbQBiPIq/MUNyJ522muZDV
	vPNv3EEgtqtIH1vMv8f9wNHbRD99R5GyLZ7VO094mEpRdFFnan5u+x8LK9ZDd/vG8ceiUz6D0Ax
	1GjvuR4C0smyezyAld93Gy/OFJF6Z3cL+TRlbdwTGy2Uyw0jRuryOLVbwJhOsSSuiM+5CNPnXnd
	sVqby055En3JON5SWPmvlyKg8+bcI
X-Received: by 2002:a05:6a00:c2d2:10b0:898:5927:31c6 with SMTP id d2e1a72fcca58-89859273cd5mr13995402b3a.3.1791980443956;
        Wed, 14 Oct 2026 05:20:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:c2d2:10b0:898:5927:31c6 with SMTP id d2e1a72fcca58-89859273cd5mr13995364b3a.3.1791980443440;
        Wed, 14 Oct 2026 05:20:43 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804ec645sm1016990b3a.43.2026.10.14.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:20:43 -0700 (PDT)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [RFC PATCH 3/3] arm64: dts: qcom: shikra: enable WCN SW_CTRL wakeup
Date: Wed, 14 Oct 2026 20:19:10 +0800
Message-ID: <20261014121910.1509541-4-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acf739c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=MaKIKtuR7Ise4_itAv0A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: -6A9sYgzfo97gEty4v2UtyNjMqBsYX7D
X-Proofpoint-ORIG-GUID: -6A9sYgzfo97gEty4v2UtyNjMqBsYX7D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX4A1GN1XSrgXd
 DdPjuACAQo7DsqZXluDNkb2yFi+RYYjCRz71xp1pJ4C6iaiZYuEkXxsWs1anlvAppGQFoexQjkh
 ZVGFHnxQaQt9btWFGQTHRKJxJKMOyqaeRvKDxgBYdIyfK7QwAMpBHaaPchCWsQ9Mks/Ip64VVnt
 Hii+5IJN1WEufG3ad3L5LS+GkPJ4hsizzKeecRDH/KiyhFCGWwoN4Z74OHtBiuaO+tY9Cnnw2GG
 fKuap7KBEqq8skGRG04ZxfXAi4s2pdzz5iOzz9cXCYh/O1K+CIHAcSl+uOs3JT2TPnPobl9Ay+G
 uRdSwm3kYmLn6FZhMUes/sFxCySuSUO9/9x0qnSN9PapWYpSpewRNgOJtZuyRS7yfEYDuFPfmHt
 6gAlzhi3stV1ksn3JCVYhSMPMvy1KFc6bD6l4AYUZzkV41stpHOBEcm97B/d4qrWpKB0zETn+Yg
 BW+NBqwWdSQL9+0D8Kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX/BLLsEzmEPmp
 9HAi6XJ2KRmFyM8rWjbKAZA25iegZo5fkZMXuy+vnZRP+ndr3HVnSD0rgJJ1I38dICO8RGJaYQ+
 FKT6PK+wNM8t5CLDglAiczUhrnC1NM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140049

Configure the WCN power sequencer SW_CTRL signal as a named wake IRQ and
mark it as a wakeup source. The CQM SOM DTSI is shared by the CQM and CQS
EVKs, while the IQS EVK uses the IQS SOM DTSI.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
index 8ac42ff625a..c08fe15a91c 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 #include "shikra.dtsi"
@@ -39,6 +40,9 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		interrupts-extended = <&tlmm 88 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "wakeup";
+		wakeup-source;
 
 		vddio-supply = <&pm4125_l7>;
 		vddxo-supply = <&pm4125_l13>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
index 4ff97945274..e16eeb15a23 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 #include "shikra.dtsi"
@@ -46,6 +47,9 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		interrupts-extended = <&tlmm 88 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "wakeup";
+		wakeup-source;
 
 		vddio-supply = <&pm8150_s4>;
 		vddxo-supply = <&pm8150_l12>;
-- 
2.43.0

