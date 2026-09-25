Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011055.outbound.protection.outlook.com [40.107.74.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376C255F28;
	Fri, 25 Sep 2026 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317034; cv=fail; b=pm3kKZnOJeOXKmSC4JtF4EPj5me6wg1dBlYA3psAJQ/I21YBoQkRmRq/ZEbBmtWVUwTmfL3XAcSCzWLzS18hZF94H7D4XwBr3RdRCaNTtjBZ296RsMRv5ioxXwNmukVnnw8bfxV31tAPJpH2gWgkzXN4+yCnivTl0I9A5ilcCo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317034; c=relaxed/simple;
	bh=Z95/TkDKJe9cX/OMFiLTrltNcvd60g7wBCVv9OejR5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfvZCSmgfTPypxCxNikIlzXyn4hUdKUpNHPQs8C1ITxbt28Ux67QXLFcoXCHQQF1pjUA6SbuDaOvPZTjUCdiIQtoWluUCl/erzgJ4+YbTxDqtqyFVkeeUiheD3ew7ruZr0nxtNYNvWBd/WcAm1WNTeuo9YimDdnc0gG1asjJvBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XkJ/8+Ut; arc=fail smtp.client-ip=40.107.74.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XkJ/8+Ut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcytQrexleAop7cbpEPhClppEt7SbRCAiJsZU5pP20kMY3IZmUr7F2Q6+T6HZ5BgQhMpIY8rV+Y/c3ubPB7sIhxsqtt4MuFKeHlHEkY7FIe+2+/STClzTvLhiyZvClPqlJsAz4X+/A/neZcUKixSM5oILvpvyO27l/jH43tv84C7uS0wO63R+l5SoxCU1NbsuVYEWt0tsYvMlfW9ejhGYsWh+OaCtuTEufvR60TCjwfw20iUbiU2PtKU68PbPibKzOUuJjeAX3BNGRDYJ+Cl8yRRqhCUVOQa9V1n9Q4ErNee6QzZXVw0nblyOa8kGMeFjF7pFrQWdkv5akuuO1+NHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjHW/1kBLwV3kUXyzJ/iSE12bsdcOaJW+z8aFtxRgx0=;
 b=Qqty2CIGY68CBgapF2ahonHaOPbeugtCiJl1fToZik5x4C1G7B2ATF/4vtSrBDNAqhHzXrPvDQ7ri9A2FKTYZ10OT3CtIPTlJiZCv8iTXH2iPEBh6ACuIZgis87lbRYgb1wAh7YL3X1iLNhUH6vvj/+vt3fBZ+WJDu4Wn4y8BMaC6kOGpNAVhue26nniPHRmI7e0cjGHbISqxfXshn55L5YWlx+Y0y1ZUf1kjJtSz9CleYa7mum0A6weLuMPM34XVLvhsIJ92LHhHxoCngPySTZvynMlr22hZAVLoRQko7rwPDzMQUWShevwrEonUFCgcFEQGE1XnTUdJryzw0/7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjHW/1kBLwV3kUXyzJ/iSE12bsdcOaJW+z8aFtxRgx0=;
 b=XkJ/8+UtyOCxl5L4+OTl71MsUhcT4GH3s8CunAk8KQlvREPxzxSsCX3DfrvRUNfCWpANozUAVVinZVeBQC4UJZDQn21otYb0PwmVAC7SNXiztKweqBtW7MDs0PuTsISqR8SiydTzqOmuhjNgTtccgymdY4s/xEwwa0vMqodFusk=
Received: from TY4P286CA0104.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::17)
 by TY4PR01MB17388.jpnprd01.prod.outlook.com (2603:1096:405:353::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:17:08 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380:cafe::9e) by TY4P286CA0104.outlook.office365.com
 (2603:1096:405:380::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:17:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:17:07 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DA84A3000252;
	Fri, 25 Sep 2026 15:16:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v4 4/7] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
