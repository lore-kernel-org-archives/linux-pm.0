Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352324;
	b=J6ITsfAZIm1Ip5t7iFPMZnsakEqv3JLtrkhiDupko8lRowYhFSnV4im8vkY4kabZPFvK
	 G480OfGz+p5+I5PZ0s/1DW/1BrXxYJmz65Z0AywxIO665XfkDAv9rKZibO4HCtiO+CVa+
	 lfcQ9n6Cp7C6vjjQysOf/Atglx9D8Yrsm4RYk/3cVrvexPqsSYRTYd/eaX0jAZCx7Op7p
	 7IciBMruhXZBkoMxIi/IljPggQ8Ko7IKI5naBbIQ8S8KQS72JkFQf6T17nKZqTY76D5jM
	 xLQVpQz3B6Qd+7id4bd2rGJbDt8jY5KlTG6+R2yMdLta4IAbfEv5+fGYQDRSeWgbazA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352324;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
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
	bh=raoiYtcZ/fFzScurDWhTgsDnXCRtL6btUH+G07iObCI=;
	b=zmY8lNjUYxWRqUk1M6F3emavf2+S14GW141BHfiOTQa526ddECpgC++DcKGgAgMzRV8F
	 ZqDvwqn525Zm9PTAW/Xb89PEMxrefbG4Z5V1zCS5M4PbgwhilEJlibgX9+Ay+nRkCtf0d
	 uSRAY18dWYSXJ+YSBMznkluR8ZbTiHaoXWuIOJyYARy950E/jXPzBB4QWxq1soZhdr0pj
	 zmGr2DwVdozvYpmVFunNQMOqRRRVgamVPgJUxpNRldH+IfMrzOotdbD+9SbYYn9964trS
	 GBQFCG2GH5fxpjWLlrU6lzXNZeOiTwgWZTDqORZGHsa7ZNhdloXkexhWIGo1DAtleQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uYKYWuYP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.47
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C8606A31C;
	Fri, 30 Oct 2026 09:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 726C8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uYKYWuYP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbdLJ6V/OGtvur/mM6wyNv23vJja+QZOHVPjEJ1n7OxWbj/lDn9SxkqaW08+gOzp6Y+gDNkvZPtD4Z8kkD6WOatnP6kbzHcNEi5xZaHnu6XDPp5WUIjqJm++4f59uKl+kMojBEIQVJMsZ+pdauD/rMEPxOAH7ls2IkcTN1iJkKH51dWT2Kyvurjv93qNpswZ+LOWDRr925TaJCG0BtzTESSRZmU9ew2fT7kGzMcOmeuXvY6pp0Wasb2MncB0ReAXeP5xdcjaZlasMx/Tz4n/XnxTtm8SzxWixPdkygz0arAUcRJya/bICxHWuELXlUI30LiZs/LvuQbgHXYJhoLBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raoiYtcZ/fFzScurDWhTgsDnXCRtL6btUH+G07iObCI=;
 b=HEtO+xXAjsU7BN33rT7iJ/zXjm4TiDZXWrla35nGQ6ldn8Wm70CN8Qlr74lYb6vqQ0a3gKLxPWwzs87LWG8102qEL/taI2hWZAx2wmJemx0JTj3RFDfREqQFmc1VOh9SnK24ARynEr4/BHObx0TEJoOlXvOJ9ru+HbRITZkVX36pRy8eb+Hxxpd7KB3VE945E4HMuZxTl2GVLWA5FD0fBwCpKPzeJDRwCCT7PYFpTYq7klQbVwWIWTSBclXHaP7gE+JKK3cYZrTLJvJFqolUjMRxkeTrjUK6tXBVT5zxib5W5dSTNUfkdtjqilvvlMiewmaXQ4NbNumUCuHDmBV8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raoiYtcZ/fFzScurDWhTgsDnXCRtL6btUH+G07iObCI=;
 b=uYKYWuYPh2rCDmMzQ3ElHsFhFn7NAyLfByljzkPScbH6ZFKwtNCtoTCMyZW+uCLyBxi22tWAK1Pb6rpAGBIHHSBFi9BMKkL1ys91w21oGVIpGNJqeXBO0MLRV2vxIL2k096Nm5zOGaq8uNLCw6zE8VmiU7V1bB1TUhntK3Imdz8CHjqOTkeccqxRr6qQLTFd2Vjv0QCDGHSSBi0iPG0IJCo/hsLa5HTLst3WB2nitDlld3TmvqWxAkcAB0vZ4Kd3r3Icw4JSW/86r0aIvr+YEdHaHV4bb5FDATsExDW5hIMclrqNGvDxy8uw22199+In8w2abZvmo6+kLvtxXQKWcw==
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:25:17 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::55) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 30
 Oct 2026 09:25:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:25:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:25:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:25:04 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 02:24:58 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v7 4/5] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Fri, 30 Oct 2026 14:54:15 +0530
