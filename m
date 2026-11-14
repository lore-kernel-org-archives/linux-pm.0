Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665266;
	b=T1g3WpNFP6yxJHcEKHfHU2vnNLIQ0T3Zq6mTLohlmZ16vsarisj2MmokLW5ShyJROYEA
	 BGU6Yjrb7B7Z8KJml39qSQni4NSJDoVvmdzRhOqAeiae8unT+YQWWLjRao4ScXuHFQjMe
	 Wdd2ODbimVirDNtKe+te07VNE6JG3J0kFsH+Zfy8BcS23/RquloFweZprOt9hahS78yg/
	 R8jytqk4T53DVBDCq1mUqgFI4XqXZ6nsDT4LjtGBKUfrVqXGVn2FqUdcGKVuc0MvS/SM6
	 4FUZifcZ++IHtqxiaI5Um540qnD0qgye7jhwSW1jxpntM8/cTM7xYH+bQ8rQKhzmgoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665266;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=C55eBjErjmkrF+e07ycv3yHO8XvAxs6AGnnYfh5Cldo=;
	b=iyVr8jzEnAb+aCHQB1wIwhp+7WcbdoLsIBoLHTGE/BDZApTwcySSl5/m230Ffhy5Dqzn
	 +yns19CA132KCfRP4FRKVtesAT5I0FfIXanzXcIqo3yDmfu8bhcmPnB2B7aMfxorUH5Fc
	 rMGh1qBQvEC3vZdD26yqdpG3DiGrncEZ5ZDylyYGVrN71Zazg9yNN+7Sl1hWe+6fDsGrf
	 uyiBd6RVjMk3EqV8F1oHILtAixD+unYTACdxOsEyWRA3qMag7TtYICdYb9e86hetv5JXP
	 NdHgPHX8Ugw5H4u0z7jDpbG0mQsigA5WPPsM3VuhSjpULjam/oJDoCOB6m4rzoAkJtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=MVNFfPjR;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 184D8606A329;
	Sat, 14 Nov 2026 14:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184D8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=MVNFfPjR
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v6 2/2] cpufreq: acpi-cpufreq: report filtered-out P-states in extract_msr()
Date: Sat, 14 Nov 2026 22:07:24 +0800
Message-ID: <20261114140724.2336-3-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261114140724.2336-1-lirongqing@baidu.com>
References: <20261114140724.2336-1-lirongqing@baidu.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794665257;
	bh=C55eBjErjmkrF+e07ycv3yHO8XvAxs6AGnnYfh5Cldo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=MVNFfPjRCeZSdex4SQYk3aQEsEsM9Ry0llqz9QAYMKkPGZp2pU3IechABlsJDphBW
	 UJDorZa/SNyynNkwthH4lXjxIhZfgR8hX/6gAl63sbu+TLuhJLQMoZlNk92jsSN6N0
	 jEvf7PNQL4icEhr35NZRIJWarsbY49zeATBlMwRH1AjhSWo3UVjC9QoEwOAadfnSCB
	 QtbybWO/h9Q/DCk7C9shmh+KK8YYGGjgL36qDnK+Zo/+WwsmUpmmUCoJPSs7yq4AGi
	 YkzHSlJGj5hiDb2rX2Lp6OFoHd/pL//2IEGlf51ZbO4Xz24MHKQw8OH7cGTc1DkSDQ
	 ZPDD/wMYVvvZw==

From: Li RongQing <lirongqing@baidu.com>

extract_msr() maps the status value read from the hardware to a
frequency by walking policy->freq_table.  freq_table[] is built by
filtering out _PSS entries that are not lower in frequency than the
previous one, so firmware may autonomously switch the CPU to a P-state
that has no freq_table entry.  The status of such a P-state cannot be
matched and extract_msr() falls back to freq_table[0].frequency.

get_cur_freq_on_cpu() is the ->get() callback for the
ACPI_ADR_SPACE_FIXED_HARDWARE case.  When firmware has changed the
P-state behind the OS's back, it sets data->resume so that the next
->target() call rewrites the control register even if the requested
P-state equals perf->state.  However, acpi_cpufreq_target() is reached
only if the cpufreq core sees a difference between the requested
frequency and policy->cur, because __cpufreq_driver_target() and
__target_index() return early when target_freq == policy->cur.
policy->cur is resynchronized from the ->get() value by
cpufreq_verify_current_freq(), so the frequency returned by ->get()
has to differ from policy->cur for data->resume to be acted upon in
the ->target_index() path.

If the OS is at the P-state corresponding to freq_table[0] and firmware
switches the CPU to a filtered-out P-state, the fallback makes ->get()
return the same frequency as policy->cur and cached_freq.  data->resume
is left clear, policy->cur is not updated, and the CPU stays at the
firmware-selected P-state while the cpufreq core believes it is at
freq_table[0].

Look the status up in all of perf->states[] instead and return the
frequency of the matching ACPI P-state.  For P-states retained in
freq_table[] this returns the same value as before, because the
frequency of each freq_table entry is perf->states[driver_data]
.core_frequency converted to kHz.  For a filtered-out P-state whose
frequency differs from policy->cur, get_cur_freq_on_cpu() now sets
data->resume and the cpufreq core updates policy->cur through
cpufreq_out_of_sync(), so the next request for the expected P-state
reaches acpi_cpufreq_target() and rewrites the control register.

The fallback to freq_table[0].frequency is kept for a status that
matches no _PSS entry at all, since returning 0 from ->get() makes
cpufreq_online() fail and triggers a warning in cpufreq_update_policy().
A filtered-out P-state with the same frequency as policy->cur is still
not detected through the ->target_index() path, but in that case the
CPU runs at the frequency the cpufreq core expects.

extract_io() is not changed: for ACPI_ADR_SPACE_SYSTEM_IO no ->get()
callback is registered and extract_io() is only used by check_freqs().

Fixes: e56a727b023d ("[CPUFREQ] Make acpi-cpufreq more robust against BIOS freq changes behind our back.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260910111329.2220-1-lirongqing%40baidu.com
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 2d7d147..3dc7ee4 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -210,8 +210,8 @@ static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
 static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
-	struct cpufreq_frequency_table *pos;
 	struct acpi_processor_performance *perf;
+	unsigned int i;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		msr &= AMD_MSR_RANGE;
@@ -222,9 +222,9 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 
 	perf = to_perf_data(data);
 
-	cpufreq_for_each_entry(pos, policy->freq_table)
-		if (msr == perf->states[pos->driver_data].status)
-			return pos->frequency;
+	for (i = 0; i < perf->state_count; i++)
+		if (msr == perf->states[i].status)
+			return perf->states[i].core_frequency * 1000;
 	return policy->freq_table[0].frequency;
 }
 
-- 
2.9.4

