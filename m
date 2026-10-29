Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259045;
	b=I0QasB+nJM+E+07yXqhx1Ha78drLCN/u4AuubfdgjYolEJlkuFeW6jz0c2nJeOrGQ17J
	 Ce0bHrpNyxoEgMtRy6CCbCaUnyWoxnACYtSsi7qYsf5mnHS5dtYxFXnMuXL++PmJdTiwU
	 HYQg4GcIv/bB7yKrNOmAuTtjkGhp2r/sAczZCb5AjxS8OntMzTwN5lZwvmn51CAkMBct+
	 PHmi8YsRtU8XGIexAwdEOyw6wdWReGtRY4gKklu3/2p6ijsXmCbC6VoMfTumAaT3rbAeH
	 H1VbUVLdxPtr4MUm5pgkV2i0L/zNk080nWdzVqWADx0oRE+3G5XqJHi6pqJHFv7/jDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259045;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HyWEsx1GlWlY3L89mEqtrYdx5WTFLSmuRxoVGkH2Jks=;
	b=X+K1FPdjxuvOguO/N+/urMaQeyT7kBwWcNB8caVufv6oJz/yYtYncA06HPrslWqmVFrd
	 Q0dGyo88VnHhi9lGYD4+d8d7FWPGZD0e1KqGmpe80na2nmKRwfgqyO2G7EyjRo1cXYjVq
	 UKCJjDoefwURGP8U3ruYhJ2lBN3rIlTpLEvzsCsF8p1fvAYF50ol7EXr/zudoVgU1LV2Y
	 kPwB6Vg42Swkn5mezaKh/E/ueG4v3Vey9B2BB/e1UsnXpi7S2EPgxduduMLUTnF3jVcnr
	 vGV1v0Tk73dw43M09UIzjoJ3pMsU53sk3SpASW//8opUQi/zoHJvIgJ2+0BBpR9ci/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=PBL7Ur3p;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=aEWdrYNr;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6001606A324;
	Thu, 29 Oct 2026 07:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6001606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=PBL7Ur3p;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=aEWdrYNr
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5GkaW1940240;
	Thu, 29 Oct 2026 03:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=HyWEsx1GlWlY3L89mEqtrYdx5WTFLSmuRxoVGkH2Jks=; b=PBL7Ur3
	ptRzyximQISPEZk71j/Wwqwor5+9vn5E54O9gyALWMu/tTYe5h2oilHdBrPo4Fd6
	eT7TFLSf0JhcCfyC7RtWlpL68ty9BUfVf7DZ+20O9J9XH3P4686XOQVQ27sFpQfK
	l2w12iEqvTaOdRGy6ZoEkwCeq89t3klwxolxZ8bHLQVYph8kW6KIRUyfPBCPpyn4
	6kx+3CEJAm+eaFTMZy8J/Qdqv9TpURCtETghyCdl8+dLb5oGAl4NEcEW58A0qO6h
	nXB2sD/ah+cIssS98hZWEDf62hG2XfsSegZxuKPToMvv80xjIFgbSGvxvn7DKfsw
	wAu0dhZuptQGGPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HyWEs
	x1GlWlY3L89mEqtrYdx5WTFLSmuRxoVGkH2Jks=; b=aEWdrYNrS/fhE5zTzKVFA
	2ze10N3MYUka1hYJvvDZXMXRk5qALREbnCRiVFm4fNuEBqydji4BpdbJumGNKQPx
	UDMJcJTSGhqQF0VPcxJtN3IEklUT0a/kl8X8yfT9//qiBRqy1iMxDw43RIVva5wU
	Z3yha6jMm8h78W0Tm+dbxF6I8rJKD/eTdNRJ3dJMOvYQtkhb8Z6Zd5ybAGU4QSRC
	v4UL+ilDPTt5751qW2IltRdE39j57kiq9B2277Ke8aoy8LxPwBUU5qAvxrTI9nMQ
	MdNJ3S0lR9jp101BrvAe+7eDwPpVTWAK3UqbMBedxbZmgU20rZtDFIaqgCT60Z5G
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hkrqh300e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 03:30:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69T7UXYN044471
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Oct 2026 03:30:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Oct 2026 03:30:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Oct 2026 03:30:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Oct 2026 03:30:33 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69T7UKMJ010624;
	Thu, 29 Oct 2026 03:30:28 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <sre@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: supply: add adi,lt8491.yaml
Date: Thu, 29 Oct 2026 15:30:11 +0800
Message-ID: <20261029073012.1498-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261029073012.1498-1-johnerasmusmari.geronimo@analog.com>
References: <20261029073012.1498-1-johnerasmusmari.geronimo@analog.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: pDQQd3-LQvDxGisjU94vocGGfo1oVOI1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX+32yDyqm0NiQ
 G4XKUxA1cOTNzSfgGY3Ahur0W7fnPSEnvu6P9CTwzs15ZZI0/3NqJDii4/RTUvhH6GMg9e31jny
 FTjUlhMjOJI/I9vZ+uTA9TRlRCt+wu1xTLxfbXiV9pvhH6xwD4pZ
