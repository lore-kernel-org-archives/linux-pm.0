Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19F481B1
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278619; cv=none; b=ZWC6pJZo2x3Acv2tsP+A/zNJInOPfRDUj6HEMzPX9IUOBeP1+vg9hDyp/b/gf+wlmOowmbfXbh/DWqEJzf0hLmZO/lwPSrBH5LEHqFdkNp6kG1m95bKScoNTl7ZVDrp6Q7C7M0SUa5ZJ499t2D06ZzTZACeVeENYSh5ArfzDltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278619; c=relaxed/simple;
	bh=8e68S3J41m5lUfAd9CmgbUyj3eqYXTOESXQP5hoz9rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3tmTq1ori4xJaKLNTjODiTgNZep9x89o2nFK5WAkUC3lP7g0e9nq9ZSCgtlzqChfiRS9b7qW/71FY2NjEKgwCWziSoJ5ZYEUZenCSVNq0FFmurjWUUvUGSGzNGWyH8jCveAWZ5jQB8tWBnhSULLd3ez6FCtCy16665nMytZHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddV6mCSH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kKcUG6JP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddV6mCSH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kKcUG6JP"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C1Ul32396596
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 12:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M96SxvkGRMZ7Xi+w8uZL4LF/+V8cVooMvtAQ+Mr6Kmc=; b=ddV6mCSHSOcffW6T
	m5Ed7YDpGFWNnJy99+8Jpr0kB7y8ALNHQGh6K/pib36Hu7tNvXh7xL1/2218mJDW
	KCEr6Axox9jOvKVVovRtvhviMXsUSlrx5Xthe4L6IJgey9WoLL5dfpuzvCvcitT3
	AdAuEpGItMKspv/SSsbUWIR59InHHdgZSFLeED0mK669rNmR0hIx2oGF6l3gtUlF
	koWCD3wJZJZBQncrDgN6kSZn2UQqciQS9+c7Ih8knpGFsJWzEaD+XHcDP94gLgOp
	wxgfVBu5vXOK/rKCbVih6qEH/NQ8MjeNLd+cis6uRCYya1gxahYgFcbPXGLCSUeH
	/Q0EZg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvu8jt4k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 12:30:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso708105a12.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786278614; x=1786883414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M96SxvkGRMZ7Xi+w8uZL4LF/+V8cVooMvtAQ+Mr6Kmc=;
        b=kKcUG6JPdFNzeexpaUBhLMfK+noUhSmAErDqVYbJ24G9wgQzcJPSFAYMjcqQL++sOH
         76nFSc81hFKInEtUzVMceVDVG3PkniSkOD6CR5a/3MBvHqp00+iW5n59qeblGAi9qD0U
         mVGWCLj/hdPQNxCea7CdiVHtHFzI6DOQIr/RV5SnD5cC1me7dfia6IhfLEunx+pWq9q6
         Gadm575XLvGE8DFoRSPkvbuw3LlXMZvTVv9r8Tg1i+xt/ikWTLbjVouDKrzjRDMXfXRT
         7VkkkdMP1s+5slonHJwr2v5mA++PovG0v9Vm4fbRwPSeflj0X1VxUxHk63Evd7pHhUxh
         AbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278614; x=1786883414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M96SxvkGRMZ7Xi+w8uZL4LF/+V8cVooMvtAQ+Mr6Kmc=;
        b=KnDtFzo2S/4oPBLXr5tyyacGE8H6EnkAPsssydmFCIeIg9qf+AlnyfZWWNdBt0MIbh
         /NSHkQVLYfk04Pd7TNccODheqgkkpW9Zj31JIpS6cqJx3vtMPBrD0b1eQ608RY55woj0
         ZWlKVqoh9lm/KDfSkTSYD/Qa/co4Cuw3PF5ElpvT56hBDpnax6Ky3RPh7gVxyDAcGLBk
         Inw0DfJjxNF7DKsnYmiBxTur6BzQwTVT73KEzXSIJ1AeaVdVi98VQLLyi//xhwc338W6
         6upDMHXqrtQsAB9/SldG5+FoF71XU8nIlhsg0WwCh/Jfj65Ly5H1U1J6ogNnS7NotrZp
         iWWA==
