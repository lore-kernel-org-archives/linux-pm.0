Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010003.outbound.protection.outlook.com [52.101.228.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EE4FD7B4;
	Fri, 18 Sep 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744091; cv=fail; b=JjRuTxiUSJFOI8vCoRo2Y+ZLioQix3Lpfivp4GUI2CXqLCkAuqTAA66SenTD2yJ3AqEFC4MiAGP642+mVYnhWzth1HFz9JlxN7igFV7i1umt7paA20NBq0Ig5SnFus8PdaqtqXWH6TUJFDsY2Acua2VnUYX0ufRHdeYpITe7Ypk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744091; c=relaxed/simple;
	bh=NYZHW4GmR0zMRfuz+AeJ2zH8L8cY+1iGyANldZ8Jl6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLs9cOVhnrbpUn5R77UMDQ8SijA6GP8+fy1IZLDqlWpCw/30ke5KmxvDdYcnvTgAHgs/h+CsGQYJq5jA7eOE4i5ZAwgsphrc/jn/bpmNKFJwL3hzyZ/9s/JjyuGi2Pa9aDrg5J0mPwv7pdbiOTA8FHTJDeaolQb4vgKFjdGa8nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ciK6hkD1; arc=fail smtp.client-ip=52.101.228.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ciK6hkD1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJuSEnkJYkdA4JVBQss1HwT9a5aTI5jGS8c6mNvqz/Ns2rsadufqZ7yw/De2LNwnTk7mZA12zZ5UrCGyJjTWE74VcgpBl7J3+IjCO1Yi+wMrDBv67iTbXKsAKF4H0QF5LoAHacA3ih/TRgqV1T0TSmd0EyCr5poNcOXSp072TzBAfvOINgiz+DunEueGA6EhgK8MbQGvg5yr3camgUCf3c/wFZ8aKUxLX7GjDB7EujZBV30OJUeFGBM2jctlpccTVoumFqhyfX3GExvHKXuqnPD9fOPzhGXnCC1QzQ5xpG7/8sM5s/ffqHymZCmS5+q4z5OiX8VnUikNgocGZYC0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yMENaN7PlQeT35mYBvLZbXShkL0OZbajmmh9VIgFZM=;
 b=I5GxYPBQ7vqrNx7UNp8Ud7Uuto0jCKT3pY0Awc0JLPy9kni8M4PO96Bwtzckcgk7blWOflfjkCmGmVzEJqvRV5ryuJlTWqJpy90LyMe08samSpbHRgFakOywcaggA/e99gEeZZAo2U00PFtqZvJhNT6mQnmILUHFE0NHpH7HH9/7lI048KAX7JR6yAyvJ3gtXcUIECi8Q72gP+g4RMF18M7eZZTId3KmuqrSY+O6G857Q8NTwI59L2JBZ0K/n1SwobTcx1jx8ujCuWFakJyc/dd+9EH6j1G+mrTCISjNOu867r49LulftDmcj9IwAKF1USpkST1DIRT2P5dfV3vhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yMENaN7PlQeT35mYBvLZbXShkL0OZbajmmh9VIgFZM=;
 b=ciK6hkD1geR3TO9yFjDS2ROMQeF8FRZTLLYR/5VZhX7KfqptM05bemx6hb739h0/WnSE1n9SRHUNAYwaeUUWsNxdYD6Dlk+h39qw4qoqXAtiDRUXuzgUPYuYAseuzQHprSCO6zYR4AEMsQRTKAumLwQM+paC00I8pkmsuXAan44=
Received: from TY4P286CA0058.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:371::16)
 by TYRPR01MB16230.jpnprd01.prod.outlook.com (2603:1096:405:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 15:08:04 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371:cafe::22) by TY4P286CA0058.outlook.office365.com
 (2603:1096:405:371::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 15:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:08:04 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 6AF1D30007D2;
	Sat, 19 Sep 2026 00:07:54 +0900 (JST)
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
Subject: [PATCH v2 0/8] Add Renesas RZ/G3L TSU support
Date: Fri, 18 Sep 2026 16:07:17 +0100
Message-ID: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYRPR01MB16230:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e814c029-dfbb-4cb7-9adf-08df1596a369
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vGs/D5vx3gSbby6HTKhXfwSmuSyJUbP/zrhWkfFYmIjodjlH7pLnQPXh/83w/NcHk9DfTurG6RCL0bbxnW3R1k0z7l6yGScpncIec53X+25bQlKim13LdwvTQ1yUUU44wt+TJXj3bJdgkzRvpJpGZmdOQGDyhcTXt1yr/WQuss0BFoEKFSeim/XDUnCrL6xGA48RAMMRKqsnsMh0gQ/phdrBYVbHhF6DTFm0zmiMtqKdJCbt9Mqcig/RSnss+O29Dx58k7XqxV2wlSq3F1nul+BNQboHN1qQiR2oLALViqQZ37sZqXRz+pQCcHBbtt+m4c567YIygZCanmbwGxrgqON62bKc1PmxgX3ZMGllXiyPYeT031H4MtwB3Ee23PWKzK1i9Uw29LgZxDG9uoOmq77DndwbKS90IQAYCeTlVlev35GF6En4fB9lS7DpZjKaiqF57R6zSHc3zcTB5SElzq9bCvv9Myr5BjzbNj/e6yK4pvYgjjTsdKY9pLkdUsBnczOEweiADB5h/TAUuLts2n7nRxYRi1ag5D/VKeyNPWqNMy9kD+73AVPmkQIu1GUiH0h1EweO91CKvvL5wMWBHRmbMWxLM21yXx0rnJflwWxAR6nNuQe+EPYcY5+e3ypZBuU3eDc0AaX0tT8X9AakABKDq1NBSUHzGT3Vy7GSN4NMqGn4KU6WbsN/84/H2rqLNIpKNYGgdqAZ29v1f8lI+A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bFLLGjoDs3bzDqVOEwWys0/6kLvy+UmBjL2pnho4mJ0rnKBS0ckpX9JYxcWS7lcv7RMnAGGjD+NhN76vcyi717dPwhA539jTvb8nv3UxvkFZqIl0HoA1q57fxUTEIFUCxNGaQZVGRJYWFjKAXY08KgBIUqTqqGRGP2IGlqbGQHfWm5pzWMVTUH+nl2h9SteVFm0nkmU6LROsN61FyrEuYjs5myc5kDHkgS8TEdaThp43zCmuVnQwaySY4Z5tJ/t6j7qzFTFa9BtfvaiiH2M0g408Df9zX6wyE7LEGJjRSWpxcd3nZzCikFQ1386BN5ZPujUMbQgbuCP9VF82CicHzHDkKQ8PTjk3I7uejVweAfAo9DJZfmbwtBwg0f7cJyywIvWizwAOT19fHLhvIhCtZWd0NKKPynNGAonL9DhC3FDWGOlmEN6JnoNmJMkDC5FD
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:08:04.0289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e814c029-dfbb-4cb7-9adf-08df1596a369
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16230

The Thermal sensor unit (a.k.a TSU) IP found on the RZ/G3L SoC is similar
to the RZ/G3S, but it has different calibration constants. Moreover, the
TSU is connected to A/D converter of TSU (a.k.a ADC1) on the RZ/G3L,
whereas it is connected to ADC0 on the RZ/G3S.

Compared to ADC0, there are no A/D conversion result registers(ADCR0 to
ADCR7) on the RZ/G3L, and the INTEN bits in the A/D converter interrupt
control register(a.k.a ADINT)  are also different.

This patch series aims to add support for TSU along with ADC1.

Merge strategy:
  * patch #1 clk subsystem
  * patch #2-#4 thermal subsystem
  * patch #5-#7 iio subsystem
  * patch #8 SoC subsystem

v1->v2:
 * Merged TSU and ADC1 series together.
 * Moved the clk patch.

Biju Das (8):
  clk: renesas: r9a08g046: Add TSU,ADC1 clocks and reset
  dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
  thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC
    match data
  thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
  dt-bindings: iio: adc: renesas,rzg2l-adc: Make '#io-channel-cells'
    required for R9A08G045
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
  iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
  arm64: dts: renesas: r9a08g046: Enable TSU

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 +++++++-
 .../thermal/renesas,r9a08g045-tsu.yaml        |  4 +-
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 66 +++++++++++++++++++
 drivers/clk/renesas/r9a08g046-cpg.c           | 10 +++
 drivers/iio/adc/rzg2l_adc.c                   |  9 +++
 drivers/thermal/renesas/rzg3s_thermal.c       | 38 ++++++++---
 6 files changed, 144 insertions(+), 11 deletions(-)

-- 
2.43.0

