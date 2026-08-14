Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B641D211
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692806; cv=none; b=m/+4m4eoYHZdqpzX4Z9NTyidCBDBdzHt87hmp5pksuTwsInWqhOZ1LN2q6saGT5CeaHsdly6xw2cD2BIQbCcofrimbZlfHhqHPylfqHKN2xXd4geG2GiCD28MAnP9yGG1anyq3L42gV+skbJMhf4Fldz2lEi7Ebsp3LyBOIJ6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692806; c=relaxed/simple;
	bh=4z/M2eUF++qMVVESopEVCO5xHLKHISN/jqlSOg71SV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OyN5h2fS7B0cvHd/+j16w4ZU6eGOwllN4KCoLT13370VJvexz+lIaqcI9lX1ytlXQyDIs8VTrybBcoO3hCwdNn0GzmfDd+vrfUB9jOSWt8MeiH9408O+//VRZqkyw7fkPzMt/pm4g33NMWaq3/anfUcgjDyjxbHSWG58rQfiQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JO7d7EFR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJX4ryXt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JO7d7EFR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJX4ryXt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QW00669257
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A3v6CEl22R3ZSvcqUczYoW5Tyuq2qb91XkxugMVwZ7o=; b=JO7d7EFRu2glBHAw
	bAN6yPdczbHuZT1pSDgP9hlRmEqT6vOP87+s8dHg4552v7Tk12oQLe0lIqbF4eKM
	op+GKvuYKB930gzHJ6FFgNUaBYrN+6lNPQJZih9uHF0xsuFfopszmdtxghveuzSe
	hgfC4jWrQsut9KLyUIJdFiyWKgoutmhpI7yCaQ1gUYaRUCBoe63lBNjHxHa43A/5
	fzysoF61a8zX/XmeAowlHubC3SrUHYe6Zi7suXXBP5Ly5q3DtG2VxR3/Ze2hVHQ2
	zWbBRU/2DtMYNstHb+mhw10DjMJw/b9p2FXY7wWP0mjywQCbB0PXYdNo0FXzQdkM
	w/WPcg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1uua8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so1045153a91.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692790; x=1787297590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3v6CEl22R3ZSvcqUczYoW5Tyuq2qb91XkxugMVwZ7o=;
        b=ZJX4ryXtAEghn+R46jGvq936F2ElKD/9vZ0A7Nkxx9x5YhrVSRpG4cxBqH5ZlDl0Q9
         EFIcU9qxdov9TUNI0JR6jFxhmpdHSj0v6rOEImQe+B5QkD68lBEj+E8OtOUzSTjqp7LD
         tgDt23wUFWbhwBSQqCI3NdV0wlsVpBss5oXM6gAP97aC3kE/3XGxzi1Iz0m5E7Nzyg7D
         g6w6bqUb2ZSMqJXQMfDHgf2kBqViTd0WRM7JLE77M38pIOMMVepTqEgbWYRoBFz3zhDs
         9JgUvsBBkSy89tHsm13vYm866z9cc7/QkN8I1DdE2Ce1rWOFISkTbkMbMmTBeHt4ZyXK
         GC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692790; x=1787297590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3v6CEl22R3ZSvcqUczYoW5Tyuq2qb91XkxugMVwZ7o=;
        b=O9SWPKKtOOmWA23kv1c6D0fWsWzgKjFuYTHoSH0Z2Qx/gqcwPOTu5nHgu93RlE+OBJ
         O6gzFCTSLta1FQLq0+A+xeKxT3HSed7OulEzkc2QZ2eeGPivCCnJ4vgDl0y7tRiiUHUk
         i3dNnnLwKTrsZ/nU4Q/xTfOb3bjVTOMEeVMls7aLMemEKnK1PaZacUHCJGj6sl0imdoc
         U6Q/kVmt2r9iyBfzr7Hri2xzmvbCAovbQTwxju0TGnS1AGgxbxKikGt1RyLIte3iu8EF
         sTPmK81L9mSyy+xOkD54PG9YKwryBYHKQNB1AqzGCIt/4n0LdAeDLKqNHbGGnm7+uUbu
         tJAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrExsPx2RVSq5KMcpAz9P7RhCJPosFswPpo4B+L6D7IIftwtQDFStKopiH29GYKoUc4Us72qVd8Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SPjJI5SeuxhUBL7Qv2P+F3O8nkYVLMWzO/xR6IyY1gSOnoix
	F+glVQ6Rl+qcNLw+UpBlmYpw/mkkZeUsgGA+PbUibJtuh/ByZC3Cpz7/qWWmfL5doPa+JQCzK+o
	KMmWFP1eQD+IHfu53NOYB0qs/8jPhw+P/y55ejU7hXBjMh+ubS5D+A+RG0h3grw==
X-Gm-Gg: AR+sD12EAhgZLrxBQzw2A6w645K3UwCU2o2XBJpMAR+FOlnWWRxmFwwfS+H1plZ5ziW
	y4FRM7cWOGY2t3VkZnvz7XnVLesiy0lOkuKOLGxpRn45csiRuB9FHntPYBGfjFxZqssj17h1tYK
	tdTJ/E9+IMR+pkaP7xwmVh+6nfPW1JchpRAv4NRsOoXSK+SAVaYYEu0vKRe9irZd/GONK6K6Pq+
	ZYomWKbBbkts26UXYxHOgScnqAx8UkKwBeiFSpkMHIIsv4sDqDYsKL1LVSnf02tyD01HjpXUWRM
	xIdbFiwGZDTtvD0K3J/rN1Xe/2mvTVoJC281JVQKxWKHWI04cBM7Kj956SKuoEQDgmOYd1JDzxe
	k4CookUrUH1VsKTS97qJxfdNMEfUrRRC/SAhfLIUpV0ceibWjuz7IiA4Te1HXeo7PdEHL64SmTK
	uDHx8+StTbP8YBJpj0ipvJJfQ=
