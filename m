Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545757;
	b=SjOnXAztJPizf8ZyDMklifU5HqeZNwHm2bv2W+CnEban9gSQr10BiuFMRKUxSzn96KIj
	 xIElcNDlOrbvyjWWIV1Y+xEkvLwZXS68TVga7WGyOSM17SP9JJqaO8TAnirq3fIJEFzpu
	 wXUKaXXpuOdJWKFDtMam7PgiTjzdISYKMe5NWb915wimZsSxsVGqA0FyKcVKjsjsiBLmz
	 xjb8KlhB55370VD08gn+XUbV/UXYccSC0C16JuN8XcdzBT+hQyk5w6bI2TFpw1qxuqqkI
	 8Ho6BoSPIEQcV/Jj7h7cBxo//Hgq8fG1CZmbr7Y97u5W4XUGs+YF/kUcn2DXJluDwSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xVFG72PNJc05CviP7xNZo/AxabG5HdWiKbSPhL5aFtg=;
	b=cgegYIM4UA/5L1li+iU5/os/IKN7/3CviYtBcR2RoQoJscxyF7g+7rxw625vpoxLJi82
	 TpPnpCq/VsxIkOZmJO8YIoajawEPv6AnnZ9DlaTlG0mK+755iKD0wrp9Kv90U9fLneMqt
	 9vHH9ezffGHZ8RVj7gpPRF8/IPFGtjVgp77WX1+dr49MJrFNZqShJfEcWIyWfEBjrdgsk
	 pyOb8SfZOMlNHixDFQEszlVNttgn/Yb1M8RCVgOEmwoKvIlEE+/HaWSlnTVBfl7w9SHpN
	 d4wShHf5EZVhN+Mwu1V/9hAaeSXlkMbUAQN26UHRtoMmvWeoQkJOvBbs7uKP1lKPLKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pg5NrZPO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZQKRdPTi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E306606A8AC
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E306606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pg5NrZPO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZQKRdPTi
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD2K0Ge2688331
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xVFG72PNJc05CviP7xNZo/AxabG5HdWiKbSPhL5aFtg=; b=Pg5NrZPOBthbtwqS
	xB90pYx4t3dhHxty8ZW7kyN7wtCVBVOioiHBypjrLM1M/eWjCs8/nXeKOrU00y7P
	+PFT9PWaTXNcCal6itSc/um3EJ3fK7f+Fpp8mHamleuqEjc8cxJEPGWwyrrb7MIf
	6o9X+U0IYZMx5RXrUkW9GJv0Nm6tnKcmuFE94EK2Rt52KyRqmqJ7c6Gd4bNGr+5Q
	6O94jpwJszTrSjXkc1q+yNgPlD8wkbp6GCmWT6T8/fiTHBKcLW0uCD/J2mQhBFx7
	aO0IYgROJBrNWBm7Ey18cZd02ODmC5lP39iLGsYA08nxXaI43e+SyyyTAjKAgCWU
	NZgn1w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgw9g2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b0a9de9c2aso309581a91.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 20:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794545755; x=1795150555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVFG72PNJc05CviP7xNZo/AxabG5HdWiKbSPhL5aFtg=;
        b=ZQKRdPTisf3yF4+vRpx6QkqV/XFYeMwge0OjWthO0Vknba+xvnut+cr/JY0ERZLof1
         dOCVkHccAE29XiXG6x4UHRFpa/pzvzDkFkHDULvX62KDdyJJ6z+mSKqNgAHCCLEsJknp
         Ge5CvfpmJcig6asX+ML82ZnWQAaA5+BKpPUnIpMj2kRRU4DuoWjm7aPrnlYNL2ZIgy/C
         PI6B7s2Hu+oQOyBBU32+v93xff44qWWZM/8H6DmztHr9h9jIHuPJ+iuWx+tOeee71tDM
         2l3dATWipoCtl/Q4DUOaUKmkwQldwE46DGH+ktLVrA6ugi3v6v4QeYEK+E9A7Nln9y52
         /55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794545755; x=1795150555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVFG72PNJc05CviP7xNZo/AxabG5HdWiKbSPhL5aFtg=;
        b=j0wtxUaa9OQKRU8z1xCLy10kRpasJLWV0KxCmSqm6zCrgeo5H55NrvglSMAGdfVQWO
         Azy46br6QCLgLJlXGuZ8dAbyM/7s3W4+kL4kq7cZGf4yQM0Dp0sGd2fbXZtcnYR9sVT/
         fzKB4jaGs1nMmNbXk2tpQTpaZx/wN+SO19ZnNhUjiqgeQQlrdIdGDzcqhPoXAiWsVpDE
         XUhDHZdXH/DzU2NSYjec/hmlvzX1IR8GyG2yRZG9F5pbwHZ3bnRHHw+TlazK3gLf55o9
         ElesTbIC6t5neatdorpcvq3HYVHo1bPf5sND79AYwt8HVqdUJ59gndjcrhKIBcMLs5eR
         4xSQ==
X-Forwarded-Encrypted: i=1; AL+hErH6B4OEseCVzdtkoUoIYZj8K7Csao5GDT/DV+peagZOcrF5TreRrO34QSfzevuDIj/hrpBqpOGbvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/K2p5MnKH94pKDogwr/uE2RfniEKP9FggQpx9alG5CxvQtQEi
	vLNUqVhD2nS2NNOHo4AnsN3U1ImWO7vCWK1S69T0n9+g/AqPwZUVvMbWwS/RnS68gF9He4adUZy
	pOtTHtb4B4ypKk+QZSrXbsRKUiKrT3oVvqZrO0gDTsavDx5k3bdCG9S1lfWVKAg==
