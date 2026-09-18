Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011068.outbound.protection.outlook.com [40.107.74.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277034E36FC;
	Fri, 18 Sep 2026 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744110; cv=fail; b=BSvHwgPGy0aIVz2diAj8U5NKKL7ozO6hPdvsEXvWJU6rbZuuRKPyAkQ3lPmXw3mGc2wwVd7DrxOEvdYNABhaRF6SJ0bh0PfLroPM9lPx0m5SnvKVlqDECvLfLWETI3vP2T/Eh7Qjqx64WCQzDVGVMuv8sGJ7GMaPgQBB3poK0qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744110; c=relaxed/simple;
	bh=+zPFYLu0QBhMs59HQOjeYXFxz63pexfZm7QCq2mSdvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lfof4ob8Z57dsifq4CGpoV4qchOhTriDifNVX5uD2FQXlwdrb+9Xaf7wQZGQcKmSJAwWNyTu7Awm7zM1D92stNwTW6txvWv3hKC3F2kdBx/CYQDkP+RL892KgR1Dso1FYzaQ1/cPTJs37n6ZgChTzLOBjltDXcy5S1BWn0eTSZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wop8d5gq; arc=fail smtp.client-ip=40.107.74.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wop8d5gq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBfQi9DLu3a6Up5fY7Y0Ab2OvWxGoh7IPgPCQxqcwKmEvI8I/bq/uGfYsevg9vv1BRlc/Hl8fbhLMIXlUYraaOPHmcoSsdAtCLTzHd+razmCkVKNGDUKz1UsjI0jaO9lDUDvR+O60Ef2ZM+gJVDeq24DWFQehuV2DHYfSOo4aMZsfPuLSoribiqYQX/Uxw7pXRuUDTsHVL2VGg8hwekhMr4cXFQ8O1MLcFNqdO3Nf1/WdQbVtRNEXj3k3ssWK5ElGIdp2bb9srIeeGS/ZUor+w2IDET1ll5Bzzj8uuzeI+7u/Hvbgui6hqwFLngdGmtlcnAOIZVImPKVx6T0FREjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMwuRK48ASaVYEw+29bKzytACQW0LDtIpwr17eKtSbA=;
 b=EgxZWQo1lsPNWb+w8wNMK0CtiBMMpcdyrbeNvkyB2eihOha6SfN4hMOs958r+QdYQUHbz2MbNLYEVZCpA1EjT+dh+xjA1aLUgJztMFN5RxKsZylcCD8y1VNLT/TjCxb8fgobKmBUHdzwNHyQM8i5kxQlr0YOOX6LVLnoes35+LEqt6o2dNcj1BlVoKI6843jb4i8Id83FLTyTb+q8VjoD07+lGzOdAko5SflVMNDfW3Vo8zQv/IauRUKUx7YtmiJnlQkXP0lSbbxV0fSLDZzz7YPMpPaKURnWn0wG6oGsD3iMMUoKloMNIBNh4D3EQFDWVe5NdRjql0YNBLHTC8tzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMwuRK48ASaVYEw+29bKzytACQW0LDtIpwr17eKtSbA=;
 b=wop8d5gqlSQg0EoX85mLeAMLEwwGyRAgsO2Kk7rY8CkI8nfaMGeNuNsHB5S/zBGfuct8hyRQNitOJC4yUG+KsM4tI4zNwle98k0sIggVv17zu1EoCYglLE6Lvk30jmKOcd6M9nJQ2O3NGhp6OFbJLYN6stgk7NLWCEzyxRn92sw=
Received: from MA5P287CA0051.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1d3::16)
 by TY3PR01MB11351.jpnprd01.prod.outlook.com (2603:1096:400:36e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:08:22 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3:cafe::6a) by MA5P287CA0051.outlook.office365.com
 (2603:1096:a01:1d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 15:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:08:20 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8B29A30007D2;
	Sat, 19 Sep 2026 00:08:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/8] dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
