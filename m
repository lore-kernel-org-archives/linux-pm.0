Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792498819;
	b=0CTfCSG8dUBhInQf/qGE60Uw/wGHgJt6z4vCV77mhLkGhXfCBzcDxx9UJ3LVxzU7V7Bg
	 snyHiURFZtPeGADr0Jh++5D7Dyz4msW/PxgImn3gtO45y4Au0gjDlFzZUn2JcWiEw6JCr
	 QrurEtHDGI8Ljw8T3q/LMnK0E3xvInIlXsLW3gMbPRu4qEuC7loBL14dGUZJKTY/gqozO
	 Bs1TDk6fYZZd3XJnWM0IylmX/7+XkEQcZio5knROyaFeND/E063/Ko59Z3LQi9AbWzTdp
	 tRp1zgIXur0MMhaOLsMHsPZ9CHSxavVwHa+WnTqXSRwFW4qnrvoeaiid9XWCcFnuq3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498819;
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
	bh=GyeJEpvkAC4NDfRwTkn4Fs0D65FBQpfjSaJiqS4gXK4=;
	b=clZepMpCeNOPCOD/iWUPG6SzsjJtRre8sYB1h1YOnqzIg5AeHvsKLgbj+z1ZAPKOVnOW
	 76M6UC5mtlakcW3zIk8LPfHiPftFV7QeCZxBk4xJhJeRIkIxAL0sR1DpF/oDBk27TJS7N
	 Hu5pI6Hc2Rv8Yy4ReKUS3ZZWNaH5DruJCfCUa11e0J0XsoaGkZBgsO5l1Rdtq33UCSB1O
	 sPUzPIoavhTyt3pmgs0MtOuCkTMTB9mzYt4DG3MclJt0I12FTeIDVG7jlkHZ9KeXbV+rR
	 GO+0AlKxrZhmuTLkCZEEdmOH2gdVrLP6QGRfQx9jXAkTXQml2eVJ1OVl9yUef/Tjvdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pPH9WXu3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.19
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2860A2628;
	Tue, 20 Oct 2026 12:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA2860A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pPH9WXu3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3LtT0g2Kara2C331zXH5dozLGZEuAdC/hZLgr3GxPT0GhJrd7XwDxU7FrQc8MrIo9KmnYcC5b7O1GAsGPc3dh99eFB0xAB9L9h5JfcfOiww5QfBU0moZGxa8NZQpNcAinsqbjOaFUcyhRm4SVhNKWMd3ubBboTNfVJCVhKBdd62hB1SYVQ3McihmT8233gcTrKANPo3yxfbzAHQmAwLRuAb3yeP8Km1pmubchQSuKG5qJQv5JssnFT/KC3xkHgt+V7qYlb8JpcXHxxiNVZMd44xNekdCVXOILVGT+1Nt0gDsNfDmNRaR2P7OzaL6MoT1ILvlnz6U8dQxjc+oPBY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyeJEpvkAC4NDfRwTkn4Fs0D65FBQpfjSaJiqS4gXK4=;
 b=BcEcy4WFeF6rys43DwnAKC495ln/9oG9nwPJr8SPeKZWNpPgdUOhqY1zavfHNptpgYz036OuC8biXsny/hgUjn6/9QYN0clU6lr2fiGYYeNWrKTpvrUumgjM8tkqPcRm8hX14GkBCeVCuyV40goQqFFwyG8qqyPgF1TUfMM159zABbLeo4QmRQvgZZCogeApF7Bv4hebFxv6oYSqkQ2LfuJBkNXUdkz0G22ALLFH3St7S/JIT7Be1tWVGMYYNFdw7c6EuAc7FHfNvEhXcqSoHVnWWa/L5JPPUiteBX4QFJhkR10GHy5fbhhWP/7vlDm43WOhy3xdk+c4znKAB6Sixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyeJEpvkAC4NDfRwTkn4Fs0D65FBQpfjSaJiqS4gXK4=;
 b=pPH9WXu3nr+YGX0b2fd3mWd8ACFAkN3FOn2IrvpQ31FNaWM0+sJHsRZVc6kHOhXx1flteUpWsznaGdcxIFip0L1WN+SzZ80yt3pCincZuQixJycAR8M0TCGzhVjaiiRlbUm0I8SuXbbQJW9TrON9wB5YODVTSMsOkhWnQBaMPbAUCKF3pC4CUn+5qiPenvs9RpsGIYDn5VLNuTFIjIAOktX+0LtOtIGPj3/Rj2gQ1HLyrzQdpGGmpqvYTtrscr/qaaxisoPfYx+M+eQoY9euQILZrVpvgACnUnxSLgKzIJTg1o8b8ICdXWduewasuOydV9jGnOQOu6Q1xdB55JiuUA==
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:20:07 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::71) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 12:20:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 12:20:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 05:19:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 05:19:49 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 05:19:42 -0700
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
Subject: [PATCH v6 5/5] cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
Date: Tue, 20 Oct 2026 17:48:46 +0530
Message-ID: <20261020121846.691218-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020121846.691218-1-sumitg@nvidia.com>
References: <20261020121846.691218-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee11c2e-3f63-4e1a-cb74-08df2ea47a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hPz84knt3Ybq2Ix5srk3Ee1Vb3UtRaGPJ+kR9nbfRt12UIzUB+PysNQPFQykiaXIHWCopO+0nAtBXw6wQ4sK3IaraiUfRaP230eswQT7OPYOFOmXfsvMn2HkEmuF4ap1/bOVhlfL0MpDh5vuYRBqwT5KYIuV5lhWDeCTur8eJ2fuyNio13q9I+mkiwpqlq76diLohsulkZ15sTNHM1btuW5MoydiHqdvIdiBunIVlYFxz1j9Ig8T3u2kOzpZb6w66fYTjebJG6NacuYlFd62A9NBp0Gznfw/eranQKYpn2/E0n7NuNhH+33/xD3ZUkCSRluu0dw0amyBLFM4VLvVeBE4wn1lNvTvxsHRuMw9YvcIsHj8HhIN0YLIgx5XNO7MIp2TPnW0KsGl+Ln3mLCJK9eyISiTIHEFDA5EgHPa3aW+KoyYHDKD83yfmr9Td7FORIGmbnw/lgpMWSsmYSzUF7/M7O9fTeyYkj/Ckg5j+iR8vHvfyJNfsLTsez6cbfZfZbRiWzd7lnvMgRfUnv77l7QMPJwxJ0InBWmkTjlSa3EOYR2GK9MzN9memQcvPllt/iaciZZ284SzDfUJ0LW/A5ebJckisLv1gVrNCRCgskjabkOAO9bk3d13sypLYwdigvum+cV5aCd0pUiO1XLlhaF9nSXaySDYkOfSHBfkbzPrpT7I7b/453F6jpztNimDrz/s7h9P+X+vitcGulHjvD6gS2Qpf+a7tj+Eb6piWGWp/3N81j8mMIzK8TFe9anp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ShU38J1gJGFCx+z3vzvgwtGVXkZ3darxmr5p2zBCGJI6qM8hzOgYtctKxGJgB6F7bCHoSmcA3b9cC97vh6H2E9xERr38tMnnaIFveMS3EaYPBayUgom4VBiIh9ShiY9bCQFsfc1OO1lGkaD7m0Dq63/90N7sZAd/BQCn9qL1JhLdT5A46Q7X8vputsv8acglRFIR4I1PK0JcGrOI9cax7UAnrWqVXWQolduJsw8yxu52bi7IPGXNkDYK8e2ig+sBwfuYRmo3kMLEDBu8u5m74pedFSzsZYr4KNyOdZLtlaaB8jemoLxHd3CZW4BDuvnWubC70ilA05AnojcHsUH60/9ilggSo21shyE5ZAwIV6/bp68QtXPE+cUCx3j+pvWz54Wx1XIm9/ezP2otn7acoD63FFOC7Bi3oo8Lar6/IrBILRArU0c2OykFC2/BWD1t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:20:06.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee11c2e-3f63-4e1a-cb74-08df2ea47a01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725

