Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916983AA9C4
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260492; cv=none; b=J5PSlxFg0eM67h+3PMgwoO4QMxr7PUzFn7WaNg/6oL+e6UZFSb45ApoFAVqqSILtp0dX6m4BDDihzQgNbsFlSzVM6U5Yw8j4eNxEPYeC86FOKc1N/NnYc1aLHDQ8yXKD1axxFwdNu6Cd10u4jX+Q5aa6Q2xGzsBUujL3W/hI+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260492; c=relaxed/simple;
	bh=y0IL0P723unFgRB4uYjEc8ZsQBI2DNe7UYsXlujUs0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDTfi83bxevXl4VABP2JLID6Kl5IETiwInZJawApTD9T7maeIH1dvdW0p5GBNlo0fh4/g/6/io/cGZoGLGKx3xVQnP2ftdx+Sq8QrnQc37Tlymtgtum641MX+vgzJRK8xlDiBzjMFLHjRk2ljvTU5GsUZyGEZd5vNB1Iq8B0WgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q826qVpM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e5Jlkrwn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q826qVpM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e5Jlkrwn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6795c6V21914196
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvPR+t+mjU7nsY/5td2EhTFszp46c0QOVr7u2+FWPmg=; b=Q826qVpMXQ7ohk9X
	9XgvJwqX6IJSEmy/U4qvoXte0mNedIelfz/KDa6m8OJU9Y4WbIxstUlWEUfNoVFO
	fdvbTqZS03Cu3yVhMw+cgYKHXvnbcCpgppHJCTVp3+FOK9jLjU8c/ZSD6l7fLb+i
	NtLli+LC61o0k8dMdyfH0DUCtwAg9S3DeU6afiULdX7k9UNissx/1ujhedHMBkpA
	sq9E/3pFxy6LjlyD44XdxoqN5OGlbR3M+If0K3cLL6X7lh6zqnmzcjHyVyLJz15k
	LdA5UOhSVTiks14xrfrZKFFkLhxPrY11BNaSIrv8IklMMSvfN5NASt2bDt8wVhSt
	vPwaTw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwstp2sam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:28:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso818890a91.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260488; x=1786865288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvPR+t+mjU7nsY/5td2EhTFszp46c0QOVr7u2+FWPmg=;
        b=e5JlkrwnPXpGcn+NsPhbhiHMD1CXarTDW1iD7r3Fd/xxrYgh2o9KRbFrYALoqgSy3R
         nvs0fTRf+E0BbRPDch5XIZpPl9c1lI6oiQw5UKlUmmV3KxW0Mx6Adq8DfpVsrdOHrTAH
         S8tKzN+wR1ff5hfsWqOPj7hPxn9O98sCzmXxQ6OvYKuuaoJX/WhZtFN8INgXZSHbb6rY
         i2k8vkJJ0jDyLwYqDbtXpb7i3m3i1WNY5daGeGsHGOE/PZbZfWmoTmuUGVHD1I09xVi3
         zQAXbk4Pl2CaN+TZeaJ7cVvzH6P9DKp7Slru/VmVJcNXvk+YL2cjuUAJt1iR1GToqqwY
         QTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260488; x=1786865288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvPR+t+mjU7nsY/5td2EhTFszp46c0QOVr7u2+FWPmg=;
        b=j9oDZsePSc66fmfc5FSwu5EL901ghV6EPX3htVRq3HnaGfHVeL7tECC1h/wNrlZ0hi
         QAqJkAUVoVVJpzlUWTJ06BiJyiMYO9ifJ0rlIR3dn9pohA4Gtq/E/5XpH9d0G7ECNcOM
         YSino36IKaUIcPAqTR9isvWfC04rIpGm/u7bMaRbMgW+u8WHZgMdWgHTah10PweXMJC1
         hgHj9wjJPhdGQfdx0K8+EiPfcxcd3nCkHVKjJD3PWKJVeuoYlkqoVhY9yLQXTNHyQ0Vn
         VuRFNF4wI4u9qKJ22eIArSk0VNZMHUl6GGarwgNI/31HocR+C+gs7j11nxjfrtVeRMF7
         uwBA==
X-Forwarded-Encrypted: i=1; AHgh+RrmBIAjxFQqsieaVzLofamM0r6DoIb6wlUv+F/OT+detfvo88l0Xt8lPRhMC7rjEZ5pgSVB1g8vwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtetiF1xlZ3B9NjVt6whzTRmqFLFI8MgtRggrdMOJS594lIjCE
	MNWGmhd4JiAcgQQbEpkqZhY1vYsbUuhwQeTI+NA5uuZejKhEQYBggnsecI8TtjFrmswwiHMF3Ba
	97PGS5CVInUEKlWStOxFuy7ECbEOWX35u0Lt70auYysQXlV2hq5+MMNnCcYLyKw==
