Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010019.outbound.protection.outlook.com [52.101.228.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFD4CA272;
	Fri, 21 Aug 2026 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324741; cv=fail; b=nQWSWogrqwRfI2sBkwK0Bk3AC8NKL771BvjXeAda7N5DyrR2PebQGO3ooGgBXktZW9joPy1uO2eE8T3Q22NGEiK2Fd43g6beM17FxHYkMWpdB193R6ehCpBtQYPR+gZbia3UEooBgp3Ub2sVfVP1pJLv2tpu9wpZfTpkbhouAJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324741; c=relaxed/simple;
	bh=vhP5RsLcUhwVd9zskSptZHLi1Sw5/r691K0nFT3pGlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swGhl7MVdwFj/VBl+wGiaJLLU11K0cMzj+Gv329teeTDkj4hR47iNvCvDBxsNMmpEL4yTT5xQ4BKEc8C0XBv86xR85WpWoaNuHv2FuSXoRWGZN47Qhh5RacXlgvVachCnpdPhVH9SOFjBj+ENPi9UdZeZxbCxz8RwajnPUj8WgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Vw7GZ3tL; arc=fail smtp.client-ip=52.101.228.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Vw7GZ3tL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVEQuQab3uJT3cragrjtUHTBiRLWfg8FVE6qOXS2/0qNi53I5LQ+8AVYOLYWWqiBB0g1e0fpgVi7kl3358S4PXqdpekZ3qBLT1CJjHhJbXlbIDaQCwRGeBnFaIoKUxbtZ3Cq+WY4Xlwk9i8DSJf3Nbj4i9U8D6ndpQ51PaTxrWWJPEcg9ym0KcMGXEfAjmAclcxPjiExMR29opNgTnd8W1NQyV2ainE9tlXQmKgkOuyECnzSGDEN4qirHqA07/I9k0o35vpQ++0OjA5G11KeDh7n4vbCOyKVXVWKlSacI7xgALGTtIdxvQ1p6AwkapN6Yk6qc512hxF8Idm26z1VHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+YwWGlMFFX6EI3SUacRS6q5w3IF3EyXU01wVCxFmLU=;
 b=gI4Ir0DDyLeg1chDVUbkwgjYUY3o+9k3nu4fvTcgTbSf0Q+corrckCsjRyz0Z6a/wcENAFxVLQ1yF6yUqgdYNCNZ0jSNK0GfB0NaiIWMZ7e/b4niJoAYPrF4Yd/mKdphvWSq6z6GsjnWE0A6AiChPaPw+1DtB/l3bQ/IS2IYzS2QcR9pRasLoKn5cJ/Qn5Q2SHRlGenSl7BRfB6wFGDf9VqOLkrIdVJvd9htb3Y+oydaT8Tizq+zbM+HlAKznu7GcLcxTxW6Aa1K+KopGs3InOwW8X83zwvi0RLSXwinyOJPpDBKlYigKt9I3Cy5qDMmA2bC1/GcRqBWMJmD5/4eOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+YwWGlMFFX6EI3SUacRS6q5w3IF3EyXU01wVCxFmLU=;
 b=Vw7GZ3tLh2x04+iCHll76+JbehKoQY6UXejYVlPBRFtBQte8Bu47QNzZyKXOe7zodu0bvmu0Fj7mwYxuuc+ISE6okuGD0ss5nD2yoKdX4fhomxz7WIYYL1vCXxzgXjDP+8CRx/tNHZl+k9GeVi1PGKgvLbqoBBYyluHjIO+EymA=
Received: from OS7PR01CA0254.jpnprd01.prod.outlook.com (2603:1096:604:24b::20)
 by OSRPR01MB12031.jpnprd01.prod.outlook.com (2603:1096:604:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:05:35 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24b:cafe::8a) by OS7PR01CA0254.outlook.office365.com
 (2603:1096:604:24b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:34 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 9F79030002AF;
	Sat, 22 Aug 2026 00:05:29 +0900 (JST)
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 05/10] soc: renesas: rcar-rst: Add support for RZ/G2M v3.0
Date: Fri, 21 Aug 2026 15:03:30 +0000
Message-ID: <20260821150408.73829-6-ayman.chaudhry.kc@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|OSRPR01MB12031:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 80ca80cf-abf7-4f16-4b09-08deff95a6ec
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U+kf769eLr8ywYKe7uaS3vt68mKB4LV4/7BlzsrxNnXT1pRU0AmGsJYDXWvuu+5CTnpUpOmyNS0F0V18xxb6GcGbnboF+IC+EXNEAN1i7zGxtECA7QaSNWt8u5kPHhJlvo6AjeJJVHjvqQx3gFZ5i9IVk5aJHRuY8G1GvltY18YjEWklaUE3nptpMRsYDwaYE5I2I2GkWw1HMBb6xB734q2/Q7ZMrn0ym+K5Zcz2uBNWDZhxA8lCXMQa920ZPpRBDbXETP3IX39fD+oKPbC3aMd6cVF6CJ5mm6qgviQScNxUncTvarTBK5RmalvSWlxFFV5DcrCOSZVBJZWCvushOZdUsFq9qXX3e/RLjGwDFdvYk4DnqDXV4FzV7kN4+ySz8JiYFE8wdL0qoWmpy8uvH0suo4lWO/xG3YE8gRlZ5+SXV3a6ciNHyjvfVJ6CR1B3sD5rBJfkyr1VSW3JNwNUmPPmvreBOywTLa73l/vLG22WKuHYedBR4B6qqlWAPMriGRB31EGbUAF5n6/7f7EWlOMfpIhFRcZSqcjaBK6iPkJtE0BkvZvI0ugCsOMpFV6S95sMXjSNeETWn3vzZZFedIIlZmJnxcGeM65wlqHxDQPf3mUsd5/2x0d59YnaIw9S4h99Z0qhpHX3EZLpaqYAEEVSOkQCkV9oWDv/e0pQjSsYEse/TICled+A1OlR5HWxmrgII0DNQsMvBc+UxjBoIQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EqpzGeW7+Cj1YiLdGQtsJSbnIytuz13tbcmNru+45+kmWDh5qTEACrXXe2SCqKrDE7QghWEqRJfMySUgZSYjJuIbXrOjaTLl9gtprUZmHlP9Ut5R/jj9U1gRk3syx5+johjcAZ1JWsyJ7oEACCTrP+vHYWjkOyH31lta3CUDtiaAbh1jW5o78pg0KYGKc/ifRco2NaS/x5f4WjPMOGYb8S2pzgv9DA32t5W4uu21+o8jMxeCl8Qhb3ebj/vvYrIpmdaoLQBsENT13Cs7Gd8nYnvtTsw/8WjaFCdeAAdLQFW9+4yBskbyeJgAvDpOMDukcXN4HHyKk5pgF9CgNmahjBeEQ8xUf/VQvN91Ch2uNyCrpvzDxb0ydbFYFiC/n9ESvbLLhMLK7lrx2451QLn5UOL0ZP0aYAHl66Y49c+OuA9Xu/WS15zPIKjScITy9KpU
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:34.8280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ca80cf-abf7-4f16-4b09-08deff95a6ec
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB12031

Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC to the R-Car
RST driver.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 drivers/soc/renesas/rcar-rst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 0541990901fc..26f976880d3f 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -93,6 +93,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a77470-rst", .data = &rcar_rst_gen2 },
 	/* RZ/G2 is handled like R-Car Gen3 */
 	{ .compatible = "renesas,r8a774a1-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a774a3-rst", .data = &rcar_rst_gen3 },
 	{ .compatible = "renesas,r8a774b1-rst", .data = &rcar_rst_gen3 },
 	{ .compatible = "renesas,r8a774c0-rst", .data = &rcar_rst_gen3 },
 	{ .compatible = "renesas,r8a774e1-rst", .data = &rcar_rst_gen3 },
-- 
2.34.1