The driver preserves the OSPM-set registers across CPU hotplug, but system
suspend/resume is a separate path. On platforms that reset those registers
or the performance controls across suspend, the values are lost.

The hotplug callbacks cannot cover suspend on their own. offline() does
not run for every policy, as the boot CPU stays up during suspend-to-RAM
and no CPU goes offline during suspend-to-idle. The cpufreq core calls the
driver's suspend() for every active policy from cpufreq_suspend(), before
any CPU goes offline.

Reuse the same save/restore mechanism for suspend/resume:

  - suspend() saves the current OSPM-set values, restores the firmware
    ones and sets a per-policy flag, suspend_regs_handled, to record that.
    It also stops the frequency invariance updates, so that no sample
    spans the suspend window.
  - offline() skips the save and restore while the flag is set, as
    suspend() has already done both. Saving again would capture the
    firmware values that suspend() wrote back and lose what the OS set.
    It still requests the lowest performance.
  - online() clears the flag, so that a later offline() takes a fresh
    snapshot. It also restarts the frequency invariance updates. resume()
    no longer marks the cached fast-path limits stale, as online() already
    does.
  - resume() calls online() for a policy that still has the flag set. CPUs
    offlined during suspend come back before the core calls resume(), so
    online() has already run for their policies and cleared the flag.

