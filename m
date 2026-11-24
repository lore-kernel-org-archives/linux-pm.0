Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511766;
	b=IXBFlOw1wWGHGfgWOkT50Ma3YZSHOF9jEinJ/lzh19EIxHS+kI/nTH2EBuFTPd14XmVh
	 B3LlFLY6fldI21sNJyksMmB0l4W3lF0Fs1bMs4k0rL1043/dkoGZuMYLTrNkAFK/TlnPp
	 oIqLAjHrixE9tLkogC1UvBHd1Y5JToUeCaDl8hZuXIghMgOFTxvUitV2pSS1KrbtdrgRC
	 xQo6T3km7Vevc/z1lIxAskUaM5i4Q7F3myMq5w2aHpJCrkv0WgHAeGEOi3ie8SjPtKyKF
	 mE8BNoGvDCvfk58Le3nS12B+lcFd8FWGemU1KeB2aX59EezlY6n6ZfZw/ASttWXH6BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511766;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UyDaDhJrRNXgsf22haK3fPxDonsmKiOgnNSI49tEwtU=;
	b=TiZrccL/oVGTzphfP3d+tJmGHsyBfoooMG5Bx4nDWTqkaATq0faEEmvAsiiabzy/Im1k
	 mBTFyqI6MWEVLrlSyzmzF+8u21ub7N1Z4dvdAznevEbOgs/GxQstn9xCLe/IkoocTawPo
	 8WdEglAL8jFhc1i6aeNY0ZiOvwBVLjwYo31Ns7lMOqAMrjfVoJTbQcIYRIsa2K9M1aJMU
	 a/AlNCFDZv5amggg6AJUnlTO6Y1u9WVfs7ON6zr0YZDv8nXv/vOl9Ce6PyoZlnjF0cmkT
	 cia4hMmuyPsKaC0Infy4dSqrCSvmAUgei61hLiYcozZ82OtY8uEyJ9cAqbWK1gj6clg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avMgDcGh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cQTH24cv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96113606A334
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96113606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avMgDcGh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cQTH24cv
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8Q1V43701111
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UyDaDhJrRNXgsf22haK3fPxDonsmKiOgnNSI49tEwtU=; b=avMgDcGhJ9DViWB/
	XYqjFQ4iMAdvCvFoLS4XALfaeIuIqZiJVA6htH31cHhOSzQDOM3JWE93AffBazRu
	zPeEC54i/pa2YX8e3F/1cBN1FQDrovs8ajOdcs6TCx7TqFNE8oifIhD9Y2oh9usy
	lD7uYOo+slnHnFT/zVNkHI0+rAQvejqO7UJKtCIPKNoJrCM/GkB2rSnW9d0o+Heq
	aU8SsGNwSxPjIODdZEaA6Bgf/O/sgrJq/gr8dpAUiimtIPXeSE+jn+TALFFPLw3i
	4j5LeHVdvQs2Fz5/XZCsUwf0TU26D3MYMCAdnLCZe+sX6F2exKWzQOFweA75Dy3E
	ivm65A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky1qu4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd652c0385bso3104141a12.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795511764; x=1796116564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UyDaDhJrRNXgsf22haK3fPxDonsmKiOgnNSI49tEwtU=;
        b=cQTH24cvlaQJ42AyKtFdW26cM7+biAu/e9mccS2UT1vFNsURM2/HNI8KqKMNCM5Byf
         OMOTrqrZ2wbM4MDgPZA3jMp2OzcmY1dL01m/50kCxQvySaB1Xk7ljSVKA9MBsMbwmi0M
         +CxNAPlVyKRqLdyD63egyPXSTidfvtxcQiDaXAfDxQNCIL5eLlZyttE5S1WMobJ1zchO
         fEr9naE2Eu1qCmlScmZXkfU6Zf5LdfvP9+e1XjBUHMv2fafQ1bkauKz/HFpHM0EgfWdM
         /obWuiVL4MPoVzsI59qjOzeoHCA5YRWwhPpKnxV3EsegZZreY+CJVypLFB2W2Hw+pJMz
         Q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511764; x=1796116564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyDaDhJrRNXgsf22haK3fPxDonsmKiOgnNSI49tEwtU=;
        b=eO1u3oXHAStcUxg4E362hv6m/5LLnnaafZldGPJj4J86UuC34DjtuFEB4Y6J6lT5j6
         WMDfbh4RrqnOBwzgLaZNxPqJ1Lyyq/kvc1ys2Wd0miWp4TQR8WdUqYw3NVm+ktDw6G8r
         gfFYAgvrnj/3jyrBnzf/1QtLJcICiqMm0idXZT/D3W0fKU4lWP91/na2wiJmQG+qVVmh
         csS1ILrmgo/XcujqSU/LqCv+bIW/UV8HBHzkYh3ynZ+tW/k/gB9LJFUtRWJt6BdjtExF
         UrHssfnVxXFHcklkOBPWtyo9WOrXndGl0SAqPuJC4+1pI937j38x4QDAhwJRHMDHbdVd
         awcQ==
