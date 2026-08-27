Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E894ADD96
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853165; cv=none; b=HjgXUYl+5sZyI9nG+wHu87EeRjB5N7xQImdP+IRFjOyzqBSCTuFwvX/2JvbUAh64YMxwLNmetRXxcb9KXCcetTOlXmYq0iNB9dq7UyJxH20kI8faz5YIpRyu0joFXTrAY0var8kVB6cxhTEdMoVCUIDe0P1CdXFXk9kKdAWZxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853165; c=relaxed/simple;
	bh=9FPCV87eitw661yJc7gqbrscj5MlCzlDB1E+PFlfCyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADXaLQlZZoNh0y8nwkT3sjLMjw62PvC/9zx1XRZYtdvag1vzoVPauk0/fMHMiRVGxHNixBRsdYD6tK1/2quEVRw/Q+gcJIWqr9ADwHzEPLFQ+rDvGyJwaEKm05xZnYYFJVXm0aRPTIiRNUW84IXsGSK0RkO4699N5SIWn0IuJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RZBq8IFp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=feud1py8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZBq8IFp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="feud1py8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXcWC541126
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XYHgBCRZLEB3XoVwSokcAPnaY99rEFsjH7u+mtUXlls=; b=RZBq8IFpwxbYDmxG
	7Sos25G/67+VZyucyv805rbaSQqzgdPQE0d39PcfnmI3z/qArTK5hkVjx/2H6794
	1GrbWk88RfDRlW3EthG891c65RFE24x0FiyMLDm0h4ffaCMklQ4DQBV/dlQg9fse
	YH9KKETwt1l3TMyFaAIOSvq2P4TyfRH9gPqoX1aJH+l/kn0C8N2FJdGBvIWNqL3m
	B28ppjKOPW/W29h+a5wlddmaQmc7anG8d19YHf9jiiG3AebB7Rnfrz5KsREDPGvm
	UVppY2oZ8eTWzmZ4FVmHwAU0ka5YFvd1QRr5x5gOECW+6rOBt6aE1xr1P1vpjthB
	LDAoWQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee0p76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso332901a91.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853162; x=1788457962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XYHgBCRZLEB3XoVwSokcAPnaY99rEFsjH7u+mtUXlls=;
        b=feud1py8P77nX7sSRUU6GgAao9uXLOjJeJmfLoyAVlNZUGC4EAKyGFq1IA/pNFNka9
         x6+a4frGMmt1uuOp007C+JMF9MsIRprQq15U/9yrL057AM73KyW6fbZaZ/vu0KhmnWuW
         aWtnkAvJrZfq+EEMfz9HYNC2td42dF7OvOi8JNoafvGQFEAESdwZTU+X08DfZ4YQSFoe
         FLlo2uzQ3mYo45Ij5VrSC2fPBMRuz+4sgkBLukixhs0Jm/ydYIj4uAnvLAxMqJubmlLO
         2auEbKoB9xgTp0atP3n6C+kGI72iAV87j36TWrZktZsYm7T0sXRmFYaU+5P8s1I0r6xL
         x5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853162; x=1788457962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYHgBCRZLEB3XoVwSokcAPnaY99rEFsjH7u+mtUXlls=;
        b=BTZ6bL+zDSiNk8vjeRrgzpxad2C8BhTc0TMHjX4lOux+Is6fp7SC7sMY3wxpVIGpvC
         idkemcmJi84kISSBDKht3oalZZLMxwNMa7ryK8kFAZ7RL1RsRs6YidAr/E9c43YdUVTP
         9hjp0l1Kl8oQawePJiWBCDN48WATpX32+1nrLI3vX1wwRL4Q1x1zX+WDQvuhCRfMEwTg
         75vXYNqEd/zRe5+EN+JM4Q1vSkxAxDuQFv7VKyVRu5EUquOudkXlsnWNPQk26y3IT4CH
         VRD/VdySD3Qpe6m/Bpn3Yl2vPAGgASAvqZUaz2AJ+DBCJQQ0QqD3eVSUPreU8wkBkWiH
         M07A==
X-Forwarded-Encrypted: i=1; AHgh+Rrl0VpoUZmdcVxjJ5je1s5VvHYK2Jq8RQM3nMQzhPa55lzYAp15wtogUdNSR2d+/yLoPSDdDn5vqg==@vger.kernel.org
X-Gm-Message-State: AFuF++mVi0sNdhJnGqr0hgeas6Yr3rYVYDPq1m5QQDgnYz97GNkYulWs
	iO4aYrYhdXh+D6fJEjAlLRiTApi+U4ZLpeoLApHsUFSUUUfwBS2JqWrZCwgFUD4Yh1xVG3BJ6+l
	tcyGrIF0dU6TQ/0DT3ts+UTiulPikjMbSS6936muJ1cBx7c+hiVDdj4dFFm52QA==
