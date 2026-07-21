Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAD40926E
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615369; cv=none; b=bxRYkkpjfdBne6jskGAbDDPerbzCHGY9e6figSDg69FLYh/mhKURf4it+swpInvVSfbBfFYytqeLOScXa/p880YL7vJ5+tfPeJlUvq//XrZJM2P8u/rQNSfdqdpRD+78N+PadmpBHHyT3cF0U3LQ8x+vQE6vKxH0HJetDQhA+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615369; c=relaxed/simple;
	bh=ZNmmhz8d+ikVqmiuGAtmzNkjyU7gAGD5sD7LIuQiwdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qu874AR1ugzfQKqT0D31Yxl3QuxgLN4hNoc5ZbJM4G1ec6jYPwPhozEr7aJJFPxQrwpT+nKnLfOp2HdbuxR3bqyAAvSormKqKZ+X4HgNhYahZIkcj/fG0dRLNjLJoi4jk7KsMZQLcIGTvJ1EsxHQQAo/g+BB8bdmGa00R3bxzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F34KMcM2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TWCIu35e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F34KMcM2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TWCIu35e"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L4631w037609
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o+LVABKIG2BuxSt+UJCwEcPXThG7BQ1oO2/vhndDIjc=; b=F34KMcM2PjCEuB66
	dnKP67vQlxk+BTF1GnhKxnXaYVng2ageb+I6G7qoQ43txoeDUl2xA5+77qtIzNC2
	fBedlx57FBy5lRtZzI10TnM8YCTtNFzKSexEIe4NYzE3rDQYn0n1xbs4NpGIbTNx
	Yv5yEfWaL8UnNyR1t/HNtc2dO8nu/ZaO235B3it+hcq0G3aiuR3p3dIaAZcsePHI
	UzfCu4qJvL1xd4PGwtLkuARKOWOzakXT/wAsw+uZEa0DURayfboUxjZkfox/KZ8t
	cbKEyxP6XDfxhh5kGLrV1nsrWy5Vv2elDR1xQ1mfyVNgrF3HoZECkZwUgLsm2rEx
	bnnnow==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es0gpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc88e22f92so234203635ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784615366; x=1785220166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+LVABKIG2BuxSt+UJCwEcPXThG7BQ1oO2/vhndDIjc=;
        b=TWCIu35egUcr/2xlfsSN6/6Gn19HgjXiKc/Rx7/FmDW4vgeuEXSoHf3+LOkyajD4j/
         7cu8FsUcUqGdQReRsOHBkNZcDwvlgWXnsu8Qi3PCZo/BDdd58zr0mIAC0wG5k77h+V9F
         SU3rrWhxAUOYaw3TyxjKqLd1UP46VIj17zga1gU1+DTtBkWEQY05FSPyFm52irb+yvDq
         qdE7eyEPY4rBB5+b/xjFiGkRyPY7r6/7nvUmoV/kMBdNGt1tdM2M5qD7Im06ogpQAqIU
         wp6QS2GhxsYxMScv/sGEMTguZNVdCi6CRjMnvSPvhBOpUgxLcKPIgieo6+EGpxAh8hee
         vI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615366; x=1785220166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+LVABKIG2BuxSt+UJCwEcPXThG7BQ1oO2/vhndDIjc=;
        b=i0DOFs5xqXJAqZOE1Qz2jJe+0X8JKJ4dxS9Df+XEnN867jyVuTlKD7YLIomzd3ByJ4
         I3sHAeDLnuSwnW9Dg6WdJlnlQYSuy2xyqqoSTDaU7kWmkfRo3wnkMn1r9O/ihWFBbHoo
         sFyK8EiSYHAidneXJ2/EwJU7T5BgHaukwL9c0lAR3e/bWBTqqca327eHWz5pA3SNfC6h
         fMAm2YHQZK2UKHwVrwFeiCOXsHp3TJ2XtQpdnBrgmISgKz84XsqZPxUmN8s7TaK7FhiA
         v4QfZHbDOdfaVW0CYLo+Qavl0zXoh+F4zfBzdgaBQzcEmcPFSnENGeHFg2T3nSP6KsWe
         J7BA==
