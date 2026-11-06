Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993650;
	b=bbFPPbMSzJ3BqRTLGiT5ZzO0+UaeOFkgS30O7loLsCBHtHEHjAn+klMM7xcYeEQwqwV4
	 wMK1ffoyqSOr/PciF+UFv6KXuv4Bb6dUB6VA44l1EUgRnUvJH99ymlosGG0fJ2IG88wGq
	 oO5E0j7hcWuQgarwc4JD0/sMnpng5rdm7FlLk9wVKXF6jdYw2bke8AP7MlHiGAcU429oS
	 ACw80vsMPhQt4sSZmBsnw+dBP/2RE5i6pgnfF3FivBq5z6IfWfZ20nIF6vrUPvbRvfCn/
	 3O7+0q1iw53lwqJB7MFt9GhhV6zo6oZ/cfbdVB3scZE+nXQYg1FaNRpy9SnwqVk/jmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993650;
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
	bh=D9go+rsrVlDceJvJY/jx97FJnQZbqVS0XkFef1Yw7dU=;
	b=av6XwdrAKrTFHEVF5wkPAYplGWms8EmWQ4Iylrulm8IL1wtcHznjepslQbJLKeDNynuY
	 PtFCCE0jIZvswVJNtvwnn953gpAIwuYZXr3hb3rgsSqQ1N86Ab5iswqZzWKmw4E0Kdshm
	 ijtPFOkm/cTqKGETvvFsDc29A8uNGDo9vOAPT/FFd48WnzEfZmBIqOeL7Oqrp8xaYYFkt
	 gqxvymXkilODFLFvSCyva9RkrFB39fqD1ytQfeu8yS1ImKu1GALenwzxfuJGgOb7Ugk4y
	 yGNxQfgkpZ1LUDB02fzZkzjn+ymj6GxPPSVJOXbKB/T73ZPY839vz8/u6vf6JeKb5KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="mhYTr/6G";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.11
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F819606D801;
	Fri,  6 Nov 2026 19:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F819606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mhYTr/6G
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt+QTIJhX05e3nGYFmqxhmZBgeaYE2mZsN65Pg6jkXuxoNym1lj2TZCV0QS0KTzhWBYxuTkTovr3SkaXGki8yOiIH/GpCLIXVntiAYor+8TfYAer540vo52PNYrzhSfyctPDqZm1Rt4kNYWvDojTrEQwVkXof0MsjclDFu/wuj/i1Kq42Y0SXxJQ/ejKBe445eowdwiO0tKPpmZA8eQ22Y1guRFADpYhFyVfQkFzV1qZUT/KNdtbpg6ngbwU5qsJVkNXymvXtpJ7sBG3x10x56r+EcvS3V+5BcgDt+3ThO+zla21gzB846FqiI+0I71dG6vA29iI7rCC3lgIYt133Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9go+rsrVlDceJvJY/jx97FJnQZbqVS0XkFef1Yw7dU=;
 b=cA2bXAUgMuW5R4ZroWcdj4ZHOphbC8YKWH2ssG+KWVga2vqEeJJktAdanY7jiBBWwwNwyNv6SoWKeBHlOA0mMwWCsfsJ4IFGwyQwHDD2TTz0LZ1gz+VjjY9VXAHRbg7gk/1GWyFTyGBp1iL3hXd3L7lvahJvyI9WUvinKFLxchr7XTt7pDmNvJBH0QOuD0tn9UWLN7JWEn/zED9B+aclHFIgWNQxD7vOxyfBuVC4sa6vysaAvaW0m9DD7TIaFPiwTVgCCJshJwZb+3qNqPcQvcB+lEIjrpgI73L//cqtBHFwEO5iWT+ym9ee5UBP50jFY11LhWJPUrZxeUIo+xb/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9go+rsrVlDceJvJY/jx97FJnQZbqVS0XkFef1Yw7dU=;
 b=mhYTr/6G2jC5J4+Ik+RIj+JVSq2gE/9wNkXif0h7cJIl6/hbJBYTrJRPn5a+u/lXtb9llExJphFA/sgXGGEHfmiI+fEgDfDTArobbM2dJSHqtv4DjLOow8LdTCdoF2T5HcY82rF2N9KPj7SE8SP+R3gjvGXPD9iUcreSFXlBSR9bWe8VjcMmLXd7td/M0oleTbB7B9VpilVI9mJmA6W7T8DYlA3X3Jupxoyl+YbkP/WM6NYtHWdxLAxoUVTc7Yc8HsWzZ8hbGm3hl/LoN2g+QUtY4t0dvQFvyG43VnPjjwDkewqjMhztrNSpEIy52vIK2kyGSEYiwcvRqN2jsdeAyA==
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 19:34:02 +0000
Received: from CH3PEPF0002457D.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::35) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 19:34:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0002457D.mail.protection.outlook.com (10.167.252.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:34:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:33:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:33:46 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:33:40 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v9 2/8] cpufreq: CPPC: Keep the policy across CPU hotplug
Date: Sat, 7 Nov 2026 01:02:58 +0530
Message-ID: <20261106193304.3347374-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106193304.3347374-1-sumitg@nvidia.com>
References: <20261106193304.3347374-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457D:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 1545b55f-1080-4781-db94-08df3c3ce983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|18002099003|22082099003|10067099003|921020|11063799006|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Wp6j0qkaWF4B27luuK7Qz6Z1kIXL4AZ4f41qEw+Ig5kxIQnHEVHM44+L+IaQHMSNv53gWmU0O6JI/bjcV0z/6N533HrZRkjG7RnfN9JmlGeQD2sNKNoHlovLl2sTfOGDgq+/3i/eZxXw9X14JrgWnVLtewCgRWF3krJO9xaFCHxgbwXHVUkB19JQbQluNZzfnNuY0u3IuNSneJ/oMel99FjJ9EGJ2Xo6e8Syd6wTQyXB2a2ABPX6FRfFmqKGUooLm1qvocRd6a1L8aS/IJ+SSQNoC7M9rslfyORt7QaL7q1RsUXTeqdshTxUzahz5mx7wJ38rpbnkpDbe0RNaXHbdYif/k1D4SIdUQizxkJmbWmvQINSFhNp9U0ocDDp2tQuYml+gS/vJWmNQO6cWlCN3SsmPPobMoPQjW1gjBqlrG5SNcXniOuPnU4251h/TpAmuezqF9caNrsADkX0BwmlZFalMRt7DnjENBhxnoe8ul01eHzYG4IUMqFHidvOau84ieNmJPhImbjPOGiSStUaxpe5D9QSh9zCLnoI235rOf9yQ7nR8Req4kT0aLwnMmuAyDfZvHYJSk2sk7ipOoHJqFyINFmtk6+UdshhOu5YGDJIDNKybgS6UDBk6fYWz+4KjhKp/48chPh6MltvZiPDw9By7biaDpEgCJYjgdTcgXfMaHWCn1nZaHIm74aJiqd7hNATKEkH4xeTNm+LksxSIz0ZIDIz4oM+Yqco6lJ4vahX1g/8fHvx6XAE7MWzKXyN
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(11063799006)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sidjTM9+oPKW5fsTN2BCqLwHUvGhTf+ASW3EmmwVqON33yU2PlF1WzCl3MKfCY18EWIeNfwnv9V03tnqkltDGtfJUnHHQEgDSAHhx73L8xMlF/DOWP/xwWAeEfJHUgteRTdrYAZZMLTLK6PIemA1ETOsxhF9j3Rwdlh9iJzf5jZtpNn3YFuFhle5qtIIpwaQ3ybV1gV/71sKduALPjxNec1X3L0LdSArySmQBCkTmqMNy5l6kfSCuRQlVxEFfD+E29R1j3DinkW1SipmBYWTdVGsbeCZV2JPn6CgsgEiLldM5AR77pWAfUIMifZDtHpUCFcSa0dUhLIj2Lb782RiKRq66KNpBaJ5aMUZv0jGFvoT92w5QvCz2ZzCgidpwFqRFgODAIyL2L5mdwE0n3a7iSgV+0TGIQMMnsSe0K18+lwmXRL7qj85fND7HsERYCR3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:34:02.1845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1545b55f-1080-4781-db94-08df3c3ce983
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

