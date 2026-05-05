Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457448B373
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999286; cv=none; b=OMXUOEuquFz6nVSTQnbUmdNw2KseQtqOOaqli+hTNrZeeXwwxZQbwtHUlSTQaAlXze+f9BFqIp/OFHxHyIp+XclzpacdlZGTWaR8sczKLyaH8A3RSlzJLqoSstDNCgzZUy3nrGulVM1XYMHoSJFwCfyNckAFOgBXKumcAnpNaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999286; c=relaxed/simple;
	bh=m0faqyCrHJWc2tUqVULH3Q9yMRfy5zHU1Rhi9jAOmrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2MnpebaE8o1BBM20oay3Uf6qdTVM6eSII+JvCOZZiZhz0MS14gyQA1CotqnGYlWJbIo9WH1uqz6OX4KefQZ6I6rG8w+T7nelt4TpOCEGOGKIbPIerIhIoxegEwf9m+PFTzZyfS8LJVM/fFvgIR6vkJHMu3wG3n9dOGUf/1abDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G7+mA8s/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GjxE5fEo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G7+mA8s/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GjxE5fEo"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Djj463501672
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 16:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sBeBFB2zgnPp2cu215uLKYUsMzk16DEizzaozJqXl9M=; b=G7+mA8s/A9O7EoLc
	oBjg8lRfp1j2YnnmWJs0/vg2rjEg5frSnjGyddRTIEYRnLQMYhsg+Ygc7pXDq3wr
	ki0TirsrTH5jUhoU1YDZ9kMk9USHpBsv9YI3hINYOc1JD24bFqVUpBIAybbmAu9w
	nHV2z74uHoJJfy1BJgc3S6pgUr2aPfiAA4Pbdzng4XEIU5HIQnI+gFmKdmwn+tTg
	e9ktqqkxyDcUELfyE4e5agZdf5lXIz0ULp50dyH83bsmELud/LAsD+8UHTXCv6Ws
	0AXImQIcTSnVqSqAD04YdrGdA/Yh8CvYnbnAEFJhfF/lggWT6cZtAh0xau8CktMH
	esxI8w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqf8s1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 16:41:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354bc535546so5859605a91.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999283; x=1778604083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBeBFB2zgnPp2cu215uLKYUsMzk16DEizzaozJqXl9M=;
        b=GjxE5fEob4o3lz3JAxwGNHvYu0W6CHGkX/PXRPAc1T5iR3EZ1Sf4nxPYNdiArG/ebQ
         dks1chzO7ZP4ebpQ9IMHytfqzGRxG5Sh+p3/p5hdT5Xcbac+IUs7zeoCfLzFdq/723K7
         acBl2y7Zyon1r3KYQHBXeCLbfoh8nM4RX3fzximdTXP4ypkAZdgPKHGHoYEHQUQ060cT
         0rlVr3LPRdCJ5GptUOioCYF4s0u6awwiut98/9p1zmDu9T8gUwjpgc23RJAtYBMYcuJE
         OrHKOI5pekk95ggsl/bg2JVVRcAITIiz5D/n1aGbywXzD+NPHLmwd5WX83R/04+pA4bz
         zGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999283; x=1778604083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sBeBFB2zgnPp2cu215uLKYUsMzk16DEizzaozJqXl9M=;
        b=HlFNh7uiF4P4sdP2V3MRqttadt1gAFD6Tlbv3mad0O+o2TV90zrlLBon2ZfQXU4rMR
         Tfqmi+GLNmLSWwbj4yjSJOzHEGDxIZu6jKcCzx4Q3tzgxuqZmptbKL/qUVOHDV+a+ZO3
         13Yia43FZzMOahepVwH/DoHOj/qHRRjFAIrPceoB/W1txVPcM+qVGbNi9/uw3qRYJzLv
         KoznVxibrcIi9S+dSXqILxKIZZdVaWXJVgQDb5W7oWrY58CkBQgZriZQ5NKkwOOyZq/l
         Q3TT8kscDb3iF9rvCgi2aLNCDE2ES0c1U0xY29MpFtkDV2qGU5aRtY73nWMibW/bJkNN
         +vYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LyCLvq/U+84gDaVgpBOeraJa6rX+VjppY5W5/7RB4CAuHvONe5tgp+Se55MCjz4Wqn4t6AeVmlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPvf5uLaui65LBVkHRo+Yoem3+B2dfYJnILdQIS5XYmCCGNf2
	rbZ9YjeJ/iOSGpx5LJl1U82vQcKb067jak1+ElN+xo4EHo2JBhLFXdZzRDzlZ6VRpTVgUfnQW7O
	fsZj7twtK1vcNVq+McH9M7Ibf4FyXcCG39WZ+b4ZmjvpCzGKEvc/MJfxzJ8GWpnv5FWmCtQ==
