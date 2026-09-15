Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC80448B96;
	Tue, 15 Sep 2026 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455807; cv=none; b=i1RGKuZQs3hi+9Dd87CSshhagsHSfXF15mrIqTsxWceK2U/jkaqvMfw0Gm9APA0JrRBNeNiGYzzYIznuRnXb9uPN4f3YXM1PsGJ9lhl1o2/IJbrXLfTNWz7DnZoh948cl+f6Puh755r+l6+VPE75dLE6/T6JMkWg7GWZ964OkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455807; c=relaxed/simple;
	bh=F/2LWRZ+8JwZK8jwN6/Q6olYJoMUVmkHIy78bcstgKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=coDEHJ/GBwCdtMRe0285BwhLWrYmF6/bk/3wsuXNjh0x43LHowGHm+kOe/6NLnrrgn7v8w1y1t/fmHpPOZ2wagd3taLCvSg4B6/QsO4+s88Sn3pdq1PnMwUC4mCam2L5g5Yui4H73ON41UOrEzKgweWrOCzS2Hn9cJDtgoJnbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hkXz45fpFz1mw6v;
	Tue, 15 Sep 2026 15:02:56 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hkXz44Kl9z1mw6v;
	Tue, 15 Sep 2026 15:02:56 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id C15E93027FCF;
	Tue, 15 Sep 2026 14:58:39 +0800 (CST)
Received: from jianyong.hygon.cn (172.19.20.52) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 15 Sep
 2026 15:02:54 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <kprateek.nayak@amd.com>,
	<vincent.guittot@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>,
	<srinivas.pandruvada@linux.intel.com>, <lenb@kernel.org>,
	<hongyan.xia@transsion.com>, <zhongqiu.han@oss.qualcomm.com>,
	<wujianyong@hygon.cn>, <jianyong.wu@outlook.com>, <wangfengyu@hygon.cn>,
	<zhongyuan@hygon.cn>, <huangsj@hygon.cn>
Subject: [PATCH] cpufreq: Use a non-boost reference frequency for pressure calculation
Date: Tue, 15 Sep 2026 14:57:47 +0800
Message-ID: <20260915065747.1671965-1-wujianyong@hygon.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall
back to cpuinfo.max_freq") introduced cpuinfo.max_freq as the reference
frequency for cpufreq pressure when arch_scale_freq_ref() returns zero.

However, cpuinfo.max_freq may include boost frequencies and therefore
does not necessarily represent the maximum sustainable frequency. On
some systems using acpi-cpufreq, cpuinfo.max_freq includes boost while
the frequency table only contains non-boost frequencies. Consequently,
cpufreq pressure remains nonzero even without an additional frequency
limit.

Furthermore, drivers may update cpuinfo.max_freq when boost is enabled
or disabled. With a fixed policy limit below the maximum non-boost
frequency, this changes the pressure reference and hence the reported
pressure, although the non-boost frequency limit remains unchanged.

Add max_sustainable_freq to struct cpufreq_cpuinfo to provide a reference
frequency excluding boost. Populate it from the nominal frequency in
amd-pstate and cppc_cpufreq, the maximum non-turbo frequency in
intel_pstate, and the highest frequency-table entry in acpi-cpufreq.

Use this value when arch_scale_freq_ref() returns zero. Preserve the
existing cpuinfo.max_freq fallback for drivers that leave the new field
at zero.

Tested with acpi-cpufreq, intel_pstate, and amd-pstate in active and
passive modes. With no additional frequency limit, pressure is zero.
With a fixed limit below the non-boost reference frequency, pressure
remains unchanged across boost transitions.

Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq")
Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
---
The earlier fix was incorrect and has been abandoned. This patch takes
a different approach.

Previous discussion: https://lore.kernel.org/all/SI2PR04MB4931A8BA0EF213B0238BD9E4E3BD2@SI2PR04MB4931.apcprd04.prod.outlook.com/

 drivers/cpufreq/acpi-cpufreq.c | 3 +++
 drivers/cpufreq/amd-pstate.c   | 2 ++
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 drivers/cpufreq/cpufreq.c      | 4 +++-
 drivers/cpufreq/intel_pstate.c | 2 ++
 include/linux/cpufreq.h        | 2 ++
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9ac753..e7b22456ebb8 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -856,6 +856,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
 
+	/* Init max sustainable cpu frequency */
+	policy->cpuinfo.max_sustainable_freq = freq_table[0].frequency;
+
 	max_boost_ratio = get_max_boost_ratio(cpu, &nominal_freq);
 	if (max_boost_ratio) {
 		unsigned int freq = nominal_freq;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3a6b4b224a66..6fc28bb1499b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1085,6 +1085,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 						perf.lowest_perf);
 	policy->cpuinfo.max_freq = cpudata->max_freq;
 
+	policy->cpuinfo.max_sustainable_freq = cpudata->nominal_freq;
 	policy->driver_data = cpudata;
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
@@ -1912,6 +1913,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = perf_to_freq(perf, cpudata->nominal_freq,
 						perf.lowest_perf);
 	policy->cpuinfo.max_freq = cpudata->max_freq;
+	policy->cpuinfo.max_sustainable_freq = cpudata->nominal_freq;
 	policy->driver_data = cpudata;
 
 	ret = amd_pstate_cppc_enable(policy);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6fe0e972952a..f803fcdca483 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -682,7 +682,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
 	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
 						    caps->highest_perf : caps->nominal_perf);
-
+	policy->cpuinfo.max_sustainable_freq =
+		cppc_perf_to_khz(caps, caps->nominal_perf);
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b898b6544069..c1d54a22265d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2587,7 +2587,9 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
 	cpu = cpumask_first(policy->related_cpus);
 	max_freq = arch_scale_freq_ref(cpu);
 	if (!max_freq)
-		max_freq = policy->cpuinfo.max_freq;
+		max_freq = policy->cpuinfo.max_sustainable_freq ?
+				 policy->cpuinfo.max_sustainable_freq :
+				 policy->cpuinfo.max_freq;
 
 	capped_freq = policy->max;
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6e984c114d96..daef7e99fead 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1474,6 +1474,7 @@ static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
 
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+	policy->cpuinfo.max_sustainable_freq = cpudata->pstate.max_freq;
 
 	refresh_frequency_limits(policy);
 }
@@ -3052,6 +3053,7 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = cpu->pstate.min_freq;
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
+	policy->cpuinfo.max_sustainable_freq = cpu->pstate.max_freq;
 
 	intel_pstate_init_acpi_perf_limits(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ae9d1ce4f49c..aa3f60a167be 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -45,6 +45,8 @@ enum cpufreq_table_sorting {
 struct cpufreq_cpuinfo {
 	unsigned int		max_freq;
 	unsigned int		min_freq;
+	/* Maximum sustainable frequency excluding boost, or 0 if unknown. */
+	unsigned int		max_sustainable_freq;
 
 	/* in 10^(-9) s = nanoseconds */
 	unsigned int		transition_latency;
-- 
2.34.1


