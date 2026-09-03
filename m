Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E14908A3;
	Thu,  3 Sep 2026 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432431; cv=none; b=TVfWDnMeyL72Kgec/l70+yDxkzVHHVQ4ZVPvO0ga/1+/Wubwx9jnIrZASSI7DSU5UF9yyaB23gSI1mCTsvfUWHBG5OQwyAksoFm/Xn+c2FLVNVrtJgxcBxjT0LA4jiZEeD7iY4/uw6vsZiu7Dl4eiWfglVssNdcyr0uRuEmAOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432431; c=relaxed/simple;
	bh=nasn8a+u64Jp/Ldgvax4KZh8rgvmhg59y2Y5VzvJpFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcM91ZiQWqYlG6iWC4ikB8qDJmlB+XzLbEpXgJrwQF2eMGmorqaS9r/D3N5JNWfYI+UouH/DZOkV+f/V31xJbf+miGw/5ARhm1BvFPtuxlwI919ePOQaJUMVIXTrl1QCyOknax5SKrWoh0x11nDjzzXg981IXdlwIajZWv6LNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j10NjWSs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j10NjWSs"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AFHRO850908;
	Thu, 3 Sep 2026 06:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hLYEj
	06M94HfmBPvG5HWcvQuhXjRwfOALu8Grhspl7U=; b=j10NjWSs1wUshR635lH5N
	uHljP3sdDK3LhwCBi7damWI4Eqqt3ZIycwaYDqZWpqAFz7mhw/53+MTuDG8iqmUy
	6I7DAWM50I/v3HPzuIkGppxiRvXBTgKjSoUu/eOju2Qaj5qmMY5b63b2shkJbFff
	hahISthD4UlXTEk4fTyWiNBmkC5cl2DFDHOzXDHprNwwoN6I3NsAyWH8D+ATaYEP
	SzcjUG5snEuECeRqgwtv6FU4nZCiRsx+08jEwKUEdA/Ssw+EmS+cxxVVVnD+sd1t
	9zlQQOM2/gly0byeQVEV4RwBH9kNnA17YN6wX7p50b0ckKjj3l09zxThuEBb9Hav
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ufb8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:46:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 683AksH2059064
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 06:46:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 3 Sep 2026 06:46:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 3 Sep 2026 06:46:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 3 Sep 2026 06:46:53 -0400
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.223.216])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 683AkdDD015001;
	Thu, 3 Sep 2026 06:46:48 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <robh@kernel.org>,
        <sre@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: add adi,lt8491.yaml
Date: Thu, 3 Sep 2026 18:46:36 +0800
Message-ID: <4cf7fe04accbd558c4f0aa3da2f648b8144993be.1788432152.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788432152.git.johnerasmusmari.geronimo@analog.com>
References: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com> <cover.1788432152.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfX2cwIMLI7QuPs
 ZiGwbZFDkyvqqCWyPevYyc4fkvJifAXIsPTyXkTX7Zfg3+quGVQarOcPI51SH48dJ4sLXuK00mZ
 1SHjIz676S+YtSrtVV/1C+KGgUc5f+EKLo2zazGWAVcbDf+HtqR2MTxFSinwfLFowppCcc3h4Fi
 IjorWzG7CF5BNQmvgq/Td2rBTD4KkBiJlZw9LiP/wxrsyN0kLppXLeJavnujUqE5uAZI6AXqMdD
 AIjEQs130sBLOiQAEmdu1aeyO8i4pNkOzpxLfczacdjf9+I2kVzfYRXj6Z9SlkAeMPPAsYJ4cY2
 oYS9TdjqhmZSk5192vffLVxeqZk7aLDFKaaH6yWzbA5QnXaLjRA34vw/TPT+RsOK9n6oIeAdEbp
 BeqI7cBryh1Aj0ahbD+bwHcnRhbMJKE1WSDamcTjS8KfrWz+9rwDIIotUE1xouYk6cPt8is9X8E
 UA6rFbjc43j6BZT+NCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfX+dDxIHqk1jPp
 M2U/aug8A72gulxCnIjmtJvvGH+AX+BWGp4v1pzllVoi769uSepTarJOqufsm9utilpRgDqg25K
 jXUIh/+pmXm/K9y62K6zZg7mjFXleEqeJXiL6eah90MnJUStCjNH
X-Proofpoint-GUID: mUlhVMaLOjmzCVOPG0fH3P3r_Ed-Fh0Z
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a99501f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=C-PO4pFZFlxbmb0oAE0A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: mUlhVMaLOjmzCVOPG0fH3P3r_Ed-Fh0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030093

Add documentation for devicetree bindings for LT8491

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 .../bindings/power/supply/adi,lt8491.yaml     | 92 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml b/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
new file mode 100644
index 0000000000000..bb364b48fee58
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
+additionalProperties: false
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
index 2fb1c75afd163..d79187312f789 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15170,6 +15170,12 @@ F:	Documentation/devicetree/bindings/hwmon/pmbus/adi,lt3074.yaml
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

