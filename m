Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227180;
	b=Zm2FZQTcFIDWNB+MCuZm4WfHc35bnBs0X+ueghTTS7vkvl/0o1hEZirTH5sCG1otUGnl
	 vLnDHOBsg9o1CCMbipoJCClMkVkLhlQIHfEnWEffW4sYfmHodqiJ8wmDxa5dCCG56G3jA
	 Y1U8IRNZKblbgeL4WVwTbWqKJn+I4G0ixVMZn/xPcK4InRpFuq6WCRWyS1F10g+uwdo4N
	 Bq43Xou4scDtpW3Zm2AgHl3GfzN2FC9iCLkbEi1IAittaHFy39hDPWSz5SL2YdU15ev0J
	 ZsOR2W3N2hjrjuBjQtoR+ky/B4FXwNgP1PzKNxWCYMzQbAukJN7BfRJZ4pKcbWaXjYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227180;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QhYukEpAAwUKWRf68Uo9FZQhTdRX9ETQYrsglGUCgSg=;
	b=qzpXzDInAnidggWERQLRC7mSWwvuWFXBGwB/s71xW6X9zpgbXDdAk5wYK7kklCitO35U
	 81Q1B9RWwEMiZ5+9xLrdpVT6MOvkPZ+L0OSjW2Gh3GSw/DG5TS1iJBFmggUjaD1TW0jfc
	 RlTSaVdWueDL8I4hNetTKGJBzufgsUs8WjmS467lS4EJR8VL3+e55CeiWouTkEZHlMThY
	 vjw84V52MwJN66sf8sXVkS8LvE0hG7H/3cliB/263xOo9rRqpUwLGHhST5xVoY5LJJDO4
	 F79SBqHUG3x4P9zL+fc+XyuM5OCWWN7N5M2zw6qqubnm/dlPCM7KL0S+eq8NZ04lQFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=o+YGvjt5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181D606A326;
	Wed, 28 Oct 2026 22:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8181D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=o+YGvjt5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gznpisiRq6U8y+QJCDDMNQMVTJcehwVSnfH9wNDqGJn4KZ/acvfCXvL4eUDGCKXSqL+tsH9hB1DV/2tgxP+virEOV2Ah77cvrRZ+mDo4cWT64bArLUechTRZEz0KJmRyCihn5JEk7oc9TA5kokavadYiVaSY1a248dW5RAmeZXOB9TEREEUrUa7PJsxf/LYMtesNhmHvntMiYxIRowhAxU8eJbH1UuW8hsdG+wYiFiLMXxowAFM4z7JCz5EhnRaHOLRgG25egmgoRqw5koRq4rdeYyhuzEaHXwTETEb4VeX6VI+iTWCEuEeDm95Ce4r51aMsl16xzl8pZcyAOG0+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhYukEpAAwUKWRf68Uo9FZQhTdRX9ETQYrsglGUCgSg=;
 b=qn7HokcmRgJ/xLsxUx6fcv+yLktYyyWTNZEbjvpbxxebW7hRr0A4+JWJoiborIwy4opp60cHqJawj1mQYV6U99jEGhVpOKvocYIwUFlfWbFQMYFdok4zpMt7c6i9Q/ME1AeUhW0ZkJ7X4tGppKfNzb8Stn9DE4UIrotjKUthKpQqV+fNGeyLqNOZdrrY/DPOP0+noMmWh4pCsiq9sBySlZ5Vn07W2zZWPGa0DmmqcuaUwAnuYODDUfps05ZlZm2jp57Lg2nWBK+VWKWjXgtGCq7sc7JacttGIXaZTvM7Y/fTQXz+XBfNlPaQd/UL8nJFs0o9qyPhqQ5aRorBZ+XM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhYukEpAAwUKWRf68Uo9FZQhTdRX9ETQYrsglGUCgSg=;
 b=o+YGvjt5UP4lZykZnZ2SCa0IvV2jL1kTRnh+Fl/tgakGiJmgd2WN+IN4UQsn4VpAGH4Dn00jMq2wDygW/cpEFN5Do0HL9/PWvm2lzUl8k2XHfCYbDwWtEs/CX8KR//I+2ojXJqBfKO+pYqEAOwBb1aB15dRz8Tg9Zj3d+JQmCdc=
