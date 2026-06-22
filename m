Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FC35CB9C
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108425; cv=none; b=NZHaCivHf5ARxeeWcxevrjP/5jUYTwKpT9Y+27ksS30Lhi40QWspDZhWVssuvPVNPZnuTjvW7mk9xBmgG4OOM8e+mbbr4oMo4DMkqAWRtfQ5y8UB4PXeFI5d5EXDuobuoMrNp6WXgaRehyleYqaSFzrkcjZcmwPCfVGvQucRgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108425; c=relaxed/simple;
	bh=EeCOzBFzLfdn68K0NHPbkB6kmZPDlrF8OdyZOOk27OY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHlE4ryP5S6+UPFvRXZFb0vRS30LnEHC+c6AnDFCflU5REegCdEd1sw5kBf95Rfzw3cvFNvFbbf1pp0x0i3wx8vfyj8Bzmx+NXx6KDRtSmwpMQ0Lr1jqvFAKxjxRJKzEflPE4CGMSviC7M32GU0xxEQd/t9mPzqiAd0eZpIHzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IUrniO+a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jEIWqt+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUrniO+a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jEIWqt+1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M593aE1275281
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EJd+VwhCUOgDKPUEKaJlxtNfCOg/wx7KAVVM9S5gYKE=; b=IUrniO+asoGJueez
	LAZy6IB7KI4SxTYIrKc3JYGQHshklL337xBkCNYbOaZeNwmcfqE+MXVyz1rm9X+b
	z0Ts5vZ6p8Uk7Y6VgcetDJ6BH85+OgE5kgGp0+NbO8qS8bVy6sI6wqeUw54HBiFA
	MSwfvADZl3k/tUwqS+Q+QGF4UyAMsm+O2wHE8lMbkwHr7i39TLcVeSp7YIpbEcj3
	+iPm4OHP6RdLqq7e7Mb7oeM+sC7PjGtEiDLhMmepNTYGEPl3k0bTBiwzut1M4U/t
	HufrfZE1SAm4wuOhM+wEiMHdvuZABYfK4Mn+bh0Ftmrf9OuBDe71Gjp1b5lgL0jf
	kJTIQA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewk32vxmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:07:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c891ed872ddso2677314a12.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782108422; x=1782713222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJd+VwhCUOgDKPUEKaJlxtNfCOg/wx7KAVVM9S5gYKE=;
        b=jEIWqt+1h3z8X+l1FdQa27I1LbkpCdJz1fkU6euJujDrdnsl04xpnX3yn1ZiOCK/xq
         JLLZEbuhzpZ1xxID8AVUa46VDSgToID4+C8lW4YVYGDMhOqqA9rIT1mA1zTPLnuqOAYe
         ACUCXa0nlOtuBm3jt72z4nAChl2Q+WOUvxdk+jzGumHKxgiWj0Qydxi1X3ZtbVIjR8fZ
         aMUSK3dNXNuBTETguqQkAoBJSn6ahiMf4vYiTOPt3tzID7hjpXQD9KS6RQjmANAX/b/t
         5khW0ijJe0v2C0NMB8H7sKdwJ0gKX38ttZ9uKN2Kdp5st3cAX+ZLe/Yl4qRPqNkjxp6x
         64/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108422; x=1782713222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJd+VwhCUOgDKPUEKaJlxtNfCOg/wx7KAVVM9S5gYKE=;
        b=c29D70Pv8f2iAbeilC/K9Qq/8VySXIXR9bpMiu14jkmRboCyMnOfvcMDGoWtVOg7FQ
         ohtEvgBuZDwoJwIl+vEB1D213q9NlratseoMPFyXd/jI/GYm6VtfIy8CuL22D5US0qeb
         2Z5lx1Go8TqzifIsd71Re5fujF1zsI4+2lkpSHd6Z4APnRhhDtgg4TAKzv+PKsz7mXiY
         BGdmFD3aczF+50Rr2B9DG6Lv5wCBv/1e+/2eZQS1Fa1ZErQEWGnBR0go/DNqvhrrtx76
         OVqzwxBvwoYXo4AKcdLeNLSaUkGMTZEjMnZH+Skmhg+lMzu98cgypnrG2ccqy12ZtAv9
         l6IA==
