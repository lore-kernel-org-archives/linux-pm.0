Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE234D394;
	Thu, 23 Apr 2026 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934105; cv=none; b=TO71crtwYz1Vtd6XWbCj6R5RUdtM+Zkg9TWOJCeRmot2CClW5bYjXgJ2V4RN5kY/aFwJFlBaqSARqCiYEQgRUTGrqQ8o5NBNT/Ixn9YrtOGu9luUBtJvyrTLXb6FatVnG9IwvmVen/+1k6CDkpobDx8eIRiIjPgfk9vPlYeJpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934105; c=relaxed/simple;
	bh=Ss74ARx+xonzm0LBKXO7QeoYIoHg2vRVipaZB4y1R6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYS3jL/IAKXrW+3lQbMmNjcNr39sv4Bf9Yhvg0pAjT+6xMze7dmIGlbBfhTtj4xE8feGiSH/V6ApFyB0OqQC7xZMMIlZQyNlDe7UJI/Y00Zk4fmDGHIFrGZOvezYFkmSNvv+CIKRhlIJVFdlPRyOwe3N/gwXnz1LRXCGDjeCWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pCvSncFf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pCvSncFf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23B1A1C2B;
	Thu, 23 Apr 2026 01:48:17 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.63.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 536FC3F7B4;
	Thu, 23 Apr 2026 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776934102; bh=Ss74ARx+xonzm0LBKXO7QeoYIoHg2vRVipaZB4y1R6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCvSncFfgIWXXSjhcHOteTjtGN0SbvPwz8dQfQuGAQm1C6afRWZtVuaYzvEPmy8Zo
	 4aE3z8XH5/UeFl60lIkjM/qR5XhSYNfrHf6tAaUw4mJBMOq30aFz1r+IG2tnnpz4Qc
	 MN0AtfB/e7w865owKcUb36P75cfm9BjrynWI2FKQ=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS constraints
Date: Thu, 23 Apr 2026 10:47:28 +0200
Message-ID: <20260423084731.1090384-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423084731.1090384-1-pierre.gondois@arm.com>
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_set_policy() will ultimately override the policy min/max
values written in the .init() callback through:
cpufreq_policy_online()
\-cpufreq_init_policy()
  \-cpufreq_set_policy()
    \-/* Set policy->min/max */
Thus the policy min/max values provided are only temporary.

There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
cpufreq_policy_online()
\-cpufreq_init_policy()
  \-__cpufreq_driver_target()
    \-cpufreq_driver->target()
is called. To avoid any regression, set policy->min/max in cpufreq.c
if the values were not initialized.

In this patch:
- Setting policy->min or max value in driver .init() cb is
  interpreted as setting a QoS constraint.
- Remove policy->min/max initialization in drivers if the values
  are similar to policy->cpuinfo.min_freq/max_freq.
  The only drivers where these values are different are:
  - gx-suspmod.c
  - cppc-cpufreq.c
  - longrun.c
- For the cppc-cpufreq driver, the lowest non-linear freq. is
  used as a min QoS constraint as suggested at:
  https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
 drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
 drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
 drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
 drivers/cpufreq/freq_table.c      |  7 +++----
 drivers/cpufreq/gx-suspmod.c      |  9 +++++----
 drivers/cpufreq/intel_pstate.c    |  3 ---
 drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
 drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
 drivers/cpufreq/sh-cpufreq.c      |  4 ++--
 drivers/cpufreq/virtual-cpufreq.c |  5 +----
 11 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 453084c67327f..1ed4bcdcc957f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1090,10 +1090,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
+	policy->cpuinfo.min_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = cpudata->max_freq;
 
 	policy->driver_data = cpudata;
 	ret = amd_pstate_cppc_enable(policy);
@@ -1907,10 +1907,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
+	policy->cpuinfo.min_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = cpudata->max_freq;
 	policy->driver_data = cpudata;
 
 	ret = amd_pstate_cppc_enable(policy);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24c..c6fcecdbbab0c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -645,6 +645,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	unsigned int min, max;
 	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
@@ -655,13 +656,15 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	caps = &cpu_data->perf_caps;
 	policy->driver_data = cpu_data;
 
+	min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
+	max = cppc_perf_to_khz(caps, policy->boost_enabled ?
+			       caps->highest_perf : caps->nominal_perf);
+
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
-	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
-	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
-						caps->highest_perf : caps->nominal_perf);
+	policy->min = min;
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
@@ -669,7 +672,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * nonlinear perf
 	 */
 	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
-	policy->cpuinfo.max_freq = policy->max;
+	policy->cpuinfo.max_freq = max;
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index fbbbe501cf2dc..831102522ad64 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -355,8 +355,8 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 		min_fsb = NFORCE2_MIN_FSB;
 
 	/* cpuinfo and default policy values */
-	policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
-	policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
+	policy->cpuinfo.min_freq = min_fsb * fid * 100;
+	policy->cpuinfo.max_freq = max_fsb * fid * 100;
 
 	return 0;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44eb1b7e7fc1b..b30bfa3e27daa 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