Also make fie_init() cover related_cpus, as fie_exit() does. Some CPUs
may still be offline when resume() calls online(). online() is not
called again as they come up, so their frequency invariance updates
would never restart.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 81 ++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1b733f15d641..aa4429c615e0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -85,6 +85,12 @@ enum cppc_saved_type {
  */
 struct cppc_policy_state {
 	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
+	/*
+	 * Set by suspend() after it saves the OSPM-set values and restores the
+	 * firmware ones, so a later offline() does not save the firmware ones
+	 * over them. Cleared at init() and by online().
+	 */
+	bool suspend_regs_handled;
 };
 
 static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
@@ -313,6 +319,7 @@ static struct scale_freq_data cppc_sftd_pcc = {
 
 static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
+	const struct cpumask *cpus = policy->related_cpus;
 	struct scale_freq_data *sftd;
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
@@ -320,7 +327,17 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	if (fie_disabled)
 		return;
 
-	for_each_cpu(cpu, policy->cpus) {
+	/*
+	 * Use related_cpus, as cppc_cpufreq_cpu_fie_exit() does. When
+	 * cppc_cpufreq_cpu_resume() calls online(), policy->cpus holds only
+	 * the online CPUs. online() is not called again as the offline CPUs
+	 * come up, so their updates would never start. During init(),
+	 * related_cpus is empty and policy->cpus holds every CPU.
+	 */
+	if (cpumask_empty(cpus))
+		cpus = policy->cpus;
+
+	for_each_cpu(cpu, cpus) {
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		cppc_fi->cpu = cpu;
 		cppc_fi->cpu_data = policy->driver_data;
@@ -335,10 +352,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
 
-		/*
-		 * Don't abort as the CPU was offline while the driver was
-		 * getting registered.
-		 */
+		/* Don't abort for a CPU that is offline. */
 		if (ret && cpu_online(cpu)) {
 			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
 				__func__, cpu, ret);
@@ -347,7 +361,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	}
 
 	/* A shared policy may contain both PCC and non-PCC counters. */
-	for_each_cpu(cpu, policy->cpus) {
+	for_each_cpu(cpu, cpus) {
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		if (cppc_fi->pcc_work_initialized)
 			sftd = &cppc_sftd_pcc;
@@ -960,6 +974,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, desired_perf);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
 	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
@@ -1023,6 +1038,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
+
 	/*
 	 * The platform may have reset the controls, so drop the limits cached
 	 * for the fast path until the restore below reprograms them.
@@ -1081,9 +1098,14 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
-	/* Save what the OS set, and leave the platform in its pre-driver state. */
-	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
-	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	/*
+	 * Save what the OS set and leave the platform in its pre-driver state,
+	 * unless suspend() already did so earlier in this suspend cycle.
+	 */
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled) {
+		cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+		cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	}
 
 	/*
 	 * Stop the frequency invariance updates and cancel the pending work, so
@@ -1109,16 +1131,48 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+/*
+ * Run for every active policy when the system suspends, before any CPU goes
+ * offline.
+ *
+ * Save the OSPM-set values and restore the firmware values. Doing it here
+ * covers a policy whose CPUs stay online, for which offline() never runs.
+ * offline() skips the save for the rest of the suspend cycle, as it would
+ * capture the firmware values written here and lose what the OS set.
+ *
+ * Stop the frequency invariance updates too, so that no sample spans the
+ * suspend window. online() restarts them on the way back, from hotplug or
+ * from resume().
+ */
+static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
 {
-	struct cppc_cpudata *cpu_data = policy->driver_data;
+	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
+	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
+	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = true;
 
-	/* The platform may have reset the controls during suspend. */
-	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+	cppc_cpufreq_cpu_fie_exit(policy);
 
 	return 0;
 }
 
+/*
+ * Run the online() restore for a policy whose CPUs stayed online through
+ * suspend.
+ *
+ * CPUs offlined during suspend come back before the core calls resume(), so
+ * online() has already run for their policies and cleared the flag. Only a
+ * policy that still has it set needs online() here. Either way online() has
+ * reprogrammed the controls by the time resume() returns, so the limits
+ * cached for the fast path are up to date again.
+ */
+static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+{
+	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled)
+		return 0;
+
+	return cppc_cpufreq_cpu_online(policy);
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -1423,6 +1477,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.exit = cppc_cpufreq_cpu_exit,
 	.online = cppc_cpufreq_cpu_online,
 	.offline = cppc_cpufreq_cpu_offline,
+	.suspend = cppc_cpufreq_cpu_suspend,
 	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
-- 
2.34.1

