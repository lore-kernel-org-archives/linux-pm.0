Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B03A257C;
	Tue, 17 Mar 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742729; cv=none; b=BWpl8wuVvpA0aeHocDE6nWk1NFU65mOKanjBD7iX9SgjRRlAAz2ZjzgXcwGECPr/22BUaFuEQ3MLjrRBdD8WPsR45TOAGIoRHn8HWGfRoJVDt5GZuKOmlGwGYjGpU36C9N1w9nKcFD7qeWABnw3TtJHJUaKfCaikPbEAnhnxdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742729; c=relaxed/simple;
	bh=0IzK4PglcxCWxe02pHeruwGB+mwbDVI8+RoPtjnseX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeoFPkNlk1xsk3akhZsVlOKToCBKGn2j4En2zOBj6utGnt4X+fjtszICTaY9b7l+1OZjVw7+UuHAFGi2dfaXgW/C5KnPMjlRdSXvEd3DEz3j1GkddDW9QW4vpGdZ0SEWwWxGU9JHwjjwt/69nckvqM0B8Y7RLoPVh+pgyyLN3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E11F61476;
	Tue, 17 Mar 2026 03:18:40 -0700 (PDT)
Received: from e135073.home (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A1143F7BD;
	Tue, 17 Mar 2026 03:18:43 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 3/4] cpufreq: Set policy->min and max as real QoS constraints
Date: Tue, 17 Mar 2026 11:17:44 +0100
Message-ID: <20260317101753.2284763-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317101753.2284763-1-pierre.gondois@arm.com>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
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
is called. In this case, some drivers use the policy min/max
values in their .target() callback before they are overridden.
This should only concern the sh-cpufreq driver, so policy->min
and max values are replaced with their cpuinfo equivalent.

In this patch:
- Setting policy->min or max value in driver .init() cb is
  interpreted as setting a QoS constraint.
- All policy->min and max initialization is removed as the value
  is not used.
- For the cppc-cpufreq driver, the lowest non-linear freq. is
  used as a min QoS constraint as suggested at:
  https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/amd-pstate.c      | 24 ++++++++++++------------
 drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
 drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
 drivers/cpufreq/cpufreq.c         | 15 +++++++++++++--
 drivers/cpufreq/freq_table.c      |  7 +++----
 drivers/cpufreq/gx-suspmod.c      |  9 ++++-----
 drivers/cpufreq/intel_pstate.c    |  3 ---
 drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
 drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
 drivers/cpufreq/sh-cpufreq.c      |  7 ++++---
 drivers/cpufreq/virtual-cpufreq.c |  5 +----
 11 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 310d5938cbdf6..aaafbe9b26cae 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1003,12 +1003,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.min_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.highest_perf);
 
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
@@ -1485,12 +1485,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.min_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.highest_perf);
 	policy->driver_data = cpudata;
 
 	ret = amd_pstate_cppc_enable(policy);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4c46c7ea318eb..2bbf36516a0f0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -586,6 +586,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	unsigned int min, max;
 	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
@@ -596,13 +597,15 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
@@ -610,7 +613,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
index e4f24754df164..3059200766b0d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1451,8 +1451,19 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
+		unsigned int min, max;
 		unsigned int req_nr;
 
+		/*
+		 * If the driver has set policy->min or max,
+		 * use the value as a QoS request.
+		 */
+		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
+		if (policy->max)
+			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
+		else
+			max = FREQ_QOS_MAX_DEFAULT_VALUE;
+
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
@@ -1468,7 +1479,7 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		ret = freq_qos_add_request(&policy->constraints,
 					   policy->min_freq_req, FREQ_QOS_MIN,
-					   FREQ_QOS_MIN_DEFAULT_VALUE);
+					   min);
 		if (ret < 0) {
 			/*
 			 * So we don't call freq_qos_remove_request() for an
@@ -1488,7 +1499,7 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		ret = freq_qos_add_request(&policy->constraints,
 					   policy->max_freq_req, FREQ_QOS_MAX,
-					   FREQ_QOS_MAX_DEFAULT_VALUE);
+					   max);
 		if (ret < 0) {
 			policy->max_freq_req = NULL;
 			goto out_destroy_policy;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 7f251daf03ce3..9b37f37c36389 100644
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
index 75b3ef7ec6796..57999b8d51fa2 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -397,7 +397,7 @@ static int cpufreq_gx_target(struct cpufreq_policy *policy,
 
 static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 {
-	unsigned int maxfreq;
+	unsigned int minfreq, maxfreq;
 
 	if (!policy || policy->cpu != 0)
 		return -ENODEV;
@@ -418,11 +418,10 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 	policy->cpu = 0;
 
 	if (max_duration < POLICY_MIN_DIV)
-		policy->min = maxfreq / max_duration;
+		minfreq = maxfreq / max_duration;
 	else
-		policy->min = maxfreq / POLICY_MIN_DIV;
-	policy->max = maxfreq;
-	policy->cpuinfo.min_freq = maxfreq / max_duration;
+		minfreq = maxfreq / POLICY_MIN_DIV;
+	policy->cpuinfo.min_freq = minfreq;
 	policy->cpuinfo.max_freq = maxfreq;
 
 	return 0;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe3745736..bf2f7524d04a9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3047,9 +3047,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
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
index 4afa48d172dbe..f53b9d7edc76a 100644
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
index 642ddb9ea217e..5cf0f482924d5 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -57,7 +57,8 @@ static long __sh_cpufreq_target(void *arg)
 	/* Convert target_freq from kHz to Hz */
 	freq = clk_round_rate(cpuclk, target->freq * 1000);
 
-	if (freq < (policy->min * 1000) || freq > (policy->max * 1000))
+	if (freq < (policy->cpuinfo.min_freq * 1000) ||
+	    freq > (policy->cpuinfo.max_freq * 1000))
 		return -EINVAL;
 
 	dev_dbg(dev, "requested frequency %u Hz\n", target->freq * 1000);
@@ -124,9 +125,9 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
index 6ffa16d239b2b..60707bf6ce1e3 100644
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