X-Gm-Gg: AYBFou3cMqyy/Z/ae4eKjukiYuCOnafsX8OtxLSeO46z1HCaCpEbjeMp/dHsrVtSbC2
	jBknssktHMFVlIJuJEogDExv6a50eCZEJVbfpDOVUrDEJmZGpkJOFdWgGrnG1RaH6+QPAvWXsFi
	NYt+q+hrvZpKL7YSvaasTxV9LTArzjAlNC2RGURFvvjby/+l48vpAMvWK3zZJQoiZ6wAbwsKusK
	G9ALjjf5Ftj5Io4EARRzAfSykHTY5yZCrArXfMjZfVVAgxhioFSC3zWAO2hzsQ3xF2+QbNgN91k
	sop9zX4VfbBZr71/++eGzGD3he9TSm8Q/1l1So/NZZXTVQ4PbfCmPQJzp2bJ9/lowD9u3BD+RLX
	/5bm2CuYBEF3I9N8HFsNp5ewy1fslxt1perjBBA1i93e+SPhKmfpwh0wgtGpRKuJu0j9id+OFCY
	4v
X-Received: by 2002:a17:90b:1650:b0:3b1:8396:ebf8 with SMTP id 98e67ed59e1d1-3b1b0a4fe2emr1091207a91.36.1794545754938;
        Thu, 12 Nov 2026 20:55:54 -0800 (PST)
X-Received: by 2002:a17:90b:1650:b0:3b1:8396:ebf8 with SMTP id 98e67ed59e1d1-3b1b0a4fe2emr1091192a91.36.1794545754499;
        Thu, 12 Nov 2026 20:55:54 -0800 (PST)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm7739875a91.10.2026.11.12.20.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:55:53 -0800 (PST)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:25:27 +0530
Subject: [PATCH v2 3/3] arm64: dts: qcom: monaco-evk: Add suspend-only
 power collapse state
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
Message-Id: <20261113-s2idle_state-v2-3-ad604182e7e7@oss.qualcomm.com>
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
In-Reply-To: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794545733; l=1804;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=rmjlNp7nzxS52DoDEeFUOHUSdU6WMCg82sqCrOEZzak=;
 b=99iaGDZdsjb3GWnJn0sBCepEljAZvIMI4mra1BI3ze7MPtyBgN92lgx7tfmEL3USukl6zESNl
 vaejUR9FkQ7BdMKu8h44J8RpH4F6m1DxRsfFH8jZvgdVRcpHd87abPo
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af6985b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=JkMn96IHD8b9Uh7FENwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: XP9aXjDznczZ7btfJNr4WA8v2drLVVIo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX72BDF26KsbpW
 7sJBDpHfSM+m+Kc5RnH+1cOeL59ylVETrRYmnFXLZrCfdvwHrpuBakRZWaYJSj4rveZ0SLv6EIo
 COU/Rh8XUx2SHJyXQbpLhGaYNOqvYBCxeSfRZbd5V1xrm6DVRpJQg76RXP62kb0oRq99uOTXOQR
 707FuQlKeGmqmGsQi56LoEpJl3KZjNhdn2zguTlJWk65a4+4mAfiukY1pXsiyssHYPuFOTRhx/B
 ZQtOPrzjIBKsyHcgnkjN3DeR0wI+ExsnBgQS8tPWMsGbIG9+86yGtc6aaO6M12Cmw0Xmq+mCcJ9
 0ICRbDkzMhE0V3IP9sYyi+xID6wbGqhpPs6skdAz6z5SH4FhgKcfaLNVgdjXlS7+lB9ZupIieA1
 9SGrZ86f2rAZRo/II1uuVKTECBcBwVBO1RxL1PwYmmJHJyjTN2MfmVy9l3fKCvr8akGXiYYtQY6
 TQuUerYW1Zla1M0cyvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX9xKaE23HXHj8
 IZ6Fx5r/l7HD2IV7I2YLg0KWDE0YELr5dp7uMsK/KKM5GK/SqGwHqTA88Mcy6QTEDqf0YRyF3Dp
 XAO3BX0rgoQBmphfq/NNOOR84BHhVIw=
X-Proofpoint-GUID: XP9aXjDznczZ7btfJNr4WA8v2drLVVIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019

To achieve SoC low power mode like chip rail power collapse (CxPC),
the Monaco EVK board with four PMICs requires coordinated power-down of
CPUSS and the Safety Island (SAIL) subsystem. This deepest system power
collapse state is reserved for system-wide suspend (s2idle).

Only the Monaco EVK with four PMICs supports this deepest state. The
Monaco AC EVK described by monaco-ac-evk.dts has two PMICs and does not
support powering down SAIL. Define the state in monaco-evk.dts instead
of the shared monaco.dtsi so it is only available on the supported
board.

Add the system_suspend domain idle state, mark it with system-state,
and reference it from the system power domain.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index 539c9c80a808..5e6206bcc97f 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -80,6 +80,19 @@ m2_e_uart_ep: endpoint@0 {
 		};
 	};
 
+	cpus {
+		domain-idle-states {
+			system_suspend: domain-suspend {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x4200c344>;
+				entry-latency-us = <706562>;
+				exit-latency-us = <706562>;
+				min-residency-us = <1414124>;
+				system-state;
+			};
+		};
+	};
+
 	dmic: audio-codec-0 {
 		compatible = "dmic-codec";
 		#sound-dai-cells = <0>;
@@ -772,6 +785,10 @@ tpm@0 {
 	};
 };
 
+&system_pd {
+	domain-idle-states = <&system_sleep>, <&system_suspend>;
+};
+
 &tlmm {
 	pcie0_default_state: pcie0-default-state {
 		wake-pins {

-- 
2.43.0

