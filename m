Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DF420894;
	Tue,  7 Jul 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445145; cv=none; b=Vf/r6tOmGJcLPkK3eYeXddtNO6Ksffvgb+AltQ2IjhAtTOLt+mluVNh0h5ITVhaPNtFzaLg7a3L8v/47T9pAcx60eWHQ2AAv11iZQK/R7c60VxMknbuvgGEsnNJHTTo4RtBqV105sUBIkmxGhdOX0dpZQrihWRJIAO5USv9o0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445145; c=relaxed/simple;
	bh=lX2a6AWpMokS7BzGM+qzcewEmAfPSRoBfBjBXPy5tiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BU6U5JNladXhFwibIEu17ltI5Ib/nLFa1i8g64HzR6k7Tim930ioYzXpggnp6sgMYRTtKAotHwBRK7AchEbZRFYOq989rYN6dBy4lJmtWtNMkSYnBJrkkJhwMWML6kT1YfuuberVaMk7HqVkePAja2egRNhISLj/aq78jvZCQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxR+Rbsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxR+Rbsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44F21F000E9;
	Tue,  7 Jul 2026 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445143;
	bh=nJvPeWTUm3YxcIMFkA4NMapf6Aik/1OZyaFj9/ZkhBo=;
	h=From:To:Cc:Subject:Date;
	b=NxR+Rbsk/pDs4zzNsJpCIrJ7RO1w2IrK3YTsMCdYvEL2ZGOdUSsUGrwJXQITp/fFe
	 xy4U+2SIunJ4wZzi7J6isI40mxwKgwGHlm6A1HZpb4t3fZ9DAP8utRmOqhGFnegsP4
	 Ao4S+jDcpWJu7ubqFse8xfaovW6f2afQTGQfyJS80QcxccAJK8tBzpUVDZYrfOwTLX
	 pJqPmPG5YuY8mQHdxrhX2Us+2oBf/7v9qxxXjLsgc15LBke/eNSs9AgU+ROpR71MFU
	 yAuMSuFDbAw3RgTydD3tq9ve6rI2AHmitOQs6S1Q4j9WyHK14VXmUAWRWjngplGV08
	 n/KOoMdbDeKOA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Qais Yousef <qyousef@layalina.io>,
 Ingo Molnar <mingo@kernel.org>
Subject:
 [PATCH v1] cpufreq: Make cpufreq_update_pressure() fall back to
 cpuinfo.max_freq
Date: Tue, 07 Jul 2026 19:25:39 +0200
Message-ID: <5086499.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If arch_scale_freq_ref() is not defined for a given arch (like x86, for
example), cpufreq_update_pressure() will always set cpufreq_pressure to
zero for all CPUs in the system, which is generally problematic on
systems with asymmetric capacity [1].

However, in the absence of arch_scale_freq_ref(), it is reasonable
to assume that cpuinfo.max_freq is the maximum sustainable frequency
for the given cpufreq policy.  Moreover, there are cases in which
arch_scale_freq_ref() would need to be defined to return essentially
the cpuinfo.max_freq value anyway (for example, intel_pstate on
hybrid platforms).

For the above reasons, update cpufreq_update_pressure() to fall back to
using cpuinfo.max_freq as the reference frequency if zero is returned by
arch_scale_freq_ref().

Fixes: 75d659317bb1 ("cpufreq: Add a cpufreq pressure feedback for the scheduler")
Link: https://lore.kernel.org/lkml/CAKfTPtBuRLfYNnR4w--cFZYZy-R8gaPEgVwCcaMmbCcJ2H-muQ@mail.gmail.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2590,6 +2590,9 @@ static void cpufreq_update_pressure(stru
 
 	cpu = cpumask_first(policy->related_cpus);
 	max_freq = arch_scale_freq_ref(cpu);
+	if (!max_freq)
+		max_freq = policy->cpuinfo.max_freq;
+
 	capped_freq = policy->max;
 
 	/*



