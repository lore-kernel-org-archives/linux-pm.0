Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011034.outbound.protection.outlook.com [52.101.125.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764743F4854;
	Tue, 22 Sep 2026 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051262; cv=fail; b=RKc6sjuSjzbCt7dU7yvex4VUc/2D4r3Jsh+YYhN46BNDTKQKzE/rzhBojeg1CkZCPQKS0cxjjjNUGiyfbxjnl+7dngJ+FTo+7xa6S4cEA+8W0khynx060ivVGUaOA4VY79ahrCt9RGzqT543cdUjjdy1yB2qk03ICqqAo7WtKWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051262; c=relaxed/simple;
	bh=H4cJYdaVB1B2DBSQaCyIu/zkvcAAua/9u981Sbs8fJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTnu1JgbE+XEy6EdzESrU/EEevEDHLH8rZ5h7oVc0Sqgjs2lpLaIS+ua7w+J33Lpr/53CW+9VPb2nz68huzugxBTj8b06Ua1HU/vBEhhizvWF3kXSdIsU7NamzlnHELj4zsCojkJmf4ZuQ0XgQGHm2WkzRuHBSc5uGV94QlHB3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Y6vvqZ/s; arc=fail smtp.client-ip=52.101.125.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Y6vvqZ/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ek+ctSlCYSEhRrSjW5zABp8JzuNIYooVKSkHuOvOi0OOKtcZpGTbQ1Htgq1Q9cPpSlh5MOkc3rORFc+Rvhhiq9NC174s8FncrleAJWdZmrGw01Pl5JYSQJBQ5S5MhsTNEQ1F7smsn2mCroW0o16mYnL4eHESTCa6jlIVupabao2NFxjY7Wtv+L20xeKt4ClvESD0zeEQPWt5J/fAkJvN+UuVNOz0rjMN21Vr3NpX3UXQLdVrw7ztV88TOMrnGEiSKCVYy27a7fOoAu854qnKwtLpM3gbq+TLAtTWhPSj6PckOGQSCPUkrU4pWN4bnmw2ciu7F5U02scstjv9clZD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhByDdksvqKKRN5bHlF4EdKLlPv57hbyDN0/kwsPz40=;
 b=fMgQIs1nvzVho9fVKWwvcEEiRwsQ+y6G1W5iBiNoXqs7V3p/9gcYLUMqaIPN/mNrTmxQpjfIyUnTe7Fb/yJdFSPWw53AvMJrOJAeuB1+p2pvfolFtsZHsYOGDkoJFlciq12oz/B5tpxiR0TBmEAdnrOyWJNEL155V8FhrwHwYI7nO2QRkigpb2D20Zd92sxMubr4AotfpLVF8rT4BB2Y2tc04e74qgqVH9QtheOC2/vQoVe6Sne9ke0RxApysImavOfRCXskpCKW5wR/d155KJMMvB3MmJmpQcdQbmhyY4PTIh8nTPRoj0k/EJJ1BY4Tr8Zw4EpYwRw36hAG0F4nEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhByDdksvqKKRN5bHlF4EdKLlPv57hbyDN0/kwsPz40=;
 b=Y6vvqZ/skmv2a+VVMSWZ/HkHOKApkcS44SaBJnjAfYYMG1cG1wjOXBvXKcopHSb1UquD3Slmsc3EpWLuETS7WrXqq9BBslMU2+LrLYNvvI/aL6iMrmomc8BZgMWSuBxUXy4LOgxi5tKj2pvjJR1msXq3rUaPGradSd/nFhTUFh8=
Received: from TYCP286CA0148.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:31b::16)
 by OSCPR01MB16332.jpnprd01.prod.outlook.com (2603:1096:604:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 04:27:37 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b:cafe::92) by TYCP286CA0148.outlook.office365.com
 (2603:1096:400:31b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:27:37 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 804C8300028A;
	Tue, 22 Sep 2026 13:27:27 +0900 (JST)
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
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 2/8] dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
Date: Tue, 22 Sep 2026 05:26:54 +0100
Message-ID: <20260922042707.116378-3-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OSCPR01MB16332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fc333811-8473-4449-9b3a-08df1861d502
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IiiOHn/d0msB66xzLpli9wnJ/my5l2ak6G4FoYP/qkR0egCHcCgixoZvpaq8AThItH7j/ie3orH0FJzyVhDQ3BYEp0UuY+MYectH8GH2ZuaQgTevXyyxwmr1Spp+Re7Qdx+kq/fi/N2qafP141JCaOUOXV1hw4XTg+mr5ZVuXIXpSLlDlrBqCX9V8dzaM8I5eSnAJ12Pdg+BwziMDBLtQlaXQ60OtIaADh/AJcPeVtzZ6R5ut7u7WvvOYEh1S6YntkXQXodae9AFv2yQaHdqc9mn08fy3xciHydytkUAEU06e7L1+ivdheRoLK6g7CODqqG9vgFLkLX3yoRfy/ZuRaN/z2j5cinLD7XmuqaWslWbobprQR6BMvKi4HbdHqnJLTb0qFWKKHBR9mRYygUPgxcUBkDz1c0NwiXMJGdFksAHnrtFkn5GSQj+yGhQPq8Tm8TJpFTR0DbmFmz8nZlJXJJhMG7o8dKAZltx8APJbTmLkeOstzn+pSYrlVQXwy0dovZRxYbQaWVvxE0joQxT8sOSiXSrXfU3YpfkS6QtbCDZ+27wS78kjpja9nd3uLpODkR763vmjbTnoDcrWgQJzbeua0BNDXflh57XCsbGq0FSQwaPzqhOuoiy/FCUWX5Sm5MOt9JlhTALGZTAIviSnFmt3GP4mqBtCPGhPlGeRrADJOrKhfUq0x0qCydCEv2EXmRlxiOsI3ijV33vXOuMSg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bXV59k6FJLLZ89gboMkCRztAC+rGwsgJtDEBWHKNmRanSTjRewhJjrrkr7dW2Az/8QEispsEIBtELvOdr+OWT3n5uYktj1jPWLXcN0CNVMviOwoT/5bVQfTyt4AFxIRFvp8QkB7nf/Hi7sNex/dqFEU3JKYBcgY+hHZ/PIbb7CEJb7xiqRtFpePefwBy1EA+W3r7kFzgxHba+ngT8a+MVv9+VhbW/vvhLTyFRkECurDDrY4KYRrAHVtigzrGW05WEnoYnj3VUSjicmXoARpcUQXZb7O9xyWW28rZND5fZ0Hmu9ac/TT8bGfdSvIfKZIGpHD40Fz9MfIEnVe9SfmLZJyzcHF+ngv03kOyg2EO+73eEgMeIbjQIwkWEQfA2LXRHzVhsGAMc1H2Cq3NL3RJ/SgTZiJ0Gx+miobykrqWtHMjRsU8uuQa2RZ6G9LcbCPK
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:27:37.4017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc333811-8473-4449-9b3a-08df1861d502
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16332

Add the renesas,r9a08g046-tsu compatible string for the RZ/G3L Thermal
Sensor Unit (a.k.a TSU), which is similar to the RZ/G3S TSU but uses
different calibration constants. TSU is connected to a dedicated ADC IP
(a.k.a ADC1) on RZ/G3L.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Collected tags
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

