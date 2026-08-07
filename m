Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321074398E7
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103408; cv=none; b=igdeVgmgd+/Brs7qyDQokiO0gVaHIZlCcaxyx/pWO1giHvykWmFEhY8l3cmgvFd051oiT6FHHr1ldTEjwArwFn+hh6qBg0lBGbK85zb7BxdaD8OMjIO30qrJgaf739Bq+2lcwLMoIqL+KvxYJBLkiPJtJPUDn2hbVlxBHtI8cfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103408; c=relaxed/simple;
	bh=V5QrfIURKe2dg26xdbn/ShQyVuf1iK+2B54wzMw0qiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AP66QO0wM4hORc6cGaDmI2695cPENIdg0UxDSb7GHzCGX11C8BLXE4u6Hk8C9By44zvl2iDHXknV4rdkYvHM4qLwyLFyPQu/9k6CucZG1PPUNY2FNz3LKG+kIrpLUZt429MweJQLxHKCGl0MZUT8UcZLeAbL1VXxa2yVQ4LNLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWK7dj0J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UMMYIhHW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWK7dj0J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UMMYIhHW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6779WG1Q564797
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 11:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Es2Bo6DbUIV
	Spy8lWzFEtUQcWvBquIjh4qgpPiJWYR0=; b=PWK7dj0JYXGBEgjHTGEMTUp9/XV
	SiMTLLyHXSDqbA+bTB+08IOM42oK6jSMC2ilwRLvani9lhE4AGA9ODE1VIr31LfJ
	RMaoqk4G1aQYTm9+LyHg77/VyE8ou/4ozTIrj5EPGwtf7u2TI+ps0FrJuO5sU/UW
	QOcFNqY8O7BGjUx3yZGqzkqjwgSYgLYbte3hTMdmF/wRXUEA6SsfThd1H733s6jH
	ZiJqVoWCKwJ0o6ZvBF+NO6/R7UXzM+1NgsWJ+SOfY2smeitfcvQ8oEr3qs9/V28r
	fnBuupyixFl6mremDl4CpeJwNIGFDyUnXK3Bwpiwa3vFu6aFp0S0mDvBePA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctp8ewf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 11:49:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52b4f6ac06aso52554031cf.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786103399; x=1786708199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Es2Bo6DbUIVSpy8lWzFEtUQcWvBquIjh4qgpPiJWYR0=;
        b=UMMYIhHW/vWFhimZ6ZtA5S+AF9dcMsTsEd5mB9IJbaWcIyv4uNi8Z0rMCAMFFkztPa
         vj/v1LpkgvgnC59lu+rxxyw+WpSUDWDJq9fmQozJaPTyDiqOnddH7hZnKgTR38e577y/
         OjZ2lBsbbxaKmxd/PJhOqi9h4lfO45cj/73zz5WaRR5W+YwjODrYryzkZ10bAbO6+BKj
         38F6Th/7bQLxVWCs3aPeVu/SGdMMZr3q0BFE8WVtwg3mLWFCDKYElv5Ro0ohyJ0GHzDT
         5Rmgi5PyavtYNdcA4tq3Cmq9UnPENAyLXmuzehDrfw3P6vVGXYF5a4XZcvcWHFUAfvjt
         ZpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103399; x=1786708199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Es2Bo6DbUIVSpy8lWzFEtUQcWvBquIjh4qgpPiJWYR0=;
        b=suiZ3ZhqeVkTh12nNxcu1emAFVkzqxaj/BT9ILkx12L3j+xFQFi/Q4Bhj7DX+Om3E7
         f6zlVZ2xjF6N6mMKVXe81pebc7Kd7Ou4keavYplDYyebEfS9u1nx5PUEDWI9qXO4PBl3
         1FxwsvLaqhvPsmqw1z263FO8Nk9mEw0HZdIAdFs9nO+uUYJsLTY2iOcGR5MGNF2xDn4z
         Lt54U/Wtne4avtmjAAAMA0NRjlaKUv/RJb8SmtWXfZOYTQPB5m/9iKfBIyB27qcPu2AO
         Wzf3JRUzmL72nRywx+9spLaHFpRrnSiSZHvJKYfubBo+Y7oMlkNoiGgwH8cQDQKD9tvF
         Yx1A==