X-Forwarded-Encrypted: i=1; AHgh+RqLn+6ZknyMzc9gh3ZkgtyYFSudT0WohmfUSDYMAH8hydHMsBxK0ouTmanSeseeLKzrcjDBg10ZRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuvWL61MtGNJrDVcKCJG1yRby8ln74+qlRDOtDyy3pAAOhM+KP
	Oh0ZclI300NE51LfDP3wQE2tO2/+MBXvKztA9SjMa8MzshfumS1OeDkv3uyQaMT0HoPTDWBu96J
	yFdcz3Ao6y5NdoZ4v8aExPonGnJ/WzaXQnDHmDCJLIHDuy0V3WLw5zfFArATsxQ==
X-Gm-Gg: AR+sD10a1s/u8c9sL5N3tzolYr4J+cS+LFU6Rehqx7fPAx+epIEbG0XKCsshSQ+Ycld
	IkShBbL8M42PP6kBCALxIt6fhRgoAdU4ffZ/WW/XaYI7GK3ZYsXZMyEB1U2f+3PYgf3ScUka2yR
	aK2kWGpfwR7Fajj5x9JODRqEGoa2cu5Z7Hwj4TA5RozvpWN65hJZ79nj9OkpnTI6fkO6SR05+Zl
	Tj6UpSBgHJqpryTgU0Bdluf7u0K3qX6A3Q/6k+SMXKfV5IsC6AxL8eDxDlwf0jkhuwno/fiTlUr
	j5R/GhswUcATsoxBiuuEX4J4gZIf1YwDH0kjacjz952r0fnljS1vqsR0fprxvI3EdgpcZqqOjdo
	3z0xKd7RYmxxopp6n2FFFSKNVB0tOxg==
X-Received: by 2002:a17:902:fdae:b0:2ca:ecf6:910e with SMTP id d9443c01a7336-2cf3466a93fmr191394225ad.0.1784615365957;
        Mon, 20 Jul 2026 23:29:25 -0700 (PDT)
X-Received: by 2002:a17:902:fdae:b0:2ca:ecf6:910e with SMTP id d9443c01a7336-2cf3466a93fmr191393995ad.0.1784615365482;
        Mon, 20 Jul 2026 23:29:25 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347a1201sm69376505ad.81.2026.07.20.23.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:29:25 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:58:58 +0530
