Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32A3502AC;
	Mon, 16 Mar 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649204; cv=fail; b=kTDE7eXiV97NciwC5oG7S8FNsR009VcxsHnTuJvczVDas+FVO9Kq9y1S/lom/DaiqSdLgA2Sf9QwKgq2Y14ISBOc0TjKwrl0ndL2Q6A/qV/pwod+aGrrGAVdgoOt2wI+HTjqHNLLlutUJ3FP7NnucA64eR5LNKIXzfKBllA928c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649204; c=relaxed/simple;
	bh=piezncCOp+g+r/eFQIEey25yymdGdj5I+X/Mb5yOWF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCJXstt1GWeLnGRVBQ9NDhj5GyNlvWsdyDyrms4OPnryyPqbjE+tBmxroTh9aNXUo+3SuU4/Xmr5/+F1Gb0XNhs70rIEBInvKoZYTEj9kyq4FbCHhWC+lL4eQA2fHlRRAjQVgNa1IkAagtRdYgdXOvPA3z3Yo3yp8+Ph0CtDFBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5kpxAYzG; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5kpxAYzG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1WBNXag/zLYC38cl6xjNTF9l5fX8B/5bRZD69ww6WSonSs0zgOI3OxvtwgWXyn1LC1KKDtLtkoPrGkwq9kHPkXYmz4VkrtLE2keLnhrqFTZwh1fNz4ZO8k14CitAAhKzDaVpVa1fShmWAAhOhl0AmSAHg2VtOfYPuEQuHVgDfhPgeo3zpYtKeF65HI/MQ6wR5VQdLg2UuNP5igKxyZccJGVcYDrqDNScsRfArJTgR2hTBFkvIvsJor2wI/QLro0F9d6eP1jLU6DWYQufwgMK00BGW7h83WfaGr7KyT44jbHXSIwKuMawnDSANtbKBmsvN5eue37EQ4LPWnArhVBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCPogLwmME3roSPsfqdhRE/Wt6K3AkD3g7YPPknEuGY=;
 b=ITG8tcbmtGJRFF/CYXUwJbiaA91Hb+nAItKuuA/qejOlAPJ+HsKNeBKGh3tMPsOmucSpnAwui24ywSDvGtm4ouf8wxF7Ah6NCWHwX60p5ZKKTH0GWxMsm4CKCXjfoltWE0tXKu//AbdcWIc7PO4Ry3JMCizd+dskGABIGRLMT+RhKrrjoOjpe6tsIRi2pWfv2VRT31zb/q8zlOVPkzNd1xP+g5BWIZjEBwdLyhhD2B/0JjCg7uWDYYbxU/Id4S4rWlFSVhxg+oK/Xo1PT1536QSZxCN2WMwGnb9quPAHiUSpVYKjypg+N/sEzyJPysuZAUBsfAeTO0pM3CjCM70P+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCPogLwmME3roSPsfqdhRE/Wt6K3AkD3g7YPPknEuGY=;
 b=5kpxAYzGUYODzZJkd2XEU8QVNR8Pu7SnBT0ZJGlPQPWPOuF038SRj33CGl5LAcee9hBoBrDLrnp2OyywyW0srg4P04vU7Ld/CFF+0K1r+IzNIFMJHfp8+usJWdz1YyPa1I43j6HxcbOtZGFPTTsxpRhsa8CbAX/O+0ncM3UDWsM=