X-Gm-Gg: AR+sD10RlxwDY7RYHl0aty8ZQxlRTiPMynH1aE3N/EJWG9ETcng4lHYD1wPPIRl1IC7
	Fhn7/zeH+WCS9DbGeE8jlrYHHr0QsflBSpI6oAbK84JLq11MqCRrZZ1Lm9FuELSFBK2aEgOJzce
	bVdPkHgp4HSzeV2qmR3mtE7ywYFlHmV34kkooHtzYzXOINDHHqqvo8sr4aIX5B2lNEyZqdBXC2b
	T5yF964u2UOhSukvIP9rCbJPY4TAHO+Y5w5EOazn7FbrG5Dg3MCc7o0R6v+/ECGCo3p4qaqgPBS
	cN6m2kZU81Z/OC3LdUWYm+oHcJigczwoAw6KNA9trO2nndstwrA7zvOkcvGCN23PomJ/ot8axlt
	usr5K1vtXH479O65iB5ULhRMCTV5MeM8IVw53G8YaqMWIcmjPC+qhtVZ7tSB6lFhs10U9t51H24
	YDw5jX9Ie7XY/KGJJr2ft0q2U=
X-Received: by 2002:a17:90b:5251:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3903c5920a9mr36103439a91.14.1786260488209;
        Sun, 09 Aug 2026 00:28:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5251:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3903c5920a9mr36103397a91.14.1786260487748;
        Sun, 09 Aug 2026 00:28:07 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:28:07 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:05 +0530
Subject: [PATCH 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-6-5e0ede4a0c72@oss.qualcomm.com>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=5779;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=y0IL0P723unFgRB4uYjEc8ZsQBI2DNe7UYsXlujUs0Q=;
 b=bs0/hfUXQAVrhOSCE+H7nktzEIOMdCyrbF4kfIK6zXGLOq9oKJSba6trhZa0WRGaDi4MihfO5
 YpKOMSCT18FDrIrAmynE1H93X/1PlBppO/pwAvGIe2RaFrp02CJl7BM
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: v4zIkE-9AJu2u-Phawt9jC6D-dVzeF5u
X-Proofpoint-ORIG-GUID: v4zIkE-9AJu2u-Phawt9jC6D-dVzeF5u
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a782c09 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=UOSSyZSmw6qQ1N8pRZUA:9
 a=ai0LICTESboNQmvV:21 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX6HgrdZdAT2hk
 blH+Z5iYDmTB/PU21nlxb5ZwiaZsJEgIlsGqboBVLOa5sq9KX3eKzW79ItI/tByWyNK9ZZmd3Rc
 L5QRBu9LefS94r2Qij3t28QTxvHq1/3Y/FZGgUKlocOg68CO+Kb3oprdLimyAnkVa9qCwKbJ1md
 u9GrKzwkD10NRLJGi3lK48FwI/zsb/R23Idj1AtKRRZSkQfGEhtnAyyHcQP58lArs56DrjteKc8
 C8HXkrjDWpgUlujwYX/lwkIea4ymCExt52Rq0K+bcaEUP45B7/dXAnTALklobPOLDWHl3KxTGA1
 I1U2H1fTNtKrBRwTs2HQi1vn2P/yzI1Ma8LMOxeXyH6vKTvR+B2Ay9RaBUvqqmQ8LHwM2lmvhkL
 D1RjCQezi0PwEHoNYbqCNL6igQtUbf6AJikwhAK3Ci9Wqu+1ijam9RNNK09fyGVGq4MYYoEyPiF
 pkNRr8wM9q4lHMGSCUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX4fO8YT94LUyF
 ifPb/pt+/tSVb3hATTkPljjDjgRjUJNhGEQvcJJc9q67fI8ldcHbtStA28egxnVlqGfLCs+wmRH
 ZooVSJ0BufoIITf2pfUoXhG//XveBIU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090063

Add the Devicetree bindings and node-ID definitions for the RPMh-based
Network-on-Chip interconnect providers on the Qualcomm Kuno SoC,
enabling DT validation and interconnect bandwidth voting.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,kuno-rpmh.yaml      | 72 +++++++++++++++++
 include/dt-bindings/interconnect/qcom,kuno.h       | 89 ++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
new file mode 100644
index 000000000000..f6166794ab1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
@@ -0,0 +1,72 @@
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect-clk-virt {
+        compatible = "qcom,kuno-clk-virt";
+        #interconnect-cells = <1>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@1640000 {
+        compatible = "qcom,kuno-aggre-noc";
+        reg = <0x01640000 0x33400>;
+        #interconnect-cells = <1>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+...
diff --git a/include/dt-bindings/interconnect/qcom,kuno.h b/include/dt-bindings/interconnect/qcom,kuno.h
new file mode 100644
index 000000000000..217dce132db1
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,kuno.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
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