Subject: [PATCH v5 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-b4-qmi-tmd-v5-1-99620e07f505@oss.qualcomm.com>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
In-Reply-To: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784615351; l=3323;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=ZNmmhz8d+ikVqmiuGAtmzNkjyU7gAGD5sD7LIuQiwdA=;
 b=+CU+a3eT8Cbuga7goWNwt6YhSmtRDWGSDn4o/N/BDvZsXEJfU4IrriNbtpH5ZEboKxHpmPwDz
 7XgS+tmBiwpAnMvZs6B83PCNHy56kQbUzvEQqmIZiZE4ZNjMe0LOU+S
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f11c6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=l7oHOeSGPlQ5jhq5CMoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: CYp_1-kTNINDyJ3mNwnS1SFitFGBxksN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX8Vfr4qc7Ke4L
 tdd7ZLb7k4626YwJsSH3G/iZchIwB064wtyYU1mjIUxhuBzB+PdBM3THBYnSr+AxjcajzpDFR9P
 eiahQStcFeeEa72JVda4qn7sg77QNnIg+C1fZYoQry77GIjFIZiSBRFhqYpZZ+Vh76qoFrQuOmj
 CNc+nhACZq3IiL7muMH3Z86ubW2dRYiJdVl10SivswOryMLd+5MAPE4kASMUUIWp4O6nZyWsuGk
 EeLYfkSUYAlLIRasPUqmH2aw/BueUvg2K95474dECnRpkaOEzgdN05v5/6WBDomlRlGvtEOIyVD
 QKGqUyraJYJRWhUZQC1Go/cUnz09xVR4bTfA46yrzDtsz6hcq/uwx01IBOmX5SzyQjt82j44CYN
 bG06Qye73QpgyK+MBkb5jA++kWPp0OylE8lWS4Qm7mRhBBtLBQ//m36ZFhdVPEn2WMOtqvFQIRC
 hWnciOnlG8yhFb/iFng==
X-Proofpoint-ORIG-GUID: CYp_1-kTNINDyJ3mNwnS1SFitFGBxksN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX+CPwo8nm84Ox
 xo/2PhaW5gbZEWHwMIyRYjrF3W1NQ7tcnVJcV9X4uPFnauTtAMFUslIqGSbcgHEqgpG6FRqLCJx
 ywnm/GFYpFEaGY+bXSwaY9l0kmBxIZw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210065

Document the optional #cooling-cells property for Qualcomm PAS
remoteproc nodes so they can be used as thermal cooling devices via
the QMI Thermal Mitigation Device (TMD) interface.

Qualcomm remote processors expose TMD endpoints that support thermal
throttling through firmware. The cooling-device specifier uses 3 cells:

  <&phandle device_id min_state max_state>

where device_id selects the TMD endpoint (for example PA, modem, or
CDSP software mitigation), with constants defined in:
include/dt-bindings/thermal/qcom,qmi-tmd.h

Example usage in a thermal zone:

  cooling-maps {
      map0 {
          trip = <&cpu_alert>;
          cooling-device = <&remoteproc_cdsp
                           QCOM_TMD_CDSP_SW
                           0 THERMAL_NO_LIMIT>;
      };
  };

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../bindings/remoteproc/qcom,pas-common.yaml         |  9 +++++++++
 MAINTAINERS                                          |  1 +
 include/dt-bindings/thermal/qcom,qmi-tmd.h           | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 11faf655f530..39e79a1c1079 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -77,6 +77,15 @@ properties:
       channels and devices related to the ADSP.
     unevaluatedProperties: false
 
+  '#cooling-cells':
+    description: |
+      Cooling device with three cells:
+        Cell 0: Cooling device id as defined in
+                include/dt-bindings/thermal/qcom,qmi-tmd.h
+        Cell 1: Minimum cooling state
+        Cell 2: Maximum cooling state
+    const: 3
+
   glink-edge:
     $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
     description:
diff --git a/MAINTAINERS b/MAINTAINERS
index dcffe9fc54f6..2d4d19201aec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3423,6 +3423,7 @@ F:	drivers/watchdog/gunyah_wdt.c
 F:	include/dt-bindings/arm/qcom,ids.h
 F:	include/dt-bindings/firmware/qcom,scm.h
 F:	include/dt-bindings/soc/qcom*
+F:	include/dt-bindings/thermal/qcom,qmi-tmd.h
 F:	include/linux/firmware/qcom
 F:	include/linux/soc/qcom/
 F:	include/soc/qcom/
diff --git a/include/dt-bindings/thermal/qcom,qmi-tmd.h b/include/dt-bindings/thermal/qcom,qmi-tmd.h
new file mode 100644
index 000000000000..a07a515905e7
--- /dev/null
+++ b/include/dt-bindings/thermal/qcom,qmi-tmd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
+ *
+ * These indices are used in device tree cooling-maps to reference
+ * specific TMD devices provided by remote processors via QMI.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef _DT_BINDINGS_THERMAL_QCOM_QMI_TMD_H
+#define _DT_BINDINGS_THERMAL_QCOM_QMI_TMD_H
+
+/* CDSP thermal mitigation device id */
+#define QCOM_TMD_CDSP_SW	0
+
+/* Modem thermal mitigation device id */
+#define QCOM_TMD_PA	0
+#define QCOM_TMD_MODEM	1
+
+#endif /* _DT_BINDINGS_THERMAL_QCOM_QMI_TMD_H */

-- 
2.34.1

