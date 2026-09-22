Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010057.outbound.protection.outlook.com [52.101.228.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131B3EB105;
	Tue, 22 Sep 2026 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051292; cv=fail; b=KqmrodkTsJxeFFHROhn5YF4UM/bY8UikGWNQTEgGbmxtXCMSFFbV5ECcSiGR7YdLtl63dvj0jBrqLJRwAJxUMtrx6o3CitPV3jIx/4sy4Q0mqyfp4Y48Q52/5fimyDron5Kw7yLMpsaG8QVYrB5HeCsHf0hnJ/tKs1V8gzwff4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051292; c=relaxed/simple;
	bh=RLsTnERpcFihT64lj+PE7hhEo5LyDDH6GxKRvzVgxTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNvixe1TxvDQliKGzUuOCq+/JRLg7sI72j+VnP4p1gMd0NiBNruA9NyhMhM5tkYWqZLyJeZdswGta6hhMUF5oCsmye2/1k4PPdILNNZFbQYCXcNfZCUQhargqBVpCNYfuvW8DC1fVvm4qZyZvHxWo9Nib5gkVPepMN+Qhy5VMXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XnwZ65nj; arc=fail smtp.client-ip=52.101.228.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XnwZ65nj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YayHNfGQohudivaZxzXAinBGhpKCYyms52aSYVP1xfYyy5kxzUM3gcr7rvQkV/bl2x0NB5kVmhVW98Bu0I2Lo6x9nYuKjwUHSnQqAYkFkuypgdFBbe9jcnaSZFMbqylNxGc3AcipySEWxtf65XGF7SYKCcN0brUZDprmTNhJhGjIXMeGE0Uw7pRlDGyuRx2g9LZl+p2GYUmNk0/aJn6FvwwpwEbO4PVqn16BGsJMx5Tg9V+GTpN40XktAoG/IRudI/wjLVh2ojaf/KHFx2xOO105Qg2JAqqUPHFWvL1bxsX/LiWsErB/RmO0+Rc52WOZNc5+1JpEOHQrusGs0GyyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idLO0BdtjOSwRfbCA/miIVFO8reG4FLAcyrhzV8XCDM=;
 b=RgKIjQVXXHYc0tzd7zXrce8bMYtNqLyNu0x0zpk9zsrNl30b8C1rZW82+N6Ykgam6MZZbI6LJV8KFS3fyuIOU47PwtsP/etn4chNCI9z0M7aHjUE8JylRpTKvtsqNMhcvqq8FopCjO+Dz8NeZdpvbB5jgJ4RSbm7ISHcl09ncYRF/T39ScluEmy20W23VSvdoLdCTMMKIMRvl/5kjSIPYSv6aRS86qyga+l+2R82CnepwGe3pS15mLkn0d8t6ti2jfYhF3UrAW60TkOHMy5wzA4wYjufD15Wb2avpNqxzr42wx0kCL4g+mteIFt9slgV9C0wJEKte42f+qgo2jEsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idLO0BdtjOSwRfbCA/miIVFO8reG4FLAcyrhzV8XCDM=;
 b=XnwZ65nj7bHmGNWso6QeO7Oc52o+Mnz1Z+9nhZXCZfUwC/BAT54GsYlBBLQDO+XC1ETJBkRPJVEX8WrA8M/ObHBtKvvAhjrc7s1X8/H0FIetJ8nbN5Umv/6nPIlICm4+D13E7TWWrspfw8s9o7bZ0vAcSKm2eyaiL1Kr8Yy6/+0=
Received: from OS7PR01CA0165.jpnprd01.prod.outlook.com (2603:1096:604:24d::13)
 by TYCPR01MB7847.jpnprd01.prod.outlook.com (2603:1096:400:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 04:28:06 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24d:cafe::79) by OS7PR01CA0165.outlook.office365.com
 (2603:1096:604:24d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:28:05 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 6B8AE300028A;
	Tue, 22 Sep 2026 13:27:54 +0900 (JST)
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
Subject: [PATCH v3 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
Date: Tue, 22 Sep 2026 05:26:57 +0100
Message-ID: <20260922042707.116378-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TYCPR01MB7847:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ed1ba2c-3c71-4120-7013-08df1861e5a1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	W5vTx7NeMbC27HQXm+iBn4SV1nXX7SxBXG5s8cxBrbIdFE+OzKRChWKQ7KYAKkIbhz+TcrCF5hoFHpLVJh0v0mpaoAOsHPJgsHdwplJiAGqabdhgvdhUEN/9Qr5ua7k/mJLghVOnZU5adzOIXh9CqdSadflQJ4z3G9vsjz4e2V25gLxocTvpZ5nXqfG11vvInfg188bD9WFLdKBfhcYAK5ATckMkbfRwxVn46KCT2iY36qQaoli8CkD9Qe95qRYmCApnHptFNX8lTZ2snitWnv2xIJ6tATxemgkCroz2hpoxj+4XXoFWbcJ79Dm7T8hdzKNmeFCP5x8Mrp238HLwg3Bzn24IVcGXlkQZVh7ZQTkLx1XFCUVVQaArHs0om+zyCtTL/YuELk8D5y39tiKz6qJG8ibz9lv8XbCTHcb3El2b7HTPuZvIduA1Hg6AzcbHs9qL6N0b2Zib1vF4IBSsq4qdKqLcByBA5eIEdNyAO4NbqwgqAdNNCeUl9HRog/m4Q1PfTN/x77BGhEHEVgl6voZiDNTwIXQ2flK15aOimCUi6JDLYzpf1hAc6GgFre7RS2rsoiEn99rr3hCXHu8PRJ+K1saJGKJQt+jd/H4ME1sG3aYVqE4GdI7XDnMummQFRWuDdE2OiViSsuvF7hbOtaB0PEqQRLJ3LqCFl8JTExGL92fA6zAvWHYr8MNUmZWoWMc+4FE4T9sXRyAXDyHTiQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4JzhMq2VKexKZbzws0YSz7QYM2phIKUyCpAXcKmwahuCGIBi8nfG8nOeuEWBC6tQXv4vzdxI2myNWlAc3gS9lOaClc9MG24fYF3yaxUcET/grLGTUSkbJx8lJUpzaMYkhURAjw2qqGE7arcC7feRi95O8+qQQ374yNCGkyyexTMW8PGxjmSRhepGYf6u8UDRaB4qvhv48cW9aKALyQ3Z9Og7ReKPQAR3dJm8cEdsgwEOnjk8x7YKQuU5sKplRyQIjG0GbpbqeACVWZtq8zrynEDkaVinvmHX49I5HU1fK6O/ozqXLBlQgYJ/7IfmdjaF/u8pk+0ADU4JmMHfc0skNg54b9nskPShGoF+0shPYtu0YrpAivjCFz53DsoocKuhuK6llnBQES3I4ku7VPfKKyGAdQ22pFJcuwcXNQuDcohpGI2MLYYdZy8b12rKjvLY
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:28:05.2731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed1ba2c-3c71-4120-7013-08df1861e5a1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7847

Add the renesas,r9a08g046-adc1 compatible string for the ADC1
instance on RZ/G3L, which is dedicated to the on-chip TSU (thermal
sensor unit). Unlike the other ADC instances, this one only exposes
a single channel (channel@8), so restrict the allowed channel nodes
accordingly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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