X-Received: by 2002:a17:90b:1f88:b0:392:c868:35af with SMTP id 98e67ed59e1d1-3933bd46d96mr4390018a91.20.1786692789831;
        Fri, 14 Aug 2026 00:33:09 -0700 (PDT)
X-Received: by 2002:a17:90b:1f88:b0:392:c868:35af with SMTP id 98e67ed59e1d1-3933bd46d96mr4389986a91.20.1786692789380;
        Fri, 14 Aug 2026 00:33:09 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm1062280eec.26.2026.08.14.00.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:33:08 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:01:39 +0530
Subject: [PATCH v2 08/15] dt-bindings: pinctrl: qcom: Add Kuno TLMM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-kuno-soc-support-v2-8-3079794f0f73@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786692714; l=3960;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=4z/M2eUF++qMVVESopEVCO5xHLKHISN/jqlSOg71SV4=;
 b=hEeDgEgfigIgPHtEobpT5LzskiygxdZVnX2CdaOAWLjSjBFijGbnfdypOdmfi+V70J0wZrgYV
 9Uxtp4FCfLTAxs6dYTuBNUJPLrrVOKEgljY70GNM4h2fQK31poTO2zu
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: jg6ZGTV_D_cuPWwtnFFuWvG8MLlSxlxn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXzAST+UpR4HZK
 QrK/75MhVy72IyjT3R4GwtGU9nT1aoVljQMEB1N9Qc1qdfAFLmCRmpljz1R7DnHZgyBRuCGJL5P
 IJ4/7LIn2uexWQzoui0FjtdVqYSXR4lAoct79J0JYxuIZXJN4qmdLE/nPURclA+ri/t7C1DTxT8
 OD7N41JmBN1Y8yOJ3Bng8Z4bVcO172hBjGyLHzlCXUwJcyeibLufY3acIsr4kd9xzhNMhlZcVUR
 4ZhwKyf4mv7JtSsOWsuLrOuSeDr8xhXzYrNxTZxVsrl6Y6tUb5WbgJj+DsLKivyB6wSUZSBeVSX
 41hThUZzZadTch/yHzjf2kYvh45L4uFQO9OrfNyVQRUBZCyx/Vb93Ql2eJMlZta+AW7KW+9ajoH
 iYt8cL6L/gWk6eZlv7YeTejaDNoO7Mj+1kevWvhyrGscKfYAotimc7J8GaygLDPJIz2VCtOFH0g
 NaFlziHPClXOdkBIBjQ==
X-Proofpoint-ORIG-GUID: jg6ZGTV_D_cuPWwtnFFuWvG8MLlSxlxn
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7ec4b6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=CaveSyEksWnKhASb3GUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX6VoBtVn7ayYL
 dptS3dMZzg5qXLWFKI1BQQSt2CJSFJOD04yM1VWLMcs3nRu+dDq9sGLKgLAtoNSsEjeUwzz0WDs
 EzQWcKbpX94xWt5J7daGj20uhw6EFqk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Add device tree bindings for the Top Level Mode Multiplexer (TLMM) pin
controller block found on the Qualcomm Kuno platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,kuno-tlmm.yaml           | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,kuno-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,kuno-tlmm.yaml
new file mode 100644
index 000000000000..6db65d2e1c23
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,kuno-tlmm.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,kuno-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Kuno TLMM block
+
+maintainers:
+  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm Kuno SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,kuno-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 55
+
+  gpio-line-names:
+    maxItems: 110
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-kuno-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-kuno-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-kuno-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9])$"
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ gpio, audio_ref_clk, coex_uart, ebi2_lcd_a,
+                ebi2_lcd_cs, ebi2_lcd_reset, ebi2_lcd_te, emac_mdc, emac_mdio,
+                emac_pps_in, emac_ptp_aux, emac_ptp_pps, gcc_gp1_clk,
+                gcc_gp2_clk, gcc_gp3_clk, mi2s0_data0, mi2s0_data1, mi2s0_sck,
+                mi2s0_ws, mi2s1_data0, mi2s1_data1, mi2s1_sck, mi2s1_ws,
+                mi2s_mclk, nav_gpio, pci_e_rst,
+                pcie_clkreq_n, pll_bist_sync, pll_clk_aux, qdss_cti_trig0,
+                qdss_cti_trig1, qdss_gpio_traceclk, qdss_gpio_tracectl,
+                qup0_se0, qup0_se1, qup0_se2, qup0_se3_mira, qup0_se3_mirb,
+                qup0_se4, sdc4_clk, sdc4_cmd,
+                sdc4_data, sdc4_tb_trig, sgmii_phy_intr, spmi_coex_clk,
+                spmi_coex_data, spmi_vgi_hwevent, uim1_clk, uim1_data,
+                uim1_present, uim1_reset, usb2phy_ac_en ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@f000000 {
+        compatible = "qcom,kuno-tlmm";
+        reg = <0x0f000000 0x400000>;
+        interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 110>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        spmi-state {
+            pins = "gpio78", "gpio79";
+            function = "spmi_vgi_hwevent";
+        };
+    };
+...

-- 
2.43.0

