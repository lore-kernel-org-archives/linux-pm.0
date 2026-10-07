Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2240B0EF
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355874; cv=none; b=FvX/5GjZPcrFF1UOZgNF+3CCz6GWPtR+YnKg29lKAN9GhZd+ab9g+MAW0RBbmnnhsqy5FrhveH5bN0IJhWVCU1O0qsgxRmCUBRigwYJcVJ5GYKv+xwmJKyYut53pISNwAtxfxqCeqH1WsZun3SpClnBw2snO6QMB+TXjAKz31IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355874; c=relaxed/simple;
	bh=Wcv4ZLmmvdfjbZvLQSsVP39AR6mMz7RNXcdhox0hcvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=in7nicqo7/+YTiaBR2GzyWwsm6WryBDaEA2J5vO943VC4fDIggp6nO0SMrvy58yMPYqrvA4tlOBu3HWZdgo03lutaYOXuz1yEF4zaVEPeTBDxdR0UNJkGeOIGh7hcKmhH06y+p/+n9YehNFFe8Rm1cHF67v6vy8GqQrXN830svU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHJpZj48; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjjXVb23; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHJpZj48";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjjXVb23"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974U81L2879130
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 06:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VbnQ5UhdwkF2mB+kgRVrvAgOBOsNAgejHqFSdDqSGng=; b=HHJpZj48q/M6t8U/
	t+Pl32OOW+6+BXS9E8/2oM7X5ul4JVr44NB8pSsRP9Xwt5c5bje/I8nCviU45FeF
	5hFgZcWzh0OrGHmDtR+2x/ZMUoghvIDYAiKSrCXlley8Ct3E03DSmKpWvd2szOlW
	k2ez9vJsiGvr5/eVyjrUd38TTVuIMwbGi3kKZfUs+WKCqk+szL18WcpD+CVXLY9j
	qc5QgOcmdtB02nO9KJLAEyAeYCMbGezPJUYEZ7EjkB+RCH/6YpjtgxEUcDu81tLO
	f9ePRaszcGIwQ3M3LI/kCJ05rn4AaoPblGpO2m1oXBT3NhrB0Gj3xKfy4Nn65Bsp
	VbdUBA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9vfnv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 06:51:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34d62bb27a1so15787611eec.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 23:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791355871; x=1791960671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbnQ5UhdwkF2mB+kgRVrvAgOBOsNAgejHqFSdDqSGng=;
        b=CjjXVb23D0R2i5MdDcI9+1ipswJyjcsX+mppnlAbDuaevW9NN+EzYHTJqPXHAT1mkU
         sCC+yua6C4vUPYvgarSyDCEKRWKl+cw4Oz2gbIWS4As1K7HFXibWwV/1AWIaM1pCsTZ9
         IIra5F8LhUHU6StyPCEvh5HsLV37a8vYAWATWLJgrdkcp4/1Ruiy5zlfdGDp5w/ZkRpv
         6Ts7dJAan0NacKeKQY/aBPwpM2V8r+O3o+7LIRltb5yF5ZgBudCzk3jNnSMUNgzeIgQZ
         nNqMKrpswCXv5zqOz1nOkPrjM09gHE7zENR7mkAmUsEpTVdO87/KidFzoq82ahtOZh6E
         go5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791355871; x=1791960671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbnQ5UhdwkF2mB+kgRVrvAgOBOsNAgejHqFSdDqSGng=;
        b=oEWldLlMPeZnXzEXz4FTEDJOpDsdINcNA/Je8ZW0BTiN4b4SK43EzonrlJ6UnJ1viT
         nc/9wzb7GsDm5+aTD7pzQtb4+kTXSZ2rgYT4MTpsvK4sYuRbF45ZtOEltdrJxMJfBOBh
         WHlhMGLZ7OehGnJ3raRQgIJRH+bzhxMG7Ba4yuKzCGbLLNTp8f2N/q0jNWy3Z9prAoEi
         ogagB0Rq26rkgHghzYx4di7UQxfhTV3MbFxpo64cgl4GHpezRIA7eB2gDiGdGQOzbYJ1
         4Gzwm/idU8VfymxYG7c1u/WdHk22lPmt/xv4Q0C38vpnP/OjrtsSp9sPMUIfh3w5MWZb
         mwZw==