X-Forwarded-Encrypted: i=1; AFNElJ+K8+9dz4HqSyHVDIsMQ90CRUifNN5z1hDfQNXE8BQDbNDM7sK5Iq+eIts+89ywcV53NojEwSG3BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9HbyzY9tBjnhvI5CJKzPBL+xvFsYM8+RuSv0P0LG0UV0yLBi
	rsQPoPnuTWZOY0ccyLvaOPncM1HnjyjMmleZvbtXwbEYKW27fbylOMkiakVY79rKWp1bhylyKWv
	pzvbn2ea4m8h6TdJpOe+ESYEff/Y0KvGRzyLM+C2ZG5Y+8ext33m6koMEbNmFwg==
X-Gm-Gg: AfdE7ckni/CYFt2saToBwFg9/LkPMUGxD2z6caOofQkBjehm1B4MI234b4ZBcSNOfIN
	IUEB5lLRNl4T83c6IsEfLaJUrX5IM1KbJNdldXXCqTMxroc8d9+ySDNNKLdDdbo1Z2HWCrczonm
	IEeiOwHKYe6aUaYUMh1j9lSy7rAfwKaluIMVeMNlna57QCEMjQf/LGPVrauem/eVbPu4ImBxbtq
	SseE3bTKTqKpD8d7cnEycryar+881U765vuQrZhXD/jaENX5icIlKcraxqsMCj3cyELMjC2hP1o
	o+da1hm2811L8uab3ZLvdj04rjmhwsTL2N1x0dezCSAuW90ffOwGIX0g4uZFbPpVrA9hoF/tZaN
	ZbDpJEBe8QuAvwZnb3E7r8o2iUpzDgxC1VA==
X-Received: by 2002:a05:6a00:3d56:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845625b56fcmr9195757b3a.41.1782108422244;
        Sun, 21 Jun 2026 23:07:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d56:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845625b56fcmr9195720b3a.41.1782108421756;
        Sun, 21 Jun 2026 23:07:01 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7696dsm8040520b3a.37.2026.06.21.23.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:07:01 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 06:06:52 +0000
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom: document the RPMh
 Network-On-Chip interconnect in Maili SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-maili_icc-v1-1-0aa8286e6748@oss.qualcomm.com>
References: <20260622-maili_icc-v1-0-0aa8286e6748@oss.qualcomm.com>
In-Reply-To: <20260622-maili_icc-v1-0-0aa8286e6748@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: y_GevxYmgjXF-7PapAO7Y9AWBYy9C8BB
X-Proofpoint-ORIG-GUID: y_GevxYmgjXF-7PapAO7Y9AWBYy9C8BB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA1NyBTYWx0ZWRfXwQudZAYfecmk
 HuChMMvkVrBeLuee1ABeJhpZYgyDWFq+RY2KBL6Dx3/o4HEovWYMxKL4ai4SjqBDklAt/C/VQwp
 zFKt4dciXQvX8LhATBgit9GK4u62VOk=
X-Authority-Analysis: v=2.4 cv=NovhtcdJ c=1 sm=1 tr=0 ts=6a38d106 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=jEvNu9c1Eb-cNSkZFhUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA1NyBTYWx0ZWRfX7QHrxBfPYjQz
 BPB2EdT5gUxuXBgRGZ/n/9zJ0N+hDXISDvK1Jentri2yR/73ECQckRYCr+B7qrNsoZYs+LG8k91
 5GDUJJdfy9cLMSEEjjyqrAbP6+I9wlMfwPPlWANBZyGk/N6hmHe20/fIy79dcAaallAfp/pZdBx
 nrGNVFFU86uM12pWLGZyFhzO6/H+Dyj51W15Nxmbg46Jeg0Uf0G72sdBQQX7C3tVxHV8p/NtZ1u
 IGW5iijTigwXn4nUJvYhwU2LPUDGYJfMGlCJMbQdkIWYiZGjwfsNh1MaMMSfjYXfnU3d+AnmlaL
 WotMzuMBTdRKlF78rwMesqMl7+O6HCPd+G4n9bN8sQMgILYc63SLkY47fJB29TgxEz8IZG4shen
 ar31px2CZSXLjnQrELDIgUbRpHCAUQmZc1WkHRVcLIWDcIJA6q7W80R4D4IK5tse/JY9f6PJacN
 P6xIWTB979IUyJmOcYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220057