X-Gm-Message-State: APuU4Z8ABrCXIHkXXWnT0LdbNkaNI43LdRqBlTlvFZXaHAqmWVh02bfB
	T4TcnhMZO8BQkU5mFTkpoNGe1ERG3WvgAsK+Vad9hSUTpCCxtqRz9bimCq7yz03hEL181fxx3S6
	Voo5t1CRaijKdR5D4ITzU3CfiDNWcUa2KNqPVP05GSQ3j2rTrRTRMg83jlQFfhA==
X-Gm-Gg: AZFdTZeFe8TV6UFz124z2rF/E0rrpRBdsf3bEFMcL54HrPp8Q+96f2QU2vSvN1P2dR1
	eCY5oU/VdY7uGxt8fFj9b6XU3zoa1O/GDi56GnJ5qzm9PnHqCfDRa/RZQG5wFHwYQDUZIhUva/7
	SlhabHkIx5ubmxRM635EVY1c9AX2QyvBbMV3WdHDpWjPlUN9NfzO/qiyUa+IcJugaZW4Sg/zXfY
	JUezqGICIEapaqe8QMedQjEvmVcnrQUt20GMWl0pIlwO0uWSEboWD7MMiXFhSQ079J+lvvPrTsw
	oqx3aiRV1Qb0UXJjGVgnOvPTiXuG27jhqnlRulnMQ5wwaYNPfKYEnjWCjCPzlRXdYkmyDEg19XA
	PYN/RcpcfWRUw2wUorPLX6xfbUrTvpBDfTkEJJnq/BNjgdlIuClT1nwqGPLfxF3NTOssESkx9Co
	o=
X-Received: by 2002:a17:903:2b0f:b0:2ef:d8e2:8274 with SMTP id d9443c01a7336-2f03f1ae083mr138080695ad.32.1795511764022;
        Tue, 24 Nov 2026 01:16:04 -0800 (PST)
X-Received: by 2002:a17:903:2b0f:b0:2ef:d8e2:8274 with SMTP id d9443c01a7336-2f03f1ae083mr138080385ad.32.1795511763547;
        Tue, 24 Nov 2026 01:16:03 -0800 (PST)
Received: from hu-raryan-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c72sm66371825ad.54.2026.11.24.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:16:03 -0800 (PST)
From: Raj Aryan <raj.aryan@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 14:45:44 +0530
Subject: [PATCH 1/2] dt-bindings: power: supply: Add qcom,pm4125-charger
 binding
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com>
References: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
In-Reply-To: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raj Aryan <raj.aryan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795511753; l=4863;
 i=raj.aryan@oss.qualcomm.com; s=20260507; h=from:subject:message-id;
 bh=JWQ+3UkdjGpMYJ0rMN0scOdLIJkar3ei6FpbBL73/vQ=;
 b=YVgsQ2lUUxYOUccMpu9jCB/zFyf2ltdzmB57JUBFeVhSYc8RuVdjR2p+M57sVKEhcZmX0mqnR
 KwvKYb4ljPEBetYIX2lDymafrSvsHTcCJEehq0ythjJqRB1SReWiq5G
X-Developer-Key: i=raj.aryan@oss.qualcomm.com; a=ed25519;
 pk=NMkZ/eGFLSObYX6FfysQiuEElPoUYghk7+2Jtc4VEBQ=
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b0555d4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=B20DgfED3MDX--t0QlkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: UNjHDB0ga7jAcFDQ08q2UuZ4dN1rkOe3
X-Proofpoint-ORIG-GUID: UNjHDB0ga7jAcFDQ08q2UuZ4dN1rkOe3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfXy8rBkDO9/1ot
 ca8uR8ASdfLOPaOPc3slsOIqiKWbPVMOpu6cziEA08MyzfTVLbax7JR6mXBJRV9nRctywoK9AdP
 p3R4eFzgmh/VaMRcKGI8BET9IlevBrY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfX9Pm4CV72qQ92
 5VS8GbdPEataYHxmoUbH9YoIrvsdbcvZBt8a75Y0MnY7xPibxG8kFLgi7qg1I4y+UdO22a/5j3i
 0gLwni96GN+rj2pop0SDkeCpoy+FBInmtU6FeLMCjGfZtaxccDoyztBaEX3wErTk3+FWyzR1JkA
 oDWOaJqxlh7hamWkSDF4T7i58pfwZLqFOOqEqCP1XECtvi6VFbV3knBvqkV71yidCYol+jIuDJf
 CBwU6ti3J8ui3RbePhEzgyjJfkJFlLFPk/HtS3CU42GjIRvt0Agocs4DjS+xnZokvbUgMV6vfXH
 05/Au3gmI9A7Nrnsz8P8Pw3dfEJb/dX3DLtAJvqUpzPlb4pK+dT9tM0W7r8Km8JMmGPuZIAa9Z0
 bvtlo7xtpmJ8+wkRtd6pYp3ah/4RWUz2J8v0jLvFOYPzd5PObLjh21N2kXW7+icf/r/x/dfyn+t
 wJSAC3i0lXyxzPx7dNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240035