Without online()/offline() callbacks, the cpufreq core calls exit() when
a policy's last online CPU goes down. That drops the driver's per-policy
data, which init() rebuilds when a CPU comes back.

Add lightweight online()/offline() callbacks so the core instead keeps
the policy active and reuses the driver's cpu_data across CPU hotplug.
init() then runs once instead of on every hotplug, making CPU hotplug
faster.

This also lets offline() and online() restore and reapply register
values across CPU hotplug. A later patch in this series uses this to
preserve the OSPM-set registers.

Move what init() and exit() did on hotplug into the new callbacks:

  - offline() requests the lowest performance and stops the frequency
    invariance updates, as exit() did. It also sets MIN to the lowest
    performance, so that Desired is not below MIN while the CPU is
    offline.
  - online() re-enables CPPC and restores the performance controls, as
    the platform may have reset them. Failures are logged, not returned,
    as the core would free the policy. It also restarts the frequency
    invariance updates with a new counter snapshot, as init() did, so
    that no sample spans the offline window.
  - exit() now only frees the driver data, as the core calls offline()
    before it.

The driver keeps a copy of the MIN and MAX it last wrote, so that
fast_switch() can skip writing them again. online() marks that copy out
of date before the restore, as the platform may have reset the limits,
and updates it once the restore succeeds.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 106 ++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ded4f935638e..2cf250b38633 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -209,7 +209,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	if (fie_disabled)
 		return;
 
