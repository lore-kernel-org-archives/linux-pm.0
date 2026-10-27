Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104943;
	b=DF/rAj5Rxt0fQj1yRSpUeWE9ciq9RmfhExQ2RjnnHYtVvsm4qYvAYxBU/D6oNVmnCcN0
	 Jyic1anHGWxMSviQm40Ck9GyNCNrEn07efw2vQ/trC2gh3ts1M5dQLnwcvAnr60W2bHbU
	 JId28NelRBeWp0HzXlls+ANHFNEZcOplp9vLjTjh7rf8Hu1CR3CdjR3mKC2LXZYC6gH2e
	 F5FU1uVYn6BTWkO05QCcZCw61sQFc3/MGyYNzEHWmU3zCGh5sRpcldi1f5gqB66y9bHPJ
	 ktC39Ocbx028YMSkQervyh7eYKo1OCPOdODcB3SSvpPbrmHupNbdmuqEX6fUB9L7r4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104943;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Developer-Key:X-Developer-Signature:X-Mailer:From:To:Cc:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:
	 Feedback-ID:X-SES-Outgoing;
	bh=KcYG9v2aW5ns8VU6c2d99GBk/dTtdughJo8uZI/jzfU=;
	b=s6vWr1KBPy6/XWIcL2oqev7IKBfIaeqseyGUTX/oaKGpLn3eRGajZaF04cAPGNexBqAc
	 12qSJhYPVC/wwKoFNda4wtRtbrr5DwLPZ/tCW8zL7nupx1yqUGUFu/chS+DoxIvJNcfeP
	 hlAV9Zd2DtnrAxdCtiRBYwGO2clbQR18Mu2sw3KhK7S3UnF1sCZFrlGzlTpWoGwe6ePu6
	 vIKWIH14Kho/qB3VAnHji8uqGR8laibtyjOaq65wnwyF5T2mTmkbwe1hSfovV2uJ2V8l1
	 1pg2B20WJJWo8BNv2mRUQxZOWzGGuS0AnZxwab9gc/+L2LRg0MFkyFDCYQJLOcaKR0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brar.si;
	spf=pass smtp.mailfrom=rsend.brar.si;
	dkim=pass header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b="eIOaIH/O";
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=rzzIYiPQ;
	arc=none smtp.remote-ip=23.251.234.55