+		unsigned int min, max;
+
+		/* Use policy->min/max set by the driver as QoS requests. */
+		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
+		if (policy->max)
+			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
+		else
+			max = FREQ_QOS_MAX_DEFAULT_VALUE;
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
@@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		ret = freq_qos_add_request(&policy->constraints,
 					   &policy->min_freq_req, FREQ_QOS_MIN,
-					   FREQ_QOS_MIN_DEFAULT_VALUE);
+					   min);
 		if (ret < 0)
 			goto out_destroy_policy;
 
 		ret = freq_qos_add_request(&policy->constraints,
 					   &policy->max_freq_req, FREQ_QOS_MAX,
-					   FREQ_QOS_MAX_DEFAULT_VALUE);
+					   max);
 		if (ret < 0)
 			goto out_destroy_policy;
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
+
+		/*
+		 * If the driver didn't set QoS constraints, policy->min/max still
+		 * need to be set as they are used to clamp frequency requests.
+		 */
+		policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
+		policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
 	}
 
 	if (cpufreq_driver->get && has_target()) {
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 5b364d8da4f92..ea994647abc88 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -49,16 +49,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 			max_freq = freq;
 	}
 
-	policy->min = policy->cpuinfo.min_freq = min_freq;
-	policy->max = max_freq;
+	policy->cpuinfo.min_freq = min_freq;
 	/*
 	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
 	 * it as is.
 	 */
 	if (policy->cpuinfo.max_freq < max_freq)
-		policy->max = policy->cpuinfo.max_freq = max_freq;
+		policy->cpuinfo.max_freq = max_freq;
 
-	if (policy->min == ~0)
+	if (min_freq == ~0)
 		return -EINVAL;
 	else
 		return 0;
diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index d269a4f26f98e..ebda2bbebf44b 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -397,7 +397,7 @@ static int cpufreq_gx_target(struct cpufreq_policy *policy,
 
 static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 {
-	unsigned int maxfreq;
+	unsigned int minfreq, maxfreq;
 
 	if (!policy || policy->cpu != 0)
 		return -ENODEV;
@@ -418,10 +418,11 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 	policy->cpu = 0;
 
 	if (max_duration < POLICY_MIN_DIV)
-		policy->min = maxfreq / max_duration;
+		minfreq = maxfreq / max_duration;
 	else
-		policy->min = maxfreq / POLICY_MIN_DIV;
-	policy->max = maxfreq;
+		minfreq = maxfreq / POLICY_MIN_DIV;
+
+	policy->min = minfreq;
 	policy->cpuinfo.min_freq = maxfreq / max_duration;
 	policy->cpuinfo.max_freq = maxfreq;
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fcb..68ccc6eb1ef30 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3049,9 +3049,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
-	policy->min = policy->cpuinfo.min_freq;
-	policy->max = policy->cpuinfo.max_freq;
-
 	intel_pstate_init_acpi_perf_limits(policy);
 
 	policy->fast_switch_possible = true;
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index ac2e90a65f0c4..231edfe8cabaa 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -551,13 +551,13 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 
-	policy->max = policy->cpuinfo.max_freq =
+	policy->cpuinfo.max_freq =
 		ioread32(&pcch_hdr->nominal) * 1000;
-	policy->min = policy->cpuinfo.min_freq =
+	policy->cpuinfo.min_freq =
 		ioread32(&pcch_hdr->minimum_frequency) * 1000;
 
-	pr_debug("init: policy->max is %d, policy->min is %d\n",
-		policy->max, policy->min);
+	pr_debug("init: max_freq is %d, min_freq is %d\n",
+		 policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
 out:
 	return result;
 }
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 50ff3b6a69000..181962b0924e6 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -185,8 +185,8 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 	int ret = -EINVAL;
 
 	/* set default policy and cpuinfo */
-	policy->min = policy->cpuinfo.min_freq = 104000;
-	policy->max = policy->cpuinfo.max_freq =
+	policy->cpuinfo.min_freq = 104000;
+	policy->cpuinfo.max_freq =
 		(cpu_is_pxa320()) ? 806000 : 624000;
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
 
diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 642ddb9ea217e..244153a1cead2 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -124,9 +124,9 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		dev_notice(dev, "no frequency table found, falling back "
 			   "to rate rounding.\n");
 
-		policy->min = policy->cpuinfo.min_freq =
+		policy->cpuinfo.min_freq =
 			(clk_round_rate(cpuclk, 1) + 500) / 1000;
-		policy->max = policy->cpuinfo.max_freq =
+		policy->cpuinfo.max_freq =
 			(clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
 	}
 
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
index 4159f31349b16..dc78b74409af4 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -164,10 +164,7 @@ static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
 		policy->cpuinfo.min_freq = 1;
 		policy->cpuinfo.max_freq = virt_cpufreq_get_perftbl_entry(policy->cpu, 0);
 
-		policy->min = policy->cpuinfo.min_freq;
-		policy->max = policy->cpuinfo.max_freq;
-
-		policy->cur = policy->max;
+		policy->cur = policy->cpuinfo.max_freq;
 		return 0;
 	}
 
-- 
2.43.0

