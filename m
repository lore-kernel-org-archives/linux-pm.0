Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277926;
	b=IxnMzjJ1gaCEJgGGL+/x3EtOFsCWRhj/VZge3JbTMPDXEQ0CeCcVDBKZnPnJ/Y7JQz50
	 8TNlvr1X0G5yZGtiHvlrGa2MDYXL/PVPWtdpt9+Vf3MXxKUR9WvV+QgY1oekdLdnkBagZ
	 /dq4nSKxw1PYxl3BVaEFAA8Q0T++KqcaTjsqBHajZ2a4n+hoH64sMBcsErYXfSobfon4G
	 PVfGNVJ0qvevGQ8Fu6ZxCSCizW7zJiGryapB78GFnpAKbu88KXsHtqXfBrSo20z9GkRYd
	 khfOjaTdEgwjId35iRI8NVSylOu0cjBIyKFpNt3I/bbri7AFRUJuD0BnszavwN3NVRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277926;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=V7OhX3p09vKU3aS4SB+lRq7VpBYE72fDlONfPMkLMXM=;
	b=1iiSihmL2C2OHt7gMPPQrCIQUMck3P8IXPzIRCUjEsG5KZyWvltkaxuiU6k9MYF1m+m+
	 k3qaPYyZKwkWv/84apWyXNNerjJ9nR8xdV+TAPDehdPov2kzPI+xBHGENMLf9GWwK5E00
	 ueWsez/a5OqIST0/X6wbr3XkehewXEbywYt/UH/CsRqE5rny80WZiPPFDA0tYMZVGIb47
	 dQ8I4+1pLtc56xw6R/uJQRtPAR0btnMAElqrU4N0Hy2sLnCVZ+zRrYVVsJ+vOg5cQzxJB
	 Qlx7HAmiLgPf1GBsFQ+KzHnHIl8A2BghaBpLuN2MxPDDLVBBa/QnUzOHUt1000Wk/Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="qck/KGJl";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gpvaeGMS;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04070606A332;
	Tue, 10 Nov 2026 02:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04070606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=qck/KGJl;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gpvaeGMS
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0kvPY617494;
	Mon, 9 Nov 2026 21:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=V7OhX3p09vKU3aS4SB+lRq7VpBYE72fDlONfPMkLMXM=; b=qck/KGJ
	lk1Ui0Cmqz3SeZXfnmh8Xmq1djPuojZHXXhtKvMQFOY7NHPIjVVGUNb08snbU4l6
	J9F7Gtyycjmu81i2VidCr7DAC6X4CtB6BkLTDVNE5FH3lBioHe52x959NUzwtxsw
	D1XVdkCpAIWg9BQpjJrM0eyUq0cUKXW1wa46D3mjSSl5Rdbfyk/xlDJVwKE6q+1J
	0zoBgsqYwvZCYLtfT3HvS0ec06ZYbkweAMtLFyC85dglawltywWMJenPCaW32+jA
	FEb8Mqx8HUTbg+ahxDiTKselq4Jto9aXTItYZkwLCa8O5VROAqMmESeKSXKTf9de
	XMtuXT86K89vqLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V7OhX
	3p09vKU3aS4SB+lRq7VpBYE72fDlONfPMkLMXM=; b=gpvaeGMSxmeQKw9JU8OCM
	k79eoX8A000DhZ0HLgvKLWpUhVsPDiW9UFtYr2SzkD2YcjAUAiVeDL+/G1px76H5
	WB8k9JHVVur74D1xGg5wXnsYGhKSy4X5qzk0igeAAQdSQDx9NPlljn+mgVBX7nel
	1F5nl7ATv/uotWQLaNb0XYkpm39IN/7o/Ps3QAwlrmb3BwqPcDYq4ZE5kyXNvzKd
	V+pi05CE1Fk63LWe98SCjJUbUeU0X9ZH1+TmZOjxM/iM9Jj8YgI3gAXVPhDFesF8
	n1a+kT9SIcOrRBTonoGjzAz2ClIsNf051k1DQHNbYAp3qVzjWmRlM7mh1IWw0I6r
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hup1ssqt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 21:32:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AA2W1T6039275
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 21:32:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 21:32:01 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 21:32:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 21:32:01 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AA2VmeA016682;
	Mon, 9 Nov 2026 21:31:56 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <sre@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/2] dt-bindings: power: supply: add adi,lt8491.yaml
Date: Tue, 10 Nov 2026 10:31:39 +0800
Message-ID: <20261110023140.468-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261110023140.468-1-johnerasmusmari.geronimo@analog.com>
References: <20261110023140.468-1-johnerasmusmari.geronimo@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwOSBTYWx0ZWRfX9D7LarQSC1W2
 xyjmVXP0/ruH84k3tQs3ACbmrdQ+DCQs2cWFVpPFpDBcPDWdvHHzvbXHyXpb/GPT8p4AwuxljNR
 y2DV5J6797MX7um1WemIJaf/HV9KLHMUmP7Hy81FNfHlj56W5DlB
X-Authority-Analysis: v=2.4 cv=dI8zC+Zb c=1 sm=1 tr=0 ts=6af28223 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=C-PO4pFZFlxbmb0oAE0A:9
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwOSBTYWx0ZWRfX8Mw5DIXvLJvn
 vVj0aHa4RuMf5SZOdcA7C3V8m3KNmbtN0P/5C1AaRLwnQwOmiogw45kzVNo38eIx5RELr/mbr7k
 lnCyc62hIk86rZ2fGL7LB4YCeL4WZSJos8KUOC76Dw7/b/npjvQvUTpkuaN1kpJYqZyZ95y2t34
 H2FPlpo98V150lRy6V1t4mpNC18dduewdyVraET2IrIL7K6kvr+WXQov5ipc2amzJ2kT6IRJpyd
 yJHA0VOhltE05nrtGb+GKAdwLMyjU7NwM1WVE2KveUk/xHMuOXlj6VgTuUCSqlBDX3Cd5djbvv3
 fZ3MDfEwMRkcYGeXXaS3Lyp6iAtnTaPFZO9C2OaJBWxKByyZQMaNaMuGi8L9KT4Uz2la1jSk1vz
 rwIyE0w6lQgWm1Ob+w1jhIupcF33VSPPwrMmLEM5I7mzNaySNgdr+ai+kDylynk2xHwRRs92B3C
 /WGhH4zmA9pU8esQhjw==
X-Proofpoint-ORIG-GUID: MnfgfCNK_VIIkpmlo8bVWhe4LFAU9_XN
X-Proofpoint-GUID: MnfgfCNK_VIIkpmlo8bVWhe4LFAU9_XN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100009

Add the devicetree binding for the Analog Devices LT8491, a high
voltage buck-boost battery charge controller with an I2C interface.
The values of the PCB resistors used by the chip's telemetry are
described as properties.

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
index 93abbb315..12e8517b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15807,6 +15807,12 @@ F:	Documentation/devicetree/bindings/hwmon/pmbus/adi,lt3074.yaml
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

