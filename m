Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD450254A;
	Mon, 21 Sep 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017370; cv=fail; b=DXNKzav57O2PqRBCYOsLvmTmQBANaf/QklvqiqPCDzJ7JDcMVNC89Zc98hoV4n0rH2At956UcHZOWuj8fD7FN0dQX+c82UfJqsHx9m5ZOlA2osOGsSousqg3kfPhhmw0Q+AZs67zK+4Hy9Icnoz5ghLvfZPFk6kOywBKKL7RdfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017370; c=relaxed/simple;
	bh=599kirf6nSI3N1TxzWDSYvhqt/r8XPtyilwWQzi/+kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ho906t063J5eJJUa5DDopRSNW/mBQO3KzJeYyGJVTAannkjdrRgwikpsk3luqdrZb2K5TFqQcgQ1dTsT+GopO0ajG6DpR3flmj2JTYWJ/HJJ0855P8JWJ+oB5lQNxw3MTDf7zjW7JazMG790gjpR7llBUYcdaz6VBPR2SfgDSgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g1I0UALx; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g1I0UALx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeRPj0muZlXTILglRAFCzuNdZ50YTVv5TEeB1KUnvgIt/24JTB5+yOlcqeur/q1X0oApGoOJD3Y15Y+HrPlGEQqqZzv1fdx8i+MM674B8Hgb8gHaske5ZpH8KgQAnLvJxlbXLnf3dHaCbZx2HFkS+jGZiRwPV/cYLuEZ9T+62D/JN/t7bhO/q8Rn8vc0M0yfB+kdT8BV7xvo3URPuZ4k2UXuEc621HG1Tn14zmpQaxNufiI9MGC5r9QFUWaH8fOJYOZKjMZqn4N8KWL3g/PvGIdf8gkD4B8uWDMNwQfwegCIBq0AELEtW9l0/hRYfYLtO1El9M1H3WbGTsg0YcLyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB8oxDN/MyYdGv862a1sW8qCkF5mA8e0rFzPH7SNiqM=;
 b=s6sTJfMe+ITruLVprQa3VnAXhrZ2/qCJkYgt49LbrHvzIceDHULmH+YII7Y7xt+ijV5WHmtjBEVI1bksM9c6yygN52BQGnsT2I3ULdRT/pqPq8lCz//MFWgKWaSRi2ohpnllx1/uUdCuFqnGQr24zPjF9c3fqDyDOCHdOuw5NBMPacPdNq+XTNxteicKGm6QlG0CjfswRZH4+6G1B9cXf702ehmLXiTEl/CXF+CwcUMM4Vb7+ENU7fPmxoM6ouIl4qKjHNTRkJ4pUYsFyDoa8BEQIxrh+KCccClXAU7q3UK8Lc/4aPtpSN3zCWKCiWHf1JB89fHJu1W1CVkeANdQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB8oxDN/MyYdGv862a1sW8qCkF5mA8e0rFzPH7SNiqM=;
 b=g1I0UALxXL6luGg6kMS31Ixq6766C9Gf1dAeK74Z2wJf6zO14ehyJEwVXKFSK9jtjH+OPMwFe1hMyR4ezafHLcOFXD4WI+eKFmfnQq5cAmMrCqgXyzBiZ45i+4LWECsQfKnu8y2smvW7+JQncdzF1VYBzH8gUwFOehUuuMD1txw=
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by EAYPR12MB756173.namprd12.prod.outlook.com (2603:10b6:303:2f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:02:44 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::60) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 19:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:02:44 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 14:02:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 1/4] cpufreq: amd-pstate: Restore previous mode when changing driver mode fails
Date: Mon, 21 Sep 2026 14:02:32 -0500
Message-ID: <20260921190235.3651688-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|EAYPR12MB756173:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bf3831-bb12-40b4-b420-08df1812eb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	9G+SwJMXshZ25YK5zj/o4WR1xm8gYyu3Rvd5cPzJ4ou3jqIDfQgPkquLg8l4m548GGHL1GWH1aRa6GxakbzrNlwAWXegJTSx+PYip3MIWDmDlJesGE3ChvGIAa6IHZTD6NWc0OkzI19bHtLFK9etaNnmMZnT5+Sgd45Ym8zrn7WWz+O9p36X/8JvZfwMsrxkWr0pqjRbM3fZc0lZzHvI9+T/Zj5RahBmI7r2DGwVTHovJVIXskApKxNe3CpGscj+Gf3wPGWx0LC1j5zoAKy+uw7L5P81frus9lEhPGWYlZ7REIy2OerUfTLh4ZuFbKOCIbvHa58Ei5W+nTIPKb42F/JllqarGVBWmNcfW1u/fU0wvyVboZ1cK0WXIJc4MV35DNKgdctCbs0CC08vBOGICQoC/MDzdH+mnQ8eILtSyGOrc+IRD+YYvzsnWUtEcqXH8bpfJKkb9wN/ULXHommYm9jWILJUlynPT+T9vYNOuoWlX6OTFQK2izDel9ETCQPbkcDlXINqC5pA4KBQI6F09iSscR/ypX/c8+e8JQXRd/qm3P/aL0zEmr8S9NRIXjSlv9ml54p+mSNVJ4FnWUVhhE5nh4oonowRyUf7QL55WsmdboyEtKaZ+3tgmk7EwuYYTwXy8xU7Ws7mS6oDStp8/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aFtUOeRaQeeqy44hFxv8v0+Pyu4V1Dqyd+4yWfi4mRc20xdskyVfOKZS1F+gjwyq5ibh5UEHXaur0jq9EbYljaJU9w0Tqov1vvyLXTE+LQQpDxw9YE78xYqvD2zmGfCUqumOkrmMpIVa1D3IELMsCFJYb49qoohY4hOqUYZgTtRV1ZOMj053ZC36wg+EAqhwW4jKrUUh03871WTeqVTXI4h4O6CDzojX9Pn9bUK/ldS6AG7Xdd+IRody3eUjR3SXRvOUUFMVi/J/jvE0eM3dAY/IDxsr3KfVTaR7UuR08iNitBzpAfkVMJgAK5Lj6ZymM38XGcX4RoUz5iE0DyRhG4FGp7LHiiihvmfRB/7bMYt9KsEolbczSaarbffFjS2lfGSUwBIzcCafXJmjIpUdGv3ig0L84r8FtXR7L+altl43au7uxhg3kp8qAGzAtrJQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:02:44.6738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bf3831-bb12-40b4-b420-08df1812eb5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB756173