Received: from CH2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:610:54::25)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:19:54 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::f1) by CH2PR11CA0015.outlook.office365.com
 (2603:10b6:610:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 08:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 08:19:53 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 03:19:45 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>, Len Brown
	<lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Miguel Ojeda <ojeda@kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Boqun Feng" <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, Bert Karwatzki <spasswolf@web.de>
Subject: [PATCH v4 2/2] cpufreq: Pass the policy to cpufreq_driver->adjust_perf()
Date: Mon, 16 Mar 2026 08:18:49 +0000
Message-ID: <20260316081849.19368-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316081849.19368-1-kprateek.nayak@amd.com>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b3184c-35c7-4676-2187-08de8334cd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|921020|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eYRan3LGXijtOt8BvfiUK1sklkYGKX1W6cojtyBhOFYnlSW2k/OUlz3IE9eov5x/mU+RqdfYxIuBsF4z1w+UQYPHDns/vzEtU5KFicsYi4T1UhHB8cf5yTIAj0+8IvOuWKaBqtAx2KeHbmQ1UrRYdhht9JoLXXUUkj4S8zEQgAUd8+hKGEjAMsxjppB9g2dGPEzOE1M1GML/AMTO6j9CfUssHm0/bYseAKbbs1t7JyrkzC0uyPsqwyZwTxxo7Gs8hoYIN0T0PBLvYyrN6HBI8+v8+iNAWWgMrSFnbFRpNNbicL1iCpRlAPKjw28Jla0SEEJ15rkKHf/MXa84tsS1PDyvBMOJzN94UScSacwy7xnhSp7nicC6PoFd2MvNiR5cHrjZ+6Cs6dtouWafmkThVeTI/OpLVvVb+inMB2RKUStm4Rj0UDEIDjYqqrCd0Ua9FCLxR1/3rGRnK3hF65/WK3Y2OL8q9I1LZbMUj0SgktOuZJpogUEtQk4c+WnPzrhwXqhwaNYR8XYDYkIGsVyGYKbB1udNwJgC9djxAr1UdyhIxbfTi/ECQwT20VM/kjgfAZss3Zbb/r/imXLKzhYffIonLwFnCIW3QCW08plU/KEzgERE73tyvnf4gU7jfTZdOwBTqRaJUThVE+HX1L19d4j6KzhZxdMDU3tluMKjOALuW2B0aMApYb/mRu7qRVt//As1LIX7g/eF+X/B3qSBy358roLNtw7CCXFw8U0ruTsjWSnZ8ggUV7DQ0QrOhajxyfGLEQ8gW1zLL2Wbj/V5NZK10uyb6i7t144/DBvHjR5Z0f7GuGhXY/wyarZ3JPCG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(921020)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7by5fJLAzybWJL1K4/MupY3HzCMhen/NreD8mJ5bWeUHJduwJ74FdkXB8AD9+2yptlNQfoOYCar1BUxVIgYrueuyIv377PPQ2etJJH1Vs/WfYTXVdxl0Onp6BmJkN6QXAWIdikiWgv67Ch831yWboXuvzdMI8jkS8Efen14y7scgro7FqvhYua/OZRkw5wlh/yXGADGgwe3tNEMMAqdLoC8aBMswctnx3beIIUC0i2ZUIiHGSHLUjJ+yzcgqe3aZRg7/VrBHK4FR7WEr8ivJgqYaiqVXRafjy6ojP9vRbDHYZ5qU7OAsgU5ZtptcGM2SprNxJIuZfMiQu5vBMX8z3280XVbbdvukL15Wt/iPCvsGzxKMdEifQQRpX3nJs8o+nehFdgP+GA+jdubtTReAZNYkZeeHWwYDxPCU13cgBio0O3Z+mIgt9oTU/N3CstvE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:19:53.7917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b3184c-35c7-4676-2187-08de8334cd43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634

cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
writer(s), however amd-pstate depends on fetching the cpudata via the
policy's driver data which necessitates grabbing the reference.

Since schedutil governor can call "cpufreq_driver->update_perf()"
during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
fetching the policy object using the cpufreq_cpu_get() helper in the
scheduler fast-path leads to "BUG: scheduling while atomic" on
PREEMPT_RT [1].

Pass the cached cpufreq policy object in sg_policy to the update_perf()
instead of just the CPU. The CPU can be inferred using "policy->cpu".

The lifetime of cpufreq_policy object outlasts that of the governor and
the cpufreq driver (allocated when the CPU is onlined and only reclaimed
when the CPU is offlined / the CPU device is removed) which makes it
safe to be referenced throughout the governor's lifetime.

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v3..v4:

o Added the Fixes tag. (Gautham, Chris Mason's review-prompts)
---
 drivers/cpufreq/amd-pstate.c     |  3 +--
 drivers/cpufreq/cpufreq.c        |  6 +++---
 drivers/cpufreq/intel_pstate.c   |  4 ++--
 include/linux/cpufreq.h          |  4 ++--
 kernel/sched/cpufreq_schedutil.c |  5 +++--
 rust/kernel/cpufreq.rs           | 13 ++++++-------
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5faccb3d6b14..ad4b5f84773a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -710,13 +710,12 @@ static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
 	return policy->cur;
 }
 
-static void amd_pstate_adjust_perf(unsigned int cpu,
+static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
 				   unsigned long _min_perf,
 				   unsigned long target_perf,
 				   unsigned long capacity)
 {
 	u8 max_perf, min_perf, des_perf, cap_perf;
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2082a9e4384f..17a5b8e0ea1e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2231,7 +2231,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
 /**
  * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
- * @cpu: Target CPU.
+ * @policy: cpufreq policy object of the target CPU.
  * @min_perf: Minimum (required) performance level (units of @capacity).
  * @target_perf: Target (desired) performance level (units of @capacity).
  * @capacity: Capacity of the target CPU.
@@ -2250,12 +2250,12 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
  * parallel with either ->target() or ->target_index() or ->fast_switch() for
  * the same CPU.
  */
-void cpufreq_driver_adjust_perf(unsigned int cpu,
+void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
 				 unsigned long min_perf,
 				 unsigned long target_perf,
 				 unsigned long capacity)
 {
-	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
+	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
 }
 
 /**
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 51938c5a47ca..1552b2d32a34 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3239,12 +3239,12 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	return target_pstate * cpu->pstate.scaling;
 }
 
-static void intel_cpufreq_adjust_perf(unsigned int cpunum,
+static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
 				      unsigned long min_perf,
 				      unsigned long target_perf,
 				      unsigned long capacity)
 {
-	struct cpudata *cpu = all_cpu_data[cpunum];
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
 	int old_pstate = cpu->pstate.current_pstate;
 	int cap_pstate, min_pstate, max_pstate, target_pstate;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cc894fc38971..4317c5a312bd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -372,7 +372,7 @@ struct cpufreq_driver {
 	 * conditions) scale invariance can be disabled, which causes the
 	 * schedutil governor to fall back to the latter.
 	 */
-	void		(*adjust_perf)(unsigned int cpu,
+	void		(*adjust_perf)(struct cpufreq_policy *policy,
 				       unsigned long min_perf,
 				       unsigned long target_perf,
 				       unsigned long capacity);
@@ -617,7 +617,7 @@ struct cpufreq_governor {
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq);
-void cpufreq_driver_adjust_perf(unsigned int cpu,
+void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
 				unsigned long min_perf,
 				unsigned long target_perf,
 				unsigned long capacity);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 153232dd8276..ae9fd211cec1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -461,6 +461,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 				     unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long prev_util = sg_cpu->util;
 	unsigned long max_cap;
 
@@ -482,10 +483,10 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
+	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
 				   sg_cpu->util, max_cap);
 
-	sg_cpu->sg_policy->last_freq_update_time = time;
+	sg_policy->last_freq_update_time = time;
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 76faa1ac8501..a83aec198336 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1256,18 +1256,17 @@ impl<T: Driver> Registration<T> {
     /// # Safety
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
+    /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn adjust_perf_callback(
-        cpu: c_uint,
+        ptr: *mut bindings::cpufreq_policy,
         min_perf: c_ulong,
         target_perf: c_ulong,
         capacity: c_ulong,
     ) {
-        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
-        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
-
-        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
-            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
-        }
+        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
+        // lifetime of `policy`.
+        let policy = unsafe { Policy::from_raw_mut(ptr) };
+        T::adjust_perf(policy, min_perf, target_perf, capacity);
     }
 
     /// Driver's `get_intermediate` callback.
-- 
2.34.1