Received: from e234-55.smtp-out.ap-northeast-1.amazonses.com (e234-55.smtp-out.ap-northeast-1.amazonses.com [23.251.234.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D001606A31D;
	Tue, 27 Oct 2026 12:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D001606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brar.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.brar.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=eIOaIH/O;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=rzzIYiPQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=brar.si; t=1793104942;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=IQnqLD5aSoR1BAw8XCDUtjzjKPqfYP94V06iJS+BUuM=;
	b=eIOaIH/ONw4nIVAZX26IjUNW3zyFiEMlyoAguu0Xoqm04g8lMBSfpMeLEbqlnLjt
	3RyM0fzyYIRgjXxNQOcNOBAXpsiuJGPBKe8AGrkLIiqAyaXZWYawYOKvy6I6RhXcDSb
	d6HnxQk5M9mJwpDer+yRYDqm/V2l+3yB2wrGGJmc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793104942;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=IQnqLD5aSoR1BAw8XCDUtjzjKPqfYP94V06iJS+BUuM=;
	b=rzzIYiPQ3/wzHtKyuYX69A+UkEq4n2ASQKMl4mkV4BHuEBzONsS0XIg5TM3/zo6R
	Osjkkzcdg+KfFEBjwfNzFlMkvjEl7eeiXX5To4MEoj47ithMdGIsFuMmNRv6moRy2Zt
	2GZV+nu6MnHlOxTtBWr3td842/hnfsbSbbdlE8fY=
In-Reply-To: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793104934; l=8058;
 i=patches@brar.si; h=from:subject:message-id;
 bh=q4yzXXlCRn0kps3FvCm+P4hR8fdJlPB95C955wiBDng=;
 b=SW15U5ucBLOm55b1seDuEJmx3cgGPtJ0UMdnLsnFzzbOmu5IYssfGdOeL8J953LmRIU61t+jw
 dHHeUw+P6r0AEJF9gYJD622hRfC09FDdzDWLuSOF0yS3F2V6YQXbcTi
X-Mailer: b4 0.15.2
From: Ishu Brar <patches@brar.si>
To: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, patches@brar.si
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	konradybcio@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC
Message-ID: <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:42:21 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.5YL5VvZ+qZ0e19wo5UdMspzrKjMAjMWs/SlfuwHJq77JVCQWpVGwyETo7FaXf+sztO4bYMxF6WHssrYHSY+K7X2T1EZhOskwm44pQQStdKG0Jdj3d5ybzIXFkMTcPBXllY63oWIrFhJN26LFqLzTuHiXuqj9UCHxIuFhxi7IM0GCfceBHtKocmWdFsR9dK9X:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.10.27-23.251.234.55

Document the Network-On-Chip interconnect providers of the Qualcomm
SM7250 SoC (Snapdragon 765/765G/768G), which are controlled through RPMh
Bus Clock Managers, and add the header with the node and slave IDs.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 .../bindings/interconnect/q=
com,sm7250-rpmh.yaml    | 105 +++++++++++++++
 .../dt-bindings/interconnect=
/qcom,sm7250-rpmh.h    | 148 +++++++++++++++++++++
 2 files changed, 253 =
insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/=
qcom,sm7250-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom=
,sm7250-rpmh.yaml
new file mode 100644
index 000000000000..1ae1ebfc27e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,=
sm7250-rpmh.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.=
0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.=
org/schemas/interconnect/qcom,sm7250-rpmh.yaml#
+$schema: http://devicetree=
.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip =
Interconnect on SM7250
+
+maintainers:
+  - Ishu Brar <patches@brar.si>
+
+description: |
+  RPMh interconnect providers support system bandwidth =
requirements through
+  RPMh hardware accelerators known as Bus Clock =
Manager (BCM). The provider is
+  able to communicate with the BCM through =
the Resource State Coordinator (RSC)
+  associated with each execution =
environment. Provider nodes must point to at
+  least one RPMh device child=
 node pertaining to their RSC and each provider
+  can map to multiple RPMh=
 resources.
+
+  See also: include/dt-bindings/interconnect/qcom,=
sm7250-rpmh.h
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm7250-aggre1-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm7250-aggre1-noc
+      - qcom,sm7250-aggre2-noc
+      - qcom,sm7250-config-noc
+      - qcom,sm7250-dc-noc
+      - qcom,sm7250-gem-noc
+      - qcom,sm7250-mmss-noc
+      - qcom,sm7250-npu-noc
+      - qcom,sm7250-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: aggre UFS PHY AXI clock
+      - description: aggre USB3 PRIM AXI clock
+
+patternProperties:
+  '^interconnect-[0-9]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space=
,
+      but share parent's space.
+
+    allOf:
+      - $ref: qcom,=
rpmh-common.yaml#
+
+    properties:
+      compatible:
+        enum:
+          - qcom,sm7250-compute-noc
+          - qcom,sm7250-mc-virt
+          - qcom,sm7250-qup-virt
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect@16e0000=
 {
+        compatible =3D "qcom,sm7250-aggre1-noc";
+        reg =3D <0x016e0000 0x15080>;
+        #interconnect-cells =3D =
<2>;
+        clocks =3D <&gcc 4>, <&gcc 5>;
+        qcom,bcm-voters =3D =
<&apps_bcm_voter>;
+    };
+
+    interconnect@1620000 {
+        compatible =3D "qcom,sm7250-system-noc";
+        reg =3D =
<0x01620000 0x19200>;
+        #interconnect-cells =3D <2>;
+        qcom,bcm-voters =3D <&apps_bcm_voter>;
+
+        interconnect-0 {
+            compatible =3D "qcom,sm7250-qup-virt";
+            #interconnect-cells =3D <2>;
+            qcom,bcm-voters =3D =
<&apps_bcm_voter>;
+        };
+    };
diff --git a/include/dt-bindings/int=
erconnect/qcom,sm7250-rpmh.h b/include/dt-bindings/interconnect/qcom,=
sm7250-rpmh.h
new file mode 100644
index 000000000000..2b1fa23d0a21
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm7250-rpmh.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Qualcomm SM7250 interconnect IDs
+ *
+ * Copyright (c) 2020, The =
Linux Foundation. All rights reserved.
+ */
+
+#ifndef =
__DT_BINDINGS_INTERCONNECT_QCOM_SM7250_H
+#define __DT_BINDINGS_INTERCONNEC=
T_QCOM_SM7250_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_QUP_1			1
+#define MASTER_SDCC_2			2
+#define MASTER_SDCC_4			3
+#define MASTER_EMMC			4
+#define MASTER_UFS_MEM			5
+#define MASTER_USB3			6
+#define A1NOC_SNOC_SLV			7
+#define SLAVE_SERVICE_A1NOC		8
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QUP_0			2
+#define MASTER_CRYPTO_CORE_0		3
+#define MASTER_IPA			4
+#define MASTER_QDSS_ETR			5
+#define A2NOC_SNOC_SLV			6
+#define SLAVE_SERVICE_A2NOC		7
+
+#define MASTER_NPU			0
+#define MASTER_NPU_CDP			1
+#define SLAVE_CDSP_GEM_NOC		2
+
+#define SNOC_CNOC_MAS			0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_A1NOC_CFG			2
+#define SLAVE_A2NOC_CFG			3
+#define SLAVE_AHB2PHY_SOUTH		4
+#define SLAVE_AHB2PHY_CENTER		5
+#define SLAVE_AOSS			6
+#define SLAVE_CAMERA_CFG		7
+#define SLAVE_CLK_CTL			8
+#define SLAVE_CDSP_CFG			9
+#define SLAVE_RBCPR_CX_CFG		10
+#define SLAVE_RBCPR_MX_CFG		11
+#define SLAVE_CRYPTO_0_CFG		12
+#define SLAVE_CX_RDPM			13
+#define SLAVE_DCC_CFG			14
+#define SLAVE_CNOC_DDRSS		15
+#define SLAVE_DISPLAY_CFG		16
+#define SLAVE_GRAPHICS_3D_CFG		17
+#define SLAVE_IMEM_CFG			18
+#define SLAVE_IPA_CFG			19
+#define SLAVE_IPC_ROUTER_CFG		20
+#define SLAVE_LPASS			21
+#define SLAVE_CNOC_MNOC_CFG		22
+#define SLAVE_NPU_CFG			23
+#define SLAVE_PDM			24
+#define SLAVE_PIMEM_CFG			25
+#define SLAVE_PRNG			26
+#define SLAVE_QDSS_CFG			27
+#define SLAVE_QUP_0			28
+#define SLAVE_QUP_1			29
+#define SLAVE_SDCC_2			30
+#define SLAVE_SDCC_4			31
+#define SLAVE_SNOC_CFG			32
+#define SLAVE_TCSR			33
+#define SLAVE_TLMM_NORTH		34
+#define SLAVE_TLMM_SOUTH		35
+#define SLAVE_TLMM_WEST			36
+#define SLAVE_UFS_MEM_CFG		37
+#define SLAVE_EMMC_CFG			38
+#define SLAVE_USB3			39
+#define SLAVE_VENUS_CFG			40
+#define SLAVE_VSENSE_CTRL_CFG		41
+#define SLAVE_SERVICE_CNOC		42
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_GEM_NOC_CFG		1
+#define SLAVE_LLCC_CFG			2
+
+#define MASTER_AMPSS_M0			0
+#define MASTER_SYS_TCU			1
+#define MASTER_GPU_TCU			2
+#define MASTER_GEM_NOC_CFG		3
+#define MASTER_COMPUTE_NOC		4
+#define MASTER_GRAPHICS_3D		5
+#define MASTER_MNOC_HF_MEM_NOC		6
+#define MASTER_MNOC_SF_MEM_NOC		7
+#define MASTER_SNOC_GC_MEM_NOC		8
+#define MASTER_SNOC_SF_MEM_NOC		9
+#define SLAVE_MCDMA_MS_MPU_CFG		10
+#define SLAVE_MSS_PROC_MS_MPU_CFG	11
+#define SLAVE_GEM_NOC_SNOC		12
+#define SLAVE_LLCC			13
+#define SLAVE_SERVICE_GEM_NOC		14
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI_CH0			1
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_ICP		1
+#define MASTER_CAMNOC_HF0		2
+#define MASTER_CAMNOC_HF1		3
+#define MASTER_CAMNOC_SF		4
+#define MASTER_MDP_PORT0		5
+#define MASTER_MDP_PORT1		6
+#define MASTER_ROTATOR			7
+#define MASTER_VIDEO_P0			8
+#define MASTER_VIDEO_P1			9
+#define MASTER_VIDEO_PROC		10
+#define SLAVE_MNOC_HF_MEM_NOC		11
+#define SLAVE_MNOC_SF_MEM_NOC		12
+#define SLAVE_SERVICE_MNOC		13
+
+#define MASTER_NPU_SYS			0
+#define MASTER_NPU_NOC_CFG		1
+#define SLAVE_NPU_CAL_DP0		2
+#define SLAVE_NPU_CP			3
+#define SLAVE_NPU_INT_DMA_BWMON_CFG	4
+#define SLAVE_NPU_DPM			5
+#define SLAVE_ISENSE_CFG		6
+#define SLAVE_NPU_LLM_CFG		7
+#define SLAVE_NPU_TCM			8
+#define SLAVE_NPU_COMPUTE_NOC		9
+#define SLAVE_SERVICE_NPU_NOC		10
+
+#define MASTER_QUP_CORE_0		0
+#define MASTER_QUP_CORE_1		1
+#define SLAVE_QUP_CORE_0		2
+#define SLAVE_QUP_CORE_1		3
+
+#define MASTER_SNOC_CFG			0
+#define A1NOC_SNOC_MAS			1
+#define A2NOC_SNOC_MAS			2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_PIMEM			4
+#define SLAVE_APPSS			5
+#define SNOC_CNOC_SLV		=
	6
+#define SLAVE_SNOC_GEM_NOC_GC		7
+#define SLAVE_SNOC_GEM_NOC_SF		8
+#define SLAVE_OCIMEM			9
+#define SLAVE_PIMEM			10
+#define SLAVE_SERVICE_SNOC		11
+#define SLAVE_QDSS_STM			12
+#define SLAVE_TCU			13
+
+#endif

--=20
2.56.0