amd_pstate_change_driver_mode() unregisters the currently active driver
before registering the requested mode.  If amd_pstate_register_driver()
fails for the new mode, the function returns the error without restoring
anything, leaving the system with no cpufreq scaling driver at all until
a valid mode is manually re-selected.

Remember the mode that was active before the transition and, if
registering the requested mode fails, register the previous mode again so
the system keeps a working scaling driver.  The original error is still
returned to the caller so the sysfs write reports the failure.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-5b138ddb-c88b-4f82-8a2d-f39446b625d4
Fixes: 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control support via sysfs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 03727d9b2ff84..f633a8e349255 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1833,6 +1833,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 
 static int amd_pstate_change_driver_mode(int mode)
 {
+	int old_mode = cppc_state;
 	int ret;
 
 	lockdep_assert_held(&amd_pstate_driver_lock);
@@ -1842,10 +1843,16 @@ static int amd_pstate_change_driver_mode(int mode)
 		return ret;
 
 	ret = amd_pstate_register_driver(mode);
-	if (ret)
-		return ret;
+	if (ret) {
+		pr_err("Failed to register %s mode, restoring %s mode\n",
+		       amd_pstate_get_mode_string(mode),
+		       amd_pstate_get_mode_string(old_mode));
+		if (amd_pstate_register_driver(old_mode))
+			pr_err("Failed to restore %s mode\n",
+			       amd_pstate_get_mode_string(old_mode));
+	}
 
-	return 0;
+	return ret;
 }
 
 static cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
-- 
2.43.0

