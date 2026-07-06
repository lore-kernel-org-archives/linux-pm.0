Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D639A07B
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325738; cv=none; b=cgxJjYnaXgyV3w+8kTO1xI4kwwLUw2QD8ev9DApr2IR5skBsH9SZJr0lNQFZeoiCORJ/ik7EP7Iid1lgd6o9sUzedT3sEtN3v20cHLAzw1tyDoieqDHqa69jWzy8OpWhZ17ahK8OWBOk3HZLO2GzHD81BqZ6hDs0q0jMEkVGMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325738; c=relaxed/simple;
	bh=HfW02N1l4i7cmbUtMhYPdTWIGgGXsEjiwIOB8y3xC7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKubjhmqfvKqHrXB+Ixa6i/gUdOfPJbJvXSAveZdHkUmbq+WNpmXLPI2OQzINbz8v8ehGt+uRvbjSOfcGf+CUi5E4bncQo3mgdEeskRYNyZ9cV6rJXx2SJfou7/vgdWesR4uAQYfiFbhb0RODaWe/uTvciOUK48CRsjO+HnP5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pxPgJhY3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SfM1I/LG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pxPgJhY3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SfM1I/LG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641R8c3459041
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 08:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AQ+KvHpKSyuoob04CXLtszZfz/siqFdFw5I3KK1ovkU=; b=pxPgJhY3u0cIEi4q
	ZFmDtEANrUdbSlxnZ0xsn7xBJWtYSzSVBz4ES+sDDXu1MUqmRD2yb8IjBJntAyGA
	wzcr3/eQM8lPoo7K+q5o6/BCq5SKTPOAQrj/TNnj2B5pNfa0Y2TMLOzwOvj1pQsF
	fYlTOEqVpGpQ0OLoDvFzraQ2/u23lXM1wFwT0cETK6+857ZpStStDFN1I5iL90eE
	FjWZ4WlfgKjtxN0eaRLyn+yVYoQ1UqUoh8Wn+F4FhDAjwH/WN4Yy2oz0ScC83RZG
	BUGIpfKKf4x3fNXi1cqoOtrfH41AWhJ8vf7HjukXJwfTWk+yYgX8luGt8TzpMuDc
	qpDwEg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf852ye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:15:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so2229114a12.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783325725; x=1783930525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQ+KvHpKSyuoob04CXLtszZfz/siqFdFw5I3KK1ovkU=;
        b=SfM1I/LGJR0ShEJZ5DBMtXfGahAfQzwngO42xwiyW3LnsFdKAE5q3EUUsTF1Yhuh/E
         boUD8FKOP5+DpzRjzSpU0GYhrns6ZYsWHCfS+8Do6qaZoNxUx0uetV+mbvsPdIxTFVGs
         0eTT+xFHIsXk3kDEtK+Ua4SDIXKXCCJshEEP/mZYue1Ejn7FTHcHepSIadWRkIW8L8Fv
         /zI09fBvI7Jzz5mnj10HNYi8joHc/krT27BFHzBdliVrEtBuTBN0OE42ss5wSUvYTahe
         M9aSrGualhvByWCsgpECr/g5bzkn5IK6+qNVwccOD+89OZ5x1VQtIh86PjFJPyaynvxY
         7ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783325725; x=1783930525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQ+KvHpKSyuoob04CXLtszZfz/siqFdFw5I3KK1ovkU=;
        b=C+00V0vaVdRt1xRkMNbngkqzJLmVN2voEe94FFwDql8q/VbYVKRpUaoDf9uS3bQ6je
         +qcJh0ESIqVAIktM5jH5NkBIc2gphJ54uoSQ5gzJFff5kGHIUdWRfMu4E0v4P7RUZ5Bs
         owKHbRBlJBqXUiNSaA5JCVIYStY+iR4OBzswpe49tnOvABQPYr6FmTjZj7tM8T/nB4jt
         n2RQCWpUysj9YqnKTvGSeh9hvzgLctIJMTGE8qP8KB0poDrzUZGwip2MzDFFaWia1b17
         8a4ujsRA5Kcg4y1tu7q2TtOFDuCQujG9CiprDk8hwn5VTjtMLiunsUXUYetgvC1/x8ZB
         SgSw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1kwGnrbNuFunDi8t5CYg1PRGnArjAmSu8TSns3ZjPIl955pRIY5gsA1d9iEg9ydxUvHieWz2x2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWddNchA8m24dp0kfeQHwWjXAGWQpTzXvvL9xOhYOo1XF5B/V
	VnBfGZfK88zD80cnVxhWieRKElkxYFCEXG6uxm5qv0YHzbEYEbphqi0alTdqkwyRUR9JODUtHlK
	MIiKpdW4ro+5FHc1n1LxB0BI8semCEunQl3kPHVmGTVR/TWl180PdVVXxoS7s92GJ2XIs6g==