X-Gm-Message-State: AFuF++kt0xp9qvQ6JyHUn0SncBIg9ehOni6qoKKtfkV9BN62N7eUkRS4
	1CzeUDydytxkm6ex2hTmdjkrc/ZywuITOPIzFmr5aL29ZsMomdVXpgKsG3HwPSwRdykhv4OHeQN
	uiHkT4OVTtn/f5WG6SkLMFXLcFepqAqi3iCOlDKcMto5hLhH4pMKwpTiiVJvenQ==
X-Gm-Gg: AYBFou3kxeCFIxCxvpUNruk4xTel9GT43ErxmfY4jDYsd5v5FkuGXkdc4NsIyVJLFP2
	vvSYGJAsCFGo+GcGymZ7P1L+u/5XgD0pUjUE2p/FlImIgiu07ckckQAsiBVjn8OUfHgONZLoh9j
	ZFHqJ3HvUS8Ibv3WT/5SrLmX9RqjHxOhQNntGWeQJy84VaUqqYP2CTKjtH/5NPYCcYz8ayJ3mtL
	dfALQmisafwCSJPxSfPX7tGS4TjIZbggUKiNF007hhc0c62yhiBCevURi0ipc6nXzoTqD7d1TcK
	JnVg/JkQv9MsAsHTsDePARsLApFmK5Flj8BFuZALcquETXEGwEmzLPpXR2X01JXraFnvpWHPf5b
	btgLQNJ7MXU5KLlLTx0wtiKBjlpxgVkicNf09FkW6g8GcYLhw4HyyNQtM1obQveM1n5DL2+sZfK
	/dp5N1HNfuyKAiIkmoD56RKM+U9vD7hQqsJZk=
X-Received: by 2002:a05:701b:4550:10b0:151:8d26:a798 with SMTP id a92af1059eb24-16207e74c92mr1202467c88.26.1791355870684;
        Tue, 06 Oct 2026 23:51:10 -0700 (PDT)
X-Received: by 2002:a05:701b:4550:10b0:151:8d26:a798 with SMTP id a92af1059eb24-16207e74c92mr1202435c88.26.1791355870033;
        Tue, 06 Oct 2026 23:51:10 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm7374730c88.2.2026.10.06.23.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:51:09 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:20:46 +0530
Subject: [PATCH 3/4] dt-bindings: clock: ipq9650-apss-clk: Add IPQ9650 apss
 clock controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-ipq9650_apss_clk-v1-3-fd4c2b3cbdea@oss.qualcomm.com>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
In-Reply-To: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac5ebdf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=QDl9-_pjA6WZ_EjsUeIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX2l5Sn3aCz/6b
 /NaGKA+dsTqxpI0FdjtkT1B2/IhJsINVWPQisziENkjQcshkk2esizG+4S/LgSPqcgmI0YC1w3O
 3NBh08N/kVzCgeHLcuayctKsJTpobrw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX2NbnkCaNraVP
 a+L2mXHhILyMDvjirKQn2TyCIGfQ9qAbK9sMamlkn0pB34HMFY9MKUa9cRbJucmtD13i8gBSO4F
 iM8ReiNUoIYqzg1tLtJNhb9p7lS7GxRAREVH5iKmIN+11XORfpigzv1M3PdIUMIn7fKt0tSKGNZ
 W50ea+tg7aPA5xT15n4gy7PBuiZDEVDXh2kqbVUO29KVxu7RmCEdgBpv/wJxKL1iXNKM7f8uOXu
 KIz30EgOxAlHP5IovmySPl9tYlEpVqLEKR3//5IVWFdtKCECEtwi51CTrHx307ZmF9eCWmstJ+e
 1XI5CKD3NKNZA8cRaRcfge3/t/mkb1dEowv1W3kZNoYi5Cd9yz6q4i7N1XSJ4Lly7AHdkQ4i5l0
 moQ6QpDaups02E3AGMvcjxkidAjRTgQbtLBwK+S6XrU2+B/Qn5R+3oBYwfJ0z6DmoO8jJnvl+m9
 z3aYMseUu4U0zJVZBNQ==
