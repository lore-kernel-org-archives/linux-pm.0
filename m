Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE203F1ACF
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187823; cv=none; b=YuYA+QRICmIMRDOhwvxtIXMTu1cemLSSOwNt9SJrIoEzQDeTyjt2ADc1gXOfkOEPFc734PCnZgexWuQNSRLNNATImJcVlFkZ9tUAhZOgwQEvf7QaAvmDpuI7TbCqpN+rk5mcjXtNIHrEU+BjLDAsWu/9k1t6IWfStULEslqmC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187823; c=relaxed/simple;
	bh=ez6BI+iFIWBZJ4OKYJs5blAxXM0YWETGmKLMOIskNuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Avy1y95A0U8iSwpSFjpOC9KIh+QMthSfX5viy6nRrqQ3ojmQhDx1qtgd34a+Nt/nr9nEfI9XJapJq8uHPY0hWzAxMjRCuwSez+5lcHOAVbhkrc629xGLVb0cWwQYhprG0LdWzIBLcE0CinJ9rTDg1zXr/VTlDNdAEY9w97c++3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QRcfLm5m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6ybGc8a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QRcfLm5m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6ybGc8a"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9LpQO4062972
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yMu3pwwfQeds9RjA4hYk8iB+KBRpIN6EKL+u9mQS2mo=; b=QRcfLm5mmSr/ulxn
	bVyrHujCPYH4W47x5WLyl+CGwvoXpze1FP6R/kIbWfwQJYAE9PRp4xgYD74YiTdq
	xfI2ddDB0EYtNjQHojnjolO8bNy/U0GK17vReG0hGXW6FVeenSiSSgfQO8dvVaDW
	1/P3coiT1WySPd3P+d/XxFy0jO8whThz2Wf7lYl+b4bXlYe2da/ya09GPyCorlmu
	lGPlLqHTn9oLFU8II4YJjiS2EJcGDH0FSwanUOWEJ1rZs5om8GDT1yDLVVtT9p69
	t+cBswWv908YxXGlrI/BZ4gGgAJkF7L15WX4VLwLtvYdraifYD9UMVQV+csaEaFj
	/Dx8BQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8n5u0bec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8291230235so5309781a12.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779187821; x=1779792621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMu3pwwfQeds9RjA4hYk8iB+KBRpIN6EKL+u9mQS2mo=;
        b=C6ybGc8adLJsJOBUPW/O6fZB9JWxkiKmSihJfNKnCrp18o6mwJk7NmbaeiYqNh0x4X
         siLaX7x7DGguCGTmIZ1FBV0h2kgx++XGygP7oeJxeCQ7QNGYczRrUAiwaW7qvDl7rG04
         zLne3giPUYl5zNsRmRytCqbSeCuIGpERPkW6dQkiJCuVMC0oynnP+UwMK12r3M0VtN2S
         K+wK18inNyajGVKy4eDtK7ehUN0Sxtjzo5ZgTaCq2Bh3XjMpBBXGNPuYmC73y6/byajc
         hQQ0wFl46geeBh2Z3nY0Ss1bd9HKuIEeioRRoZ45F2luxzgPz9fZIE3HVP86SvAu9wU3
         tkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187821; x=1779792621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMu3pwwfQeds9RjA4hYk8iB+KBRpIN6EKL+u9mQS2mo=;
        b=hVwSyYHMSjqCsns53m2Vha5bi0wAXdPpZxxQQgMSfQU8sXCcdzQDiW2RfEJy+KSxOo
         tdPYpGT8MOSgcI8Qs/d79TknvfglD2x7ONE0Pe04aenVKJmcnq5UUYo2xMuIkmqRC8uN
         SuWpP/hcN8b0JLNZp19WC4ZGas+5pEdVvrYzZyt7tmUZjEbmwdfxUy1cqKM3uNazr4E+
         n4GerLNRWGkGokZZL1goNIT5tzlzpa33W/nmuP/ooWeawzocgaamuOW/XhBHE9t+RsiH
         zwwtGezlDlg1SQ8EsuhnbCkILHKQLjKS7TLGmr+MoaI9rdqYnDcoZaDJIEeDyUXF/RvB
         Xh4g==
X-Forwarded-Encrypted: i=1; AFNElJ9tLsruyzyNYvjdE9xNjHoVReg8typNKkj+gnhbWuly6djNHDiygeC51JMKac2CFR/N0YQcbo9Qyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyulwuuSAhKXQVb2Sjnz2SRjlPTJ5ktj4Uq+5/WBYbwyCwINuXP
	GW3OEx4O9lUtG2i9AMcElyq4I5Iz+U0ykCsCrkaabAtT6bl7vtWom15aeFC/r4n/B79KtmYEDRz
	QgcWwefb4Z1RNI86gpFm94wAgFDpyl5yJhVkldSK3r4wuuUPSSu2Tu4u2/F4j4Q==