Date: Fri, 25 Sep 2026 07:16:02 +0100
Message-ID: <20260925061617.127349-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|TY4PR01MB17388:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aadfb26a-c6d4-4be8-990c-08df1acca031
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|56012099006|11063799006|10067099003|22082099003|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	OtVIl086m9tQ8210gV8v48gvyUpS4vzTrqlI1vQPyry6fe62lJE4vjvq0vd/P/UxSNmKTLBkKZGq4hL7N8r9sqjiD7v2D7FG8BufHt0CRVm41NNBx/SQm7vx2iMGs+dSouQCRegl5SeQYjc+qA1R7Y3i6PBcxszXnf4uxz2Rjhdx75dHBltKpgUX0SsHS2Ecdn2Lz+ovPMbSp0VkH9j0yIesoPvFLiuz7Iy8cU5yH5B5K8McGIkdxWvjisEeCFYA7KdEDXtddHHgSl7VQfurqPSI83Uf/YaaFgmdcrA9UN3oYcT2eU3fJoRcEww9d6vgD3sNAPL9Ww/gE0p44BIZF3HIchUA3Bi5k2oz7u/QPc4s/HfMOHQ4HF0TNeeKjYWw8wWPJfe2sohOV4kuNf0E+cKVJIKz7v/NO5jcYG1MCAwueH8WFeO6dEWteyz7oDup7T7LZ0uIw37w5Ii49D7xaJYRqVnl1udV5M1t5G74f7FSvvFVuBM1gd8Q3/ebF5g2Ej0nZtHHOyZnfQldS7Z80UL7hslFuDieLtFLvFs7dYONjOmYjzS/MO/N4qGZ9E70DTpB0t0zTO75Z6UJbB/md5cu7hIbwWTeN6l/QzDDogvvbTSo+VkUdJlsl9EBxYDxeRVi3wXHCSKqg89Av8rtap6ucla97pP9oGSqEpzXqX0=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LVMVJtzT0Gahwvm73gw+q9IOSbvmdsOT5pCpDjdcJ88clIUPZG9vbh+35p6ulsTtP5M6AZzIEEpAe72cjrVBW0lcHGiXGGZ0bPCLFN/krnF6eG8w31PpB+YhiLYUVc0HkKrVOuE6MrcsPhHL5Lq9rbarDbrazX0ROujxUx7NQtiHUKc8ankUWaKxADDigJT6+Oc1ZXvcifMaqZzE93Xqix7mwhRdLCLFLYYVfeBnzMXiAWzbe96CvM06QutdUI2oF1gqKGADpdoexhK47GG1bXafowkAeFgb4D3I+GkGin7fW/m8My46/QFjftKpYyzC++785lvnD7dgSTz7FPr/FtX7GSDuDT95aFjd7lvP0OWeBWHrkoVxxvyWNJTp+D55HKsY4/C9ZXo9lmPiUOWpfgs/Sa3NRzyRFyYLYSod8t0JrI3XoRmNvq7VLRgWdv8n
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:17:07.2638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aadfb26a-c6d4-4be8-990c-08df1acca031
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17388

Add the renesas,r9a08g046-adc1 compatible string for the ADC1
instance on RZ/G3L, which is dedicated to the on-chip TSU (thermal
sensor unit). Unlike the other ADC instances, this one only exposes
a single channel (channel@8), so restrict the allowed channel nodes
accordingly.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Kept Rb tag from Rob[1]
[1] https://lore.kernel.org/all/TY3PR01MB11346568D44110BCA1CDD146D86802@TY3PR01MB11346.jpnprd01.prod.outlook.com/
v2->v3:
 * Dropped required property '#io-channel-cells'.
v1->v2:
 * No Change.
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml     | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index 40341d541726..f08f5439d127 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -25,7 +25,9 @@ properties:
               - renesas,r9a07g054-adc   # RZ/V2L
           - const: renesas,rzg2l-adc
       - items:
-          - const: renesas,r9a08g045-adc  # RZ/G3S
+          - enum:
+              - renesas,r9a08g045-adc   # RZ/G3S
+              - renesas,r9a08g046-adc1  # RZ/G3L ADC for TSU
 
   reg:
     maxItems: 1
@@ -121,6 +123,19 @@ allOf:
             reg:
               maximum: 7
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-adc1
+    then:
+      patternProperties:
+        "^channel@[0-7]$": false
+        "^channel@[8]$":
+          properties:
+            reg:
+              const: 8
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

