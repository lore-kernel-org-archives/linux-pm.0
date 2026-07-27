Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2437CD5C
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162196; cv=none; b=N/Ih3Z2Vfz3vnZ69LPr9cUiodQtAXX5XSoqr1jIK71HGSV6kkj7YO4NP4f8OgCsnjaQWWl5JrjBByOTqCrVsBlJ4kZ5ZPJVp3dNLUeAc+DCk1cwnyMUtyX9SQbkc00kySTxpIF3+SDoLMHuGEmDVidlELqRAI6TN3MV8Yh6np9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162196; c=relaxed/simple;
	bh=PXSF6vkFlEhCfK0LyvLgZoPU7bFhvKJwsRbKyMRblis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjkX/11QUubxe89pZ9fbKIYkXEr9hm5pjfPTb5iO6pLqhVmXj5kSbMjDVpUuvjvopFLu3tl6M3XdPZDfuh+gILdpqWKMaCeW0kBdjzF2HbPEoWXUtQXc2zVR1p0FPHlqPrB0LbSraJvjpGTKs31yAyHRsR7nJM3KgwGKxWPNW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+knv/TR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsCBktfH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+knv/TR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsCBktfH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlkiU855957
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sFwWcc4KyJZhvy5Ht2M4dKaSAVjHgP23MglcWOMuwzg=; b=E+knv/TRE2HCqRtl
	dh81QxPKVOv09Guu68Pk/OHUTHjndfmC5DeemV7nAnNlKXeoFSA2GSNzWKWTtAEM
	MFSUbYr9el5st3V8gHO3EI9JOKugL3J5g53fR6FCi4VI5dNz6s0Bo/BnWuSwnZY6
	+nA+9L18pITQ7jjyUp/nKtpIUqxuNuIQO8bOmmcDFDogxPOreu1srQlJND1lw/au
	n6kpu+FYoD+sS9iaQQRb9P1DfgVv5wcigo0iCjctZA3LON4J2tLEtrfkYHmmgudu
	OC8g6oSeS6j9WQ9QKZTswt8W2EeIQ2ECWxCsKG5zq/d5bRoKkrqHh0BgBpyQDJl3
	/qCfbw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9wjc38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so42916435ad.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162193; x=1785766993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFwWcc4KyJZhvy5Ht2M4dKaSAVjHgP23MglcWOMuwzg=;
        b=BsCBktfH92qWvgRcmtRI4UBaRiiJ3voygZHoZIc3nOm1nUla++j2y7xI7QZXaF16Eq
         OQx/bW+atWP96kbbPnyDTX1K/lZsjpul8tHWNHt4tNv2i3GWek9L6oeZmmE4slpWhStI
         P5xaIkQpYu/9HHq3kOPW0Kh3JHSmnIyKtnuii3afIMkliv7KejsXQeTB1NpUA8WExxmL
         aEOLZ1IqA5cY0zvQh0j7JJZstXmDJcRFL6i7XtF1OOnsrmY21eehcnoTACMByQfZg4v8
         8F/ldwRvVQ/vR92m9h6Ow8NkmkAo4pgVYcSHLx4a2SL6HILSs+0gkjJJ3u1L+YFntpLU
         JoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162193; x=1785766993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFwWcc4KyJZhvy5Ht2M4dKaSAVjHgP23MglcWOMuwzg=;
        b=Ej9xj+MBEujPzir1Cskt9BLRoDesWB0lX+XBryhUmEOe+q8uOCiFWk2hR33KJMcGJX
         3Rgn7a6k4nJgRbb+7wCEQTVS5BaZ+SPekrxqlWeAbCYnVpARRuWJqCZ0A+w9KuiIT17h
         edTVQDLtPjwuAVdTKBS4ZqeppzQldhSMIt4Yw/EyaJ3dVwFC9jUkp9G4Uih5JlXI6+S8
         6CvtYBF85lE2YGzKY5OjI00sNuarYxcg4Mvn3nIM6qCO6hJBTZLRwc4xWVmvHrKosV2Z
         0+Z4gC9UPV9qZolgNg6j5H2uwbpY0VL3aUHfQ38eDavUjsaODmFN/XukX3cfew51ktp/
         oC/A==