X-Forwarded-Encrypted: i=1; AHgh+Rqh/2M/PWFaVQoErXuIlKu6OLLiBABdtCwviTJEoXD9Zv6FzKkHbaymcLO+1hF7jt5nvNnzXCJ7IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGK54cf2PEIv3HEA9XCrgEtKo/YqKQ8/0bGdldTMSXxFZwj7ko
	+QYO8vkWEpi1YDqmh7pNcEpvJk/KxDDkTzOMeqMVkNXmAf4KFBYk+mr2RbrDsnxzUaGp3rJkqkm
	WimFBgz5RsxOlcgiRPUeNemPUnExQeRyHzXASSs0koSzARNEMl3UCk09yrkw6vw==
X-Gm-Gg: AR+sD12GA8OHV8ry8PRIt5pDJ3MI3HPVlBBf263vvZtA5xI66mbVehKe4TSqvQd47p4
	xCbUF2kDxehS3TLwkC33V8hcXVEmMhd/f8cXkCR8kJsYD3W7oi8KysjVsFvbHH1ZbwyrY7GYoze
	xU7AsXuyeGVbi5t8EJMu3y6IDmys9BQMUPFwNFLoub9wTqkOw59NKOc3uwwj+oh6ENbzPV8mApn
	7jul7M9Q3cdnIWdDNmJewOn6XJBPgIVm+DGps999noR6mK76ISQ/cIJ5ZQANbtBzpHmtkqd0I66
	LR2LGmAmRAI0zNLEaQ6D+z85gNpMrrFFPzBSs/rwp7OBOuThDYYvD1rZMVmKR+/5CfYxcz+P1Wb
	NBuciuu0cUW9nvLCnAAAAFjov
X-Received: by 2002:ac8:6903:0:b0:527:7027:cc1b with SMTP id d75a77b69052e-52d0b220c2cmr102191141cf.32.1786103399331;
        Fri, 07 Aug 2026 04:49:59 -0700 (PDT)
X-Received: by 2002:ac8:6903:0:b0:527:7027:cc1b with SMTP id d75a77b69052e-52d0b220c2cmr102190771cf.32.1786103398943;
        Fri, 07 Aug 2026 04:49:58 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c9047esm43046266b.33.2026.08.07.04.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:49:58 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: djakov@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, krzysztof.kozlowski@oss.qualcomm.com,
        odelu.kukatla@oss.qualcomm.com, raviteja.laggyshetty@oss.qualcomm.com,
        vivek.aknurwar@oss.qualcomm.com, quic_afilipov@quicinc.com,
        loic.poulain@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, atanas.filipov@oss.qualcomm.com
Subject: [PATCH v1 1/3] dt-bindings: interconnect: Add Qualcomm CAMNOC ICC binding
Date: Fri,  7 Aug 2026 14:49:49 +0300
Message-Id: <20260807114951.4164439-2-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
References: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a75c667 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=4OcPW1pHXCyAC2ZdQ0wA:9
 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mOyf9IOLsVs4c0PZHOqjhUxKPoegbCHt
X-Proofpoint-ORIG-GUID: mOyf9IOLsVs4c0PZHOqjhUxKPoegbCHt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfXwfaHEd+lSvke
 rMcjRNmW7Vq5i7A/hkleOBQf1rj0VF5rakRmgQz59JLV/zujuC77Mdxv/NknUYr6PcgL8tivdfX
 fTrvypSfvi+ro2ig9jj1gAvKIdLV0+j1AAeGWHj4bQ3XQFkaP2YORQAfrUkzqfz0gWXbb7C/WhQ
 GqVYa44siOPIjYlAeVah1jKb7TbqKdgdGO/se01n4N8XTq1s0U+eaoKCo4de6fei3mi2UFnA0et
 co+IDisVQ3wSW+qaaVCH6zniWudgj6oLKUYFZlRuBwFUmvsfNmamS4fHOe9YA3HkKk9ktmC7VPK
 d9Yw2RnPto9iCKAcSGhBnFWGj1xP4K/S5For8n67VHBuPRR9Q/JvxCWhfevQNO9XKDLLanMbP7n
 64w2ObG+jy6xFqDD/UOfs+n3DMktfqI0t8Y+ZM/Xldytrt/E2lLeCCarRLulyQD3BdClIZ6IOIN
 E/tIA88ZUisb4nBKACA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX0ROn+8u7oqZX
 PvBJIuAWPP4noen1z0MNyWYrkL8/w3klO4k9sSCEKkqXsd5upOBclZ8ENi1yPVVKbSxZgn8WlaM
 6JUpKoN7KdE5UIT7FAt3FELz9MSjomE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070091

