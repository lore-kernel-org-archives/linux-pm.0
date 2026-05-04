Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD036C9CC;
	Mon,  4 May 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935717; cv=fail; b=MmBMsapJNZRZbJ8Zv6cKtCmW7WRqVG4k9gdUZR0qrE7TjJ61jt6NSDPDAZQARcf0cokyQMHNy+YlmCN+YFTyE539B9HiKhPUmfqqDce1mkZtubzHjJ/+eP4u9lszE1f0TagadqGocxNWZTXci00VNrnF84zsKtlkDepRLaALUug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935717; c=relaxed/simple;
	bh=8W1TVJju9Ngm2MeMp25yzFLGLZFZ+BUEJmp0hyl5Siw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afYZEH4X6b9SkqwPxZlNyzCnTdc5sxghRB1y/vfC6+FHuJEy9+ykKylTqPsQsjABE7XDW40uUYd8wVCt59LE8SxSpMEChEciaNNTrf/w5sZ/y49/VFkdZRBNjRugSe4l3My+b/BYD3G8FgFWKFI5rjzITMst8lUux9/IleHAXLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rtE96AQ6; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rtE96AQ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiO8GdwBIApeWOeTXlhR4ykZ5NzFojJRA8xigqIrfl2Vjc1Y+QfOfPpiF3OH+YjnjskNqEAanfQrFpGtF93zsg5bk1HXhSefTudF3NG2f8ti3lMqoO+5lZi++9Fi59xdC4hek33wjxct/MUqco8itBnluzj38pMXvmctuNK4qJBTY0kHr5tELebF+cO2I2mYmLDsZQsjqsTFMFFYefVdppmhO5ah7ZxKZ1kIIUEeQ1jY8d1sjF89nvOyqMf9h5KeEJlZaQysG+0dNa+2qCDqkVgFvFWhkz/bWu3YvhR+gND+79q483KTvxSw6OqU6Do98oVHLr/ZbgKu5FdDmyHRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eujsdyE4ZFQunKpBYOkk0PvfjY7/ne8UmAo3Be1S468=;
 b=tubXhi2uR5l6spW64+QGoix7ygRSsVnJDUFbvIqLFHNoxQB9oAiP2KxTcftMs6qXVTByysiPUXBncCvL1k8jGvlABaaTN3tT9lDoO7RXBwnrScDCdUqbxHzcXtJryOWyMV2YXHyu1qePXcCTDBa4zRpisbjcXnyF5CAVsI1ccubD2NXx26lZl8gQKjd1tifEhuvns841gwlksXBHs4nTBrzy5RlG9CcdS8IJWucKeo/kAfXDAuA4fnusBzprpF7EMD0NlXzCltA9ODMTZBIsyQ7B5HMzpL4d1pobRgzcwm+D1vgmsGkYgYOoS3Jf9bgNQc31pRP+oSruV5JusXiDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eujsdyE4ZFQunKpBYOkk0PvfjY7/ne8UmAo3Be1S468=;
 b=rtE96AQ6KjQp+mRLeLCg6tNNGpunrm/8jNvL1fdVG/4UnQaFynxV6T9N2SkSouN5ginR4CClbs5YUHDdU7ignK8UjYlDxAxKKUTY/69IrM2IT4BP/MbDu4vtY31vnaMErwbfheANN9SKjEPq3hJtM+TBWWq6D7Z3z/jNPIVkiwU=