Date: Fri, 18 Sep 2026 16:07:19 +0100
Message-ID: <20260918150730.122056-3-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TY3PR01MB11351:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c24b96f3-cdce-475c-a129-08df1596ad80
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|7416014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	yMB/760QLnKdi59qhfOcDmM9ptvfU6QUj4FJRrp+6nrp2PVil9pUj8aikS+JE98i1mhs7FWU0TWJ/u4cf7p/TdNxXZpfr3ASN3m00bDFec0INoOyg8nXuQWIaaOr/heziFm5vnOy2KzHgfm7+A0LWrD8G0zl8Fv3XbIZxSedD5h4mLPG4GAzrTU27omEOqIuyb6ZNUWOyxv/mp7daJOSDEgVJagsCsx8dZYJ5BcuUiS0cdX7R1O/V4TfIDiJwxVFyTe3iwoTm6aTbouCJ77EUdTUM6RK6M+ePasx8QEDbm0sA92nn0zTk3dfyvm9mLJF0QaM5WsPCbghzP3LzMXsdBaI4E+l5SSFg19k5+Weepw+opLYcpVRfw8ZQ+9A/D2bo0f+ncnrZ+DNycRL/5qVqP5wBo8qBkkPh1b2iN7QR7HvlE+GtgtpZykO4nEFdEacc5oKHO/HC1DppRaivImvhtwBkq9tWVNkETGLXXroeGsqkAQYUBDI5Ogt5eITH2aOrUSCXMYmQ7V54R+lWnko9JAcNKAZx1eo4iVU+4w8r6YkbhyxCPiIRJ1+3zaL9EBlFw93mYo1s7CeQVAv/S8CQeEIfPGJedow1PGyhnuds0XYb/K08DwF9lYfm0KVcMkJEBtPbHtc9iRY7mXedOpHsQEsB0DvAjQyTxOIhuwvPraKNsD3MXWwTa3uE1g66+94p/A2y4qW9zMzDIvC6v5n0Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XNKxaLShqzTnKIsWrBKGGS11WUKupwUtOnjGj6IJ0w3qEgP6LjLpP/pelxkFTtCYuc/oa8CD0V9DfTPMVnhVr5OqLioZbo96nDvmDKlm3kehoyyyn1+ZscdeL0OsnSEANAPuWnkye5YAj6GHEwOD3dl42mdikG10kkAQFlm95j/IaBXAI+uYYlxxZFlg1qDDPRJnwa0WSSo+YdlUrOYPfX8gNCl9FmbpW1GhbQnoPdpKgBrQSKUMgO4waOwWhwiJU7psax/p9ShZXOR/pXp+tJzF5CNFjQWul1joMbLzoPZEGDaB1TVR5z45hCZRj+LwGHGfP36mqgyZRwutqcFmz0nazK7mN1/ohQVs+4GtJK4ClgOAjsq9yOX6VBs8RYFZhVPNqNU+9N45/fMNl6bHkXMSDXaGhXFIM2fb47q/6njX1N8q0tNIN1QVJOAPwbir
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:08:20.9560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24b96f3-cdce-475c-a129-08df1596ad80
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11351

Add the renesas,r9a08g046-tsu compatible string for the RZ/G3L Thermal
Sensor Unit (a.k.a TSU), which is similar to the RZ/G3S TSU but uses
different calibration constants. TSU is connected to a dedicated ADC IP
(a.k.a ADC1) on RZ/G3L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description.
---
 .../devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
index 573e2b9d3752..20fc1a8000e3 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
@@ -17,7 +17,9 @@ $ref: thermal-sensor.yaml#
 
 properties:
   compatible:
-    const: renesas,r9a08g045-tsu
+    enum:
+      - renesas,r9a08g045-tsu
+      - renesas,r9a08g046-tsu
 
   reg:
     maxItems: 1
-- 
2.43.0

