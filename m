Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344504C8FF0
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328632; cv=none; b=ebLjOEDah5yniQuo3PT02lBaAEgWhRJ2iRYgAe+ALcwLjZd2Or30CBMGYIRHRERYvY4D8MQFIT9lWOrdySHiNNyEXFw/igU5Lk7b2Lae8J3iFHKyqQI0LSjaBFjjQzuKvVYrd6k+2wCmx1jks7mh47KBSoYiNZBLbsuYBPUOHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328632; c=relaxed/simple;
	bh=9Fecwe0sAktGee+deC69QVwT+mIH7oP8T6NEsor/Km4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P61oxR6vZ9nfsex7OXL0sAnyD9uKBBUqzkCHVfRd4nqJieqAvUAUPHNjv35wxxNA/xwOEBW7wEJn3uvCjC5aSKbFbVFviUPvNZXwV2IGee44B0zPz2n0l6ZoJ7cMWFPkrcT16YCEymtk6kfrmVwkcNDU+q/qwRtFm1f0z6Y1Hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PPgLb3lw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BW2AgI+p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPgLb3lw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BW2AgI+p"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmRuK2404364
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yS6bCkgNl2tfRL+N0AQpU6w6x0P3yKp8A+VMwA4EIUo=; b=PPgLb3lwYUJG5+g0
	fvDX8DuCMbQHqT5CJKUFNy3H/gjJu01HE+uh+zeAB7nNSuRFJ38rJNbXeHWJcJaq
	B/kzKAoh3QkAb85xB1RribP/fRNwjngplIQU9P/PVICnayAvGyw0c79BKcpljzIL
	jJyrxP1kQ0LEnnsVnT30ptJYg2CAqWXamT9Bs598DixiGdiKYKbciUz67nDpVDoc
	woxYhb6L46ftHDcHOFr1Tbmzzdd1Sk1iHW6/uPxqo68rnyb/ULHR7cvJxGVcc9Ea
	P97ZMserwIs6kytqEkLqfBBBcKUottzi9cgsUEKYiYaLGPvYDHucNrmXq2G13VVV
	ED08Aw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6d06b3bm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:10:29 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab4af22d09so2001984b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787328628; x=1787933428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yS6bCkgNl2tfRL+N0AQpU6w6x0P3yKp8A+VMwA4EIUo=;
        b=BW2AgI+pKJ+yrSCLaYhO+ijXGOT7ynriX9X+pGmY72d47kU0B39NI69hNMduMSPoas
         tpKCuWTiBj5lbNfgbOd+v8azZoSwaoGBbOaOBzGgzhW374P33de/8Kkp10m/NDr9hw6Y
         918fAhIMmbw9T0eKTDCufqwyRT08CiiNf6Nr4VfZYvoo/ua0ZqGmDq4+25y9b0HcJKcU
         mLD13XPUfHysxf/vGzA5jyf0wIjpQ0XlnJ7JAUwp0NInVQ75pIlQXN6LUIVt53JSuCLv
         e3lbl7d9PXbGt04GOv8TwKpaBQQI3NVKgSLp4hakE7CVXVvuycUlqocmSRyamftJSKST
         q0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328628; x=1787933428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yS6bCkgNl2tfRL+N0AQpU6w6x0P3yKp8A+VMwA4EIUo=;
        b=p2HJVERGrlFE1nswMutPveMPqZKH3exKMcmqkoGqEULsx41UySvcZv1hHiZQylRLf7
         DDjQqzoEn1QmXdZ2BFO9HEJN/4bbajbzFs0RbTsOzbR+rWLOyZE2jWXtNLxVQgyu8Y3k
         oKwOjXYfjjdZ4t676aUAIkttmZv3CS74/DAXoCy6b/uhUWdgCCtvahMc/rTqNcPYWwsL
         eFv42k0BKTjkwlym2S7+PpGLI5qJmQ8gr+e1eNHjhRIgdufOHhGchbQPGui/HF+Pg5bb
         oHjX3PFcb8m5/PrAuS2EKjTCCOArvb9GoASzFVV2DICXieE8uYz9Jf1kwrGXLcNjTLrV
         oGhA==
X-Forwarded-Encrypted: i=1; AHgh+RqcAgdk8LJTFw9P5UHpoF8OAA1OerquYZqFDwSCuCQ13iFc5uUBeMcKq3pTh8cNSVvLwzjpv7IV5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMhPSj9WUqpL8x98oLGo9Ioqx0/rdWovJ1tyPauINcsBzJ6mB
	3o8lNd0H8jXoFb5H26wXVRmCpvlSpwnUzZe+jnnb7YETRP5KI5vjtpdXovtPjbL8Jd+FlJ751bP
	w8QaHX5JHLsKo8h6yfBqazhEzemWQWO9kcvfVXmGlh49bTp7aER7b0SkzjOLBaA==