-	/* policy->cpus will be empty here, use related_cpus instead */
+	/* policy->cpus has only the online CPUs, so use related_cpus */
 	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
@@ -807,24 +807,110 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 }
 
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	/*
+	 * The core always calls offline() first, so only the driver data is
+	 * left to free.
+	 */
+	cppc_cpufreq_put_cpu_data(policy);
+}
+
+/*
+ * Run when the policy's first CPU comes back online, the counterpart of
+ * offline().
+ *
+ * The platform may have disabled CPPC and reset the performance controls
+ * (desired, min and max performance) while the CPU was offline. Re-enable
+ * CPPC and reprogram the controls.
+ *
+ * Log failures but do not return them, as the core would free the policy.
+ * Continue after a failure to enable CPPC, as the writes that follow fail
+ * on their own if the platform does not take them. A failed controls write
+ * is not fatal, as the next frequency change writes the controls again.
+ */
+static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 desired_perf, min_perf, max_perf;
+	struct cppc_perf_ctrls perf_ctrls = {};
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	/*
+	 * The platform may have reset MIN and MAX, so mark the copy that
+	 * fast_switch() uses as out of date until the restore below succeeds.
+	 */
+	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
+
+	/*
+	 * Recompute min/max from the policy, clamp the last request into range,
+	 * and reprogram the performance controls. Update the driver's copy only
+	 * if the write succeeds. Otherwise the next frequency change writes the
+	 * limits again.
+	 */
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
+	desired_perf = clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
+			       min_perf, max_perf);
+
+	perf_ctrls.desired_perf = desired_perf;
+	perf_ctrls.min_perf = min_perf;
+	perf_ctrls.max_perf = max_perf;
+	perf_ctrls.min_perf_valid = true;
+
+	ret = cppc_set_perf(cpu, &perf_ctrls);
+	if (ret) {
+		pr_debug("Failed to restore perf controls on CPU%u (%d)\n",
+			 cpu, ret);
+	} else {
+		WRITE_ONCE(cpu_data->perf_ctrls.desired_perf, desired_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.min_perf, min_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.max_perf, max_perf);
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
+	}
+
+	/* Restart what offline() stopped, with a new counter snapshot. */
+	cppc_cpufreq_cpu_fie_init(policy);
+
+	return 0;
+}
+
+/*
+ * Run when the policy's last online CPU goes down, the counterpart of online().
+ * Having offline() makes the core keep the policy rather than call exit().
+ */
+static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	/*
+	 * Stop the frequency invariance updates and cancel the pending work, so
+	 * that no sample spans the offline window. online() restarts them with
+	 * a new counter snapshot.
+	 */
 	cppc_cpufreq_cpu_fie_exit(policy);
 
-	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
-	cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
-	cpu_data->perf_ctrls.min_perf_valid = true;
+	/*
+	 * Request the lowest performance while the policy has no online CPU,
+	 * lowering MIN with it so that the request stays a valid tuple. MAX
+	 * keeps the value the policy last programmed.
+	 */
+	perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
+	perf_ctrls.min_perf = cpu_data->perf_caps.lowest_perf;
+	perf_ctrls.min_perf_valid = true;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	if (ret)
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->lowest_perf, cpu, ret);
+		pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
+			 cpu_data->perf_caps.lowest_perf, cpu, ret);
 
-	cppc_cpufreq_put_cpu_data(policy);
+	return 0;
 }
 
 static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
@@ -1141,6 +1227,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.online = cppc_cpufreq_cpu_online,
+	.offline = cppc_cpufreq_cpu_offline,
 	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
-- 
2.34.1