X-Gm-Gg: Acq92OHW0AzOtZl309gKwrGpkTfr1E0PmsxABX8P6qj8prvW68+HhqZI1LiS/eVRKb6
	F2hgs+IWHQQ0+ZyLknkeCZBeZ1QMQBUbRnrrW/5ZLIwj/6PTGnuRp5FG0vhU827yr18esNuz6Du
	/zWtsimDHOaDtVkykZk9dseUFEtpUlaJPsgVsT70aBDCQYYHlWwt4iz+yMGTpOtMY8GZ5gjAslY
	4rdllHg1qAKr2oHa9vigb6LUSMqgwYq0tblNYUiyC0siZftKERogqA+TrlTkSqfO9JfoJeNjiqU
	L4nJn52xI6g3zZxHvTrRGU7kqIsd0dPlE1uh06R5el1DhCG8/6jhkVg8JNYDIhR3FlB9rtgXBjz
	W/JxdHA17ECZOXMxQVXHQNggZDCc2OC5L0TiG1KAuTjOpX20QOTf6VM2G
X-Received: by 2002:a05:6a00:4b53:b0:82c:247b:ffdc with SMTP id d2e1a72fcca58-83f33c359b3mr18235909b3a.29.1779187820877;
        Tue, 19 May 2026 03:50:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b53:b0:82c:247b:ffdc with SMTP id d2e1a72fcca58-83f33c359b3mr18235880b3a.29.1779187820298;
        Tue, 19 May 2026 03:50:20 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19fa869esm20877879b3a.61.2026.05.19.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:50:19 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:19:49 +0530
Subject: [PATCH 1/3] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom_spel_driver_upstream-v1-1-75356d1b7f94@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
In-Reply-To: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779187810; l=2537;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=ez6BI+iFIWBZJ4OKYJs5blAxXM0YWETGmKLMOIskNuM=;
 b=+d7gNedQsIlsHf9gc6Uv0waPlUJuobTPnNYs0y84owz2NwRH3/+Xhpd43TiRCGNwDLp4vPJAt
 CVdutJ8/8qnAkWS6mCmHA7QjndpPgrf+elpfD71Va3b0tnoZbGEEaAX
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Authority-Analysis: v=2.4 cv=MfBcfZ/f c=1 sm=1 tr=0 ts=6a0c406d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=MtUMKvMtarDq8PFyUT8A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2Kl9YdqAPJhKdym2fYRlLBhBoanW9wPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNiBTYWx0ZWRfX0nMSs8uCr9Ok
 uUNmJhw3hWzLad23FPFP/8oh7A9GQPkQEtco5vDVPh4ggdOkLZD6tbJQnA+S6HXy+BoojWLUHiY
 f4ggKFqQzg4DY6+TAmGHwvq2ZUYc5pQ+qI4emRl/lYg4XzgY3ALY69q5olQdzDNOHDQ2PsqF2zF
 jGwBEeyRjhPH2QhZTKk0RgTKEaw6HOnJQDRUASsXTFfhO2HiC4fN32Cc3dyg/y08bKH9uuYw00q
 aNGeIXETmiH5JFrMGLd7+uynrYX5q/zfIXChYtptBYNSE8lUb/tKAlYMoBwDlqbP1zdk2iGbNEM
 asRXTPUxN7CEWjvnlm/MSUsDGvPxJ8VWUEBDf6jDnMm5q43FOyQYjKN2K2UfZ76EYdxvZM9UInQ
 EuWBx7BWly1hUsi+TLLUiLgD472Li08Qo2abhH5/quk95LfUNpXu5mo52OpM+bsqQ7uRMqCetm3
 oezafney98T8FPv0jdw==
X-Proofpoint-ORIG-GUID: 2Kl9YdqAPJhKdym2fYRlLBhBoanW9wPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190106

The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
based power monitoring and limiting capabilities for various domains.

Add a DeviceTree binding to describe the SPEL block on Qualcomm's SoC.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 .../bindings/power/limits/qcom,spel.yaml           | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
new file mode 100644
index 000000000000..e9bb70c3a3aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/limits/qcom,spel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC Power and Electrical Limits (SPEL)
+
+maintainers:
+  - Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
+
+description:
+  The Qualcomm SPEL (SoC Power and Electrical Limits) provides hardware-based
+  power monitoring and limiting capabilities for various power domains in
+  Qualcomm SoCs.
+
+properties:
+  compatible:
+    const: qcom,spel
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: nodes
+      - const: constraints
+      - const: config
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller@ef3b000 {
+        compatible = "qcom,spel";
+        reg = <0x0ef3e000 0x1000>,
+              <0x0ef3d000 0x1000>,
+              <0x0ef3b000 0x1000>;
+        reg-names = "nodes",
+                    "constraints",
+                    "config";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3dd58a16f06a..c63f147e8c54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22233,6 +22233,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 F:	drivers/power/supply/qcom_smbx.c
 
+QUALCOMM SPEL POWERCAP DRIVER
+M:	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
+
 QUALCOMM PPE DRIVER
 M:	Luo Jie <quic_luoj@quicinc.com>
 L:	netdev@vger.kernel.org

-- 
2.43.0