X-Gm-Gg: AR+sD13rMopZL4t8/4s/MKuTV/ogJGEPl+nFrg8ptzFP7+cK0J//x7Ow9E5r1AhmWXY
	iVpr308BIRqCVNfqAI87hsau8iFFn6ql7SlGfmdhD8+ntS9uJzih/SO3SViL/j4Affw6N36cuXY
	tNaqF1A1QHAx7hxfM5/87AmE3s2jjdbva0FfhzDzUhOvDn4TwzvAxjLisCg/Hg7HtYqJ/Q+gunL
	n+zIuG5ZnVNUW4BRBxqKplta1Be/slpN4uPHNzBy7EY3urFGrvuJQJR7ombq6jLgrEH8ueOMnj/
	IZswwHrNYAqCVd6dFKeGJDM1iMEZafWM7urL0+r49+U2vn1T0WAnTDcBL6BnGj+RwGK8tyUFyak
	GO0LC87f7lDoKibnqycFFco1VBxtgMn40pKKTMz+l2oWg6BSmB0ct4US+zTL1TsHnCURbhLB0mQ
	1PBfVRnGE/9tz5UIhUtrertbY=
X-Received: by 2002:a05:6808:4703:b0:4ae:f5be:fe30 with SMTP id 5614622812f47-4b2ef468b49mr7770381b6e.18.1787328627664;
        Fri, 21 Aug 2026 09:10:27 -0700 (PDT)
X-Received: by 2002:a05:6808:4703:b0:4ae:f5be:fe30 with SMTP id 5614622812f47-4b2ef468b49mr7770153b6e.18.1787328626352;
        Fri, 21 Aug 2026 09:10:26 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm4804321b6e.13.2026.08.21.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:10:25 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:39:01 +0530
Subject: [PATCH v3 08/15] dt-bindings: pinctrl: qcom: Add Kuno TLMM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-kuno-soc-support-v3-8-196e2b306368@oss.qualcomm.com>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
In-Reply-To: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328540; l=3999;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=9Fecwe0sAktGee+deC69QVwT+mIH7oP8T6NEsor/Km4=;
 b=Q8ZMyfCR02v6uEtw3VdSdFS9dyKXekOPxO3TtqHZoj3K4816tbpTbhYqHkkim/lnsQ8o+qV+P
 v6BsZGvbu9bC/aQR+sWrFAmb9kEc2bUcNItHHwaqPKy3uBIi4CPkbRG
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXxPANS2mQAIJA
 OTQbvhWWg8LgpAD4ylFPMJWpQLkI0iDobHLmeFBYabRxeUYCYihXBRkIkHXNkdKKvjAZZ4rhlTY
 FbSKV1Z9ac1f0tfwiYDR4aju1wUnXe/5/rN55Fqf03e68MkQg8OkxmjVNJQii0F1opZ6Mw7Thuj
 1gGqSEUE9W1bMal8CkevjVc8TSE1Ddf75CBTCnIosHcJsbawhRbBH3hpyaIZavKv+pK62j7DvLe
 jhFJTASjF/jH9p3FfHPyn+EYHkzAHv4W5UCHuypA26gFJAn/eaJrdm8YE/wLJWCGgD2NVYy0I7L
 Yj+mLsab0jykcw6aiyD/73XByq+IfXdAsJLRQMopPKQ+JfnXLMKGYC4tRBYMITTaAhTeiFOwjgG
 DfmGn0VWmDDPbXSDHA85M5hkfjRjsfDL4Dx+ik4eKoklwa9FtVaMsxE3Lc7FEAjeH6KYRWwc/P8
 e2w5I+6xThm4I6LaubQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX1h5McgU7nN8V
 hiXPHszXhAaHwPr3rtm/52nNoftoSAmy8hd1DyJqDeCUtZgDUQfUqrQA7Zx4BAiM0t8kjsvxbvP
 7yf+5lsLmaLSfI9FsCb9sQeNg76ODic=
X-Authority-Analysis: v=2.4 cv=DdQnbPtW c=1 sm=1 tr=0 ts=6a887875 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=CaveSyEksWnKhASb3GUA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: dxd1upna-2MltJd2JU37i4aicRv6S3eK
X-Proofpoint-GUID: dxd1upna-2MltJd2JU37i4aicRv6S3eK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

Add device tree bindings for the Top Level Mode Multiplexer (TLMM) pin
controller block found on the Qualcomm Kuno platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,kuno-tlmm.yaml           | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,kuno-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,kuno-tlmm.yaml
new file mode 100644
index 000000000000..2250526dfae2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,kuno-tlmm.yaml
@@ -0,0 +1,110 @@
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
+                qdss_cti_trig1, qdss_cti_trig1_mire, qdss_gpio_traceclk,
+                qdss_gpio_tracectl,
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

