Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691C50EBE9;
	Mon, 21 Sep 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017927; cv=none; b=Z18CJAXLFMlyBu23MGVfjSgsxqRinPNvI6VN7bt1k86uN/veCTZUkcuse8bQgW8pUZCcL8P9YtAWJZHx9z6dJ6d5U0xVke3eCfV/ua/GHWjwpm1/61KEpvxtyqHNGkzxgZ/KDFYbRFQYdglaAFR3LrOT3UmQTD+WYsHLmraA3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017927; c=relaxed/simple;
	bh=mgfzSGVc/d3wR7Qgrfpq7d5gcwTdFHVjd4V3Iv5jNG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FKkXofkWcsKYSgkmbPw0RGkJ3k3i1uDqzWskoiaNLCitwjtikakgdiL8xkJTRgjdRQDKEM56swOMaISdEskK4MuHmspmIUkcHcCC8lT9MsF7+mcXZy3wtry/i+cVdgX7RFGAqJcLrtp1PWmN9EOH/cXuQBfUiA2/zq+AOXIT++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA55kC/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA55kC/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D921F000FF;
	Mon, 21 Sep 2026 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790017925;
	bh=n4ruEjUQePmqY2gTIb1KvdOFDlj70sRmRzzqV5hc0aA=;
	h=From:To:Cc:Subject:Date;
	b=MA55kC/Zu3p7MWRFC2uO3hvraJNfF8Y6XfYxsv5EemTg7S0a+3b5SSew5ayEpfDTG
	 SoqBtmb1I1Hm3p5kXm9R/H/ix5B/RZGGPRzmmOUdWBkg7Y0KZLg12/Iq8VPG6HSSso
	 +W4LgxVz08JUKYrFvpNv92V3uG72BTsbax6MSLyuRHBM/Ncw7oSik/KqqGWHVTpEkV
	 QKeBPudEtftTyejsTKVZ6ML04lYES9KQYBulIosV8uIhQOT2+yR3cWBiGcD5XIPWGf
	 0UoQ+5l9BYD/RDf42jGFzp/yOaCOIcHFDCuaKWl4AlXGojklqyUpZ2t1Jc2eKHxVD5
	 z2pDW6VMPA/Rg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Jianyong Wu <wujianyong@hygon.cn>, LKML <linux-kernel@vger.kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Fix max_freq fallback in
 cpufreq_update_pressure()
Date: Mon, 21 Sep 2026 21:12:00 +0200
Message-ID: <12975163.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall
back to cpuinfo.max_freq"), cpufreq pressure appears in the CPU load
balancer unexpectedly in some cases in which it was not present before,
leading to confusion and uncertainty.

Clearly, the scheduler assumes that cpufreq pressure will not be set
unless the capacity reference frequency of the CPU is known, and the
commit mentioned above violates that assumption.

However, in some cases the capacity reference frequency of the CPU is
in fact known even though arch_scale_freq_ref() returns 0 and in those
cases it should be possible to set cpufreq pressure as appropriate.

For this purpose, introduce a new cpufreq driver callback returning
the CPU capacity reference frequency, .scale_freq_ref(), and make
cpufreq_update_pressure() invoke it, if present, instead of falling
back to cpuinfo.max_freq unconditionally.

Add that callback to the intel_pstate driver and make it return 0 unless
the scale-invariant capacity of the given CPU has been explicitly set,
in which cases its reference frequency is always cpuinfo.max_freq.

Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq")
Reported-by: Jianyong Wu <wujianyong@hygon.cn>
Closes: https://lore.kernel.org/linux-pm/20260915065747.1671965-1-wujianyong@hygon.cn/
Tested-by: Jianyong Wu <wujianyong@hygon.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c      |    4 ++--
 drivers/cpufreq/intel_pstate.c |   10 ++++++++++
 include/linux/cpufreq.h        |    3 +++
 3 files changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2590,8 +2590,8 @@ static void cpufreq_update_pressure(stru
 
 	cpu = cpumask_first(policy->related_cpus);
 	max_freq = arch_scale_freq_ref(cpu);
-	if (!max_freq)
-		max_freq = policy->cpuinfo.max_freq;
+	if (!max_freq && cpufreq_driver->scale_freq_ref)
+		max_freq = cpufreq_driver->scale_freq_ref(policy);
 
 	capped_freq = policy->max;
 
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1135,6 +1135,14 @@ static bool hybrid_clear_max_perf_cpu(vo
 	return ret;
 }
 
+static unsigned int intel_pstate_scale_freq_ref(struct cpufreq_policy *policy)
+{
+	if (all_cpu_data[policy->cpu]->capacity_perf)
+		return policy->cpuinfo.max_freq;
+
+	return 0;
+}
+
 static void intel_pstate_update_freq_limits(struct cpudata *cpu)
 {
 	int scaling = cpu->pstate.scaling;
@@ -3088,6 +3096,7 @@ static struct cpufreq_driver intel_pstat
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
+	.scale_freq_ref = intel_pstate_scale_freq_ref,
 	.name		= "intel_pstate",
 };
 
@@ -3411,6 +3420,7 @@ static struct cpufreq_driver intel_cpufr
 	.suspend	= intel_cpufreq_suspend,
 	.resume		= intel_pstate_resume,
 	.update_limits	= intel_pstate_update_limits,
+	.scale_freq_ref = intel_pstate_scale_freq_ref,
 	.name		= "intel_cpufreq",
 };
 
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -420,6 +420,9 @@ struct cpufreq_driver {
 	/* Will be called after the driver is fully initialized */
 	void		(*ready)(struct cpufreq_policy *policy);
 
+	/* Return the capacity reference frequency for policy. */
+	unsigned int	(*scale_freq_ref)(struct cpufreq_policy *policy);
+
 	struct freq_attr **attr;
 
 	/* platform specific boost support code */