Add YAML devicetree binding for the Qualcomm SMBLite switch-mode
battery charger found on the PM4125 PMIC.

SMBLite is a reduced-feature charger IP sharing a common SPMI
interface with the SMB2 family (PMI8998, PM660) but using separate
SPMI peripheral bases for CHGR, DCDC, USB, MISC and BATIF blocks.

The binding covers:

  - compatible string: qcom,pm4125-charger
  - reg property for the CHGR peripheral base address
  - Four interrupts: usb-plugin, bat-ov, wdog-bark and
    usbin-icl-change
  - Two IIO channels: usbin_v (USB input voltage via ADC5_USB_IN_V_16)
    and usbin_i (USB input current via ADC5_USB_IN_I)
  - Optional JEITA soft and hard threshold configuration as raw
    16-bit ADC comparator values written to BATIF ADC comparator
    registers
  - Optional monitored-battery phandle for battery parameters such
    as float voltage and charge termination current

Signed-off-by: Raj Aryan <raj.aryan@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 .../bindings/power/supply/qcom,pm4125-charger.yaml | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.yaml
new file mode 100644
index 000000000000..5651b428b0a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pm4125-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM4125 SMBLite Switch-Mode Battery Charger
+
+maintainers:
+  - Raj Aryan <raj.aryan@oss.qualcomm.com>
+  - Rakesh Kota <rakesh.kota@oss.qualcomm.com>
+
+description: |
+  The Qualcomm SMBLite is a switch-mode battery charger IP found on
+  the entry-level Qualcomm PM4125 PMIC. It exposes five separate
+  SPMI peripheral bases for CHGR, DCDC, USB, MISC and BATIF blocks and
+  supports USB input current limiting, JEITA temperature protection,
+  battery overvoltage detection and a hardware watchdog.
+
+properties:
+  compatible:
+    const: qcom,pm4125-charger
+
+  reg:
+    maxItems: 1
+    description: Base address of the CHGR SPMI peripheral (e.g. 0x1000).
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: usb-plugin
+      - const: bat-ov
+      - const: wdog-bark
+      - const: usbin-icl-change
+
+  io-channels:
+    minItems: 1
+    maxItems: 2
+    description: |
+      IIO ADC channels used by the charger. usbin_v is the USB input
+      voltage channel (ADC5_USB_IN_V_16). usbin_i is the USB input
+      current channel (ADC5_USB_IN_I).
+
+  io-channel-names:
+    minItems: 1
+    items:
+      - const: usbin_v
+      - const: usbin_i
+
+  monitored-battery: true
+
+  qcom,jeita-soft-thresholds:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description: |
+      JEITA soft temperature thresholds (COOL, WARM) as raw 16-bit ADC
+      comparator values written to the BATIF ADC comparator registers.
+      Example: <0x5314 0x25e3> for COOL=15°C, WARM=45°C.
+
+  qcom,jeita-hard-thresholds:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description: |
+      JEITA hard temperature thresholds (COLD, HOT) as raw 16-bit ADC
+      comparator values written to the BATIF ADC comparator registers.
+      Example: <0x58cd 0x20b8> for COLD=0°C, HOT=60°C.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+
+allOf:
+  - $ref: power-supply.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+
+    pm4125_charger: charger@1000 {
+        compatible = "qcom,pm4125-charger";
+        reg = <0x1000>;
+
+        interrupts = <0x0 0x13 0x0 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x12 0x3 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
+                     <0x0 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "usb-plugin",
+                          "bat-ov",
+                          "wdog-bark",
+                          "usbin-icl-change";
+
+        io-channels = <&pm4125_vadc ADC5_USB_IN_V_16>,
+                      <&pm4125_vadc ADC5_USB_IN_I>;
+        io-channel-names = "usbin_v", "usbin_i";
+
+        qcom,jeita-soft-thresholds = <0x5314 0x25e3>; /* COOL, WARM */
+        qcom,jeita-hard-thresholds = <0x58cd 0x20b8>; /* COLD, HOT  */
+    };

-- 
2.34.1

