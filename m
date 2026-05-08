Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4B2A1B2;
	Fri,  8 May 2026 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217557; cv=fail; b=L/XntW6L4suW7EP2WkQ19WC37BP2NqZ/z0ldYvbL3tcQ+G6s5oCaR4Sy5KdRlbwgOUYQcsbdt9oXCGKFC/9+nwWme2Q7DKdp0Ex797kTHDwe/Q+RAB1NQbP9MCIxzKIs+lbtfVOlfi1MU2jzF9WcrModrXSZ46D2UZRNPlTSQO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217557; c=relaxed/simple;
	bh=IfWYOPhF13KCaXy4W5U0JpRIZbruzfoDR1ZpIk4O0is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsjtpiF5oMQi6u2wVB9Tla+T3Y0AG0IHntF84GKpnkgy6vtc7eW6lJLrAXQHXxZ2a1+9QLPgGw7YopbKeaKXIxjkdFjv2yz26gyi8XEP3rKtr0lByYI2olS68B2Ay05uFGVJ9Cfumml0iP0ld4jwC3/qntkau0KmVbUBEmHQ+6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4N7DZBG6; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4N7DZBG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7UwKQh7zr8aK8AFXdKJHPoc5ZKBmVhJeCQ2p2LCMgVMzFA5Rkh0LtdnIUpRCD4nW2Q5EVnjk2nB/fhnMbThcAS72QpO1fHQ8mX0iMhC4WHNrYesZ22NnDrzqU1fGLEZOnMxetqzq9xzgsO3AflYlAkpdxh/q9NFCy/r+AlDt1UNlJel5h9BiJdf6Qrjo8acnDElmieK+nG5nAeeHjXihofoxPtQOq34SNqf+ZwW7iQ6siih23OGDucoFPU6wsDU316+lxpXcamxeR07xE9v1UD8Ae+0VpSDFMBtVOlO9gXKj52PGWbhepgoxdsxZdc0AGqGtuoVnBnVRwGE41AD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2mqTcCkeYQmBOsqdj1tN6LmOO9HAi4Tt8DDBCTRPxU=;
 b=eKDR/1xAV/NsRQpGaLlxpi+cuhnvliDoMG9qdWLwg9YZ4Ikj8qdyzlEGhYFEVaNBCbC9AaNNl/tuYEy4V9DsVASyGFF6nB8ws24CVNNLAgCDh4IFNTgR/a6g0X2lqgHIC1Au9vmyJSHzSeYZ+A67Qth45cxtyqZRVIylX10CgZat+TRhNSEf/1emlczUBmfX9+ShykLshFv729A4NXNFI8vV4RBLvHSja2lInHtXyqpDIEiRcB88qmwrQWe+1atye31RbfAMu+KNHZkdS6wr8k0OKb+yfficTzKFbbDFNQyGF+eq5FC7bBr7292cqXM5YilLYDQih1VF7IB6ZaPm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2mqTcCkeYQmBOsqdj1tN6LmOO9HAi4Tt8DDBCTRPxU=;
 b=4N7DZBG6I8MMPzpYau/QAMP6iTF2KLEg6U0wPViqx0o83qDa96lBrBDc6EoM8hm/xZpZolskcRuLKhzKA62MfAlboiMMu6jMYXAzfbc7XfH4UReX83muJK8BN+0Jm6V1jerOmRyjBUfdKY62Q3T2iglWYi12OxH6bcbFWP2EuhI=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 05:19:11 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::69) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 05:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:19:11 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:19:08 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 4/6] cpufreq/amd-pstate: Reorder notifier unregistration and floor perf reset
Date: Fri, 8 May 2026 05:17:46 +0000
Message-ID: <20260508051748.10484-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508051748.10484-1-kprateek.nayak@amd.com>
References: <20260508051748.10484-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 494ca1d3-6988-4f46-26b7-08deacc1569c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vnp5tM5iWOm8c9B0ydNMGpPI3IdpdtatodKqozhtDIXB0T9MTsmIc1KT2tEmTHJ7KfyO1OyAh0NRyuaA7yYpmzH9BQXPx/uijnVg5RkUrSjkG0ykKPAlYoTR2VrtCMDGEghPg5gcpq8NVpDmBUUyQj1SlpGPJmX3LU+mP2xvb/jgcR6VV0BhjOOguAZSd//SruWzfv5Za8T43vBywSnua1RyNKhI++j4EgUSC0vuQdn/amZwbg8WxZOQe86pftIihqYmtA2Qran7juDt4gvCxvDtMG17d6UpIaCNewE5JaOPsx8mKNq5XuycFc5PLiU2SC6MlR0W6jZyiArsASaV5AAJ9GpgOfqu5KdmLPTJx7os9/wp7eCFA3WyelNEqKjBK6VFXtaNBbPemVEJWYZGaMXjSRPgFMQ1TMn7O4tDZOT26Cee0v5cQ9mBmGK26AP2g8r6eJ3ORZFDDc9ctEuWHmYr0UbqEAF832ddUrmM1Iw2BaQ+FjvThPr5uB1iC1zvfYKfm9WdKHtW8+rluagbNUqov+zu4AW3uL3J/x07rcEq4vFktZrY0XASWsP01G2XuyohxbXiWWnhSQaubL5yJmofN4YC3qzaWcMsnOAMmALjxX8nuJLf5xOsd9YudjjMC/11spwjityYyavFBaXsSU5G9s1AxdoGwlbkvayHyDRixuZiwBkmMUwZKnzU6tdE/O7bXUCtJlGUFHxZtaEyulBUlmclHupPk5BtzfTThnE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xW8lMhPxETE83AzWM9wr1dMUX1EQiDxBklYP7gyeDhmIn7A7OboGmjL4ywY3BV6BMDsX+Rxhk9roXZCX3FxzBebelNKoL2cAZXHtMVZnjKr4fTqf+U8g1CMNn3M0nO3x6ZeXCroVv4emrgNYunSajxRaP8uE8xD2AKmOA1TmfBWkx8jaeri8hdh24fOsxSr7g1i8vBZg/5aUwvJoNkbJ3eJ/wWRMcqjuVDBEVkrcI6EUhJfx0za6bqbURlyMk/3F4ik5IpN9Xw4ouN0cg1V5lHBwWpAvd8gfjSmtgext+qXGTdBto9UbGyr5zx9mgjrSBPoJXFsf+nrDzSNhulvWVdRsGfYkNv6g3ZLso7E+XBzlHpqnm7ayFhVCLG8OasOC/vYGIbb6YDFS8PG1QvTFr+En5n/+eTfnfDUq+z5JDOmfvdq9oLSQUnvmtOHvCYzc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:19:11.4391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ca1d3-6988-4f46-26b7-08deacc1569c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244

An active power supply notifier can race with amd_pstate_epp_cpu_exit()
trying to reset the floor perf and can overwrite the floor perf set in
MSR_AMD_CPPC_REQ.

Unregister the notifier before setting the floor perf to prevent the
rare race.

Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance preference")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 462ddad7bc79e..175925762a93c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1982,12 +1982,13 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	if (cpudata) {
 		union perf_cached perf = READ_ONCE(cpudata->perf);
 
+		if (cpudata->dynamic_epp)
+			amd_pstate_clear_dynamic_epp(policy);
+
 		/* Reset CPPC_REQ MSR to the BIOS value */
 		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 		amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 
-		if (cpudata->dynamic_epp)
-			amd_pstate_clear_dynamic_epp(policy);
 		kfree(cpudata);
 		policy->driver_data = NULL;
 	}
-- 
2.34.1

