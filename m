Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A04908B4
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848758; cv=none; b=kd2HA6orj+Lc28X6kzzfDaxdV3yh7+wD8oqfFwZKypGcSQKD0Se55J7j1kS+7Ao8NX7u5BQC2wqBV3dXdO+sayccSIUhYWIcR4eZVzOHb57v9kjeBUWRIOjPY8EQoJrCMbIRvI7tjGSe69XmTyIxSjklbF9OJ0oAgEpWs78qhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848758; c=relaxed/simple;
	bh=ZnkQG+JcPp3GcC7zdZXzSDhHf6/rgK9ZZsLqH/4xBvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsihtC5C06zbuWch+ITFnSBi2TOlHowIEca6ChOOg5f72UmhVFaURFZJwCXJSm4Mz1w/KchlRFynpXl7q3LhBm7JDZWkgfD4lpBkEYzTvxBOtsNK170Ub6jeDd/C3wqwv5NkBG25J/uBczJHTNSdUjfO6SdEEhknNqWKQuHqJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UneMcb6M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HTnSQ0wI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UneMcb6M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HTnSQ0wI"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RGIM9I707901
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2sikrRXkwMudaZ+uyQ+IIhj0K3P1q68Uznqjv+0AL44=; b=UneMcb6MSr0sDyh2
	x2VTzyJP0ztLqtSm52Lh6EYfk+N/QP4B0daj9DcdmfgdPp2K+q2wIr7dzIHlFKu/
	LEa0lNmo0hpX4bH/92QKHlCvyQFKGofZFWuscC6lmJz+ByXvz4uON2aen/7gJe7i
	0k9+5IHB/VuL6wxrIivGGQOrwOb9jLuBmtoyqk6f0+yH/ZAOvnFiMntG3hXTk/r6
	L5ChPO3mIp2xaAWpPVulkJ9yYzL6z4s2EVcwWIb/mL8w224oM09XLi2/mh6Anz+I
	qCKkvsrgfNord5ONlyn7vL5a6JAWpiXW0n//j9/yJFnj+TK2PPynryHhQaK71DjQ
	mN24mw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0g2n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:14 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-44d0960fb5bso179849fac.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848754; x=1788453554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sikrRXkwMudaZ+uyQ+IIhj0K3P1q68Uznqjv+0AL44=;
        b=HTnSQ0wI5p0M4kTLjOjitcb3ynvJL3GdvPhZJQoAa7TsIF4fdCNO8r/G1pjuuIUeQ6
         W/TjbZl/7abD+Ng7z6TK2iILaZBsMc26P1sbbyhuqhtxEgpow0XQghBrkHgbge8RcgZu
         Yezn3qRBiSEx16UMNV+x8igYRLQ+gGPuppZoXBJkXS2bRQL6hlSLqvcDMyqEH+IT/63g
         RTvAHu52eGcnVdhrEKEG0hGdv2LMzetXiY2WsRIUd4TOnjJBfYNc/EJ03QdCn2D9ziOW
         A8FvhKvnerTuIt70LoNzN3cnrlnRLmd/AVnUM+GR67tDBMrk5ZvfFPoZ0Y7zq1zqbAzc
         7P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848754; x=1788453554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2sikrRXkwMudaZ+uyQ+IIhj0K3P1q68Uznqjv+0AL44=;
        b=Gxbih1J8XE/3fOyLd1VMfWG+X4D2MnfPm4+qruqHltkiaOhvyZ4S337WLpHC5dnVbi
         zJykRTJX9o/6WZQXtKqLIDt0N9Yj+uj0mpN9m1/G/ZhRKYNMXcg1eVQR07eRbBDwJffX
         nWlSwOJS/JjhlLC9nOzWBkKzBCAmXLCqaXi4DTOBd1ZzEVCz0QweTQigJjUqJDDhl3Lq
         k+O1cP80AlywN8TAgD69do6vMyXR+Pq97XHeXlyxfQXwiqoBmMtX93UPAIwn+/DqvyUc
         s4Z+Nm/a5UCK3gYUkmLC85CXsIiIdskobzd2eu0FCaAD+X3qrOchpr6hF84QXP7M+kYp
         H9MA==
X-Forwarded-Encrypted: i=1; AHgh+RpMjzK1fGbLcCgp05iBrqr9qWjgvP+LNwU0WX0r6hJjg3hVD08stkxSUK+TwTovc0/4P6uz8NJOAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k/2ueqIoMMK03Z44xpfQVqJejZ7TupTR3I01I7SFrnOLizQ5FP
	c5za1z95TcYhWGVmD8PRrVTYuWszBkNm1ADrm0BKKQZRGqU4+p2/4mPyT23cIQO/TBXOaCRWZ70
	rrCFonhAC8EF+Is3GW3SlUGtiTr2enkQ7oMX6gtmdHJ6Wr4uLglhKot0dVtKnTA==
