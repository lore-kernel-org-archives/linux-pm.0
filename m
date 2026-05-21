Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9F2D9484
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372389; cv=none; b=sY5oKX0dIqqqSuvwApqlMA+D5As48HUViPGxqyM0fNl70vzUG2GB+VEHDb4l81AnBlQ9Qe9Zh7MotJbzPGLKcORzwE6mda9CKD1/+XbkVnLANOi02fIN7ZOtYT4F1nCnXIPE5T//jfcnltKlkXZiSxskE7Z6kMX0b6NX57UilMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372389; c=relaxed/simple;
	bh=q6/uXjQ/XPAer0/bzSYSlACp4MPDCgjTYubdTYSseks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnlZqyMPGYcAJcce5qA2BBy77a5ahdTNyKRXc99nMBBJ8NqB+Ym6FztFTTToa3NDzbrW9h0s1gnbPF2cgTJzWu+YAolVwjUOMGIPWT5lrI6x2cX8wKbVIE6+W4f2GnkaJZy3+wxoZQrcs5jDqsTste1zuk9an40b49Sz2dniJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxUxF6tJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gwfEtq/D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxUxF6tJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gwfEtq/D"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9AQVA1731514
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+LbFZlJpygkKRNnq4cZd2WgvzDUunEa6SjSNWENQD28=; b=dxUxF6tJiF4JOU0F
	C7K+Xg92czk1OTWjaITjIKcP2mI1FvyXbL7DOXxhtNz1x6gFYT+5CX8UENdNOr+F
	KfE5H5CJrdyYurZ1AdDd5c2LK0mkI9Mfk10A68SmfRKJPt1E1bLTwXa6l7MdUIq+
	qW69NM4BVAAok4Da6cimmDObxHKIExvkFb7Tl5x1DJrRXqXF7ETkL2KLBW/Ru5Wt
	M1EHZ1sd/f1zVPXT+rggvCkewDUZWzoeTENcCDliPtoXQCcGcynaQ2awve8VTW5f
	+ohmEu6zeAaMutYOf6bag6iIGJjYH1ZhwgYzuraOBe9H9FcxXga6fAAUbiwY77nJ
	7Xny5g==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f5r88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:26 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd5c267082so49383087b3.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 07:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779372386; x=1779977186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LbFZlJpygkKRNnq4cZd2WgvzDUunEa6SjSNWENQD28=;
        b=gwfEtq/DHKZXDo6gizZZG/H95lF4XeVikttCVSdo3ZxCRbakk6OSsHwBtdFZSQ47kQ
         sVuOmT79iChK79TSNXtEAJ5GPkcKb6RfZgUVA7NxGq4m8PkGOPTt+U6g1e3yme91LLZ/
         ABo8CRoPc4VjqFA1UzbPlrrb/7IgFD8NE4o1i04SvGCmMZlCf/q4XE8Vj3Os5ehkI+Et
         q57aWozVExCf6e7F9Nkn1Tx6j8chIc5OhMuyjKNDgrIoXUOJKxS7TAaMdngyKmovz5r1
         JlasGNeKB5Y6OITsivrDCAASLL2vO0I8cKRyFspm/PyeHWZVnS57OvYDpp9Is9djC6Kh
         DmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372386; x=1779977186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+LbFZlJpygkKRNnq4cZd2WgvzDUunEa6SjSNWENQD28=;
        b=iphwF45yLQ7a3z2Bjq5PyrrkQ9ke2LsNddSAUM0fyudyszYB751V7mQPRe9VA53m1n
         epXqzI+OvqPejd4hit/JSgNComZ8ljzFF9I47sJIijV9mfKlRpvV+w+b5OYtZdxFPUoC
         or09SPX4s8HDTpIqlcWblSJqjISPAO7yaV0QNMgjIsNt4Hvlp5Re9MDmnTAlamGqWY5S
         scuv8iFhj3etp8TeRZUQ7rbaI9ft6a2AFRhr3TlANvNiIKHSf5qm5FKGkHdge8zEVbiS
         JGxJ5n34N9UTKqMPppRF8OHPglJ2Gj9BOeXV8dRTASDTMQhz0TGxn76VBYFXmReTGfmv
         JJfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lujfWBb1dZNQAuVI/QBQtnQcCMbTcHfKuvItDqcXJ6T9jMpCYLWoM4+ISkKEsWaRDz4wdQMwrbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIKMAdbwYDne7Za5fVsyGQDLGig0/2dvMwwrX2nfv+5cjk1ts
	NBVgsoNj1w4wlo2CjzBa7qCIy6L1gf+ScuWVkphc6u53lTAChjyynlpumazHBkFjQUGKASrtRq6
	rNZ+sS/iN/8G8S5emsNf924h0gftT7bObqP/tb8N1wCnM4EmLO1BWbD6RIMIaBA==
