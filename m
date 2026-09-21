Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010017.outbound.protection.outlook.com [52.101.228.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D249E147;
	Mon, 21 Sep 2026 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998304; cv=fail; b=J7NmidIYUqH+XxZN1IcltyEY70Lez6WWp+6ExePMjDVCrJXbGT/Y/OAkzR5i9imLCvQgGzXsd3C6ZNwUkp+aHsr/2rpMiIcuSON7GK//3qnq8YqGovnrWPvWR0qoNnkm1GQP4mGmaNA7EZwhUDH4ajnlSlM+m8J7ygCSt9WCcbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998304; c=relaxed/simple;
	bh=zrwTBtPFhdDfYlBbn8H3zgcy6TXcfkFYJOHAc99cedg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rk1kOJpp1hKmzlkSyyqNozKXhiaGzF1hi2+0FOdDxUqQDiT8VO1Q6eolNp6dUYR87pjU4HOh9UnxIhxdXAYCrkAU4zNvWse9sCOR1c4wUUA72xcPH1a3tf9YGu0cHRB38dWkHplqNsfQMeqvrUz/gb/FbAkB0H1IkZv7nah8Ohk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=QA2Jhp+J; arc=fail smtp.client-ip=52.101.228.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="QA2Jhp+J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlclNC9wNr+V9kJzDvV+gmpcHFCO3cSXjTUrrDotlcf2Lom4DC08bDPG8kOjqVdflLwZxmDFUCFsNLiyKGt8F6OhcRTD142295/4cVmXccGxCSBe8hxf4fg+dYvHlNrVahnckCeIMIZbQUceHCzBz7WYxg5Nu0z80BAdrnoiBCWhFGG2BCHhH33jj6Uu1EfiqkpmDBhh5n/8hbHc8xXh8oRrriYl60+9cG4bpt1/Q7m4wifR2QN43wWVcErNA92uQ2UobztkoRnMlbRufkv/xNt0E/hSc/OpvkPtZhWb4q/+iSZx5sEltSNLMxrj7093lpBKmzSOW47w2CZzEPjp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RXK6jmXXDMQpQTY50RcnpcJIUPzSH4ZCAeKIfZjXYw=;
 b=d9TjKNf1nQOOIYY7FuYLrQoykq9CNaA7d3n1RWLtelLoHyGzBOlB2fZz0Ekp2GUUHNErgB1exHGh3vdzs7GTuZ2gC6e3VT7lyR7MU28MyobHRt9w34nEBWWSthCDIURoeC4qXhU9fb2OfOb8oWCiDKcdG9BVNsWC7MeaMwHH9zYqQkG9huFofA/5IYt6ql/kG7he4q20B7NcirxCXtrb0UxQvFj3dlpABqeTXrp92gGowURXLwQvCbt9huX/h0cj2QXnyxNNa/H4zMqdKel9Q6E6c7KewEdqQT9ALGeyW8F2K4HzqzQLu9aEAplJUizrGoOyQHnmEBmqV/472O7EbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RXK6jmXXDMQpQTY50RcnpcJIUPzSH4ZCAeKIfZjXYw=;
 b=QA2Jhp+J3RnsGVfnVj6ySn6lO5L6j83waeEaB1roS2sVdBcEGEJ3Nw1LQuMcMbTSPb7BwWZAbwRA0mhN4mC+gU68o9DQmzcdfPw84RPInwr06tvt/IPNoIYtwwx8XpHUfGsfhhAHc/A0yLsBNi/Q0bXYPMBM2XX+amvFLNfTHRY=
Received: from OS0P286CA0129.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16b::21)
 by TY4PR01MB13334.jpnprd01.prod.outlook.com (2603:1096:405:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:44:57 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:16b:cafe::30) by OS0P286CA0129.outlook.office365.com
 (2603:1096:604:16b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 13:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 13:44:57 +0000
Received: from laptop.adwin.renesas.com (GBR-5CG34119KX.adwin.renesas.com [10.226.37.103])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6CBFB300025F;
	Mon, 21 Sep 2026 22:44:51 +0900 (JST)
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/9] Add support for Renesas RZ/G2M v3.0 (a.k.a R8A774A3) SoC
Date: Mon, 21 Sep 2026 13:44:20 +0000
Message-ID: <20260921134432.50338-1-ayman.chaudhry.kc@renesas.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TY4PR01MB13334:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6cd72914-6755-47aa-b7ab-08df17e6864f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	2c+9qgYiYUSXg4+zB9VziCUFsWN/oHPTFH/Cpykgz9TuuGmfgVXbNw5OgTysP5tJGFx8QkfrDFZ/TVRFh3vioUfKlSrcFKfDRwHUJdKk5sl8W532OsXqzloaLuiZIbHF3/MeKWF71pnq8dtkgollsudsoVUWFLf/Wh793jl5ffq9crVvtW0SPsnHw/kOT2BzdSOi0HLEvjjVhp+1tcumN1OWxpgSBvHvBxjZqjKzD3MPR0aiTiZqfPMZ0+0Uy3WxEq71DQlopni0mryF19zpraN6BG3Akv+POUY4prZI2dQYS/Q1lQmQfZQp8stg7nGHD0llr/+2U64/YY5TY1lcx9XpHElV+F3F2VM3Ahu5aRCNnlzsskcl+DYKcsu9Eorp98p4VGhbJVZCeXhdgi4N6UbdIFYjby2fizsw+pWJ7QbVEHoUgSvH078Jyy5foNdqxbMBzVXwtw7wy60bzBNaIsHLBIgpghK6/xYxI5on4WsNygnVn7vvwltlBYl2giPKBI2fTPNACU50nvYI667tI55hrElQBgqHtSn9EfQMWomRQlTzUV7bHeY54vJYSUtgkDqR79UWKercRsvAdKRJuTm1I4pBqZ9C6jHHshuxwLmbd6c2g8hmx9WvjzvrW4Aj95eKq2W6SMY79I2xY8m7PpbkoFdY8oUW4+QmoCnrzuk=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	foFRpfZ9rnN0us8hFsr+gaVIY+E+cFyWzcukP1Ut/GBKN4BFeZ7zgFwD3iLvQ+gm27P5+zvQy+faTwpZ4iI9ZgWxb7RYXV8W8pqPd9ZymC15ffMnNosfirbpqAx0NDe/NQOWUQ23e31dNMsPRNewJRSqprhYgeLUJLoBWAB2Z767X/lwW8cwCmuOqM9VPHGvVV/z+bv+C9ZQPMR4VXnoQXQ+gM2ybUIwNMkrZFd2u4Ij2INfjTXofCeHsTWcxJrF6Nj2u60mUNEkkEUx0RwZaQNnCDiGOMtDDj8/wi/2t03xcFIIUhdUMDm6bsaaiU6tAOTkxZ3UoJLkstp9mIBWz1lLM9dmmFeiuaK7zs2qg7VU17+YwqZ3cWoY7wFctzQBRMw8+DTq8Y8rGr3AMK4WwIqV4fLzXqTd4APu/Ip0emYjdRMoLQeNtFJNM+PPDw1w
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:44:57.2545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd72914-6755-47aa-b7ab-08df17e6864f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13334