X-Gm-Gg: AfdE7clZBS09eLzYDVUXQ/ag7d6FBcr6fnviYMsfG0MsL3L7W3b8kCwStrnDATGIUuY
	wiiZTAorVOWkREv7mGEguo6BT52qrtkOlT9ppZT/0vERmiLl4DAtnijPT8aCADzXc8OUkhpE0wX
	Fkl1kt9PYwvvuezuX2O3T7dekJRAVreJO34XGtwfAPuZdDAiXJ+jFi+RCEOGs69TaDW+xG6SgAs
	2a3iSggWIDuGobTt1VwpGxIqcFFH7Ev/Qo4b7ixusfOvpilRCk9v8ZgAwy6kYtp/0OsBEKv6K3E
	a2fvKGJz0l/LKYXhrjsv65gr/3XsA7YWRGAGJTtR4vAisfIvEt4ec5Tw4jFiczTOQDmn1AjGejp
	POB+/L9052zoKWKKMsvqwyurlxkfExvMNWUtj+1wxSuo=
X-Received: by 2002:a05:6a20:3c90:b0:3bf:6c04:a817 with SMTP id adf61e73a8af0-3c03e4dee8fmr11935120637.56.1783325722480;
        Mon, 06 Jul 2026 01:15:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c90:b0:3bf:6c04:a817 with SMTP id adf61e73a8af0-3c03e4dee8fmr11935058637.56.1783325721949;
        Mon, 06 Jul 2026 01:15:21 -0700 (PDT)
Received: from hu-sachgupt-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f4cd4b1sm5584525a12.12.2026.07.06.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:15:21 -0700 (PDT)
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 13:44:35 +0530
Subject: [PATCH v2 1/2] dt-bindings: thermal: Add Qualcomm MBG thermal
 monitor support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-spmi-mbg-driver-v2-1-f883ff1d8719@oss.qualcomm.com>
References: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
In-Reply-To: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Sachin Gupta <sachin.gupta@oss.qualcomm.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: JRM36spDa1a3s3KG--RNbVngCohtbaGp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX3ZuuGkvOB0Wz
 m9XttjHE8VfQVhcF370eQb8ReQ9m8pWz7zOlY22EjTxX7s58jAhoP2XsSJEXSbujJjUrAD3ZFaK
 QkE5AwX2alCdbbsM+r6l6ULtV6LDOR0=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4b641d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=E-gG5h9l_blIFwvKag4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JRM36spDa1a3s3KG--RNbVngCohtbaGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX4Ev3MlAyVb1l
 DdYO/RyBHKDA4xm9eFfENGMkbpQgXyHiEu3llMGcKzGPQWPlUG5zOGwvXazrcN2TetunINMRFCE
 I08hE/xsQEj7PMorGnRoVkN9lT037oMqlPIbCtA/9JXsQXO1z0vg9QKK4HgLDXXVBL/ioU2GUuf
 nyShawIGrn/eyPIQHmR/K/loViysbGX9Ydfg31QPi8muCeGQn5wn6bsvx019YNhxb7WlWXvtotI
 iIFCE+L23KIgbsDUXG80W1LshMJ5N9N1BqGaf+ruRbCC4ay9KFxSzQqpuyVsySizpgUvpRAPNQw
 YuPekj+fE2Z7SZ+6+5DQU/U+fgLHM19ozFT4/Nu4Hf2JbiyodaCFhY8l8aMSnWYcpR8vRwsNv/8
 SFT2AOITI4nwsWS+lu+eSwlbF1DJLHEnB1gIp40GDG7M/pJc84U2u7QjDzwyJPJDAwrB3ajnwoK
 +DTCxRx4QUpAz7KO/Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

Add bindings for the Qualcomm MBG (Master Bandgap) temperature alarm
peripheral found on the PM8775 PMIC. Unlike the existing SPMI temp alarm
peripheral, the MBG peripheral supports both hot and cold threshold
monitoring across two programmable levels (LVL1 and LVL2), with interrupt
status reported via a fault status register over SPMI.

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