Document the RPMh Network-On-Chip interconnect for the Qualcomm Maili
SoC.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,maili-rpmh.yaml     | 127 +++++++++++++++
 include/dt-bindings/interconnect/qcom,maili-rpmh.h | 172 +++++++++++++++++++++
 2 files changed, 299 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,maili-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,maili-rpmh.yaml
new file mode 100644
index 000000000000..3db8d8b23219
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,maili-rpmh.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,maili-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Maili SoC
+
+maintainers:
+  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,maili-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,maili-aggre-noc
+      - qcom,maili-clk-virt
+      - qcom,maili-cnoc-main
+      - qcom,maili-gem-noc
+      - qcom,maili-llclpi-noc
+      - qcom,maili-lpass-ag-noc
+      - qcom,maili-lpass-lpiaon-noc
+      - qcom,maili-lpass-lpicx-noc
+      - qcom,maili-mc-virt
+      - qcom,maili-mmss-noc
+      - qcom,maili-nsp-noc
+      - qcom,maili-pcie-anoc
+      - qcom,maili-stdst-cfg
+      - qcom,maili-stdst-main
+      - qcom,maili-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,maili-clk-virt
+              - qcom,maili-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,maili-aggre-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,maili-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,maili-aggre-noc
+              - qcom,maili-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gem_noc: interconnect@31100000 {
+      compatible = "qcom,maili-gem-noc";
+      reg = <0x31100000 0x160200>;
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre_noc: interconnect@f00000 {
+      compatible = "qcom,maili-aggre-noc";
+      reg = <0x00f00000 0x56200>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc_phy_axi_clk>,
+               <&gcc_prim_axi_clk>,
+               <&rpmhcc_ipa_clk>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,maili-rpmh.h b/include/dt-bindings/interconnect/qcom,maili-rpmh.h
new file mode 100644
index 000000000000..e7a957a9d0f0
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,maili-rpmh.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MAILI_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MAILI_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_2				1
+#define MASTER_QUP_3				2
+#define MASTER_QUP_4				3
+#define MASTER_QUP_5				4
+#define MASTER_CRYPTO				5
+#define MASTER_IPA				6
+#define MASTER_QUP_1				7
+#define MASTER_SOCCP_PROC			8
+#define MASTER_QDSS_ETR				9
+#define MASTER_QDSS_ETR_1			10
+#define MASTER_SDCC_2				11
+#define MASTER_SDCC_4				12
+#define MASTER_UFS_MEM				13
+#define MASTER_USB3				14
+#define SLAVE_A1NOC_SNOC			15
+
+#define MASTER_DDR_EFF_VETO			0
+#define MASTER_QUP_CORE_0			1
+#define MASTER_QUP_CORE_1			2
+#define MASTER_QUP_CORE_2			3
+#define MASTER_QUP_CORE_3			4
+#define MASTER_QUP_CORE_4			5
+#define MASTER_QUP_CORE_5			6
+#define SLAVE_DDR_EFF_VETO			7
+#define SLAVE_QUP_CORE_0			8
+#define SLAVE_QUP_CORE_1			9
+#define SLAVE_QUP_CORE_2			10
+#define SLAVE_QUP_CORE_3			11
+#define SLAVE_QUP_CORE_4			12
+#define SLAVE_QUP_CORE_5			13
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_IPA_CFG				3
+#define SLAVE_IPC_ROUTER_FENCE			4
+#define SLAVE_SOCCP				5
+#define SLAVE_TME_CFG				6
+#define SLAVE_CNOC_CFG				7
+#define SLAVE_DDRSS_CFG				8
+#define SLAVE_IMEM				9
+#define SLAVE_PCIE_0				10
+#define SLAVE_PCIE_1				11
+
+#define MASTER_GIC				0
+#define MASTER_GPU_TCU				1
+#define MASTER_SYS_TCU				2
+#define MASTER_APPSS_PROC			3
+#define MASTER_GFX3D				4
+#define MASTER_LPASS_GEM_NOC			5
+#define MASTER_MSS_PROC				6
+#define MASTER_MNOC_HF_MEM_NOC			7
+#define MASTER_MNOC_SF_MEM_NOC			8
+#define MASTER_COMPUTE_NOC			9
+#define MASTER_ANOC_PCIE_GEM_NOC		10
+#define MASTER_QPACE				11
+#define MASTER_SNOC_SF_MEM_NOC			12
+#define MASTER_WLAN_Q6				13
+#define SLAVE_GEM_NOC_CNOC			14
+#define SLAVE_LLCC				15
+#define SLAVE_MEM_NOC_PCIE_SNOC			16
+
+#define MASTER_LPIAON_NOC_LLCLPI_NOC		0
+#define SLAVE_LPASS_LPI_CC			1
+#define SLAVE_LLCC_ISLAND			2
+#define SLAVE_SERVICE_LLCLPI_NOC		3
+#define SLAVE_SERVICE_LLCLPI_NOC_CHIPCX		4
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LLCLPI_NOC		1
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		2
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define MASTER_DDR_RT				1
+#define SLAVE_EBI1				2
+#define SLAVE_DDR_RT				3
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_MDP				1
+#define SLAVE_MNOC_HF_MEM_NOC			2
+
+#define MASTER_CAMNOC_NRT_ICP_SF		0
+#define MASTER_CAMNOC_RT_CDM_SF			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDSS_DCP				3
+#define MASTER_CDSP_HCP				4
+#define MASTER_VIDEO_CV_PROC			5
+#define MASTER_VIDEO_EVA			6
+#define MASTER_VIDEO_MVP			7
+#define MASTER_VIDEO_V_PROC			8
+#define SLAVE_MNOC_SF_MEM_NOC			9
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_CFG_CENTER			0
+#define MASTER_CFG_EAST				1
+#define MASTER_CFG_MM_HF			2
+#define MASTER_CFG_MM_SF			3
+#define MASTER_CFG_NORTH			4
+#define MASTER_CFG_SOUTH			5
+#define MASTER_CFG_WEST				6
+#define SLAVE_AHB2PHY_SOUTH			7
+#define SLAVE_BOOT_ROM				8
+#define SLAVE_CAMERA_CFG			9
+#define SLAVE_CLK_CTL				10
+#define SLAVE_CRYPTO_CFG			11
+#define SLAVE_DISPLAY_CFG			12
+#define SLAVE_EVA_CFG				13
+#define SLAVE_GFX3D_CFG				14
+#define SLAVE_I2C				15
+#define SLAVE_IMEM_CFG				16
+#define SLAVE_IPC_ROUTER_CFG			17
+#define SLAVE_IRIS_CFG				18
+#define SLAVE_CNOC_MSS				19
+#define SLAVE_PCIE_0_CFG			20
+#define SLAVE_PCIE_1_CFG			21
+#define SLAVE_PRNG				22
+#define SLAVE_QSPI_0				23
+#define SLAVE_QUP_1				24
+#define SLAVE_QUP_2				25
+#define SLAVE_QUP_3				26
+#define SLAVE_QUP_4				27
+#define SLAVE_QUP_5				28
+#define SLAVE_SDCC_2				29
+#define SLAVE_SDCC_4				30
+#define SLAVE_TLMM				31
+#define SLAVE_UFS_MEM_CFG			32
+#define SLAVE_USB3				33
+#define SLAVE_VSENSE_CTRL_CFG			34
+#define SLAVE_PCIE_ANOC_CFG			35
+#define SLAVE_QDSS_CFG				36
+#define SLAVE_QDSS_STM				37
+#define SLAVE_TCSR				38
+#define SLAVE_TCU				39
+
+#define MASTER_CNOC_STARDUST			0
+#define SLAVE_STARDUST_CENTER_CFG		1
+#define SLAVE_STARDUST_EAST_CFG			2
+#define SLAVE_STARDUST_MM_HF_CFG		3
+#define SLAVE_STARDUST_MM_SF_CFG		4
+#define SLAVE_STARDUST_NORTH_CFG		5
+#define SLAVE_STARDUST_SOUTH_CFG		6
+#define SLAVE_STARDUST_WEST_CFG			7
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_APSS_NOC				1
+#define MASTER_CNOC_SNOC			2
+#define SLAVE_SNOC_GEM_NOC_SF			3
+
+#endif

-- 
2.43.0

