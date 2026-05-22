Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAC46AF10
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463113; cv=none; b=tlm/S7VdJdU6EbCEFkDItPz07B5wHv3VaZukXiZnw5jUqVeniwPMT5d9pJsMmglZbamnGq85ChzajkTI3Sgbts5hsrl9GJqwUZIQqYBuIZnevIoIRbCmVn8Bwfb8Y7H6asBHSobN3r7NviizTA4fQy427V2DDWHUM6STlPiwByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463113; c=relaxed/simple;
	bh=BLjTnPkIqMBmeKeUfBB39035D7n/iE8a3uC5nLHD7ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRiFavOOgaf7qzHw6nGcTJ2iDGF1xzBgYPRgIM6XD6SXFiG36q+Ynl0YjH75oxbouRahZEyTomAn5FgY4k5bXpr9H/T/X7FNgQrKtZoG9A4Qo1JK494EOI3Hd1Qv/nTznCFDdyQy5JbfIwTzCDL8tEt3vgZK/xa8yx8JNEuB5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmxR1aTy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ftkLxK6d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmxR1aTy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ftkLxK6d"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MBGv5j1960034
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mu9+G7n+6D1Go1la80V3lILv4g67InFZue93g9NauiU=; b=DmxR1aTycQa5i8tr
	Ex/RENYc/b8ShKyDPDJpArJswK6P0RiUU/xtO0gReVRYLm56y+OdG43rDi+fTuc0
	W2OGiAP0dOntgXmHHuj3ZHvFbJ3qhgtE8FjcmKdYcNCXZOs44Pejn2AbTgfVFBVQ
	KcPRsabvYfBr9qdmcr85m4Z2Su8N0WqGWkU/Y/v1F03Hpp0sDQl48h2hCuQ/C1y5
	U5dOqsN0MGr/CrDORB4FU3JHqKAP97l8TVtLjzxwJHg1NZjyrc4p7X+rL1w5EGfy
	8nrIGGb5Z6LI6eJevxDUuVzsm24uYis9KRwscq4VisMq1iq6Y4xLa9XVlBnvNhL+
	PVGW2Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxet54u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:18:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c827adbf00cso3389092a12.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779463100; x=1780067900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mu9+G7n+6D1Go1la80V3lILv4g67InFZue93g9NauiU=;
        b=ftkLxK6dhMF9AwAbOPHEJtvUyrXAAZ53lQ93LqGBR92YBzKhcY+UMnNaqmsgCdJnb1
         CbvHRswCcaDd5XRkbKU5d0lPlLG+SotXOqMQ9h6cM/9OH/jecHdUjizg0Z7YcjR/DGzA
         eYUUUoQ35yWJH81AbguTXDhJo2SEUOMb12ivsfbNkH7JNCOntCm0TyjkMvdeORCUvKKk
         Z4afhvss+k+xOxn+Pz00IxMBgT8CPsnBawC/4SEskAN+XCrhR2KU7CG4Bz6Wmr0KXxNo
         sm7IB7ToK2+YtIh6hiRLsJFCg5Y7P0kqgoVCgW3y4SHy3yxlUw/M4f2LT30BmADb2Gki
         4zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463100; x=1780067900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mu9+G7n+6D1Go1la80V3lILv4g67InFZue93g9NauiU=;
        b=i3DJd18FRScykLX/PeKsaDHZDpdfiMQkQXXw6nSjabMF+0lsAxeAHh3LtUvtbvj5q8
         yd88vYzGbMbxjKNRkRNOaCFCrvIup/nwj1URoa+nRKHSOfg/J5ptn3ENTlXFCcv3JPCa
         +P8qfHqTa6RUizSMuj+/uqtYho52/C0bZSg2W2WRRg97t+sZCM1rbvwN7BTm0HmEJS2k
         H9IM+zq60ojwbuN1PasKw7uxLhiQSoAvrkxCxtXmsTGEdCzdQXa/cfBbXL8O9qAOUeBN
         NzvZESvUpUrOaPUEB/dRhR8eMR2x+GrCkJ/vEeTlkOjUp5E9ZjmnFRzYWDoI/r88YBwL
         eIyA==
X-Forwarded-Encrypted: i=1; AFNElJ/hoAbbD9J55R6EJonxtuybh933bNzKb2fSR9VdrpP3cJHImCZYdMSuSYkQKOEks3XHpqhU9E8/sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcSe0h2aVXiYpx/LumLfDI3A+GLrymaftHlRLQbCHmjwz9tgO
	sMoIhjTKpq9yXx8AeQVygGYAXHJUL4I9CGg6C0u7Mfik+mXMMHTW60FhQ0ejNKllxtD4EYaDxo8
	sLQIZqJEoDVl+ZlxJ8lAotkcpyd6M1eep1IshRrkgOTjbcceCmPY/1muV7FbNoA==
