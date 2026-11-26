Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690837;
	b=Mtcq4Nkvtbae3L4mnlJgjapao5bJdZRQF1NePvHghGdCmtsh1MyUAnmvWSi7UPX8SmLk
	 oZh9MUuOBAJ+2IvxKscdCXdvtjHg0A0c32PsC5pg5ajh4E/ayGbga/umU3+4tnSt0YbHY
	 x1JPfd7pYLOtU8X390v+C62lyTifuY5DddJiDwBZK9JOvxZNAsoAj+xmvuFF5Avd+Yghl
	 6QU1d5pj3oyJwQhKxxQtk9p8OoxPbY+y2VTVoRxMgINkpQhpLxzlIV6x7iFrvD3+CFM9F
	 yA26D49uD1wbJYEG+siuTnVhcz185yF3pPTRRtDHWxsMiEWl2UWr8Kcbc7aKjdZ1KEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690837;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bAkpBnZvBiH/A2z/IDAE1d3gkLalf0A6Y5L46N6u7zA=;
	b=CrrSkWhLs6pkgEeQKC20aOCCiH5VVvsHkjjUpH8/Y0fDnzKcPLmt7I09zMawa89/oS7K
	 SNbwczEmBfs0nxPQNkC3R80wvqBjegy4/FdPS1GsvaF8sCxotFEo1Ke5E0tzdyMd+w2UD
	 Eu5wcr2FhIpmtGGwwZ33g9MXKhewOz14oVJ8qvsLNeY3r4GLspCTcFPBtD+FHgCvKTUuG
	 VL5OHqMFh/JljXE8s+kyIo1y6KwtxDVymSmShMj4jCgagrqlpuLbAbsUExXtlvARPc2Q1
	 ggt+q4/xIDubelL0G9kNPprkR91jk3A9dqyJ6LqZfyeW/kUb98Y23QjZabuwcKj+SGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwy80TtI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dMoKvYcy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CF606A321
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1CF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwy80TtI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dMoKvYcy
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQAXEnt3348333
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bAkpBnZvBiH/A2z/IDAE1d3gkLalf0A6Y5L46N6u7zA=; b=fwy80TtIGhc4VeSu
	s/5RoI7VGxBPpvJuw6RovybbXd3p3ME60tnoxYEsaIxn/OHJAdLfGe2tw0Tj3XS0
	PlbpSUwi+MXk38SwMQbT+17UXkmRCTsICtEMU5NZzfi9vv3kBGe/yodulrdEog0Z
	m3hI2YCX+kE+7vTA8wPfPE587YfRxJy1u5qQ0zS+39gvqKjolCxE2SvnmScFwIv2
	XKEToN3cFc7dRGVw/HyRhSbEnmlFQBSAiFcAzukFOx/9ezqYzABsAIgxIIXnvMGW
	HvLSN6iEwt4mBn9zpePHYwwLCt5ueE2AC9ck4lqY19xc3rmaIZyugtx7T63HAjGl
	zE1qvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rh3kc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:00:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed05b3eaecso62859135ad.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795690835; x=1796295635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bAkpBnZvBiH/A2z/IDAE1d3gkLalf0A6Y5L46N6u7zA=;
        b=dMoKvYcyDcI8VXEvcYuLay5tHiLI9Ri+YHdxpPdm1hIdjefslUq5NYcuoCpBg6LGD4
         RpGeDtoeX9rl3GpNLeYIm/rMsj3S5HfeVXJYzu4OgJY/rsF5V3bY6g9quUNLn7W5vXq/
         PP0i6S9BkqAK2n5DIkvLhqs9cSi1p/WzD6VLlF4rD+lc8U4WdxwsSJlMznaOrcZnl1lF
         u1U7BbpPNuCoF9q0mx7ELjG2CsQPstIDigGxGHIibixvQeuX6X2IqSWkROnos2XUa6ra
         QUnuRI5INkWfKe+O+xzmyszQSmZaB1yjdHxMQ9HUtQx5acsw6aAHBCeZc407OHPs05Xv
         hRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690835; x=1796295635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAkpBnZvBiH/A2z/IDAE1d3gkLalf0A6Y5L46N6u7zA=;
        b=oeuK2cT1anP5D890oCWSLzx9aZUW0iD5zt5reQ6fmDklQWgvG+ZVzAWyGxK+2LXnqX
         8gM9N1H0sq9tTWhW9424uJZCcuuUaKzkd0nye8w54ap3D0+p/O+ZKaekLTfnIO7KHzkl
         m07P2L1/qEhHs/ihyKp41nP7USObVbr2ZM/Arqp5871JevxX1V6Vo7Pq3cDNhLIs96W4
         A8YPRlQZ0bH451KSK+hLUggwzygkKH1wU7zh6jGJf+/YvFXsyl3oH66EGKfC6W3ap2Yo
         YWlfEIv4aS9BdP60qtK6GhSwEY3AJFqIeQDqumcpwT7HILycj5CgA18/ezuLFZp2i4yS
         G+yg==