X-Gm-Gg: AR+sD11/hDTeSk3BeA5GsphcQPEORGGmVn6w/4OLAewKdjvNEiGmjOhufM8UQY3ERH2
	LdQVrmTUlcxQ1Ob/9HwWteBMBQtUrqMUYueTjaCedfQGPd5FYtpGp+3Yz0BiDOTasMWnUPx88mB
	P2HVzz0Owdxuwa6LRArSqT6mS3Bt/lRJR8YvMTCL/GVwWvQNApMoj55AVaHYWvHHTG4VOrFfIkv
	7TiB4tMNrawwDMvEXP8TlMDH2MJLXcGwJP0rWGLGPGLJJpX8s3IvBEUjgoK+OqvxIHVnAwf3Uru
	9xoY3SanTgQ8bHQPqyuW5nQHfa/dfIcpJIJPLQTd7NDBaqP4xxtvrjvHxJ7q9Lf75govmpEobfG
	FTkNq44D66m8MHykDGNL54DnG6cuyMYbqHpnUccRl8G/SvpFZAOlV3Aa+oUbVak3NRo64pPdMiO
	byhb46TnsGrCu7YKMfnkhl5rg=
X-Received: by 2002:a05:6a20:6a29:b0:3d1:be60:281b with SMTP id adf61e73a8af0-3d268ef9eb5mr1275241637.15.1787853162233;
        Thu, 27 Aug 2026 10:52:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a29:b0:3d1:be60:281b with SMTP id adf61e73a8af0-3d268ef9eb5mr1275086637.15.1787853161631;
        Thu, 27 Aug 2026 10:52:41 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:52:41 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:13 +0530
