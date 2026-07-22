Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108B3AFCEB
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717101; cv=none; b=sJ5p9Bh9Bk3g3FUG3A9tGb5yxmHrbTnJdI+ALluXHO3L4fRIcbql7YGlVnwV3hFjuG6q6R8wiqm5Wcz+UNCLabU64fpLDnj7+TWaT0wZG5GUTCV+0iuu4bEpBrxc9YANenurgSLi45SVqvL8KL5ECU2mDXK9eibd3Y4GWmvSgOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717101; c=relaxed/simple;
	bh=we1L1lQ5lcQSoRayGEALtC+WkaOOAukyLvGKMNh/VIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FbmkXEqiVpgVTbNyKQUvh9wTuywv9z9gPkLJitPVIHULnS8GHyM7mbD9oUUWDqBiJVH7Oe5vOOh8DIVPrgNSuwlJ2d7HXNE6CyMt0m0EBHcuVvytT+9LRx9uuvmIAQXZinY5J1M4bbOAlHhDEhLzfRm159mmpfCEZZw29tKH2o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pojz5FDA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CiRV5ZIE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pojz5FDA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CiRV5ZIE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xIxb4018323
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GAAgAP0V7LjmvDcg7cU4QtLN1FT+eQx8NoMPuNIkpro=; b=pojz5FDAs1WmH/Zz
	4eurqxyoIhAan8Z/MhvynjLMSxvi9LDSn7SmcvhBLzwKdkPJcU7cWsYXoRRknodT
	eePyk/b3ZXY62uuKtMXQt2CjiKfNQiQsQ5kGHuBGW8UG8if20VkyXFLauNKhEx+l
	AjPq80rdF0hCvA6yt4z73pUrLukFvEPLzJBKLxKcu9D50cyDYxnr+qe8fN2w9E3k
	uiyGppf8cRFl5J1WTe3pwBd//dNYZ0rGuyxHbLq9y64TSsfs+o1LUNIRdapo4mi0
	k7LBXoIjXiendtEBCZs1wK95NPVrmhQ/JgdZb8sScBbOqnFMwIQMma4JC+4CshSb
	seCGRQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6fumy3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:44:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6823efcso109468815ad.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784717098; x=1785321898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAAgAP0V7LjmvDcg7cU4QtLN1FT+eQx8NoMPuNIkpro=;
        b=CiRV5ZIE17zpGIkQ1WwqjmX2zadsb7Rios0bRvZeRWgdOJ37cE0RWV86Q7DZyE8czQ
         l2XlnwEec8+C7Udl1LRm7znCSCd3wboKsv0VWc7jgcb17S/jQt+H2TjybnxENy7bB9G/
         8HmVwiy6aIEDE+JzIoP47ZaUfFdOX9+A7x6P+Ko1/XNI9PQPGdUt7OF4pk3oC2TFC9qG
         yMlenx4hEoxe2dTc2Wvh6BIPw7F2DEgxpDu7C7AmDr9RGsLtFua2zV6L56bCorZAHE5R
         KqcCDc+g6otthxNIcE0KlpKwuie5fUnA1bnLPx2Fs8AAa1+ZdbsJN8n8WVZMmWnug34b
         V7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717098; x=1785321898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAAgAP0V7LjmvDcg7cU4QtLN1FT+eQx8NoMPuNIkpro=;
        b=qV8T99U44SMUlX/JUSe45ay/+3W8UfOmkri+rK55ayti9DbjLg05EsEJNvT/z1q1vS
         MsHvrbT27yQ/Y5YADTE9X097b7w0JtT/4ornt/kwvL4HNQG4oGGPPoLg9a/AqLzPy3Qn
         dQf9vBF99T3hM48AnEGcuWNTpXFF4JwgMsTN8jGxoVf6HcLv+AaVDnk3XOLbbTXe+95s
         tYD7Ou+mFK2yQFXD2kj+b4fYnSeXlM+BlH4F9vY+4JYsGIzs4Rm8VqdJ14t7faeCW/AT
         I67IZLtixA8ztOUpv+BytDTa6jDuv1+SM2HcAGz2Hsy1M98m2rjn4AvHukPDejnWr6RN
         xDAA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+foKSHF9x2KAWRqL3xIvLbWtGX4/Xtw+5VW0HB1HdF+HOokvMTCAA0lvPo8PIaE1zT9uTnwes8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqqRHQp+KDynDcxVZIXKu1G2GCZjx0hjZ6H8hx/Aey8L+Q7yLZ
	Fk7bjHu2lvDsG8NVfE29aG6thhn1NTjoosqBcO3regf/F4LIgiXfrdXi8mmy52Xq3xGlC13B9tf
	KYQPMVIWl6OmsIXRbnf7z32hd5b7I80LjfytbnkfW2GZPCzzmENeXB2LHufie3w==
X-Gm-Gg: AR+sD13Bs7JFC52QrjYdqT7s9yRxEygIHIqovwQHUWjkqRdjOLOpSIRh9vKOeh7eHyT
	iSkUR/Mz2Pe1nFg6QvhRPYOJDrCYYyWLM0dZNHJzyYiTwbvVDUoVKz9nfbULr6zMm/9NRXFtnGn
	CwqSsf3b7zfPrLSz5gntfcSqqX63RWGt+YGlvvvLkSd55++w/qodaVov9NMkATJcxfB6etx/Y5S
	kJkCRGCi5YntR71vfLbb/YLkPuBDRF9agZ71pPuiOIYSAYH+kZBwTg2qXYa0foBgUF1lIg+zmDX
	Gatl2tjMv6M1Tn/x7ba1RG4U9XeXNoUW3uNc9QVqSU2ye1bF1TDg2ByualQ+YdJHUKXobA8CPO0
	jngMrTxUNSc5YwApSEAVc+y8aVoi+jCHG