X-Gm-Gg: Acq92OH7b8n3/pTnxCOwyHelTR8Rpk8y04ga9TBTet2Yvot5abixCnbGphIWm6RP8Od
	45hyjh3TM3i1eo0LiSvB3VDObzO06J5c7nwQCEvfGhTeorRptr1Q2iLMAiRip2dFx/bbe5/+zSj
	zKj6701Bvbe01Leu5EnAHdV7YAfDO6yKkf+HTy8ou+OonLxVbp3NsHm1JZpj7vbeVippkyA6Idf
	JNGGPcsDCUvSwHyey9Z5Cr5kWQtn5zqC8xxU3wWJuIow/Sdypv4s6JjjCvFwo0v427DySrtFdZZ
	KDXayys5lUTO0QVF0fWuwkFMmuq7+ENA75BAULge5zUz5bfoB+tIZM5aPd5gd20WwzSPiool4GH
	BmUJ/IvF/kR6ID/nNlCPDsCzA8t24QRi1FkPAqDmlAWuQ8ENCTIYT
X-Received: by 2002:a05:690c:c4f5:b0:79a:5fb9:62ad with SMTP id 00721157ae682-7d20d604f21mr29085317b3.43.1779372385980;
        Thu, 21 May 2026 07:06:25 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f5:b0:79a:5fb9:62ad with SMTP id 00721157ae682-7d20d604f21mr29084577b3.43.1779372385356;
        Thu, 21 May 2026 07:06:25 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2cab7a5f9sm2920677b3.39.2026.05.21.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:06:24 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Thu, 21 May 2026 19:36:04 +0530
Subject: [PATCH v3 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-shikra-cpufreq-scaling-v3-1-883c13d1e514@oss.qualcomm.com>
References: <20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com>
In-Reply-To: <20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0f1162 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=sA6xLUNpRn-UYiqxgCcA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: ITeZHCWpT-iIQZCrOvr8svX9pigk9uEV
X-Proofpoint-ORIG-GUID: ITeZHCWpT-iIQZCrOvr8svX9pigk9uEV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX7UnURNLT3yJ2
 kYGvVkCH3AVKlUhrMa7hy/yA3iof7BWIbr9ikQKCgXf+SGg5zMgMfIJHxXs7RZtTyITlBiHRMJq
 JpZioU6Hyah9vMZC0tRHfPWop++cYFJUQp7RhgHqOvdxyTCcfqZtmtE6pIkAVWSV0Nwg/1k0Ctk
 aiBURAD1Ehu7SaVC1mS83Ha1bN18yICOfeVGi/Knzl7SQh4/BnolagWO01rV4mCNM9UjASK4ABZ
 MHWGkrC/5VfifixHNA0zsrVdssGwOgieYBRr27tXb178vhjQRj4cuFwl8PNA0vpIG8Qu7otJ8cF
 l2jD60HxHcE4ntao0Ew6RDl52K8hheSUJjmmgKVfFdA1DOrMHNCtxN19AxwAbhjsrb7In5p3yvG
 QXdFbfL5b2II5mLi0PE2RQQO9tGp2H6EVyHSIa8Wnmc95QBhwkruyeBplbxkpT2zzGGFR2jN9tq
 DYuVwkEkdjmzNjRxFkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210140

The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
but supports only up to 12 frequency lookup table (LUT) entries. Introduce
Shikra specific bindings to represent this constrained EPSS variant.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 .../bindings/cpufreq/qcom,shikra-epss.yaml         | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml b/Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8543fd00d82acdbb3422bde462417118aa4c49d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/qcom,shikra-epss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CPUFREQ HW for Qualcomm Shikra SoC
+
+maintainers:
+  - Imran Shaik <imran.shaik@oss.qualcomm.com>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  CPUFREQ HW is a hardware engine used by some Qualcomm SoCs to manage
+  frequency in hardware. It is capable of controlling frequency for
+  multiple clusters.
+
+  The Qualcomm Shikra CPUFREQ HW supports up to 12 frequency lookup table
+  (LUT) entries.
+
+properties:
+  compatible:
+    enum:
+      - qcom,shikra-epss
+
+  reg:
+    items:
+      - description: Frequency domain 0 register region
+      - description: Frequency domain 1 register region
+
+  reg-names:
+    items:
+      - const: freq-domain0
+      - const: freq-domain1
+
+  clocks:
+    items:
+      - description: XO Clock
+      - description: GPLL0 Clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: alternate
+
+  interrupts:
+    items:
+      - description: IRQ line for DCVSH 0
+      - description: IRQ line for DCVSH 1
+
+  interrupt-names:
+    items:
+      - const: dcvsh-irq-0
+      - const: dcvsh-irq-1
+
+  '#freq-domain-cells':
+    const: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - '#freq-domain-cells'
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq@fd91000 {
+        compatible = "qcom,shikra-epss";
+        reg = <0x0fd91000 0x1000>, <0x0fd92000 0x1000>;
+        reg-names = "freq-domain0", "freq-domain1";
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gpll0>;
+        clock-names = "xo", "alternate";
+        interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1";
+        #freq-domain-cells = <1>;
+        #clock-cells = <1>;
+      };
+    };
+...

-- 
2.34.1