Subject: [PATCH v5 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-10-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=5749;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=9FPCV87eitw661yJc7gqbrscj5MlCzlDB1E+PFlfCyc=;
 b=TY+V8SFVuEX+OQTKe4e7vYI961JtP+1FaDJZvDP3eLd8vPdFaIU9/VXdgz/qjVw2ALhuQ2IEm
 h6Syujh2JvoDrAoaczWfiqajzvI9Uj9OatzbmK3WIOBVqlxUw9NYmGh
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXwxQDROdLS+Gl
 H6r12tsUHCl8UXfXVIvHOcVOUywiStNK2GJdQV61yLk19VbDFo/KeHKk06SXvQNfEhxYuHlNE0C
 VpzEWlXBxk+LIm0CR7WpRDvVy3bS2nqycGXI2j93LvVYQ/bwlrkymEA90cM8R29BdlpS9WoTs8p
 pPQqwmDi6/tC55PqCEUs0H5lb2DrzKX6nGoAgxPksoR3X/vDwKUhXQJkOqGQmZS4JmsLnzMtHZq
 HSOPRAYhCsfiRiALacf8qS4kJBHMb5p+o/oAhhz7z2j/Xh1TdjpDB4ConS2N6zgW8u+VUYVhm8W
 FdT6QGCsuLdLPL5drIrwcE0JS+DN8N4W9UbgXs6L6TraeVmV05DLI0Blhy5iqTxvypBiv+uj7rP
 LTi7vQpcYLkUXIE/doCiq1MEAlVhqvwTRqz7ZmO7wtX+JBA4MAcYmEhBeX7AadO/ZBAcPpfWthK
 6MrnLbYvy4v6VrLaQ7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXyOmX/Wa6kA3W
 vxB2CfNAnhUOLB+aBIW4WLvgQOxWn5aKlkHJHs45H0KJrRQnr0YHaUfmLTMQ3OOWJoVeLEIY/sC
 61MYhPJvmRFFZ3Rl9zsagO8WTXkn8yM=
X-Proofpoint-ORIG-GUID: wjs2o0IU4NRtPXGjt0t5MRcfOfgvCDTz
X-Proofpoint-GUID: wjs2o0IU4NRtPXGjt0t5MRcfOfgvCDTz
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90796b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=PKuh8qK-LUMqOkA3WUgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Document the Global Clock Controller (GCC) binding and associated
clock/reset IDs for the Qualcomm Kuno SoC.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   |  52 +++++++++++
 include/dt-bindings/clock/qcom,kuno-gcc.h          | 100 +++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
new file mode 100644
index 000000000000..7ae37033a1af
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,kuno-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on Kuno
+
+maintainers:
+  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks and resets on Kuno.
+
+  See also: include/dt-bindings/clock/qcom,kuno-gcc.h
+
+properties:
+  compatible:
+    const: qcom,kuno-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active-only XO source
+      - description: Sleep clock source
+      - description: PCIe pipe clock source
+
+required:
+  - compatible
+  - clocks
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@80000 {
+        compatible = "qcom,kuno-gcc";
+        reg = <0x00080000 0x1f4200>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>,
+                 <&rpmhcc RPMH_CXO_CLK_A>,
+                 <&sleep_clk>,
+                 <&pcie_pipe_clk>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,kuno-gcc.h b/include/dt-bindings/clock/qcom,kuno-gcc.h
new file mode 100644
index 000000000000..a237b25a061d
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,kuno-gcc.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_KUNO_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_KUNO_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_EVEN						1
+#define GPLL2							2
+#define GPLL3							3
+#define GPLL4							4
+#define GPLL4_OUT_EVEN						5
+#define GCC_EMAC0_AXI_CLK					7
+#define GCC_EMAC0_PHY_AUX_CLK					8
+#define GCC_EMAC0_PHY_AUX_CLK_SRC				9
+#define GCC_EMAC0_PTP_CLK					10
+#define GCC_EMAC0_PTP_CLK_SRC					11
+#define GCC_EMAC0_RGMII_CLK					12
+#define GCC_EMAC0_RGMII_CLK_SRC					13
+#define GCC_EMAC0_SLV_AHB_CLK					14
+#define GCC_EMAC_0_CLKREF_EN					15
+#define GCC_GP1_CLK						16
+#define GCC_GP1_CLK_SRC						17
+#define GCC_GP2_CLK						18
+#define GCC_GP2_CLK_SRC						19
+#define GCC_GP3_CLK						20
+#define GCC_GP3_CLK_SRC						21
+#define GCC_PCIE_0_CLKREF_EN					22
+#define GCC_PCIE_AUX_CLK					23
+#define GCC_PCIE_AUX_CLK_SRC					24
+#define GCC_PCIE_AUX_PHY_CLK_SRC				25
+#define GCC_PCIE_CFG_AHB_CLK					26
+#define GCC_PCIE_MSTR_AXI_CLK					27
+#define GCC_PCIE_PIPE_CLK					28
+#define GCC_PCIE_PIPE_CLK_SRC					29
+#define GCC_PCIE_RCHNG_PHY_CLK					30
+#define GCC_PCIE_RCHNG_PHY_CLK_SRC				31
+#define GCC_PCIE_SLEEP_CLK					32
+#define GCC_PCIE_SLV_AXI_CLK					33
+#define GCC_PCIE_SLV_Q2A_AXI_CLK				34
+#define GCC_PDM2_CLK						35
+#define GCC_PDM2_CLK_SRC					36
+#define GCC_PDM_AHB_CLK						37
+#define GCC_PDM_XO4_CLK						38
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				39
+#define GCC_QUPV3_WRAP0_CORE_CLK				40
+#define GCC_QUPV3_WRAP0_S0_CLK					41
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				42
+#define GCC_QUPV3_WRAP0_S1_CLK					43
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				44
+#define GCC_QUPV3_WRAP0_S2_CLK					45
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				46
+#define GCC_QUPV3_WRAP0_S3_CLK					47
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				48
+#define GCC_QUPV3_WRAP0_S4_CLK					49
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				50
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				51
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				52
+#define GCC_SDCC4_AHB_CLK					53
+#define GCC_SDCC4_APPS_CLK					54
+#define GCC_SDCC4_APPS_CLK_SRC					55
+#define GCC_SNOC_CNOC_USB3_CLK					56
+#define GCC_SYS_NOC_USB_SF_AXI_CLK				57
+#define GCC_USB20_MASTER_CLK					58
+#define GCC_USB20_MASTER_CLK_SRC				59
+#define GCC_USB20_MOCK_UTMI_CLK					60
+#define GCC_USB20_MOCK_UTMI_CLK_SRC				61
+#define GCC_USB20_MOCK_UTMI_POSTDIV_CLK_SRC			62
+#define GCC_USB20_SLEEP_CLK					63
+#define GCC_USB2_CLKREF_EN					64
+#define GCC_USB3_PRIM_CLKREF_EN					65
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK				66
+#define GCC_BOOT_ROM_AHB_CLK					68
+
+/* GCC power domains */
+#define GCC_EMAC0_GDSC						0
+#define GCC_PCIE_GDSC						1
+#define GCC_USB20_GDSC						2
+
+/* GCC resets */
+#define GCC_EMAC0_BCR						0
+#define GCC_PCIE_BCR						1
+#define GCC_PCIE_LINK_DOWN_BCR					2
+#define GCC_PCIE_NOCSR_COM_PHY_BCR				3
+#define GCC_PCIE_PHY_BCR					4
+#define GCC_PCIE_PHY_CFG_AHB_BCR				5
+#define GCC_PCIE_PHY_COM_BCR					6
+#define GCC_PCIE_PHY_NOCSR_COM_PHY_BCR				7
+#define GCC_PDM_BCR						8
+#define GCC_QUPV3_WRAPPER_0_BCR					9
+#define GCC_QUSB2PHY_BCR					10
+#define GCC_SDCC4_BCR						11
+#define GCC_TCSR_PCIE_BCR					12
+#define GCC_USB20_BCR						13
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				14
+
+#endif

-- 
2.43.0

