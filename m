Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389A415F08
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494076; cv=none; b=VJWqAM+VqDSEvPsf1b1JEReYOFQLTfA7Gl8SmofgNK+5TVmBB8RU/oIPjofyhPQF6iqJbxqefMMIxtAers2QDHBdbwlZJeWxM0N6/k03aBwXZ6UHKiIBQ3QZh8fp/AFTU2YhQF9YbtZM+TZGgBHGsR0747NcBLy6DqB71Hg1aM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494076; c=relaxed/simple;
	bh=LjX2uu5uRns9aB9+huzFuwyv8G8eDp/UqYn/3VCYmRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfiuVpYV4NoZCXBZG1EAgbJHd31+NC9JjIKWedDPp1nSXxaaMqTn+ZC7krP8zqB/TOJDWB8Z1Z8O61cXebxPI0NNwgopaXo4h3Wc7DF9TFfypykOk6O00CAZSZv+8/2jRrduLGvswS4kVuip23VWujbw4VJrsyCEPH2QTOOX9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpAZ9TyE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UycNZF4n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpAZ9TyE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UycNZF4n"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VACK103183967
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pYF9h6alUVBD7tym5vNqQYIx2ehof1mwtVNRI9CjH2w=; b=VpAZ9TyEoc15/jBZ
	BcEWFlksd+tNz2xLa5zhh8EJLwlzJlClxyh22KrknxFZ2NGmervUkceyJQSlYXYl
	jwdhzgkZN+vPQ7smfn/hRKxtAfaj2qAN5dR1PFFe5B0YBsL/IQBE0VXAh0UBaFXe
	6e4iAAKnaRAngoPauGatFB5fzAOhF2e9727ns9t5MCRIKVFURNrGvPCovI5/zrgr
	OzJzUZ5xAc02HLTvHuPCPjmKUAH1SGcyyJkrFg1JyrOjqQPFI5ERy2nQDySffj0I
	FBQe4ZrHXP6pRrfWwTtHSI6oDJFM7qXhha2G9cYdA0TJfu0CrSK4CduOhtyCq4Yb
	6ys3gw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsf1g4pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d001671a54so17082145ad.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494063; x=1786098863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYF9h6alUVBD7tym5vNqQYIx2ehof1mwtVNRI9CjH2w=;
        b=UycNZF4nGPTuyW9c8AYwlH7MUX6qqsT/Is04HTtItzqo10LhEAELxtTgV96SRR3NxB
         Le5Z5yntQvszxFJoDbzKlwkcTMt3yXWXGHJMyUW2m+HSJwjjq2hYbM7RZ9nEjcB3ZZbS
         rmunmWCdTBaOaajXtVcwgw0r+4f6ELGYbOufWr1VdmgbNRDhTmO9PbKn3glwM+n+uCUk
         HaT5EvB5a7FWIneU4Ev2xP/43HR5tsN0g5Be+h/NEPgIZ7jcFI185BWudA7ytKc17oo+
         918EMpKPNK+PRXY6lbZzC4BXRHWDLnNQI0SOaabGDW+y4+Jx7v2SrQgvHTa1WCj3DQuE
         CwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494063; x=1786098863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYF9h6alUVBD7tym5vNqQYIx2ehof1mwtVNRI9CjH2w=;
        b=kH1W9GMK7ghfQynK8kIocP4tAE5hBP8wUiVDiPXxle3YedOS9t7ua1wbN4e11mFho8
         5dFHra2s6wQlRc1xLhE5SpM6S8TdwO6dZlyX4gepBqz435CRn8RCc5dnecnjxp4Gs4W2
         hRWS+31gvf2Vead+9PSwxE0qYYkMSJdie8Cv/xauszZazdtok21k2OUZWu8AEeY4/gIY
         7aaKFZ8crOT1n9ZW1HJxCHC73mY6cXrmfZnp27xWUazq7gSySIKifM1h+cdr6tsn0Jb+
         qPngIteiMwbwsyiyj4WxZ0NDVEUjN0DLJ6LBKWh5wgmjeqd9CQj0lcj5eYSZzRNTz/9w
         NT/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp+ky1F3IJ6D6RGl9FERxBt28RI9qRIGM05JYLsTvFv6NgJLraY499njW7Wsi1L3CtKzuGhfMbqWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPfZFWR4KbfjYxlscvTXa464bpCznH1xef0dE3ieZTyX5xiIY
	rZqrBcveW0YSYHItRUVmFUSFX0xiKdjaZgxgp4udqgbeFX1veuTzKyMtUJ68hxHcq+hpsgYRdFD
	sFwZI93Xm7yedtM1jbLok+W5cLB0DoBcojswJ8wnstU3xcDZDsUZNCj6ijuYQ1w==
X-Gm-Gg: AR+sD10ou1PoK1qRfbZlGdc2k1dU+IlTglyPHujRfbQbYYU1MFqXBx7vZBc8FmPefHG
	8Y2D0a85aELIgcbczK2lLvBHR4LhbLjc273LxkZCI4SY0py+ACoybEeSIyo2RLHutlSw+zCj1BP
	5NfkKAO0zu3qaZ/ahC5Fjc2vQMdsYHbUxHLPcW86xVHUB2FfmOBsxJFMqkgfjxeWwNMNmYGqlGG
	V5D4r7bJ5fljpqCEtYja9pvtmSE6nGBqHs6LcBvubpHkVMZOrFCOpQTCOvxcNn/V0p/htnEio1n
	C+7ZGGh+YdQjrPrq/b9VibJ41vQVJ2Bw3iLuhDe9JKpBVGfPbgSPpt7qYehMdJCFsXqO2VKdtTw
	RGOSxuuZ5CVc7/t5HCDUFH4nNbOGr1Q==