X-Gm-Gg: AeBDiev9NO72Dz31h6a+9mcY54P1O8pxmvn1wQw8yRfhkhTx1KQx9Brj6/PA/b+gys+
	cRg7IDtQfab+hZA73EE4KfQaDkexVf86l5b4ECSCTbo7k+CsZN1pSCAUhGa+6Yy9IiDju91DiWB
	ArBdO+Y0TnZlHaJAdQM4LLpp4f2iQT6BJp8CHpZSlHyHEO61B4esJfGrdwR2+cO7GnI+Wmr6Au3
	ztULUBg7vaKR51zx7hBoG6TVpWyKQdl5DJ3CRZndU2j9OjFvLfoU9oaNARQS2JJISsQLWheJCwD
	7eaeczj7UV+h/Y6YzRA3aKZwU/CLllcO+7I6ZJN2toUKx6Yohp+62tlgB+PEPGk/T7trTmgGJGh
	/hQeW1cMUbnr+tioFFnOj59P0DcqCr2OQ5rgZHy2RYaDBh2w/qkmObcs=
X-Received: by 2002:a17:90b:5887:b0:35e:58d3:3284 with SMTP id 98e67ed59e1d1-365773ba5a4mr3987025a91.9.1777999282874;
        Tue, 05 May 2026 09:41:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5887:b0:35e:58d3:3284 with SMTP id 98e67ed59e1d1-365773ba5a4mr3986999a91.9.1777999282270;
        Tue, 05 May 2026 09:41:22 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be00b175sm17944836a91.9.2026.05.05.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:41:21 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 05 May 2026 16:41:11 +0000
Subject: [PATCH v3 1/2] dt-bindings: interconnect: document the RPM
 Network-On-Chip interconnect in Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-shikra_icc-v3-1-8e03ff27c007@oss.qualcomm.com>
References: <20260505-shikra_icc-v3-0-8e03ff27c007@oss.qualcomm.com>
In-Reply-To: <20260505-shikra_icc-v3-0-8e03ff27c007@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfXxE+hiA6LX9TV
 Jc3sZ+DmQVLqRDseqTewoKkju3ylYB1LynJ5698h9UebHo0Q11xXH+TOJfzCcXOmpbHUJma4uZE
 AU8XuASFdE3CeirRadeYtlDOJn2QGvVIzjk2hmRP5vqrau9JfZdK+de/xRLYQR2jAF6rigQkp0Y
 jFHsWG4V3B0znPtwSRgMJKc2Z8UP0uXDDHvY73deMsPmulcaLCRqjummM+7Dfiv5Cxea0Blq4We
 ri0QuEUw0SPSxQSJ1eOkxyiEVQLV/gnfmY9zcSDuwFv/Nb2J0vTSLIu9rfteXL649UL1mFvmVS/
 MDKwoBJUtbu8RUd2xoGzclB0Th4bIVOTdAlxhr4nHEKAXQ08rB0PZLKzHuOXbWrap6OovOzhkyu
 8kCzRonx1PoxghXvYoJZko0brWs/F4hZaTEcd0n7cawXnIyjnB4WmOKOQRMtxLX/jri1AqYJwCz
 Fu9d7E+B9K/e8F3QOZw==
