Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010002.outbound.protection.outlook.com [52.101.228.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631F4FC339;
	Fri, 18 Sep 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744151; cv=fail; b=BZMC+Ain6Tn+mURXKcDkXDu6q1iC4dtSb7jlBPDjQjKIuIDNTPFa0RrzysjoHqM4r8bPyWkjgvR8Yss79mE1M8ahv7aLdqihKPMru2EgM0/k4ceikSrLycYApWluxb+wbeykqW0pynEnI7IzlGQWZC9RJqIwMY2hNX6FvNZpYyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744151; c=relaxed/simple;
	bh=5Qpm5OMzUahGfSxp7TWFJ/lZ9cnvY9V6EiolrM28pyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw/IRl9QRpMos5XN6cmElM4aAlgN+MK3H9HmyZvBYEkAxWyAS06Vh0eIocFyh9Xy8ra0lgdZwrpKhZniPT1sffo8TzKLzxZbaQWoY4PimwZqvgccl4qN9JDfzrc6s4lkvu6Y3BsjcUmvSxPt65bD4h/nPxsi/9ZUVBQBeBaTrIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Otz2gXlR; arc=fail smtp.client-ip=52.101.228.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Otz2gXlR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJWLye2J7MBDAO+oWMTKSddbt783O3iqgwRuC/PpB73gJcvd7eM7Dsnzkt8FuXdsNVKllPbmWDU3nW5QOCBMeTjv7txkok+Hb1Z8Kfbto1dP0IR6zqtb5yedm3fH+ddQ3IkP+WqX5cFO4zoSx33Iae8CsEaCpKrwS5oSVeQ6vSXM7nQxY7SqOPhcaGQWGvrjAN/ZVeApuSh9OYH62i4QlcmRVlPH7E0701bkaM6BdY6IDPvhhajM61FGbB92b5CmIoEo2vVvtxzN1+Rv42pjf83dPEyrPRly4bfhFAe9pA/5QF0RYrsQg+9fal3bpsdYhRBHay+RFWUXwJx0/pQGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZVEt6GTlYPaVT6Y+3K9cNYgwdjzddryX6ojlSHIZBo=;
 b=AZOzrgvKHrHeK3ahS+h8OBGJXgTFAwmnwMunhVnp0/IdTBTB/H32NJApx7oEW/4mg6vdyTupiOMiGUyziU56SoiIgyHurjSfc0XyqYX0A6xbcDvPFhitnnOM8kspRRJDf/37Rd46eDsviWvjQ58Mr0r3StY0QaFOf04nCB0VbCnq3hJV53WO7UCqqRxITq1K0mV5iReeQCGRl6GJxYTNZ2JTHog71QAcR/YuXKcMo+6jfcwMG7gxHn+DVGfUkzpHzBkOuRfqkyMmP7Uyhh163tiMOJYhNjSJFf9HGIp1M3Gv6kLlrV1h08MGDcQ2VH7gWFhXKyoB8beVCgv/P8UbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZVEt6GTlYPaVT6Y+3K9cNYgwdjzddryX6ojlSHIZBo=;
 b=Otz2gXlR0EG8181z6SxCLgJEMY9IEH4M8mGJB//mBAJWH8jVeT7MqiprV+jeQ19Tml+srr655XRGvJ21Uxiy+QrmEEa9zY56gpecIORgdDT4R/+zetzNDXOomCLKbJjTpWw9En0ssvCoxkRlzndRWh6WOwNy41jsjUVj0MLqQ+g=
Received: from TY4P286CA0063.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:371::14)
 by TYYPR01MB10547.jpnprd01.prod.outlook.com (2603:1096:400:30c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 15:09:05 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371:cafe::51) by TY4P286CA0063.outlook.office365.com
 (2603:1096:405:371::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Fri,
 18 Sep 2026 15:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:09:04 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 7C9B730007D2;
	Sat, 19 Sep 2026 00:08:54 +0900 (JST)
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
Subject: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
Date: Fri, 18 Sep 2026 16:07:23 +0100
Message-ID: <20260918150730.122056-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYYPR01MB10547:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f102603-b0c0-47c0-a752-08df1596c751
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|10067099003|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pZqFUVc2TTbiFHpVH6YkaJLxIeEZeMSurkFh04GrfJKUGVpAjDr2CbYKcBuEuf0C4FVvn2BLbg0LpYj0DPMLSZpi3Q4xC1WobvI3kJjZMH3+GyqZiYuFeM+F864H5mT5dUkjHyqGbh2212P+X8vrdgsrgLQDfJPvFBcAVEVymsVoCRp4IifuzPKkdnJUx1GZQHCbSYFdcvSGZJwcVMoS9qBzXycq8Q4bxlgSytv1YEZeCIWOoNnZV90cTbsRPOZycWx1KluIKfvGqXUlEtyirJur9uZkKCEPK2tX6atoUXCYhwbohXY3QIV0V/2C/65lPx0gmdUuza299hSVTjaC1L/URNF1NMRrp4iLcqc4kKpoT9gOvQ9ivQApvxr94iFUBGOYqrssTLTZndVlu6gKkZ0O0zB7miVnzljq0/LE9W1wop+/t1O/KiBv8Sfo4NIgSJ8TrOmkvmGuKdIkPH0xvOLbnmJUx8Ro4rvgUAuD1ybMdQqPdn3ANvmiEhWWvVpXkgk+PFPpHfv99lAAjt5GWBRk9E5HtHzzvaJhNxBsxaEnok6Gvga2T906QkwYfK+a7Fya3/VopvLaNJROaeVDIljyQg3XipyUg4D8vTJpfrprBpJRxDRvovPyqQMo7fQhRFuRztN0ZoGkmXABYksT3bfpZekg28/9EAky32jlro+AMU68tfkKbCGnLjI7hQXrB8/g69E1M9aYhdN+tm1SOA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JMTOjT6nIKeHgy86pkZRY601UyhyJ2N3cszbZImNSdXf63z0AzdP1ecUDPHVG+R+eeGKIE7uI3+QTvaM5y8WDHQvk1yDV61o0j4nDw3dmorhpFQrSKoSww9mVJfP3l8zTVKT9U22e0NCT2R6yoGy3+azoOiyQYBucyBskp1Xt34rDc8toz4sjmzKXk2sZBGgRyASdf87TO0KQ1+U11tFkClGWf9HhHvc1H6RzH0/uomt1y9T79ydxIUnyw8PLaVmBCAiCIWb+J7G1VMoxNAyxSHA5kxfXZY3Mlar7k/4fWtUDCwqEIYHuBpuRs4vMUapYrTdDaGeQQ8QNugRBQykdTJPYVNeDpIHk3EW72G6RXZAjXXzvaOe+wlPs2wATFKV134ge7/8zPh8YpYT2gVVQ8r4B6N2uptJ1yBhPHjuYN66BFZyRoyEHH+YxKNdGI+k
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:09:04.2700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f102603-b0c0-47c0-a752-08df1596c751
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10547

Add the renesas,r9a08g046-adc1 compatible string for the ADC1
instance on RZ/G3L, which is dedicated to the on-chip TSU (thermal
sensor unit). Unlike the other ADC instances, this one only exposes
a single channel (channel@8), so restrict the allowed channel nodes
accordingly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No Change.
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index 60fbc05acc1a..f4705d5ca543 100644
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
@@ -125,7 +127,22 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a08g045-adc
+            const: renesas,r9a08g046-adc1
+    then:
+      patternProperties:
+        "^channel@[0-7]$": false
+        "^channel@[8]$":
+          properties:
+            reg:
+              const: 8
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a08g045-adc
+              - renesas,r9a08g046-adc1
     then:
       required:
         - '#io-channel-cells'
-- 
2.43.0