X-Gm-Message-State: APuU4Z8rZpk7Ma4QjO3sK1KlEAo8KtNDz3AXJUGwRwdorni4FQnMZSTQ
	fXhajtvm1EpyU1qjIXQK0eIvFaNGpcplS++ck7OGFnxIwdKvfo/Ytas2JdXLQOHKEJUgr15s5Cw
	Hah6Pr1D0rvok6pmJTNvmswjuO9nEZzQ+bRAO6XZXE489HcA0gd5+roMcMrjvOQ==
X-Gm-Gg: AZFdTZelvuLj4wgny9NZCSrmJRR6tA5KmQMDYIgRNoDqsgZbVsXVLfb8KTE2Woy5te8
	MKmnU5W5BZ+EyG4yTSuCkCwXrSKsr3tDbbOS5u7gFMi70xu/vsCw7ggq0ad2NL/Ij1LxTzapFmx
	FNynpO89mQDdXDHjzyTM8tNwCjMoabF1Sft9EuuNyYliPyy7WcpAFOK0Uz/7Wcrj8xr+zRF/tC6
	W05wAatGOib2rkEVys8Jfsd9uNAoIFRvGof2Z8QJTtOKjAegC/E25so+KZw7MpQ6/Ej44vd3gSF
	GsxkSSj56E8eaXFnGqi5x/ZHJRD/KsUdidyBY2LG7h7v63RnSmCZipnhRzymXb8Wufijs3sj4Mc
	WTHaOQkuAoFEO/g2OE5YZcphO9fbi6yF9rHAYPgjsEfPybXH2hNEJgkhJ1KvS+8WOoKTh6uaUeZ
	Y=
X-Received: by 2002:a17:903:2c50:b0:2e9:64b9:a330 with SMTP id d9443c01a7336-2f03f17d2ccmr205395955ad.11.1795690834578;
        Thu, 26 Nov 2026 03:00:34 -0800 (PST)
X-Received: by 2002:a17:903:2c50:b0:2e9:64b9:a330 with SMTP id d9443c01a7336-2f03f17d2ccmr205395245ad.11.1795690833868;
        Thu, 26 Nov 2026 03:00:33 -0800 (PST)
Received: from hu-raryan-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm101400615ad.17.2026.11.26.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:00:33 -0800 (PST)
From: Raj Aryan <raj.aryan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:30:17 +0530
Subject: [PATCH v2 1/2] dt-bindings: power: supply: Add qcom,pm4125-charger
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
Message-Id: <20261126-smblite-charger-for-pm4125-v2-1-20656509518b@oss.qualcomm.com>
References: <20261126-smblite-charger-for-pm4125-v2-0-20656509518b@oss.qualcomm.com>
In-Reply-To: <20261126-smblite-charger-for-pm4125-v2-0-20656509518b@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mfd@lists.linux.dev, Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raj Aryan <raj.aryan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795690821; l=5273;
 i=raj.aryan@oss.qualcomm.com; s=20260507; h=from:subject:message-id;
 bh=AUHf3tX4cjhQLgpG36hMqGc0GVm+wfhye03EyAkWlc0=;
 b=ENRMrEvMGxV35m3XI8+xe//bvjIErvUP53yqd5vdBF8qQggrPqWUlKqu+8gSsymAdOVlKMjby
 qxQCtBCkqdsBoMKf993R8wYV/QluSmaYt8E1qb3SO/jYCH4gZEr6i/5
