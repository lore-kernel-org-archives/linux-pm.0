Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010061.outbound.protection.outlook.com [52.101.229.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC7299920;
	Fri, 11 Sep 2026 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132636; cv=fail; b=XJyUuR7WUlkaQftF26cgQu9Y7WzEFTEC0Hf7cAy7advrtg7T6/GXnxeIGhAbzB04hC7xOpd4LnKrb30f0CIxvKYqQAVhAuJEnEH3XngfqIIK0Q4EueDNJhjRzvX9VoEs8DxDvOIYalDjLqLW/1I89xBOzUQgdA0YL0Ive9SLQgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132636; c=relaxed/simple;
	bh=tr/8f9ulhdMxIQj7YA0Bg8hL3+hiD6uJV3xNPyDVcMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcsb1gthcZwuS8vEZVOnF8q8/f5HTeClKvNkG8uKz7I6krTQeCdAEVqgED65xw0jDOCoDU2Vpv9TKAyp0uo2cSZqnRQt6LUCBUD3G9N0uC8zH+L/uuIzzfIfA3PkE+AMlVIzqqNH+Dt5D9xqkmKK41troLhafwO8GE/vIYQNsqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kckMyUBb; arc=fail smtp.client-ip=52.101.229.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kckMyUBb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q65TjSzFMGeJKQFw6iT7zA8U67cBqTKl0SfhP6p6eMWUpXQlOsYIUuQ98qoEjUkA/jH/NE3E/UZ2n4OEJ5IHPZtQWn8il3erXkwoMhgEzSMK0qf67T11N3qH+zoWkPNus0zW7+QmrG7p3zjDcCzwMgAyKNxgpnFdgxZrFGz9mnqeZLWZKgzNH1KlDFKmuH5COImVd2jHHS4I+EOoTd+nwj3YuoDwQMJaCOSgzJG3ddB2xWRAidxLn11r+7ZuDXzivspNChvewBjT4cOYOpfTG6JGyZspUWaZhfIT6xUDuYArueVuZfIVf5Qr5ET8LknnXiipuxzEl7uVqAPnMtb15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkvHsogu7DmqGT45eu55Lye0yjIQgwn3DCsmaX6BgTk=;
 b=ol/2ClDIdjljNWBQWETilKbHtybKvDCYsWlxzXNZA3+DPNkAaS4XY1/l/7vAkrXQQf7Uc/X9y4a7ffIDPsTwj3uevlfRhQjbe6XRNcJJMQiMzxQmBqmvxxG3tItFf8+S5ccceuLz4I6noynxPgE7yA6A8Ab2M4cnQrsLiB2vCiA2Z3LnHlij2iqQq3scXv/6e6D6dvVvJz+oHt0PHIBumk891jrVsSmKp1CxrSjKnhsclTbzBiILC5qqhiKfZqmEhwuRVJTIYKX1jLUtPyKCQyZLSkSAEld4uSXSEomDku2xJzJCQDLWeFV1Grq6Lqgq66QuxFQMEV63dNs3DmoSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkvHsogu7DmqGT45eu55Lye0yjIQgwn3DCsmaX6BgTk=;
 b=kckMyUBbhVb5X/a3vxqmIY/qfNQHY2DTwXGaABSrf3Weiupl+hljAGU0W/ZHmlJy6W3IsjfFwAagILvPLdUChCJPiS4Z9ggNjXhghh+h9a0RkAsvHQGz4vuB51ZcI+GIYZaXlaKxBUG2awC5jI8e+SBKm/H8CD/wC7zpYNbnGr8=
Received: from OSTPR01CA0031.jpnprd01.prod.outlook.com (2603:1096:604:21b::17)
 by TY4PR01MB14650.jpnprd01.prod.outlook.com (2603:1096:405:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:17:10 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21b:cafe::45) by OSTPR01CA0031.outlook.office365.com
 (2603:1096:604:21b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:17:09 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 753833000250;
	Fri, 11 Sep 2026 22:17:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/3] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
Date: Fri, 11 Sep 2026 14:16:24 +0100
Message-ID: <20260911131629.111564-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
References: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|TY4PR01MB14650:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f1587637-f974-4d11-8071-08df1006fc32
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/3Dvx5fuo4JUQFFGlF8WrmLLFA4UslAhbfraptASi0c3Gf6yQLs/L5+XFWoHJMGnz0ucZUcJvLGgxdXr4nk6bNOc3i/9KK6A4+mp6Izb9JW9DxR/25LGBLhZRSkdVsywA+XI38iz+AJOz2IbhnJAEtDdBMtdLbcBCeYFRmLz68TxFsp8skGeIA9Ir7tVPPJzTPNBrrU+jU28GC5577WhDRy88fYyxExZNd3CHffZM2EGlvlXdphe5dFo7+XxMn8ty+UwpXSsn4pw1Suo1N3OaxZ6TrSYxJFRcAAwq4wdCoC9tByzxqoBEB48wdXAK8UX9JJtkMZCw2ret29Ft+r3Pex46MI+grxav9CrobemNfTaPDBb/3TG65WM85tJdPx2M3dbnuzlG97mTF2WJY8JQ5OaK1/N0dEKr2kU9l7NHuephGZVKdP8M6mJa+R3FC+jwfEKOwW1PJXZdjcmKlNBKEi37ugG9uFsAtp+7suX6Gdu7xXnCyAObfiNp1RD/VXemz2R6iVsAKmknoNVCj6vyARBPjJ5a9R94Kco6EbTmbWe/tXA+mrrZcpdpFnRc3fDvfs7E5BTESbwdL/B5GdPL/L7Wy2p+CyxtEPK9h/JN+P03Vu+1PrYx70YSfSBp+OWPCT1FTxaf/YY5JDrDHwHXqumOiHJU+QrtgRIIsQZ+UAHGwH/f58tsi4Vc7mRN+lL95ocyrfh9G/bqb03p5Kn1Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vzB++C3OHfUxKmgHDXli9Dsfr1JR+LXCCdfxdD53zSUF6kEKG3GL6tEr3uqtu5AVlQl4Uw3zghtlmD3T+fg6vqXJhgTm9FF/ACIEx0BvDgm/3p3ZE5iu/qqeOun1FrnMsj2dsxH2EqnrewhGcgWZ5LcA/LCosXka3mUQTz1Luw0OtJBfiEXnQoVWJziv4cJ9LEzDj1zvm9YSmD34awpJzIYE0PU08Ws9P3K7qUU9TwCxfD8yKu++p8iyMXl+RtgKbSe0/5jpK4MOcguMck+kgkOOH8nFmoN/bSC+FHL2nhfISw6mIbMBzH9pA95fMRdTMuCtM36QiB5893uAbcOLMaIMRUcrpcAIfYBapsLpsijx94lOnRo70cSVSsLNlNtrG4VS0ffkECyvZCRcoBv4LSzoIlo759QFu3eQyBaEHdCcaz1VT4xzHnSVzYQ0KRSn
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:17:09.6275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1587637-f974-4d11-8071-08df1006fc32
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14650

Add the renesas,r9a08g046-tsu compatible string and its default
(software) calibration constants for RZ/G3L, used when FUSE
calibration values are missing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/renesas/rzg3s_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesas/rzg3s_thermal.c
index 146b73a1b751..a8716da7fcd2 100644
--- a/drivers/thermal/renesas/rzg3s_thermal.c
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -265,8 +265,14 @@ static const struct rzg3s_thermal_info rzg3s_info = {
 	.calib1 = 751,
 };
 
+static const struct rzg3s_thermal_info rzg3l_info = {
+	.calib0 = 1322,
+	.calib1 = 772,
+};
+
 static const struct of_device_id rzg3s_thermal_dt_ids[] = {
 	{ .compatible = "renesas,r9a08g045-tsu", .data = &rzg3s_info },
+	{ .compatible = "renesas,r9a08g046-tsu", .data = &rzg3l_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
-- 
2.43.0

