Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010034.outbound.protection.outlook.com [52.101.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B86E3EB802;
	Wed, 16 Sep 2026 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560044; cv=fail; b=CCxFcwcQd18mPXqXf6sK2Yck9PiVZMbXB1b11m+8wukDXiPfJPpGJfonrUMuWF/S6tPh8yTbR/S+GJbZVGinLiEZT/ffgq01ux3KtyNnymkRMHrqUGffZilgTQ5oKQhJR6MoOBDd33BrsKb9TislAHBioXoUic311u35nacJu5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560044; c=relaxed/simple;
	bh=FxtTmvCUlu5UgcMsb9AAeFgJLQhuVaGQakR1AEb+/DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bACttDxEGCySGbvDL6sj+qe1gYHikNaAhmUVYN8fT6n1LedwJBkkLb/lbdDWQsulPxGo1uwUN2zrlIzFbLfwIT7YC05VHfNUGUIesS9BtYU+p05fslCfrtawLll5pcWkSQ6I1vwWWiIoeWv/cCp7ByaPlD4tzpvfCtd18NGJfQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mqkCaVBP; arc=fail smtp.client-ip=52.101.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mqkCaVBP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCk6fzAuilvbCF8BmdYen04RPuMo47RssbR0+FY8fvDiSlFTQqJFa2r6QePbrUpTHKd2F7o9c+3i1MXIxDrmbWfNfIrKIO/LbSU32w+rxfxoDIJ1XKrRTjTb/WUyyGJLy9bK91+eiWXJf4V5nNyAoSDSntZl6OXn1YlB29UTkLxJkRw/Ax9vuy9xz9qBsr6pkgvB3Fj9pvXHvDMvxmPccGV2RVSJe+aH98ri9BQzO3v6LGNO3fit4Ys+gd5UNL4qojZnjE0QMPYb0fYBik5u4n3PIgHRQbEx1sqZf8EECowIxE+4qUdL5jIW9L5NOYE1x/XktcftmvJ454ZfWJViSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+SY32bnBtyEWV45h64MSlnYtVkmPWGuKsUtsXwV3uQ=;
 b=CoMULQdwrASDwK+ZCtQB2s7KIwks2CLCUyF3nM3w3BtiV78xg6WfNCg+XpEcQwDsFIN1TzGUEjgcDYjih1lznJGm/q563G/iuYSx3G48Lp3ubwt7IUofeWeipG508JhmNi52sDfugzQAgzBaEbASQuWf6+SIqEsLS/GxGGjz1ci4wCmxPVLBe7IxtkBETYWbuusw+gGdTK5V4ti73rhmCORrkdU9v+HA+U8vl5lH4BKoFBO5w0E/E0dhG7Nplr2mgg2tpRvRgcR9DlSLGzWNgJhyVBa8nMZIEjbN51Mn13LyBnbA1X66zWnDFXavzfJo+H4CSTW9h2cHPsqtUgc4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+SY32bnBtyEWV45h64MSlnYtVkmPWGuKsUtsXwV3uQ=;
 b=mqkCaVBPrdJ5jMVPr1r9M9Luti0RzNJJINwb+F+O1jUIBgVtlMejkhOd1Pd4AkZDbMGy+BPCBfi7w74coukfRIpIqxLekWamDMMT1PZMFvSgOTdqPVv0r6PSI9+C6H7wfwNUAnQt/TENLScU2kJJ7y9ctunc//B9jXn+1mao4Rk=
Received: from OS0P286CA0037.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9e::6) by
 OS3PR01MB7383.jpnprd01.prod.outlook.com (2603:1096:604:14a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.11; Wed, 16 Sep 2026 12:00:33 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9e:cafe::88) by OS0P286CA0037.outlook.office365.com
 (2603:1096:604:9e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 12:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 12:00:32 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.205])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 2EB313000441;
	Wed, 16 Sep 2026 21:00:29 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 2/5] thermal: renesas: rzg3e: Fix runtime PM handling of compare irq
