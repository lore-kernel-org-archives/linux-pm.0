Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4653FA5F9;
	Mon, 11 May 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507777; cv=none; b=YLpas6zp76LIqgj/8WIHQu1yms9aXSJQORS3FyJmwcbFwmytjUWvnlAdnwdkw7Ep+9F+VHmgvTdOBi6+dMSka7sLbInr0gFZgxtOF4nuyTlQSy45RqaeGsW58Zedg/BQTtHN3++6EU2/GzluoyM7pGvt9T4+zi+a6M8Wr542XWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507777; c=relaxed/simple;
	bh=sqP5SvsSwohQnMT43QhFhP4N12TZ/XtKpPjskLf3GV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2Uj+yEtUgDVMKTMT1fMN1dkkZ3WGbYJg7c2b3GYqidDiExJkf5F0WFtKdgPTh+q5bbS4s+9LoSS2JDchCRxiUDuw2pWJq47g4/sZUD/uyhWeHuLIuQNqcIftnTKR4n+lnOJDEemGxmUjop+cEmJ6TYe35pmWAzwJBjkhqjqqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qLseLCLN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qLseLCLN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EC9316F3;
	Mon, 11 May 2026 06:56:07 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.34.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAC4E3F85F;
	Mon, 11 May 2026 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778507772; bh=sqP5SvsSwohQnMT43QhFhP4N12TZ/XtKpPjskLf3GV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLseLCLNE/U6H1UCaBzzXomhyUDvWcHXjN8Hpal4TWfmvNEy2UODxR81JuaofHFbH
	 AQtkOz1qNPbmkGcZFnLyd/poMTpR+NKhxxcH4fbXLA18Cx00wXbD4C0R6077NCKK+l
	 uGKvLgQqlsg8OyO3p+N8C+09TZOAH82LiPxBBFD4=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 3/4] cpufreq: Remove driver default policy->min/max init
Date: Mon, 11 May 2026 15:55:30 +0200
Message-ID: <20260511135538.522653-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511135538.522653-1-pierre.gondois@arm.com>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to [1], drivers were setting policy->min/max and
the value was used as a QoS constraint. After that change,
the values were only temporarily used: cpufreq_set_policy()
ultimately overriding them through:
cpufreq_policy_online()
\-cpufreq_init_policy()
  \-cpufreq_set_policy()
    \-/* Set policy->min/max */

This patch reinstate the initial behaviour. This will allow
drivers to request min/max QoS frequencies if desired.
For instance, the cppc driver advertises a lowest non-linear
frequency, which should be used as a min QoS value.

To avoid having drivers setting policy->min/max to default
values which are considered as QoS values (i.e. the reason
why [1] was introduced), remove the initialization of
policy->min/max in .init() callbacks wherever the
policy->min/max values are identical to the
policy->cpuinfo.min/max_freq.

Indeed, the previous patch ("cpufreq: Set default
policy->min/max values for all drivers") makes this initialization
redundant.

The only drivers where these values are different are:
- gx-suspmod.c (min)
- cppc-cpufreq.c (min)
- longrun.c

[1]
commit 521223d8b3ec ("cpufreq: Fix initialization of min and
max frequency QoS requests")

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/amd-pstate.c      | 14 ++++++--------
 drivers/cpufreq/cppc_cpufreq.c    |  5 ++---
 drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
 drivers/cpufreq/freq_table.c      |  7 +++----
 drivers/cpufreq/gx-suspmod.c      |  2 +-
 drivers/cpufreq/intel_pstate.c    |  3 ---
 drivers/cpufreq/pcc-cpufreq.c     | 10 ++++------
 drivers/cpufreq/pxa3xx-cpufreq.c  |  5 ++---
 drivers/cpufreq/sh-cpufreq.c      |  6 ++----
 drivers/cpufreq/virtual-cpufreq.c |  5 +----
 10 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 453084c67327f..ecc3779e047d5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1090,10 +1090,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
+	policy->cpuinfo.min_freq = perf_to_freq(perf, cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = cpudata->max_freq;
 
 	policy->driver_data = cpudata;
 	ret = amd_pstate_cppc_enable(policy);
@@ -1907,10 +1906,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
+	policy->cpuinfo.min_freq = perf_to_freq(perf, cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = cpudata->max_freq;
 	policy->driver_data = cpudata;
 
 	ret = amd_pstate_cppc_enable(policy);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24c..5abac50df7508 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -660,8 +660,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
 	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
-	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
-						caps->highest_perf : caps->nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
@@ -669,7 +667,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * nonlinear perf
 	 */
 	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
-	policy->cpuinfo.max_freq = policy->max;
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
+						    caps->highest_perf : caps->nominal_perf);
 
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
index d269a4f26f98e..d40c9e0bbb740 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -421,7 +421,7 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 		policy->min = maxfreq / max_duration;
 	else
 		policy->min = maxfreq / POLICY_MIN_DIV;
-	policy->max = maxfreq;
+
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
index ac2e90a65f0c4..0f185a13577f8 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -551,13 +551,11 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 
-	policy->max = policy->cpuinfo.max_freq =
-		ioread32(&pcch_hdr->nominal) * 1000;
-	policy->min = policy->cpuinfo.min_freq =
-		ioread32(&pcch_hdr->minimum_frequency) * 1000;
+	policy->cpuinfo.max_freq = ioread32(&pcch_hdr->nominal) * 1000;
+	policy->cpuinfo.min_freq = ioread32(&pcch_hdr->minimum_frequency) * 1000;
 
-	pr_debug("init: policy->max is %d, policy->min is %d\n",
-		policy->max, policy->min);
+	pr_debug("init: max_freq is %d, min_freq is %d\n",
+		 policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
 out:
 	return result;
 }
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 50ff3b6a69000..06b27cbc59d6a 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -185,9 +185,8 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 	int ret = -EINVAL;
 
 	/* set default policy and cpuinfo */
-	policy->min = policy->cpuinfo.min_freq = 104000;
-	policy->max = policy->cpuinfo.max_freq =
-		(cpu_is_pxa320()) ? 806000 : 624000;
+	policy->cpuinfo.min_freq = 104000;
+	policy->cpuinfo.max_freq = (cpu_is_pxa320()) ? 806000 : 624000;
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
 
 	if (cpu_is_pxa300() || cpu_is_pxa310())
diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 642ddb9ea217e..3c99d7009cbe2 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -124,10 +124,8 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		dev_notice(dev, "no frequency table found, falling back "
 			   "to rate rounding.\n");
 
-		policy->min = policy->cpuinfo.min_freq =
-			(clk_round_rate(cpuclk, 1) + 500) / 1000;
-		policy->max = policy->cpuinfo.max_freq =
-			(clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
+		policy->cpuinfo.min_freq = (clk_round_rate(cpuclk, 1) + 500) / 1000;
+		policy->cpuinfo.max_freq = (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
 	}
 
 	return 0;
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