X-Proofpoint-GUID: pDQQd3-LQvDxGisjU94vocGGfo1oVOI1
X-Authority-Analysis: v=2.4 cv=OK+yTiaB c=1 sm=1 tr=0 ts=6ae2f61a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=C-PO4pFZFlxbmb0oAE0A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfXzIgGxxAT2net
 2EjIre1qLnu9s5e+1D0xb4FbdDgW9eTu3ATZYDqNOPRfuYvuGdhwlF+sJefPsoTa5zqOrCN7F3L
 RBkrJqKJnujQsQ42QXoE/p1KeSNqgOkCfcHSKyO0JqVN/Me500+ua+cfRPi+ZVNWXD+VioPULir
 QY1MkrmnTKgyelKSRNojzSZGMvAeqVfqhp2S5W0hiVc5cn9fALRo8TzhBU8F3OW2p3bDIT22OHS
 +3cTHUP4gYxKU0vVOXMJcbSc4i82p/0y3L5suDm7YdU/O+Hy+qP0lSZ/HuHdvKthVALKxuZGkpd
 S+vcN3NlWk3LZY2w31FDP5VUB2iENEBLU3qo7q+i2SJ9lx25O6ulFOdRdQN6B0sI6stQRJEIXiq
 nv0PExTNfXDzU8LdLVFQprVCDpWTkq/MIIgCzGE13rMlup0+TBXVvqi0QubejnSXrp3Jdmnbzt5
 cVm6PrfdzKKa6hBuCgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290028

Add the devicetree binding for the Analog Devices LT8491, a high
voltage buck-boost battery charge controller with an I2C interface.
The values of the PCB resistors used by the chip's telemetry are
described as properties.

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 .../bindings/power/supply/adi,lt8491.yaml     | 92 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml b/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
new file mode 100644
index 000000000..268289841
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/adi,lt8491.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology (Analog Devices) LT8491 Battery Charger
+
+maintainers:
+  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+
+description: |
+  The LT8491 is a buck-boost switching regulator battery charger that implements
+  a constant-current constant-voltage (CCCV) charging profile used for most
+  battery types, including sealed lead-acid (SLA), flooded, gel and lithium-ion.
+
+  Specifications about the charger can be found at:
+    https://www.analog.com/en/products/lt8491.html
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,lt8491
+
+  reg:
+    maxItems: 1
+
+  adi,rsense1-micro-ohms:
+    description: Resistance value of RSENSE1 in micro ohms.
+
+  adi,rimon-out-ohms:
+    description: Resistance value of RIMON_OUT in ohms.
+
+  adi,rsense2-micro-ohms:
+    description: Resistance value of RSENSE2 in micro ohms.
+
+  adi,rdaco-ohms:
+    description: Resistance value of RDACO1 + RDACO2 in ohms.
+
+  adi,rfbout1-ohms:
+    description: Resistance value of RFBOUT1 in ohms.
+
+  adi,rfbout2-ohms:
+    description: Resistance value of RFBOUT2 in ohms.
+
+  adi,rdaci-ohms:
+    description: Resistance value of RDACI1 + RDACI2 in ohms.
+
+  adi,rfbin2-ohms:
+    description: Resistance value of RFBIN2 in ohms.
+
+  adi,rfbin1-ohms:
+    description: Resistance value of RFBIN1 in ohms.
+
+required:
+  - compatible
+  - reg
+  - adi,rsense1-micro-ohms
+  - adi,rimon-out-ohms
+  - adi,rsense2-micro-ohms
+  - adi,rdaco-ohms
+  - adi,rfbout1-ohms
+  - adi,rfbout2-ohms
+  - adi,rdaci-ohms
+  - adi,rfbin2-ohms
+  - adi,rfbin1-ohms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        battery-charger@10 {
+            compatible = "adi,lt8491";
+            reg = <0x10>;
+            adi,rsense1-micro-ohms = <5000>;
+            adi,rimon-out-ohms = <124000>;
+            adi,rsense2-micro-ohms = <3000>;
+            adi,rdaco-ohms = <64900>;
+            adi,rfbout1-ohms = <113000>;
+            adi,rfbout2-ohms = <10000>;
+            adi,rdaci-ohms = <7000>;
+            adi,rfbin2-ohms = <3480>;
+            adi,rfbin1-ohms = <102000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d..2b3cc7649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15466,6 +15466,12 @@ F:	Documentation/devicetree/bindings/hwmon/pmbus/adi,lt3074.yaml
 F:	Documentation/hwmon/lt3074.rst
 F:	drivers/hwmon/pmbus/lt3074.c
 
+LT8491 BATTERY CHARGER DRIVER
+M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
+
 LTC1660 DAC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1