X-Received: by 2002:a17:903:1c7:b0:2c8:1f56:9fc5 with SMTP id d9443c01a7336-2cf349fb45amr235093165ad.35.1784717098431;
        Wed, 22 Jul 2026 03:44:58 -0700 (PDT)
X-Received: by 2002:a17:903:1c7:b0:2c8:1f56:9fc5 with SMTP id d9443c01a7336-2cf349fb45amr235092945ad.35.1784717097973;
        Wed, 22 Jul 2026 03:44:57 -0700 (PDT)
Received: from hu-sachgupt-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e797asm12382455ad.39.2026.07.22.03.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:44:57 -0700 (PDT)
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:14:41 +0530
Subject: [PATCH v3 1/2] dt-bindings: thermal: Add Qualcomm MBG thermal
 monitor support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spmi-mbg-driver-v3-1-ef73064f2789@oss.qualcomm.com>
References: <20260722-spmi-mbg-driver-v3-0-ef73064f2789@oss.qualcomm.com>
In-Reply-To: <20260722-spmi-mbg-driver-v3-0-ef73064f2789@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, mfd@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Sachin Gupta <sachin.gupta@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 97F_ank_eLbCPM_Qsdug3rDwcxmcMxl0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfX+AqS8di5zrSu
 xCKJEZRWLCLriux4FbpzYkj4riZ4oNUJMtzlhx/nrk0zjN70yyqKB5NGjrB4wdVxZvatnaAyqtQ
 WatPB/PQWp7EmkWGSy5QWnUhazZngI/an4YYtDGR9fLy58RDnDeV+rouEtTIyDib7lhu3KCz30b
 igSrPJwmPRYpG7srkf/ZzDOlKJANU9LzU8Rt9A3AVVrU01FFJzpP6C5DTCWo5fk2ybHhW1WMZqp
 2z/p+Opj4jMolXEP/vJlgvEgDilrdaJG+twlRE9ffVrdbWURLztAPPn97MZOOEFhYFxrgSGEKRK
 jnJ7951eYgYKdo4s33QFpgqrPU1usJRjvlPXMp+xv6KwQ20Sepf3M3/zlxBkT8scbAEgnVs0thM
 2KQ51kTPB1tP1AIxdIDXWM9/526lgxm2Il5EwF0xswyxLlzh3cWS3W87sq46JnMYwRjoZXp0OrN
 OJUjls6pNVvvoVGvBKw==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a609f2b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=E-gG5h9l_blIFwvKag4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 97F_ank_eLbCPM_Qsdug3rDwcxmcMxl0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfXyp1MltXxKB3k
 M6ZtbdFSe7kyoaiUQzOEoSmtBAC48v2hIZkQUD3Qzw3oxk3Cn0He+SOLWTkPJoSQnBCn5QXNviF
 rLQQYOUp1NWtk/NMKOZKwURT61AgGf8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220103

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

Add bindings for the Qualcomm MBG (Master Bandgap) temperature alarm
peripheral found on the PM8775 PMIC. Unlike the existing SPMI temp alarm
peripheral, the MBG peripheral supports both hot and cold threshold
monitoring across two programmable levels (LVL1 and LVL2), with interrupt
status reported via a fault status register over SPMI.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
---
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  4 ++
 .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       | 72 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 809be2756a0c..bd77cb7173e2 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -194,6 +194,10 @@ patternProperties:
     type: object
     $ref: /schemas/thermal/qcom,spmi-temp-alarm.yaml#
 
+  "^temperature-sensor@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/thermal/qcom,pm8775-mbg-tm.yaml#
+
   "^typec@[0-9a-f]+$":
     type: object
     $ref: /schemas/usb/qcom,pmic-typec.yaml#
diff --git a/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
new file mode 100644
index 000000000000..2e084d040625
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom,pm8775-mbg-tm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC MBG Thermal Monitoring
+
+maintainers:
+  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
+  - Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
+
+description:
+  Qualcomm's MBG(Master Bandgap) temperature alarm monitors the die
+  temperature and generates an interrupt if the PMIC die temperature is
+  over a set of programmable temperature thresholds. It allows monitoring
+  for both hot and cold, LVL1 and LVL2 thresholds, which makes it different
+  from the existing temp alarm peripheral. The interrupt comes over SPMI
+  and the MBG's fault status register gives details to understand whether
+  it is a hot/cold and LVL1/LVL2 violation.
+
+properties:
+  compatible:
+    const: qcom,pm8775-mbg-tm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  io-channels:
+    items:
+      - description: ADC channel, which reports chip die temperature.
+
+  io-channel-names:
+    items:
+      - const: thermal
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - io-channels
+  - io-channel-names
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@d700 {
+            compatible = "qcom,pm8775-mbg-tm";
+            reg = <0xd700>;
+            interrupts = <0x1 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+            io-channels = <&pm8775_adc 0x3>;
+            io-channel-names = "thermal";
+            #thermal-sensor-cells = <0>;
+        };
+    };
+...

-- 
2.34.1

