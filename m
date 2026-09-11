Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010052.outbound.protection.outlook.com [52.101.229.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0C2DC792;
	Fri, 11 Sep 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132606; cv=fail; b=rEdPnF1F0kR4afHC8FTkGRcAyXF2rkUg2n4IvtAo1VwyG0UwEws4wm8Pn7Xtq0rCY7sJi+encQBP3g+nhhZv+hDEu7d1l8PZMu71WtnICTWe4kO2XJ7bOvAlGb3b/8J8+JOMbqCDAVyQe4/G0+FimeKEErNcNAVye2Al5x1gJ0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132606; c=relaxed/simple;
	bh=kuF9hbOWL0noa2fn+y2LADu9KsGRs0/3cAUjEiSq5qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXJ8aFi5KBKGgCe/+4rzpS174LXWi0w/PJaHR4aAHHHHSdskwALaB6UgbNIXCicjKHS4CzEQM5HuzHYoH8D0FIWiVCw6MeBKQF50U7tsFKRsd3j3RkdHDkT84B+oCnonNjLDRxazecc6cG67X8zk12hZPvfNFiasttsJTLBcpkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=gmCJQB0F; arc=fail smtp.client-ip=52.101.229.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="gmCJQB0F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+OS3fXBu169ih1P/YWXNodBk6lfrHnGDb4dbxad0JvBbsrD6D6OWT1UrIiDhBhU6sXTDjzBDMgke4DGGOIsvDj4xFTKCToAJC5JAvg9m8MOlubeE7U5Bx7bJGfJ3vsbTF5HEzaU1rMpWTn50Via7Bqmm9n9RXaqOlntU0Dmb4Cd08u+6Sgq58y8Y4RfMP0oj+hciOOePPpimOdd8boXvURNy4qzlB5/NWRyK3ho+UaKswEtvlreX/M0Lzs4ceg7zYjDsR+4V+hkAo9cLauoUlGjJvTxvfSV23j47tNH6JUtkDXdjLS1pHlOyyXm5adNrq/1w//RaKMOILdu2A3r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNZERxVGSpEJnjagNljblFtzi/ISMeWILrsJASojhH0=;
 b=WjkSiZ6qxBgvmQNdupdmaI5DAl+/rK+XHPNJKh4lrYKMZ1y/8MO2Ek0zS2dCZGw03ZrA26o0SGKKhGf9JWy1l5/ob47uzPr+6XcUE6FydXy5ZE2aref80mCy4v6pmF+cIlztP4SVnWIy3h2Lt+yjvaQ5WPTOYsqofQQPmVYa+qELogvVSYfSvMJ5VKZ2F9qLXxQRKtCwHuMiM7pWLiALEsBQJE+ANDPb1XZ1gChxrw3zQMDLjAspyK3fa6gZLI4RokhYkqHqHwPJYGYW+BVxlnulTRYXgm50aCY3Akjkem8m4xZa1fa2wE8y5QGwM5pILawbuFPaQuRMCXeA6PzE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNZERxVGSpEJnjagNljblFtzi/ISMeWILrsJASojhH0=;
 b=gmCJQB0FNVyIM9Oib8Y0vjoxIOlo/sj0xBWBCWzor4VgS07sJfRUwSX962fhBFS3EIdkB8fs/+2TfxH0UYcN7PaJMDuJX2dR2XX5YwS9ripB1g7wSF2JnasB3uwg4C/DQ+Pny1p2r1Kq2bKPZXlhqrDUbvquYTLfBGClKalz+r4=
Received: from OS3P286CA0038.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f5::19)
 by TYYPR01MB12494.jpnprd01.prod.outlook.com (2603:1096:405:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:16:41 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f5:cafe::5e) by OS3P286CA0038.outlook.office365.com
 (2603:1096:604:1f5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:16:41 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 588003010B32;
	Fri, 11 Sep 2026 22:16:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
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
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] Add Renesas RZ/G3L TSU support
Date: Fri, 11 Sep 2026 14:16:21 +0100
Message-ID: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYYPR01MB12494:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e5020730-b652-4d72-2220-08df1006eb3b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qFern7XgeX7OyFAj7SsJezPDDmOx/iaRdiI26t8AwKXFBUu51eDpidmvts3YmRH2dYPdNlqcPBngpd6B/wWVhI48Hi3VOnfMgGdvoWWA/Pzi9rY3tlDnbeD8FnFH+o1swpxRL54W/hjq/IIu6n+sN44YeL5AX0BFcKLNREaoxOh2Ewf/w3lyTUauVZ0+JlXkXPjOC7QIhdvF9AkkR3FLN+ekZ/FZj0+XNlnMf9H0e0kJAPzcYyolAg1pLlwpFuuW482zXYidhnqxlN9fYbAQmNTC5GPXp2QebEJ9zhbpbGb/eU85xzIiuwqU2/9dZtd9MpMAnAak1BfJclkjtFMdi3uusPUaQ1sNpkVb9MmgeR6a8+PugE2J5idO5DPk9nlPm9uag6/a4QsZag2jcp/ih5OBTZLdXFIsCDxqHW6DKZ0/7gJL7Ex4dU9ImZTbvpBEk8tG4LQw520L4C8w8iei8bEtjOG5eDB1uhTnTNj4xDLfzn2yAgKulhGKPprSJjHeU2xFx8jCvCZYBLi8CRM7144PKZ3lyp/dpI5aebuzAEwCC4mVmvFqa5c+i58Wpc/wPo+XxHhJKYCXrq1iGv9lWbTegeam3hOl04FwuWvTGFEWD6bmaTYJVKi3Awj22elrLOLMk8OJOWCn9epDn+gniP8mKfLzpru+zbf0dd4PGs8ZVfHHyZu8LGYBPTl6rxL4et6try6SzYENDBIDfJYcdQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pvf/rDHGc8XCgDWKVGBPKAKUWmO5+0NO3QChieiyiMX2qJT0oudqRvecJiYQ55woOEtRaGZZBqTNK41jGfRGCyQO5iec6yoa7jn8taHEt75KCQlrBRC6TldJg+iCnYtKpQnU82/vDOQyAOfS5P3QZvyKWfVPy1bmdq6mJCBZ0ZN2LpBhQbQpDSH3rd+U3S/1vgaiiTnoGISeT+Iznu0A9S4KT+QHsPMfnp+xRitcMAYgAoRZUPyu/S74y8/a14eWklb1kpd/BPGgimYh/ogu5if/POUDOHH20ZC+zz/eIIPD7QHAaAkt6rBnnRSsbkJz/fbaR6jJ4pU/YPoG4Q2D1iVV0JWEs66ew0lUeem0y/AlmymaKRxvw3Bt+FzygygXMMFX5UJG3FtLV8JpYTOj93W2brHVZoyzQ1OCvOAYLlhCRFyrsVn0a1PfznI2pkzH
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:16:41.1647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5020730-b652-4d72-2220-08df1006eb3b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12494

The TSU IP found on the RZ/G3L SoC is similar to the RZ/G3S, but it has
different calibration constants. Moreover, the TSU is connected to ADC1 on
the RZ/G3L, whereas it is connected to ADC0 on the RZ/G3S.

Biju Das (3):
  dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
  thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC
    match data
  thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support

 .../thermal/renesas,r9a08g045-tsu.yaml        |  4 +-
 drivers/thermal/renesas/rzg3s_thermal.c       | 38 ++++++++++++++-----
 2 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.43.0