X-Received: by 2002:a05:6a21:790:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3c91b08f204mr1566999637.13.1785494063370;
        Fri, 31 Jul 2026 03:34:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:790:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3c91b08f204mr1566958637.13.1785494062924;
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:41 +0530
Subject: [PATCH v7 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-b4-qmi-tmd-v7-1-3befd44403d5@oss.qualcomm.com>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
In-Reply-To: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=3338;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=LjX2uu5uRns9aB9+huzFuwyv8G8eDp/UqYn/3VCYmRY=;
 b=+Ty/Bcvly1jI+WWQz/dApbymnZLZER2rXS661XRs7pe3SHqPe/N0DFN3Z0fT9/uJVNWsaPp1W
 JJRfLpyXyJSDyCoaqmH+yLurQ5VxvNfbF8+46zkOH9FFdOLqDqrKLNM
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: ygoeiSmGSvU1fRaho-7CQax-nXqiWYhz
X-Authority-Analysis: v=2.4 cv=ZJDnX37b c=1 sm=1 tr=0 ts=6a6c7a30 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=T6nhelsJTOTiISQcNXMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX29+piwgFFg1C
 OxQdEJpPZc1CPnfYZkoijsIbv69i5juiJ5ipGC2FY9ElAezv8EDxTYi1OhYGTtxFaYXRuX10WDq
 L+L8eRkFbwHAAbFU1Yu17+mwCETTLO8=
X-Proofpoint-ORIG-GUID: ygoeiSmGSvU1fRaho-7CQax-nXqiWYhz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX7N5ZmjKE8aIz
 uDF5tgrcDvqUMucLIg+DScKZCufDsUStfG+OF0GWJGJjXXWAltuQAH1/WQQLy6YDutMeU82KEAT
 h1qracJWUxAwW4184VuaHYk4dmbpTx8GLu/rHAGftEK4Sbjhx2KEyA44AoeosY1zK/OyrJUUoUz
 HH1Ckno5Fo/yVWs1BRBcgGGbA783vFcugAB+AxeGaRDTDO5v7D52td5PcsDICmotjp4cOcfbkZL
 lgJdw75Vp7NLm4ck3YGOGCZjEupba5kJiMpskhbPCdnVh+R/oAbQbWO6PMaNmctenqNm0VoIEeJ
 ZEbuLh2ouzRvcYNGITSRdTJ4Wm2T/qItpfcFBVS4AgufpgyOGYN6mZWYhVKN7y4zVfbYP3Ot6fR
 4uiZeYDVU/7jFuC/I3Pb4BmzavnGGTwdr2+RFOOd8sd1K/+gBu5BXICE0N/zhq9x+9HJt+Qmjm8
 rXV/YC5w2IWzTHHGQvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310079

Document the optional #cooling-cells property for Qualcomm PAS
remoteproc nodes so they can be used as thermal cooling devices via
the QMI Thermal Mitigation Device (TMD) interface.

Qualcomm remote processors expose TMD endpoints that support thermal
throttling through firmware. The cooling-device specifier uses 3 cells:

  <&phandle device_id min_state max_state>

where device_id selects the TMD endpoint (for example PA, modem, or
CDSP software mitigation), with constants defined in:
include/dt-bindings/thermal/qcom,pas.h

Example usage in a thermal zone:

  cooling-maps {
      map0 {
          trip = <&cpu_alert>;
          cooling-device = <&remoteproc_cdsp
                           QCOM_TMD_CDSP_SW
                           0 THERMAL_NO_LIMIT>;
      };
  };

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../bindings/remoteproc/qcom,pas-common.yaml         |  9 +++++++++
 MAINTAINERS                                          |  1 +
 include/dt-bindings/thermal/qcom,pas.h               | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 11faf655f530..f75cab6b4ed9 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -77,6 +77,15 @@ properties:
       channels and devices related to the ADSP.
     unevaluatedProperties: false
 
+  '#cooling-cells':
+    description: |
+      Cooling device with three cells:
+        Cell 0: Cooling device id as defined in
+                include/dt-bindings/thermal/qcom,pas.h
+        Cell 1: Minimum cooling state
+        Cell 2: Maximum cooling state
+    const: 3
+
   glink-edge:
     $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
     description:
diff --git a/MAINTAINERS b/MAINTAINERS
index dcffe9fc54f6..3f1e2bbf7099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3423,6 +3423,7 @@ F:	drivers/watchdog/gunyah_wdt.c
 F:	include/dt-bindings/arm/qcom,ids.h
 F:	include/dt-bindings/firmware/qcom,scm.h
 F:	include/dt-bindings/soc/qcom*
+F:	include/dt-bindings/thermal/qcom,pas.h
 F:	include/linux/firmware/qcom
 F:	include/linux/soc/qcom/
 F:	include/soc/qcom/
diff --git a/include/dt-bindings/thermal/qcom,pas.h b/include/dt-bindings/thermal/qcom,pas.h
new file mode 100644
index 000000000000..f603bddef9a8
--- /dev/null
+++ b/include/dt-bindings/thermal/qcom,pas.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Qualcomm PAS remoteproc cooling device indices
+ *
+ * These indices are used in device tree cooling-maps to reference
+ * specific TMD devices provided by PAS-managed remote processors via QMI.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef _DT_BINDINGS_THERMAL_QCOM_PAS_H
+#define _DT_BINDINGS_THERMAL_QCOM_PAS_H
+
+/* CDSP thermal mitigation device id */
+#define QCOM_TMD_CDSP_SW	0
+
+/* Modem thermal mitigation device id */
+#define QCOM_TMD_PA	0
+#define QCOM_TMD_MODEM	1
+
+#endif /* _DT_BINDINGS_THERMAL_QCOM_PAS_H */

-- 
2.34.1

