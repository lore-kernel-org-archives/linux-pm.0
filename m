Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010056.outbound.protection.outlook.com [52.101.228.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752B4E3EED;
	Fri, 18 Sep 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744141; cv=fail; b=XZ071aPxOeNVdhNZa+i0FmNtYeXZP9OOHgQn/tB6uG1kai86vZA+i40f4fJFnhXT6NeZPISoUBtZtLI7FVygVbhssLW3URn6/q+p97f+pmFn8QDIniY4nyefZmYF+YH9xi3NB3Pu119flHDR+7AeDb8EwKUvncxMMNf3J3nBpcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744141; c=relaxed/simple;
	bh=qy86kri5vsx6FjGtBVL7FJUcmiugX8qK+2Q/my7KTGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGd1kTDcT7eN+Nl45okXNpRFhU9+jvtr19omn2HUPJ77Ic/jOu0vZvMQWUg9yPfge3nuOir3yPy5OrFDfmY3BO8NF6/U7KtRd+T+eqYtAsOsw/Ptz/rD2d9SqU0N7OIv6N+SBKK19T0wO7+loc8mQjgAbbV7Qe1cBV/Z4zIDEYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Ds2LT/Mf; arc=fail smtp.client-ip=52.101.228.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Ds2LT/Mf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIu6/q6OwXWsoQIa0bpL8b8fpScbRe7Z1aURH9i6CEjppU2W+lnib0iyxQqP3tT0nJUiLsftLIz5K5aa7qtzOj41SITWg3XP5fbOe+9GnkBC76Lj/6eHjfs1H2Dmzgp43m2zq1T6zYP/QODhKxqHnlaP3Ik4L+ea8rkjDQnEyuEz9o2a8dkcX0DTzKcRk3ypKK1ANS/wvQ2tCFUaHCv/3E1KqxVfqhD9cvGI2BVcbvSZdzehhynTcBjtLnJLoPEnR0/opMrU9BGHDimFMGDPHp39XPmwqY47bjQINduFKD0AXsLPEQWE5+14Uu207Y+DIn+ZB/0BcZcsxr4jUjpXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJvTedmU600uJdy86UzOSSNgcd52w2hClBfUzndVh9I=;
 b=fDvGgqEj23DxaYd7XfbBQh23lFWVHbBOUllVKyAbxqhfweBDpJw3wXtS+O+y1vZ71eue22Hk2o+vLM9GAJtUMcbgwassQStJ/PIpAmdT373xmzHPG9c7mZg7BpHgrsLNDgiOAZA2Q8QXy7AqndgAWjUJYl/c7oYZEoVeLVV1GDispkMiwirBaDcXOByGl4Ve4j59jUHTToUhbea9cXQ/87DF/Bku1t/sIrtvi0JEavOTBDX7zy3EGL8plHMV1K4mPvUSBkCbemYHAeq9icurU1PsT0ClgDR/DPliGa1r4fhLXsNjPOqeApYXH+3nYQs3vRm8rZmWbU6nyBzm97KP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJvTedmU600uJdy86UzOSSNgcd52w2hClBfUzndVh9I=;
 b=Ds2LT/MfU5f28NNQ5/bqF2u+Ai62oU/vWk0ze/WGr/x1iqPKhJkSYIUUeg1LbQ57slOy4FUWFDEEJZzytpqYV5nONng+/Cb9Wq6q295wFxinnMjACRgDueyFut9NCP4kdl2c2Co69uh1VxYo/Q7OODT6bEdeeG5v65ynpHtpjYI=
Received: from OS7PR01CA0271.jpnprd01.prod.outlook.com (2603:1096:604:259::19)
 by TYVPR01MB11155.jpnprd01.prod.outlook.com (2603:1096:400:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 15:08:56 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:259:cafe::e) by OS7PR01CA0271.outlook.office365.com
 (2603:1096:604:259::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Fri,
 18 Sep 2026 15:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:08:53 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 813B930007D4;
	Sat, 19 Sep 2026 00:08:41 +0900 (JST)
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
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v2 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Make '#io-channel-cells' required for R9A08G045
Date: Fri, 18 Sep 2026 16:07:22 +0100
Message-ID: <20260918150730.122056-6-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYVPR01MB11155:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 117251b0-a1c8-429a-f3fb-08df1596c126
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|10063799003|22082099003|18002099003|11063799006|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	0Vx2p+SDcQFn7XZWDHZ3in2BFMr2HgJXC6k01SjniGE4Js4sBtcO0FCNopTJ4+CIDnQU/d5k5Ta899XFKluM/g+Hb455e8WFZnyh+36qy5Nh4yDzAF93z4pNHvpzNO0TEoBBH3suVNToeEY+I9ZFE/KnvgiZ/feI5096b3HRKbD0hyV2bE+Gf33QOCGgaIKji0MUILDAQPQUuVl/l5nP2rb2edUm8GPFOnKW1UMT3qhn1x0ymrD+57VeIjKbOZLjWGLLzxoUm2tB1d+lYrsGoKLyVIYxBTUZujJKRrroxbIFQ3Rf2Vu58xFUel4NexIlJBkyUhRDTYc5jXMRdPs5yfrPKPUwU64SQ+GD5Yoli8KzsmZZxe4ovloW/Ycc9/TdQRIxydYVHfIkmb4/76ryF4lJlDL85o+9FdtoEgiukSTlmXqnpnRzNNlL9LuKRf177Ah8B/K6JUBelgmBK9WEQQDAjyJs6cpoQLpwqb2S/Z29ohwj748E7KomgNl29D/usIzbrQ3+n0/yp3pzGHB8aiypC0eWiS1JLju0b73reMJZDhS8VyE8dNRzoXq2jLMOvn/QJ9U4PDjHK49t5IDOCPgXC8I2Pcn4OMc2hSipJ6Tpn0Bpy4yDP+H7sS5GdQpAGZpqDNw8mioDAQgmmD68EnXhe0NneSCvYfyIhWzXbNVOg38cCeIyApfvYbVU7Rw6ADiId7xu2DgbE/j9RixQMw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(10063799003)(22082099003)(18002099003)(11063799006)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C6k46RCpStSpL7Q50SVDHqmaUMnGEuGLe0ry92fRFK+aCojRZ2yIFvv+VjytmHWIro4b9tXcTi4MprLi9ZNf6cb55IRIrO6e8u7tAawJf1cgAbCsOpUMcA4J4YCbWDXHWwBsjbmYU7Ys0XlIzze6RGlmBgLu+1vVz3U3z0AjnjBq5lIenqt5wfSu2wRRR1Sx6bkksk+EflwPYsJ9/2gfKjgIm6cYA34GiHe2fan542K+4C9HtBvsJiTvIC9tuOsRSkgEhpDufWjTPTNmqgQZzyo19iltd2Dz2BMyrtTWqhvRWuayVD/DH3lMG0qxXs/MsNS41Ox+kxUIkuOKMD9hTS3Tm8/RDje89QAnEVBNvyqSj0fjy+bPRAcpot2rZ3BtBkYjfhQJMrYRImNJP89IGX+/tKy7nNcW0UP9D215pszab+B1uYOZv+XNB8dKL3kN
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:08:53.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117251b0-a1c8-429a-f3fb-08df1596c126
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11155

Add a conditional schema constraint so that '#io-channel-cells' is
required when the compatible string is "renesas,r9a08g045-adc".

This is required because the R9A08G045 ADC serves as an IIO provider,
allowing external hardware consumer nodes (such as the TSU) to reference
its individual channels. The '#io-channel-cells' property must be present
so consumers can correctly specify the channel index in their 'io-channels'
phandle property.

Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index 40341d541726..60fbc05acc1a 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -121,6 +121,15 @@ allOf:
             reg:
               maximum: 7
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-adc
+    then:
+      required:
+        - '#io-channel-cells'
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