X-Proofpoint-ORIG-GUID: nhrUdaP9uq4Q_OUt-SrP8yZ6o-eyl8jo
X-Proofpoint-GUID: nhrUdaP9uq4Q_OUt-SrP8yZ6o-eyl8jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070027

The APSS clock controller on IPQ9650 provides the CPU and L3 clocks and
has a register space separate from the GCC. The four Cortex-A55 cores,
the Cortex-A78 core and the L3 are each clocked by their own Zonda PLL,
selected through a glitch-free mux whose parents are XO, GPLL0 and the
corresponding PLL. The L3 needs to be scaled along with the CPUs, so the
controller is also an interconnect provider.

Add the binding, the clock indices for the Cortex-A78 (gold) cluster to
the shared APSS header, and the interconnect IDs for the CPU and L3
nodes.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 .../bindings/clock/qcom,ipq9650-apss-clk.yaml      | 58 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,apss-ipq.h          |  5 ++
 include/dt-bindings/interconnect/qcom,ipq9650.h    |  4 ++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml
new file mode 100644
index 000000000000..6b47183edd56
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq9650-apss-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APSS IPQ9650 Clock Controller
+
+maintainers:
+  - Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
+
+description:
+  The APSS clock controller provides the CPU and L3 clocks on IPQ9650 and
+  has a register space separate from the GCC. The four Cortex-A55 cores,
+  the Cortex-A78 core and the L3 are each clocked by their own Zonda PLL.
+  Each clock is selected through a glitch-free mux (GFM) whose parents are
+  XO, GPLL0 and the corresponding PLL.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq9650-apss-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference to the XO clock.
+      - description: Reference to the GPLL0 clock.
+
+  '#clock-cells':
+    const: 1
+
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq9650-gcc.h>
+
+    apss_clk: clock-controller@fa80000 {
+      compatible = "qcom,ipq9650-apss-clk";
+      reg = <0x0fa80000 0x30000>;
+      clocks = <&xo_board>,
+               <&gcc GPLL0>;
+      #clock-cells = <1>;
+      #interconnect-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/qcom,apss-ipq.h b/include/dt-bindings/clock/qcom,apss-ipq.h
index 0bb41e5efdef..c9b04f2dbb6c 100644
--- a/include/dt-bindings/clock/qcom,apss-ipq.h
+++ b/include/dt-bindings/clock/qcom,apss-ipq.h
@@ -15,4 +15,9 @@
 #define L3_CLK_SRC				6
 #define L3_CORE_CLK				7
 
+/* IPQ9650 Gold cluster clock indices */
+#define APSS_GOLD_PLL				8
+#define APSS_GOLD_PLL_POSTDIV			9
+#define APSS_GOLD_CORE_CLK			10
+
 #endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq9650.h b/include/dt-bindings/interconnect/qcom,ipq9650.h
index 023a3878cc08..1a77609de832 100644
--- a/include/dt-bindings/interconnect/qcom,ipq9650.h
+++ b/include/dt-bindings/interconnect/qcom,ipq9650.h
@@ -25,4 +25,8 @@
 #define MASTER_SNOC_USB			20
 #define SLAVE_SNOC_USB			21
 
+#define MASTER_CPU_SILVER		0
+#define SLAVE_L3			1
+#define MASTER_CPU_GOLD			2
+
 #endif /* INTERCONNECT_QCOM_IPQ9650_H */

-- 
2.34.1