Received: from MN2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:d4::16)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 23:01:53 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::1) by MN2PR04CA0003.outlook.office365.com
 (2603:10b6:208:d4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 23:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 23:01:52 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 18:01:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, Kim Phillips
	<kim.phillips@amd.com>
Subject: [PATCH v2 1/5] Revert "ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"
Date: Mon, 4 May 2026 18:01:37 -0500
Message-ID: <20260504230141.484743-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504230141.484743-1-mario.limonciello@amd.com>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 975d0128-cdec-4b80-77bf-08deaa31214a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1fZ2wEXdPNdfaI34Y89LA7zUNTHTf4F7g5h0nhXxHtYxNJ6xpv26YUuyGW+hPpHC/I9E1d1g5TBrdKlA7TbD6+duq/tMkFiBNyc7pmzKr7ZzrwJ+CebaQ0pNW/pK8hlk7HEzeoVbUe4+xCHADB2yr/RqEs9ig5tQZHUJw7FQf+ezwRZGcwPyDXrdkgmrovuK/aSDIVILCkkvdRqTIMpzoIUgLZWRJpKtUz6wZxL9e+oTT3Jqri6RpoJVnx78yzNoCtdcxa4yW9QK9B6yc9eYh9ogj9ZV2K3Bj9Uz5MxqJpEOnTwnoNjcIXv+6C/I5KylRtPbrwWz4xTiDwtVD1vRfL6s2aV1SIWTrqoep2NklnM1wBKUuhN6eonq81xShQxEztbtWb+zsG5opQB3LyxqKxwpuAu6e5bi48qCxLwBJF56/k9YqsdHtYnB94kTleuK15SSuIqhy7as6uxbnQcoJ1xkWUWWEPPhPNskDVRWzOgu+PQURM3CPlfms8d2BsSovevD9zgwtM8jC9X+Jy5qfbrJWMd8AyKhAdtWOQwuq+Ifg4K2o9i2Yz/wAczSBDJAEXVJnpgeEl1b1NVUfGIwMfU3ebARLhZqD4/zRMdjD+H8Oe1qKGZ7bd426HHvkag9BK+xWpLnaZL4aFeVGtEIVeADeAB/KCNfQwfeULy0YA9XxEVxNE9ZwXfkEeEINHDDZyI/UQnSW2gPwlKpoqUBS2UhESNbdm9hEyYhGW46S8A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fF7xyohkjy2IkxV0dHfv541S9GlNm/klFuvmPM1PiOBl2av2mTNuoNEWqTVN0U/ZAuAusdV/FRtpkxGRJnAznU7h6Y5MyrCmUCvmaJuSEGngX7zZ9twOr+Q/s3k6MHYedKaD6M8zgXnoDxlSyMHIeVq+xCcsw42zn1q/6WgbrgPhRJ2F7x28nOc0+ng7UchntFKRrCFCbZngiFn/zERhJLqF59rr3cJTQ50gpBpRk2U2K9ARzneHIrdC0v1QXDqLjYq75rGYh9S8NpnN4ynYbpZ0nJaXCqT6SWOozZtL6yA8eYeDbI+weYyMfRn0mwU0NCZJduj8aUUMqFgfxEuT2RiY0OilAx15gc3gENNQx2Gdvl/fdS8BYoIhOdbDu4bxz6bTiC+LZZLzQub1rgHH0VhuWaWBYnW+dfF6qh7AYsu0W49D8teNGiU6b9oS4Hav
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:01:52.1480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d0128-cdec-4b80-77bf-08deaa31214a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

Some older systems don't support CPPC in the firmware and this just makes
noise for them when booting.  Drop back to debug.

This reverts commit 21fb59ab4b9767085f4fe1edbdbe3177fbb9ec97.

Fixes: 21fb59ab4b976 ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn")
Suggested-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index d7c8ef1e354d3..be4c5e9e5ff6f 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -88,19 +88,19 @@ static void amd_set_max_freq_ratio(void)
 
 	rc = cppc_get_perf_caps(0, &perf_caps);
 	if (rc) {
-		pr_warn("Could not retrieve perf counters (%d)\n", rc);
+		pr_debug("Could not retrieve perf counters (%d)\n", rc);
 		return;
 	}
 
 	rc = amd_get_boost_ratio_numerator(0, &numerator);
 	if (rc) {
-		pr_warn("Could not retrieve highest performance (%d)\n", rc);
+		pr_debug("Could not retrieve highest performance (%d)\n", rc);
 		return;
 	}
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (!nominal_perf) {
-		pr_warn("Could not retrieve nominal performance\n");
+		pr_debug("Could not retrieve nominal performance\n");
 		return;
 	}
 
-- 
2.43.0