Date: Wed, 16 Sep 2026 12:00:00 +0000
Message-ID: <20260916120003.87018-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916120003.87018-1-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|OS3PR01MB7383:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 76543b26-a39e-4081-83b0-08df13ea1c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sXU2za0w3EHMToQAdwraJDPQMQ2IGFtmTNJikv1jqqtWGgzx/GmreGTkKXO0lHZIFK3KXwlFTMRLtL7cXudz3EuCo48CCFV8RR9760fUufutyA0fGuD97CmNd+4sXd+nmg9z3udjKOscknsTYkhy4k5b0ZBmPpVQBuaHFf4IVCfSnCmFWXIXg0PoqxN1AHCa7INH6MTIqyyMAFkNHyIEbx3a/DVGmIO08LUoTrzGb7AZ+cOsQHXVZiIPcUDhBY6LO4eaJ4a1+CEWc+/t9P4M+dprIs1UlMuRRs7H54Y1xsVtwS0kKiOALf6ifwZ7gMlE1ju88WhPa9KD3fCNrQAiRxaooqe9Oj78Bzj+XpXOB4Y8r9PuJ1o4b684p4fvmY+udUN7FdytApJAjSoDrR+N4gEtw67+4K+F2fAeeKGwjp1q04S0ePOSc56hGkYcJre0mp++3SB/bJfkIr4r26EXLIwxKaEJnseBXp7BITcJqFavhqqApSXfxQ0wy0r/aH8jZejH23tyffD9Ybz2d2T5ZxB2nuxNnu3tx3gIFvv/1CGJK0xUSqksDrhGISrwZfqN1Ce7Q5oUKTRUQoqbawHWqmvqxKCDobYdxa3aX2IBCbRNkei1ughXoCSspY95xa3xVvEIXbXaXIrw3/ELDRe7/4flUYF+HtV/+YsZ8J8y9UlTUgXkpgti6Az1bjyxhAPtjJQMojOSpSmyyG8eQRSNdA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	85YYLGHqmE80NCK6NHbq1K9PvW49PfBgEk/723TL3Z0LEu68qF/pnS6+3T4hyTWQB0rgDjVuUYasno6yA4j9zbShQuWaomkTsrNhlS9zifCA1vn+la7EHRxJoCAhS7R6ouyf3jszKvjKsfrjrVzuBi9tAOTpIQ8ADHaf6pd+BT6KLgyGel8mNbi8swasMYlPRwe9mvrNxuKmfu+FhVhju12Q9EkoUAyoS9xjG4FkQa0HZ+/XO3iUHU0mBkn85oLm7cwT2k/SV++AOhfFzGJrOiPXc9HgB6kYTNkxz0/C2cbY6c8z/Z79dRiIX4bU9Gq3zJK9Cq90evQqqRuQtCjF5Fibp2u6lPuV2bAxxQzemU7J2aUeZCLE18uT76BRTxTdNhebbbZ7aTHFckRfWlcCx+T+wlpPkomFjyHY+BUkASvl3uL8lonV7JqGYwhwMQ0a
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:00:32.9436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76543b26-a39e-4081-83b0-08df13ea1c6c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7383

The TSU hw is limited in the sense that lower and upper trip points can be
set, but the hw cannot raise interrupts on its own. It can only signal that
the thresholds were passed when the temperature is read, either during
polling or on a manual read. Therefore, the interrupt enable state
configured by set_trips() must remain active for the next read to trigger
an event.

Currently, runtime PM autosuspend puts the chip to sleep and clears the
compare interrupt that was enabled during set_trips(). On power up, the
compare interrupt enable is not restored, which means that it won't ever
fire.

Fix this by caching the contents of the SIER register during runtime power
off and restore it during runtime power on.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas RZ/G3E SoC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 4acee4eaff05..45f67b2e1131 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -93,6 +93,7 @@ struct rzg3e_thermal_info {
  * @info: chip type specific information
  * @trmval0: calibration value 0 (b)
  * @trmval1: calibration value 1 (c)
+ * @sier: cached interrupt enable register
  * @lock: protects hardware access during conversions
  */
 struct rzg3e_thermal_priv {
@@ -103,6 +104,7 @@ struct rzg3e_thermal_priv {
 	const struct rzg3e_thermal_info *info;
 	u16 trmval0;
 	u16 trmval1;
+	u32 sier;
 	struct mutex lock;
 };
 
@@ -148,12 +150,16 @@ static int rzg3e_thermal_power_on(struct rzg3e_thermal_priv *priv)
 		return ret;
 	}
 
+	/* Restore interrupt enable state */
+	writel(priv->sier, priv->base + TSU_SIER);
+
 	return 0;
 }
 
 static void rzg3e_thermal_power_off(struct rzg3e_thermal_priv *priv)
 {
-	/* Disable all interrupts */
+	/* Save and disable all interrupts */
+	priv->sier = readl(priv->base + TSU_SIER);
 	writel(0, priv->base + TSU_SIER);
 
 	/* Clear pending interrupts */
-- 
2.34.1