X-Gm-Gg: AR+sD12G5Cq9D+BhvQ1XR9LWUfdaWAWNmQ4cXKVZlVtoChcceL/EYr0OK8tv5NU3ZKV
	C76sWvpCMNh3+Asiw3s4ZDoQ2+Zqsi/3i17fxfISa2Wz/3qDQnERUBY+VJvxSCj9L15TqScgytC
	yPgRFSpwyeQQ1vYOCHcdfwHxlSo038AJiOK+C3BGzV1ARbsoW6zgoFjrcjQXG3QSn76cn9KbQsK
	CfwGbxKmJLQImVI8cLd7KMks2HK6f1vrGn8YaOFE/+d7aGGws6/2B6qoapKO/q/98OdT5bvrVVm
	aK5l/3DFuMvx6UzuJjEnXvFt0lyjLEoe8gzzjUflZS/Orn5iBOxoG79ouVLptwi87Mme14gC58q
	MN4nR6LPB1g7c4wI5oD3rD5JhTOmo/cTv5qZ9ZmtjrTEJEYx26MtyCLUJDhruViXGvoLXuR4247
	5NDWMW7bvDVtx3DgV2aqHlgjI=
X-Received: by 2002:a05:6820:708d:10b0:6b1:56cd:3aba with SMTP id 006d021491bc7-6b1a049949amr12067049eaf.18.1787848754033;
        Thu, 27 Aug 2026 09:39:14 -0700 (PDT)
X-Received: by 2002:a05:6820:708d:10b0:6b1:56cd:3aba with SMTP id 006d021491bc7-6b1a049949amr12066982eaf.18.1787848753503;
        Thu, 27 Aug 2026 09:39:13 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:39:12 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:07 +0530