Received: from DU7P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::14)
 by GV2PR02MB8652.eurprd02.prod.outlook.com (2603:10a6:150:7c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:39:34 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::2a) by DU7P250CA0025.outlook.office365.com
 (2603:10a6:10:54f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 22:39:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:34 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:31 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 2/7] docs: ABI: power: rt9471: Add newline for paragraphs
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Message-ID: <98bc1b0dae37a68b4a5f148094459fabd5f4c867.1793225920.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 23:39:31 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|GV2PR02MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: b97cc16e-270f-4da9-0293-08df354456f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|261009223027099003|261021121427099003|261022105027099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|3023799007|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ZugtW1cwTsEZNgoFc06vG0hHh4+t3RePcThdm2Kicau1ansMS7hZ/n4LcMhEQFt1ZeGGSO+hkipNeeHPDxGSm4Q0j8DeCEWIAtVyQl7Gfij1VO6Mv1nIqxos2Vx0y5+RpIG6Wb00JxDXmQWzu+23ojuTxh20+nU/x43z5s1PEZOGn4PHW+O9SD6MRn36ZOZa+GxldqC5ORjaQ24xu6buh4WOYstC3A9UX0I1GbCgEunv4sKjXvzRFXlBieW/l0pZJKbeayIL1sPNeSNjhZRrgKHRHncyfccu96UIiY7I+N6EVfUEmT2nYG3Hc9VT86xVVs3tyU+LfoqwjpZ1AuvZQnPAsz4hRxW3bzfyFcwg3awBCPdt0UJi2YialqPRczFfUXsLb5LpTaA32n4cMuNOjx1tKi/NuOSRWWmz5x9CBIJVUkv4v2kRJ/wXOX6D8RseVqc9d3lfrkDzLBROIS6+MhpkWp6jjGjnBiLUbAzdbqS81ROJfSaLcwpZwEMbQF5RShd2eHrj/iv//fRhEilLMEpYNORytkmoDzLAGwIslFFPudhq7t47O0vhwh0SUdO4r8qgJOjlcDYdeO/7JJwxEff+EMiLlfx+VBr7lv8+7JBRy0o5PQLotWaP3GorTf9l5y2dMfrMxSIMLxpixKC+faMyu/qKuYDVisyQIMKzvB0=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(3023799007)(11063799006)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sB1RqdekWNgM2gJ+kNlHdrvVqyk61VjE/HtwcrdzHWdSq1w/8H4cU7p0Te3OGvUKstpVPdJgIGVQVg9sdAvVrgGg/rwiM1w3mYr/Q0fxiFexx+ZMtcJ/tVzXeNS3xcIh8Yoe1u18Nhpm9dtPK7clIELyS4uCsuTtTYfu8i0CxTf8Cibb5Fu8dQyD9hlYngW0mdovKn89N8v3RX7odTerOd0z2c+PZe0IYzNezBJ5Tlwph+Xz6kQt1rA/Q8Nn19/PUiHUyaO1seyAF4KPgy/P4oTKT0Kg8PKAubRPLfm0NigX0cVJMEQY5I3UtxC02njPQZvntBh3MDn2PsjYO7zYBz2LT8dxpePfn/Lu6fEPNIsm8XGBqSTT/qokHt3Ssc/zj9GFoLS6s5Wc9QKLzcbFM/iaVv0Prgpb3mW2osGQO56sUSkZdQp5/6ts+mEfhtks
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:34.2285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97cc16e-270f-4da9-0293-08df354456f4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8652

To split paragraphs in reStructuredText, an empty line is needed.
Otherwise the output will be:

  Access: Read, Write Valid values: - 1: enabled - 0: disabled

Add a newline in order to properly format it as intended.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index d4ea9c9a5a9b2..53393488ec419 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -14,7 +14,9 @@ Description:
 		Note: use /sys/class/power_supply/rt9471-\*/load_switch instead.
 
 		Access: Read, Write
+
 		Valid values:
+
 		- 1: enabled
 		- 0: disabled
 
@@ -29,6 +31,8 @@ Description:
 		datasheet for details. Normally controlled when TypeC/USBPD port integrated.
 
 		Access: Read, Write
+
 		Valid values:
+
 		- 1: enabled
 		- 0: disabled
-- 
2.43.0