X-Gm-Gg: Acq92OGR2Feshjj5OwyJpGH7cwKsynPeIpyB3NrO9beEJrnKC3FEt95JBkdRlzJCd9P
	4YPr77YFOZijdldAzebN1Uyt5tUoaayQeALR8/fpqehBll2aPoQFt3vfz5uwXwpKtJ41wwBFHSp
	IBRbHeCkGRSkuxopoShhFbgdjXNP8ntZwaqm4aIzK6F2CDBjj7ZZUBNHdfTmeJTLjjTCOziudkl
	xb+IoGyfE3IMss2dvLjGk8v+HC2Sx9oJvFEcj7yAEWLLH086qh69ASrcFU/ysr+r2yqXKcmJ4mS
	W2xvA/wKUAIrlwm6UjesqW6cIQSJzHan4e8mmz9UHs64XACUoEBq479dxGHRBvpTNtZefehZaFX
	bsheMS3XDML4AAWVnbSFJVxc3uuky2m4Utyrc8xPxZD2dz4XGPrB3
X-Received: by 2002:a05:6a21:3408:b0:3b1:80c7:5f8c with SMTP id adf61e73a8af0-3b328e9cc45mr4320436637.28.1779463100314;
        Fri, 22 May 2026 08:18:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:3408:b0:3b1:80c7:5f8c with SMTP id adf61e73a8af0-3b328e9cc45mr4320391637.28.1779463099679;
        Fri, 22 May 2026 08:18:19 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fe97c0sm2083042b3a.53.2026.05.22.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:18:19 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Fri, 22 May 2026 20:46:22 +0530
Subject: [PATCH v4 1/2] dt-bindings: cpufreq: Document Qualcomm Shikra SoC
 EPSS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-shikra-cpufreq-scaling-v4-1-f042a25896c5@oss.qualcomm.com>
References: <20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com>
In-Reply-To: <20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MiBTYWx0ZWRfX4BKQxB4McVpL
 cSqLEIjy9wKQwrVX7irMni+YVKSpwvkxrWiWllxWEv9ixZsI4ijneGv+0tZ0JaWea9JNzOrtxvx
 DenBW/mp+rsDgiyDvZKIlPAyOyGRnZro7Dxlm7P1ugBjAR4KLASSjE7NlzRIqZ0B3vk0KB8vfGh
 kDc/IxdwTE+kdWYAXNz+p+tQZHXwGn2N4OKsHiIuKWrxtZ1h7Kn55lb8VZK3WnlTy6Nzpcs5JOi
 5faMeqvm0NVn56v8W4hvb+W5jZHSYNOEU7vYHuvps1PgwNHbq5EipuVxGl6zHPLenFxFIKjJcML
 jhl4b0Q0W9I5pEL/NeKOPm8v/tUCW8LuPQyLX4HvYYj4+QrVqpT3VraaBr8S1Tvsb0mkj+429LP
 BbQVaCfR42aXi++1RQ9vAT7uNep4nisLCXWUumWM/6H5uy4SKvBSQyhFsI8/9ZXePGOcUn9jwoJ
 73/yQsDLjfd+hZ7f9Mg==
X-Proofpoint-GUID: ptVvEgq1p5N3Lx9j8aIlsx2AwZwrWUNd
X-Proofpoint-ORIG-GUID: ptVvEgq1p5N3Lx9j8aIlsx2AwZwrWUNd
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a1073bd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=sA6xLUNpRn-UYiqxgCcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220152

The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
but supports only up to 12 frequency lookup table (LUT) entries. Introduce
Shikra specific bindings to represent this constrained EPSS variant.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 .../bindings/cpufreq/qcom,shikra-epss.yaml         | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml b/Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1a3105e86980a14069f8fb40c92d1f9cc71c6c1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/qcom,shikra-epss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Shikra SoC EPSS
+
+maintainers:
+  - Imran Shaik <imran.shaik@oss.qualcomm.com>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  EPSS is a hardware engine used by some Qualcomm SoCs to manage
+  frequency in hardware. It is capable of controlling frequency for
+  multiple clusters.
+
+  The Qualcomm Shikra SoC EPSS supports up to 12 frequency lookup table
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