X-Proofpoint-ORIG-GUID: flIQT9tlPwSThr67kdRxrSGlb0o51w4b
X-Proofpoint-GUID: flIQT9tlPwSThr67kdRxrSGlb0o51w4b
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fa1db4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=8QtCtDovb98T9R5Wn5QA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050160

Document the RPM Network-On-Chip Interconnect for the Qualcomm
Shikra platform.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,shikra.yaml         | 134 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,shikra.h     | 121 +++++++++++++++++++
 2 files changed, 255 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml b/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
new file mode 100644
index 000000000000..a0c26de94ccf
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,shikra.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Shikra Network-On-Chip interconnect
+
+maintainers:
+  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
+
+description:
+  The Qualcomm Shikra interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,shikra-config-noc
+      - qcom,shikra-mem-noc-core
+      - qcom,shikra-sys-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    $ref: qcom,rpm-common.yaml#
+
+    properties:
+      compatible:
+        enum:
+          - qcom,shikra-clk-virt
+          - qcom,shikra-mc-virt
+          - qcom,shikra-mmrt-virt
+          - qcom,shikra-mmnrt-virt
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+  - if:
+      properties:
+        compatible:
+          const: qcom,shikra-mem-noc-core
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GPU-NoC AXI clock
+
+        clock-names:
+          items:
+            - const: gpu_axi
+      patternProperties:
+        '^interconnect-[a-z0-9]+$': false
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,shikra-sys-noc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: EMAC0-NoC AXI clock.
+            - description: EMAC1-NoC AXI clock.
+            - description: USB2-NoC AXI clock.
+            - description: USB3-NoC AXI clock.
+
+        clock-names:
+          items:
+            - const: emac0_axi
+            - const: emac1_axi
+            - const: usb2_axi
+            - const: usb3_axi
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,shikra-config-noc
+
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+      patternProperties:
+        '^interconnect-[a-z0-9]+$': false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect@1880000 {
+        compatible = "qcom,shikra-sys-noc";
+        reg = <0x01880000 0x6a080>;
+        #interconnect-cells = <2>;
+        clocks = <&gcc_emac0_axi_sys_noc_clk>,
+                 <&gcc_emac1_axi_sys_noc_clk>,
+                 <&gcc_sys_noc_usb2_prim_axi_clk>,
+                 <&gcc_sys_noc_usb3_prim_axi_clk>;
+        clock-names = "emac0_axi",
+                      "emac1_axi",
+                      "usb2_axi",
+                      "usb3_axi";
+
+        interconnect-clk {
+            compatible = "qcom,shikra-clk-virt";
+            #interconnect-cells = <2>;
+        };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,shikra.h b/include/dt-bindings/interconnect/qcom,shikra.h
new file mode 100644
index 000000000000..a42ea22ee162
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,shikra.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SHIKRA_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SHIKRA_H
+
+#define MASTER_QUP_CORE_0			0
+#define SLAVE_QUP_CORE_0			1
+
+#define SNOC_CNOC_MAS				0
+#define MASTER_QDSS_DAP				1
+#define SLAVE_AHB2PHY_USB			2
+#define SLAVE_APSS_THROTTLE_CFG			3
+#define SLAVE_AUDIO				4
+#define SLAVE_BOOT_ROM				5
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG		6
+#define SLAVE_CAMERA_CFG			7
+#define SLAVE_CDSP_THROTTLE_CFG			8
+#define SLAVE_CLK_CTL				9
+#define SLAVE_DSP_CFG				10
+#define SLAVE_RBCPR_CX_CFG			11
+#define SLAVE_RBCPR_MX_CFG			12
+#define SLAVE_CRYPTO_0_CFG			13
+#define SLAVE_DDR_SS_CFG			14
+#define SLAVE_DISPLAY_CFG			15
+#define SLAVE_EMAC0_CFG				16
+#define SLAVE_EMAC1_CFG				17
+#define SLAVE_GPU_CFG				18
+#define SLAVE_GPU_THROTTLE_CFG			19
+#define SLAVE_HWKM				20
+#define SLAVE_IMEM_CFG				21
+#define SLAVE_MAPSS				22
+#define SLAVE_MDSP_MPU_CFG			23
+#define SLAVE_MESSAGE_RAM			24
+#define SLAVE_MSS				25
+#define SLAVE_PCIE_CFG				26
+#define SLAVE_PDM				27
+#define SLAVE_PIMEM_CFG				28
+#define SLAVE_PKA_WRAPPER_CFG			29
+#define SLAVE_PMIC_ARB				30
+#define SLAVE_QDSS_CFG				31
+#define SLAVE_QM_CFG				32
+#define SLAVE_QM_MPU_CFG			33
+#define SLAVE_QPIC				34
+#define SLAVE_QUP_0				35
+#define SLAVE_RPM				36
+#define SLAVE_SDCC_1				37
+#define SLAVE_SDCC_2				38
+#define SLAVE_SECURITY				39
+#define SLAVE_SNOC_CFG				40
+#define SNOC_SF_THROTTLE_CFG			41
+#define SLAVE_TLMM				42
+#define SLAVE_TSCSS				43
+#define SLAVE_USB2				44
+#define SLAVE_USB3				45
+#define SLAVE_VENUS_CFG				46
+#define SLAVE_VENUS_THROTTLE_CFG		47
+#define SLAVE_VSENSE_CTRL_CFG			48
+#define SLAVE_SERVICE_CNOC			49
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI_CH0				1
+
+#define MASTER_GRAPHICS_3D			0
+#define MASTER_MNOC_HF_MEM_NOC			1
+#define MASTER_ANOC_PCIE_MEM_NOC		2
+#define MASTER_SNOC_SF_MEM_NOC			3
+#define MASTER_AMPSS_M0				4
+#define MASTER_SYS_TCU				5
+#define SLAVE_LLCC				6
+#define SLAVE_MEMNOC_SNOC			7
+#define SLAVE_MEM_NOC_PCIE_SNOC			8
+
+#define MASTER_CAMNOC_SF			0
+#define MASTER_VIDEO_P0				1
+#define MASTER_VIDEO_PROC			2
+#define SLAVE_MMNRT_VIRT			3
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_MDP_PORT0			1
+#define MASTER_MMRT_VIRT			2
+#define SLAVE_MM_MEMNOC				3
+
+#define MASTER_SNOC_CFG				0
+#define MASTER_TIC				1
+#define MASTER_ANOC_SNOC			2
+#define MASTER_MEMNOC_PCIE			3
+#define MASTER_MEMNOC_SNOC			4
+#define MASTER_PIMEM				5
+#define MASTER_PCIE2_0				6
+#define MASTER_QDSS_BAM				7
+#define MASTER_QPIC				8
+#define MASTER_QUP_0				9
+#define CNOC_SNOC_MAS				10
+#define MASTER_AUDIO				11
+#define MASTER_EMAC_0				12
+#define MASTER_EMAC_1				13
+#define MASTER_QDSS_ETR				14
+#define MASTER_SDCC_1				15
+#define MASTER_SDCC_2				16
+#define MASTER_USB2_0				17
+#define MASTER_USB3				18
+#define MASTER_CRYPTO_CORE0			19
+#define SLAVE_APPSS				20
+#define SLAVE_MCUSS				21
+#define SLAVE_WCSS				22
+#define SLAVE_MEMNOC_SF				23
+#define SNOC_CNOC_SLV				24
+#define SLAVE_BOOTIMEM				25
+#define SLAVE_OCIMEM				26
+#define SLAVE_PIMEM				27
+#define SLAVE_SERVICE_SNOC			28
+#define SLAVE_PCIE2_0				29
+#define SLAVE_QDSS_STM				30
+#define SLAVE_TCU				31
+#define SLAVE_PCIE_MEMNOC			32
+#define SLAVE_ANOC_SNOC				33
+
+#endif

-- 
2.43.0