Message-ID: <20261030092416.1993889-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030092416.1993889-1-sumitg@nvidia.com>
References: <20261030092416.1993889-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 97650473-f1c8-4aed-11f2-08df3667b5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|36860700016|82310400026|921020|11063799006|5023799004|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|10067099003|261021121427099003|261009223027099003|261022113327099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CZQXbib1ozNbKmO9YhXggrzY0cFJwWYpSr1wXyKKab31wSjr5mZVSK9+/7OAzpW/u9mZ/hFO627vY4g43A55LEp2LMXpH5ZUvuVQfs54q7idlDPL40G6nH7m9QHBsc/QNqGrzBSonafmms+iRQO1iIHSlCkinFUfL1thogfO5+c0PCmd+sjXRuOk8lzLEtmUHmkT7rVe+Q2VhftACPA1To8wWH5CxrqTsTp+xjznua0suS1glPVy2Jjs+TibzYtcjFrFha0ZQ/7vAN0DbFiwJj49NPWAXYeJJUfm/8A9DBFQqtRC763L1hrHhMtCAuULwGeRrstr0AvVtBSs3Ij+K6d8im4HCDieDccZPVO5py+UK6S9e4pQYW8XK7P3l6gVh9FXHz1HUnHyi99gCD/2ripXCvuWLwqFoSoVVwp/KjM9yiw9c2dEPUElZ3jlusLoIGqePEPMi2OOYW8Ihc6GrJFmiQ+WuruFxoX4WdxBXOPvDqIsvDlzugX4t1fa5M9OE7BOmsWPAiVLiMUyoI2N80pAgIGTK7ynllqHcnZJeK2hU1qNKoQfuZzseA6gWsiHhAfNku1FCaTnQJ5ydPj2FHdeZ5dFwLi3fmr1B9ADlWENGM/diQXOw6JCv0XmDjZKaGvPiPzF2oD/ivJ+Om1rjTtstcbfCzjz42hg2fYD1TzooKX1JxlXeskDiDjKMoQ3PR75rHpgNkZuS59nJcPrVjPBUfb88VR3gN5klPNbVmk03StB+BF4dIRDYRnrGq0O
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(921020)(11063799006)(5023799004)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(10067099003)(261021121427099003)(261009223027099003)(261022113327099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Uos+DNdC5ruC4MUqxEY46XgTDauVVp0idtVh/RnH/wnBo+9K42aamkHKjIzGne0CDe0/PPi1W3TFhDrK48ITpsWwxt9BEAb3vuMbWqidSBuuI6a/mFA513gSWP0WwHMD3A1ocOLq8mcqgYeXveiqlaOiMZQBX6mBGxv23TNZjMD5K8LhWlVDBe1iCCEf1rzNlzRwukLMrb/Z8qUQFvMWCSmJtCIeBQr6ethL54Sy4mwiiHKc1eAtNRxEoD1XM6sEJZn+uinGLP7L+wgtZw7v3KfrmHbgiDyD2zdvcyftOvLhzohBnNMu1G0GJTqY6b8YySYakC6ETZ5LPs/GeMjn/rxXD1eUx865TgH3uhhzBaf/+zK5IhGtA4gkoFETxJ3fgalt0JbSLv+5a8nt2Koo+jtQQHxyx0YfSJ3HKrVj0d42NapY8nmKFQOCYrnqhaY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:25:16.8902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97650473-f1c8-4aed-11f2-08df3667b5e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

Values written to OSPM-set CPPC registers via sysfs are not handled in
two cases:

  - Across CPU hotplug: the platform may reset a CPU's registers while it
    is offline, and the value is lost.
  - On driver unload: the value stays in the register instead of
    returning to its pre-driver state.

Handle both by saving a firmware value and a requested value for each
register:

  - On init(), save each register's firmware value before the driver
    programs anything. Also use it as the requested value. If the OS
    never writes a register and the platform resets it while the CPU is
    offline, online() then restores the firmware value.
  - Save each successful sysfs write as the requested value.
  - On offline(), restore the firmware values.
  - On online(), reapply the requested values after reprogramming the
    performance controls.
  - On exit(), nothing is needed, as the core calls offline() first, which
    already restored the firmware values.

The value reapplied at online() is the last one the OS wrote, and it stays
in effect until userspace changes it. The performance controls are not
reapplied this way. online() recomputes them from the current policy
limits.

Also split the auto_act_window store out of the handler it shared with
perf_limited, so that it can save the requested value. perf_limited is
not tracked, as writing it only clears status bits.

Cover the Autonomous Selection (auto_sel), Energy Performance Preference
(EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
to EPP and auto_act_window only have meaning while auto_sel is enabled,
so write auto_sel before them when enabling it and after them when
disabling it. While autonomous selection stays disabled, the platform may
ignore those writes.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 227 ++++++++++++++++++++++++++++++++-
 1 file changed, 222 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3f7d740e04af..27ef1ea41a3e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -29,6 +29,185 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+/*
+ * OSPM-set CPPC registers tracked for save/restore. A value the OS wrote is
+ * reapplied from online() across CPU hotplug, and the firmware value is
+ * restored from offline().
+ *
+ * Autonomous Selection (auto_sel) is kept first, as the registers after it
+ * only have meaning while it is enabled.
+ */
+enum cppc_saved_reg_id {
+	CPPC_SAVED_AUTO_SEL,
+	CPPC_SAVED_EPP,
+	CPPC_SAVED_AUTO_ACT_WINDOW,
+	CPPC_NR_SAVED_REGS,
+};
+
+struct cppc_saved_reg {
+	const char *name;
+	int (*get)(int cpu, u64 *val);
+	int (*set)(int cpu, u64 val);
+};
+
+static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	[CPPC_SAVED_AUTO_SEL] = {
+		.name = "auto_sel",
+		.get = cppc_get_auto_sel,
+		.set = cppc_set_auto_sel,
+	},
+	[CPPC_SAVED_EPP] = {
+		.name = "epp",
+		.get = cppc_get_epp_perf,
+		.set = cppc_set_epp,
+	},
+	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
+		.name = "auto_act_window",
+		.get = cppc_get_auto_act_window,
+		.set = cppc_set_auto_act_window,
+	},
+};
+
+enum cppc_saved_type {
+	CPPC_SAVED_FIRMWARE,
+	CPPC_SAVED_REQUESTED,
+	CPPC_NR_SAVED_TYPES,
+};
+
+/*
+ * Per-policy values saved for each register in cppc_saved_regs[], U64_MAX
+ * if the register is not implemented or not readable:
+ *   CPPC_SAVED_FIRMWARE  - value before the driver touched it, saved at
+ *                          init() and written back when the policy goes
+ *                          offline
+ *   CPPC_SAVED_REQUESTED - value the OS asked for, reapplied at online().
+ *                          It starts as the firmware value and changes only
+ *                          when a write from the OS succeeds.
+ */
+struct cppc_policy_state {
+	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
+};
+
+static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
+
+/*
+ * Per-policy state is kept in the per-CPU variable of the first CPU the policy
+ * manages. related_cpus (the policy's full set of CPUs) never changes while the
+ * policy exists, so this CPU (unlike policy->cpu) stays the same across CPU
+ * hotplug, and every callback reaches the same copy.
+ */
+static struct cppc_policy_state *
+cppc_cpufreq_policy_state(struct cpufreq_policy *policy)
+{
+	const struct cpumask *policy_cpus = policy->related_cpus;
+
+	/*
+	 * related_cpus is empty during init(), as the core fills it in only
+	 * after init() returns. Use policy->cpus then, which has the same
+	 * first CPU.
+	 */
+	if (cpumask_empty(policy_cpus))
+		policy_cpus = policy->cpus;
+
+	return &per_cpu(cppc_policy_state, cpumask_first(policy_cpus));
+}
+
+/*
+ * Save each tracked register's firmware value before the driver programs
+ * anything. Also start the requested value from it. If the OS never writes a
+ * register and the platform resets it while the CPU is offline, online() then
+ * writes the firmware value back.
+ *
+ * Skip a register that is not implemented or not readable. Fail on any other
+ * read error, as the firmware value is needed to put the register back later.
+ */
+static int cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
+{
+	struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 val;
+	int i, ret;
+
+	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
+		ret = cppc_saved_regs[i].get(cpu, &val);
+		if (ret == -EOPNOTSUPP)
+			val = U64_MAX;
+		else if (ret)
+			return ret;
+
+		st->regs[i][CPPC_SAVED_FIRMWARE] = val;
+		st->regs[i][CPPC_SAVED_REQUESTED] = val;
+	}
+
+	return 0;
+}
+
+/*
+ * After a successful write to a tracked register, save the value so that
+ * online() can reapply it.
+ */
+static void cppc_cpufreq_save_requested(struct cpufreq_policy *policy,
+					enum cppc_saved_reg_id reg, u64 val)
+{
+	cppc_cpufreq_policy_state(policy)->regs[reg][CPPC_SAVED_REQUESTED] = val;
+}
+
+/*
+ * Write one tracked register, skipping it when there is no saved value.
+ * A register the platform does not allow writing is not an error.
+ */
+static void cppc_cpufreq_write_saved_reg(unsigned int cpu,
+					 enum cppc_saved_reg_id reg, u64 val,
+					 enum cppc_saved_type saved_type)
+{
+	const char *op = (saved_type == CPPC_SAVED_FIRMWARE) ?
+			 "restore firmware" : "reapply requested";
+	int ret;
+
+	if (val == U64_MAX)
+		return;
+
+	ret = cppc_saved_regs[reg].set(cpu, val);
+	if (ret == -EOPNOTSUPP)
+		return;
+	if (ret)
+		pr_debug("Failed to %s %s=%llu on CPU%u (%d)\n", op,
+			 cppc_saved_regs[reg].name, val, cpu, ret);
+}
+
+/*
+ * Apply the saved firmware or requested value to each tracked register.
+ *
+ * Write auto_sel first when the value being applied enables autonomous
+ * selection and last when it disables it, so the writes to the dependent
+ * registers can still take effect. While autonomous selection stays disabled,
+ * the platform may ignore those writes. Do not enable it temporarily to force
+ * them through.
+ */
+static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
+					  enum cppc_saved_type saved_type)
+{
+	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	unsigned int cpu = policy->cpu;
+	u64 auto_sel, val;
+	int i;
+
+	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
+
+	if (auto_sel)
+		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
+					     saved_type);
+
+	for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
+		val = st->regs[i][saved_type];
+		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
+	}
+
+	if (!auto_sel)
+		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
+					     saved_type);
+}
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -790,6 +969,12 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, desired_perf);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
+	ret = cppc_cpufreq_save_firmware_regs(policy);
+	if (ret) {
+		pr_debug("Err reading CPU%d firmware values: ret:%d\n", cpu, ret);
+		goto out;
+	}
+
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -821,12 +1006,14 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
  *
  * The platform may have disabled CPPC and reset the performance controls
  * (desired, min and max performance) while the CPU was offline. Re-enable