Subject: [PATCH v4 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-6-dd34f235fc1a@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=6755;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=ZnkQG+JcPp3GcC7zdZXzSDhHf6/rgK9ZZsLqH/4xBvc=;
 b=sbbm5ZU6HqVcnB9kB3/Hvk5Zd5XU4nfUfrX6Ps4zkMMQLlk0i5/zAHJr0rU2STQLUr6z7p3/D
 aHI282hTU/wDUHLqI33u3u/HuqQ4RlCjS9Va2smDgbaP9b1BFVrWybJ
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX0lQ4IgeuNMRo
 HFbEyWqpEKBtEnP9HrUtK5rG//KWAfsU6PBCPiIYu3euE5NtbplaiYu5TqUDwrGQE0MByNdLRcY
 3dvP4dyVPGRyIUr3xodC4GR+fqVd1iPMtt8lp344AI8EP+SVxttQGutCEbgToXWqlHkJ/lSF3cq
 ArIDefNY11658muF2Fl77PDtZqlnZ1sCP2T/v7DsaSkO9qCcQIZpvegyNeLl8HVhO2hWmRVrzvy
 blJvkqrY0jNx8gwH1cZc4a6bvXq6kGo9DozMXuu7OqEJiWKJ+ne7NOrKFnY2GPqsDYNcPkRWy9+
 cYWZmewQSn0l/xBtlnvDimSlMbMC8kFPEeuDOPg2qt7PrX2SOSgMCBdoa21sUfBKTe2XHkJjj5n
 2iTq+DwNviBS9IJpdFI37nnOgsRAjOTEBsZXJ4ncT/OpQDkCQV1hihTV6uitdx+9Maj4/48rhmX
 BdGJcIo+WODzaxK3E2A==
X-Proofpoint-GUID: iJGVOH2rnvY8O82hIbfPml9eK76yRv_M
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a906832 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=HzFHdt0s4hRtsg76xsUA:9
 a=n-z2q6p6VjFlOU1q:21 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: iJGVOH2rnvY8O82hIbfPml9eK76yRv_M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfXz3Vy/kzvyGm4
 jKo5VmD5uHSntdt+tuBKP/lJdTyjrKKMhme31ZXHY4CcxeO/4D3HYL9Nm6ylP8LxhfKNmgmmOuX
 tmahjFIVfz9QYA9Q8DdBAOllnN3AwF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

Document the RPMh-based Network-on-Chip interconnect providers and
associated node-ID definitions for the Qualcomm Kuno SoC.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,kuno-rpmh.yaml      | 118 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,kuno.h       |  89 ++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
new file mode 100644
index 000000000000..20d169b31142
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,kuno-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Kuno SoC
+
+maintainers:
+  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,kuno.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,kuno-aggre-noc
+      - qcom,kuno-clk-virt
+      - qcom,kuno-cnoc-main
+      - qcom,kuno-dc-noc
+      - qcom,kuno-mc-virt
+      - qcom,kuno-mem-noc
+      - qcom,kuno-pcie-anoc
+      - qcom,kuno-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
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
+              - qcom,kuno-clk-virt
+              - qcom,kuno-mc-virt
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
+            const: qcom,kuno-aggre-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: System NoC USB SF AXI clock
+            - description: IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kuno-system-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kuno-aggre-noc
+              - qcom,kuno-system-noc
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
+    #include <dt-bindings/clock/qcom,kuno-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    clk_virt: interconnect-0 {
+        compatible = "qcom,kuno-clk-virt";
+        #interconnect-cells = <1>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre_noc: interconnect@1640000 {
+        compatible = "qcom,kuno-aggre-noc";
+        reg = <0x01640000 0x33400>;
+        clocks = <&gcc GCC_SYS_NOC_USB_SF_AXI_CLK>,
+                 <&rpmhcc RPMH_IPA_CLK>;
+        #interconnect-cells = <1>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+...
diff --git a/include/dt-bindings/interconnect/qcom,kuno.h b/include/dt-bindings/interconnect/qcom,kuno.h
new file mode 100644
index 000000000000..eacbae38f85d
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,kuno.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_KUNO_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_KUNO_H
+
+#define MASTER_SYS_TCU				0
+#define MASTER_LLCC				1
+#define MASTER_AUDIO				2
+#define MASTER_CPUCP				3
+#define MASTER_PCIE_RSCC				4
+#define MASTER_QDSS_BAM				5
+#define MASTER_QPIC				6
+#define MASTER_QUP_0				7
+#define MASTER_ANOC_SNOC				8
+#define MASTER_CNOC_DC_NOC				9
+#define MASTER_CNOC_SNOC				10
+#define MASTER_MSS_PROC				11
+#define MASTER_GEM_NOC_CFG				12
+#define MASTER_GEM_NOC_CNOC				13
+#define MASTER_GEM_NOC_PCIE_SNOC				14
+#define MASTER_ANOC_PCIE_GEM_NOC				15
+#define MASTER_SNOC_SF_MEM_NOC				16
+#define MASTER_QUP_CORE_0				17
+#define MASTER_CRYPTO				18
+#define MASTER_IPA				19
+#define MASTER_MSS_NAV				20
+#define MASTER_TME				21
+#define MASTER_APPSS_PROC				22
+#define MASTER_EMAC				23
+#define MASTER_IPA_PCIE				24
+#define MASTER_PCIE_0				25
+#define MASTER_QDSS_DAP				26
+#define MASTER_QDSS_ETR				27
+#define MASTER_QDSS_ETR_1				28
+#define MASTER_SDCC_4				29
+#define MASTER_USB3_0				30
+#define SLAVE_EBI1				31
+#define SLAVE_AHB2PHY				32
+#define SLAVE_AOSS				33
+#define SLAVE_APPSS				34
+#define SLAVE_AUDIO				35
+#define SLAVE_CLK_CTL				36
+#define SLAVE_RBCPR_CX_CFG				37
+#define SLAVE_RBCPR_MXA_CFG				38
+#define SLAVE_RBCPR_MXC_CFG				39
+#define SLAVE_CRYPTO_0_CFG				40
+#define SLAVE_EMAC_CFG				41
+#define SLAVE_IMEM_CFG				42
+#define SLAVE_IPA_CFG				43
+#define SLAVE_IPC_ROUTER_CFG				44
+#define SLAVE_LAGG_CFG				45
+#define SLAVE_MCCC_MASTER				46
+#define SLAVE_CNOC_MSS				47
+#define SLAVE_PCIE_0_CFG				48
+#define SLAVE_PCIE_RSC_CFG				49
+#define SLAVE_PDM				50
+#define SLAVE_PMU_WRAPPER_CFG				51
+#define SLAVE_PRNG				52
+#define SLAVE_QDSS_CFG				53
+#define SLAVE_QPIC				54
+#define SLAVE_QUP_0				55
+#define SLAVE_SDCC_4				56
+#define SLAVE_SPMI_VGI_COEX				57
+#define SLAVE_TCSR				58
+#define SLAVE_TLMM				59
+#define SLAVE_TME_CFG				60
+#define SLAVE_USB3				61
+#define SLAVE_VSENSE_CTRL_CFG				62
+#define SLAVE_A1NOC_CFG				63
+#define SLAVE_DDRSS_CFG				64
+#define SLAVE_LLCC				65
+#define SLAVE_GEM_NOC_CNOC				66
+#define SLAVE_SNOC_MEM_NOC_SF				67
+#define SLAVE_MEM_NOC_PCIE_SNOC				68
+#define SLAVE_ANOC_PCIE_GEM_NOC				69
+#define SLAVE_SNOC_CNOC				70
+#define SLAVE_ANOC_THROTTLE_CFG				71
+#define SLAVE_QUP_CORE_0				72
+#define SLAVE_BOOT_IMEM				73
+#define SLAVE_IMEM				74
+#define SLAVE_SERVICE_GEM_NOC				75
+#define SLAVE_PCIE_0				76
+#define SLAVE_QDSS_STM				77
+#define SLAVE_TCU				78
+
+#endif

-- 
2.43.0