X-Forwarded-Encrypted: i=1; AHgh+Rp6iUHs1+RGYocF/nIaEVdbbcrOKVvjJ/nYU737H3FoCgguTjl5FjLp5xedhZjkdNrv6PKAlAxQqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMERf2q1EsUqQcuTFSYXbreXFi6HLEAqeroxvk/izheux+92N1
	tMTXesXkSWzM1NDECLMFEF/yABdN+MoettepW7OWR15nbsMVwwSqo3S7jk5Pa8npErVtDCQI841
	OOqozoR+ORFPah6bB47gDUfGLp7ReA7AOcPsnSrwI5BrhZJ0ebrA/8RJ5yyx4jQ==
X-Gm-Gg: AR+sD11HdjBLZKuwCywb6I4GAUy5o9QOucSuQLArnw2pErjzXFoMVuPe7+uMAlpww3a
	tV//LvFUAvALxB5ghu/uMowTCAn7DSZWikTMsAm7qZEkVhk3XHz9Nbg0rwbV7pUY4pxx48y+lNJ
	/7FMcwtl+KcYxX/F/7nP/0vNorMQiyaxslRap5KEkidyMKqRn9H2x+iPR2uCqCmmJN8V0T9NutO
	d8GngFizWwPC5NnhRPo5C8OomjMeOZdgceEKFNGRqilzdKNAILM2v/LKQHLuglxEY4lc8bIQ5Mv
	JBM/oiVO4O7oIGL9hMyVQnahDnHjDLu/AlLvm4qM65MMeXQaULLjD0z/SKGYfljBFPKqwYEmbOt
	v8lHgBVd471ZJOpUC2LdS8Fw9qf+bRA==
X-Received: by 2002:a17:903:2f08:b0:2c9:c517:d08b with SMTP id d9443c01a7336-2cfdf45f0c5mr76064245ad.22.1785162192687;
        Mon, 27 Jul 2026 07:23:12 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2c9:c517:d08b with SMTP id d9443c01a7336-2cfdf45f0c5mr76063745ad.22.1785162192180;
        Mon, 27 Jul 2026 07:23:12 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:23:11 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:18 +0530
Subject: [PATCH v6 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-b4-qmi-tmd-v6-1-973cd3a226af@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=3278;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=PXSF6vkFlEhCfK0LyvLgZoPU7bFhvKJwsRbKyMRblis=;
 b=SEtokr6pFfBIcdHQa10reU2F19U7op13kUhoziapXmY3pFG5ZHMmqU/Rucu/LAaiLYvG07Zm2
 n4rzrXBnk2bD57BQPnG/4T8kIFSfhLRq15hapH9WH4b8ysle83UI5ff
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX6g4nsLElhIdT
 6WhFdl8fMSiAcC4oNybEGOAf7stMnfFm/PZeyupDqYD69zWWhu7LZkZV+yPNh9s6QG1jeb86kYY
 72Jhsqw9zaFecDhvvVt8hjcQsAF9EHSekq6MEBVmNnIXHUTYKZ8ETr68kmQATiuCyaUD4lm/3k3
 uS+gI2Emiu/gwfIBZ2hppxaVpw0IvlZv1Zn04se7evY2kdJThWXs4UoVMUrfnJEn7oOjK/VDMaY
 p9DJCfLkFYU2/6e/O2RGs6odX7zmkfu+Eg8VEa98jYES83i1zC6aKHvd0/pcwCJ1RMiOzQwJtC1
 4uNnI3wRTUhnwEe+bp9s1qpFlV2JmhAXKtw0w4GjubCedHIPZKX45R7HRqqKgQAzkQ8Z0coXaO3
 xpMQo49C8zMKxlQ9bD8gMgE+IHkXv+Q5fgZP6/q7Nr4UX30RMiHTHgm8nNrflYNuYWfszTvUxgw
 o2mEkTJayvSIuvlovMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX16shLEyUcM92
 Wm7bfr9Ywsn7GUEkqh0vlrD3s6XRMJTamngrJGQXG/p1quOgyt7NZ8QIBaANtXBAZm1Jf8N+u0k
 IuX6s9CUh64OJoi43r8wDB9gO1BlkHI=
X-Proofpoint-ORIG-GUID: Bcvvfeqa_WfayBO5mBHg--3sQBAieuAt
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a6769d1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=T6nhelsJTOTiISQcNXMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Bcvvfeqa_WfayBO5mBHg--3sQBAieuAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

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