- * CPPC and reprogram the controls.
+ * CPPC, reprogram the controls and reapply the requested values of the
+ * OSPM-set registers, which offline() reset to firmware values.
  *
  * Log failures but do not return them, as the core would free the policy.
  * Continue after a failure to enable CPPC, as the writes that follow fail
- * on their own if the platform does not take them. A failed controls write
- * is not fatal, as the next frequency change writes the controls again.
+ * on their own if the platform does not take them. If the controls write
+ * fails, still reapply the OSPM-set registers, as frequency changes rewrite
+ * only the controls.
  */
 static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 {
@@ -872,6 +1059,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
+
 	/* Restart what offline() stopped, with a new counter snapshot. */
 	cppc_cpufreq_cpu_fie_init(policy);
 
@@ -889,6 +1078,9 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	/* Leave the platform in its pre-driver state. */
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+
 	/*
 	 * Stop the frequency invariance updates and cancel the pending work, so
 	 * that no sample spans the offline window. online() restarts them with
@@ -1097,6 +1289,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
+	cppc_cpufreq_save_requested(policy, CPPC_SAVED_AUTO_SEL, val);
+
 	return count;
 }
 
@@ -1144,8 +1338,30 @@ static ssize_t store_##_name(struct cpufreq_policy *policy,		\
 					    buf, count);		\
 }
 
-CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
-			 cppc_set_auto_act_window)
+static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_auto_act_window,
+					   buf);
+}
+
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
+				     const char *buf, size_t count)
+{
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_auto_act_window(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	cppc_cpufreq_save_requested(policy, CPPC_SAVED_AUTO_ACT_WINDOW, val);
+
+	return count;
+}
 
 static ssize_t
 show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
@@ -1170,6 +1386,7 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 		return ret;
 
 	cpu_data->perf_ctrls.energy_perf = val;
+	cppc_cpufreq_save_requested(policy, CPPC_SAVED_EPP, val);
 
 	return count;
 }
-- 
2.34.1