Add a device tree binding for the Qualcomm Camera Network-on-Chip
(CAMNOC) interconnect provider. CAMNOC is the internal AXI
interconnect within the camera subsystem that arbitrates bandwidth
between camera sub-devices and the external memory interconnect.

The CAMNOC ICC provider aggregates bandwidth requests from multiple
independent consumers and scales the CAMNOC AXI clock accordingly,
avoiding the race conditions that arise when each consumer calls
clk_set_rate() directly on the shared clock.

Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,camnoc.yaml    | 98 +++++++++++++++++++
 .../dt-bindings/interconnect/qcom,camnoc.h    | 12 +++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
new file mode 100644
index 000000000000..b2f5c140ff80
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,camnoc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera NOC (CAMNOC) Interconnect Provider
+
+maintainers:
+  - Aleksandar Filipov <quic_afilipov@quicinc.com>
+
+description:
+  The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
+  within the Qualcomm camera subsystem. It arbitrates AXI bandwidth
+  between camera sub-devices (IFE, JPEG, BPS, etc.) and the external
+  memory interconnect. Multiple consumers may independently request
+  bandwidth; the CAMNOC ICC provider aggregates these requests and
+  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8250-cam-virt
+
+  clocks:
+    items:
+      - description: CAMNOC AXI clock
+
+  clock-names:
+    items:
+      - const: camnoc_axi
+
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,camcc-sm8250.h>
+    #include <dt-bindings/interconnect/qcom,camnoc.h>
+
+    camnoc_icc: interconnect {
+        compatible = "qcom,sm8250-cam-virt";
+        clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
+        clock-names = "camnoc_axi";
+        #interconnect-cells = <1>;
+    };
+
+    /* Example camera sub-device consuming the CAMNOC provider above */
+    camera-subsystem@ac53000 {
+        reg = <0x0ac53000 0x1000>;
+
+        interconnects = <&camnoc_icc MASTER_CAMNOC_JPEG
+                         &camnoc_icc SLAVE_CAMNOC_AXI>;
+        interconnect-names = "camnoc";
+
+        /*
+         * Optional: an operating-points-v2 table lets the consumer
+         * drive its CAMNOC bandwidth vote from the same OPP that
+         * selects its core clock rate and RPMh performance state.
+         */
+        operating-points-v2 = <&camera_opp_table>;
+
+        camera_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-100000000 {
+                opp-hz = /bits/ 64 <100000000>;
+                opp-peak-kBps = <22246>;
+                required-opps = <&rpmhpd_opp_min_svs>;
+            };
+
+            opp-200000000 {
+                opp-hz = /bits/ 64 <200000000>;
+                opp-peak-kBps = <44492>;
+                required-opps = <&rpmhpd_opp_low_svs>;
+            };
+
+            opp-400000000 {
+                opp-hz = /bits/ 64 <400000000>;
+                opp-peak-kBps = <88983>;
+                required-opps = <&rpmhpd_opp_svs>;
+            };
+
+            opp-480000000 {
+                opp-hz = /bits/ 64 <480000000>;
+                opp-peak-kBps = <106780>;
+                required-opps = <&rpmhpd_opp_svs_l1>;
+            };
+        };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,camnoc.h b/include/dt-bindings/interconnect/qcom,camnoc.h
new file mode 100644
index 000000000000..a03f5e3f6446
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,camnoc.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
+
+#define MASTER_CAMNOC_JPEG	0
+#define SLAVE_CAMNOC_AXI	1
+
+#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H */
-- 
2.34.1