Hi All,

This patch series adds initial support for the Renesas RZ/G2M v3.0
(a.k.a. R8A774A3) SoC, which is similar to the Renesas RZ/G2M v1.3
(a.k.a. R8A774A1) SoC but does have hardware differences, for example
the System Controller lacks the A2VC0 power area, and CPG lacks modules
like FCPCI.

v1->v2:
- Dropped patch 01/10 ("soc: renesas: Identify RZ/G2M v3.0 SoC") as it
  has already been mainlined.
- Dropped patch 05/10 ("soc: renesas: rcar-rst: Add support for RZ/G2M
  v3.0") as it has already been mainlined.
- PATCH 01/09: New patch.
- Renamed SYSC and CPG dt-bindings to include vendor prefix and updated
  all references accordingly.
- Added vendor prefix to include guards for SYSC and CPG dt-bindings.
- Updated commit message for patch #2.
- Added space before closing brace for `ca57-cpu1` area.
- Replaced underscores of node names with hyphens in DTSI.
- Updated patch #7 to not use odd sizes for the sizes of registers and
  also removed the leading 0 for the system-controller node.
- Added soc: label to soc node.
- Dropped bootargs from chosen.
- Corrected indentation for patch #9.
- Updated licensing to use "GPL-2.0-only OR BSD-2-Clause".
- Added Reviewed-by tag to patches #2-7.

v1: https://lore.kernel.org/all/20260821150408.73829-1-ayman.chaudhry.kc@renesas.com/

Thanks,
Ayman

Ayman Chaudhry (9):
  dt-bindings: power: renesas,rcar-sysc: Document vendor-prefixed header
    paths
  dt-bindings: power: Add r8a774a3 SYSC power domain definitions
  pmdomain: renesas: rcar-sys: Add r8a774a3 support
  soc: renesas: Enable SYSC driver for r8a774a3
  dt-bindings: clock: Add r8a774a3 CPG Core Clock definitions
  clk: renesas: Add support for RZ/G2M v3.0
  arm64: dts: renesas: Add initial SoC DTSI for RZ/G2M v3.0
  arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC main board support
  arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC sub board support

 .../bindings/power/renesas,rcar-sysc.yaml     |   7 +-
 arch/arm64/boot/dts/renesas/Makefile          |   3 +
 .../dts/renesas/r8a774a3-hihope-rzg2m-ex.dts  |  14 +
 .../dts/renesas/r8a774a3-hihope-rzg2m.dts     |  49 +++
 arch/arm64/boot/dts/renesas/r8a774a3.dtsi     | 302 ++++++++++++++++++
 drivers/clk/renesas/Kconfig                   |   5 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r8a774a3-cpg-mssr.c       | 168 ++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c        |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h        |   1 +
 drivers/pmdomain/renesas/Kconfig              |   4 +
 drivers/pmdomain/renesas/Makefile             |   1 +
 drivers/pmdomain/renesas/r8a774a3-sysc.c      |  45 +++
 drivers/pmdomain/renesas/rcar-sysc.c          |   3 +
 drivers/pmdomain/renesas/rcar-sysc.h          |   1 +
 drivers/soc/renesas/Kconfig                   |   1 +
 .../clock/renesas,r8a774a3-cpg-mssr.h         |  59 ++++
 .../dt-bindings/power/renesas,r8a774a3-sysc.h |  30 ++
 18 files changed, 698 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3.dtsi
 create mode 100644 drivers/clk/renesas/r8a774a3-cpg-mssr.c
 create mode 100644 drivers/pmdomain/renesas/r8a774a3-sysc.c
 create mode 100644 include/dt-bindings/clock/renesas,r8a774a3-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/renesas,r8a774a3-sysc.h

-- 
2.34.1