X-Forwarded-Encrypted: i=1; AHgh+Ro45saQipTiA9sL8tbMrIKQAwNwRUfWUFQj8lTMprm0IyLp5vpH21hxTWRIuUfh3FiqMKQqnuScdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywMSi6BF3+1CYNjfiuWyQocZJNGU8ldXo23crnGAXS5oG4WbUO
	WBw9EOV1d7lSNPE4kcKYDxgOFxWFCgf5kj4zUazHtmVAkl1zw4XjxzeAOOSETsOM9XJ21PG74mI
	cbapDDdaHaxvMM63A0g7+VfYwfVktkpN0q6indxes5KgZswNX/C853ohiojAOgg==
X-Gm-Gg: AR+sD11oSwvlh6XxBYbAET6x+inw2J7vpzrOumJ7+8xCPU7wy4eJSRwjaDDbKtjSHVc
	el6pN8QVYZH3Imco8xHWrvTZeNSN8he15TWTnh/5RsAQI13FDbfuLva3Mdyicmbl/4Lw/m/Mo5E
	UVSyCFCMxAvCRCXnZ9Gw9PXfImfQMZxmcxZQShU1mEL9i9/B580YdvaB216vzzbCBBSP+aZVESz
	RQ+P1IMJRVL3Ux05mdnNx3r09k2kHJ1d8b9dLUWZd7K1qDZinv+2Gcp3qjH/l40Wmx3SVJrq5PT
	q7XnNhmR+gxen6p91XyIBiLD+slfLbgRQuUTZE8fXGh0Sh7qLYrmN9wNbZx8AuR8POiTQ43H7O7
	6/Ef3RiZcjiI9kSBco6CU9Ny085Ks8g==
X-Received: by 2002:a05:6a20:9e0e:b0:3c3:66c5:68cc with SMTP id adf61e73a8af0-3cb85efa4f9mr45271770637.21.1786278614298;
        Sun, 09 Aug 2026 05:30:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e0e:b0:3c3:66c5:68cc with SMTP id adf61e73a8af0-3cb85efa4f9mr45271684637.21.1786278613859;
        Sun, 09 Aug 2026 05:30:13 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm51842997eec.18.2026.08.09.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:30:12 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 17:58:57 +0530
Subject: [PATCH v8 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-b4-qmi-tmd-v8-1-b15d47adc379@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
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
        manaf.pallikunhi@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786278595; l=3411;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=8e68S3J41m5lUfAd9CmgbUyj3eqYXTOESXQP5hoz9rA=;
 b=7ENeHZnytfRhz2nzQ7wQQKxQzC3cPs/ryrZ7ncdohs90F7bW6YN4n9MrFdXGLi79cGzVH6lK+
 C/vTxRW/XkgAY1ctKHjymoKsUfYbTxh4isTo8gEutZNSIzBwqvE83Hw
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: VOaEJzXwpBqjBEUHW2sWqqjlUl6xDCEp
X-Authority-Analysis: v=2.4 cv=M8p97Sws c=1 sm=1 tr=0 ts=6a7872d7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=T6nhelsJTOTiISQcNXMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: VOaEJzXwpBqjBEUHW2sWqqjlUl6xDCEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX4+50+w+xu5Pr
 tLlf4OgcGRPQ5PJU7frMWMWTy5iP1ZZqg0fKH5olzkO4mWPNJ4yIFpxua4H8cvmRdDSvTrq9X65
 j58yKBnrFdP/a5YWYGGvpFVub2rwAQ0L+8t7+RQ4cUD5a1I3zt1cRLo/nrmLxggPW5mEv+WhIt7
 1xWYD//jWnWgD9E3Ps4ZPQ8/PLa7kXQo+yL/4nKJ0HqBWTsVCqJvsfLekhbFFw0GPBZF0gyCrxs
 CDNTDMAl9WOnjKUNwXfE/dewxqiBw9HZLkB3irqngigml7o87EzuEvyMXW48sR/6JgBlS7KW7sr
 TXjhmXfJOBUwYp448Jb2bvzr78p+AetuBaq/YzNFh09tHAsLq7DVb1HXOYT8GFIBKTnRzlo7JaQ
 2Iagi4DFkDFU5RUPn4C05rvNvgnryz6ouWhLsnOGaRbwRI7xaY7b9BSnSWCI6aLxgizETgHcqWK
 QABl9YiPT1o7zptpGYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX0oQ3zuGlmKOq
 A/x2beRF0b8XSfP9mrblqo4d6MiP5hrokssu6MBC+VwfDuZdBuwtcKF1+SvG+ekIB2KwNn1tfCC
 ISCRosGxQoq4dnZZbc3nex6u7qrC1FY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090110

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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