X-Developer-Key: i=raj.aryan@oss.qualcomm.com; a=ed25519;
 pk=NMkZ/eGFLSObYX6FfysQiuEElPoUYghk7+2Jtc4VEBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX2pGrmFd508AK
 efKZ5aQ4Db9CyOcRmiPqYuqK/rZ6Q9UM2PeTQOBimKDJxeI/jM45mFAcYUgjC8gQOa0Kn0iY/ep
 hmwKcX0+xWwCm/PVlaRBNDcx+gIrfwkTCKvteA6DSsZ6UZA7mYKA/FdebiWjEJXr3g7bkwyVe+H
 ABFve8Yn2IsTMq2n+IP5STs7eLMMzpmMUVzR6TaypzEJG007y47L1e9OwsbrtqEwH5O25aqsOop
 ISw/tapeVwFNHyH0dJz/CmHyQN+dFy7dVwwzbV91VgsLFTgYeeA9W0rIdI4BZbgNCodofSRpQZZ
 XukieSJ7Ai0TG4tNWyyIol+VPI1GMPfkxhpvpkU14Dl1WDlxk8pGJVc8R4h0xu/oGeoMZ7a1J23
 VQC2e8h2XJoBn3W4xogf9BhjrIbTqgu/TDVdpVCClwD5bJ7R+fsFmKwZvA4qj39BykGBnv8D5QO
 tvxytuhdYxsU56eoZGg==
X-Proofpoint-GUID: -4qNOCbAVEs8Wo3uIllEp3PHGiKI6ceg
X-Proofpoint-ORIG-GUID: -4qNOCbAVEs8Wo3uIllEp3PHGiKI6ceg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX+V9EBOqTrZDm
 33pAIqQ7szhrBGBaVbdQHn3XmGuNlBOuutsOSR8acI2BUwBLpc1/vWbP0wjgCnJwfvx1I8xTVnd
 WOeI6PROVLElpnrs8OR3YcQy+MTbXdY=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b081154 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=qXe9l9IMIpBVqIDzQAMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260042

PM4125 integrates the SMBLite switch-mode battery charger IP, which
differs enough from the SMB2 IP already supported on PMI8998/PM660
(separate SPMI peripheral bases per block, a different interrupt
set, raw ADC-based JEITA thresholds) that it has no existing binding
to reuse. Add one to describe it.

Signed-off-by: Raj Aryan <raj.aryan@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   1 +
 .../bindings/power/supply/qcom,pm4125-charger.yaml | 119 +++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 7a889d888383..8c8eec87a765 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -160,6 +160,7 @@ patternProperties:
   "^charger@[0-9a-f]+$":
     type: object
     oneOf:
+      - $ref: /schemas/power/supply/qcom,pm4125-charger.yaml#
       - $ref: /schemas/power/supply/qcom,pm8916-lbc.yaml#
       - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
       - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.yaml
new file mode 100644
index 000000000000..4c88d836355b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.yaml
@@ -0,0 +1,119 @@
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
+    maxItems: 1
+    description:
+      USB input voltage channel (ADC5_USB_IN_V_16).
+
+  io-channel-names:
+    items:
+      - const: usbin_v
+
+  monitored-battery: true
+
+  qcom,jeita-soft-thresholds:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: COOL threshold as a raw ADC comparator value.
+        maximum: 0xffff
+      - description: WARM threshold as a raw ADC comparator value.
+        maximum: 0xffff
+    description: |
+      JEITA soft temperature thresholds (COOL, WARM) as raw 16-bit ADC
+      comparator values written to the BATIF ADC comparator registers.
+      Example: <0x5314 0x25e3> for COOL=15°C, WARM=45°C.
+
+  qcom,jeita-hard-thresholds:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: COLD threshold as a raw ADC comparator value.
+        maximum: 0xffff
+      - description: HOT threshold as a raw ADC comparator value.
+        maximum: 0xffff
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
+dependencies:
+  qcom,jeita-soft-thresholds:
+    - qcom,jeita-hard-thresholds
+  qcom,jeita-hard-thresholds:
+    - qcom,jeita-soft-thresholds
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
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@1000 {
+            compatible = "qcom,pm4125-charger";
+            reg = <0x1000>;
+
+            interrupts = <0x0 0x13 0x0 IRQ_TYPE_EDGE_BOTH>,
+                         <0x0 0x12 0x3 IRQ_TYPE_EDGE_BOTH>,
+                         <0x0 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
+                         <0x0 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "usb-plugin",
+                              "bat-ov",
+                              "wdog-bark",
+                              "usbin-icl-change";
+
+            io-channels = <&pm4125_vadc ADC5_USB_IN_V_16>;
+            io-channel-names = "usbin_v";
+
+            qcom,jeita-soft-thresholds = <0x5314 0x25e3>; /* COOL, WARM */
+            qcom,jeita-hard-thresholds = <0x58cd 0x20b8>; /* COLD, HOT  */
+        };
+    };

-- 
2.34.1

