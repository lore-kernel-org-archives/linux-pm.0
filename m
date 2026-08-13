Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E2F573BB695;
	Thu, 13 Aug 2026 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611736; cv=none; b=K1PNosoi/fVcXVgn9qRWcImEgxvgxITte3BpVinx83Sj2X8IFm2Qt0CsKum2wLKgHGj/pKCEYPc9WrWkSWsvkpEbUS1Q7juOUJQ9w6FeV3jvCkq5SyAsoF7+DOne/hRLHRb8mqI3zGJxK2CU4LMLHb4LcVRL5iEIUBkl/BsX+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611736; c=relaxed/simple;
	bh=bIr/p85eWcrzYTDGgQ7gg2TlhCD/3+BMk3WjJ0L5W48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTs+1ycfK3ObMvFPihBUb80rB/6PXdvfNyswcqHbM64zrCs/aBaXpvV8uRWuNOZi3ibLLSpCQIp9OPljHrbdQS8zOexDFeSWlbQGCdAlxzTvYiUAZD2xsLhdI+W18UxehSRzc651EihQ8joQ0UYjBwfkcgYDdznrUSRTBIitfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=XGT34wyP; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="XGT34wyP"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2 2/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in get_cur_freq_on_cpu()
Date: Thu, 13 Aug 2026 17:01:45 +0800
Message-ID: <20260813090145.2450-3-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260813090145.2450-1-lirongqing@baidu.com>
References: <20260813090145.2450-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1786611720;
	bh=7nb6pHn3wIgssKvXSPIW7xprcyR8CB87q1gbn7EoJbY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=XGT34wyPIhf42PLjBjwyw55D8+nqQ6tJfRcG+hNL3MJeAWsIT0MqwcYKjOKrLKIvV
	 WETaixWTZ27t3iIR8M1Ob9lqQ1nei1QhXDqtq2GKZscIN0eiUuHxtzg6X9B40tgavy
	 WRSYcwZO73PSw8Cl3Qkl8ewiunvj2G8U768ES4ZJFO/JgKG1/m4h+ZRt5GZuQlocxJ
	 WHTUhxAM/450OvflgPehJgR3e1ZfPfKdxGN6jLL7rpnCFUPA5ZWW9Q4jNnS9b+irUT
	 lymMBFo09YzWRcTBHJdNu0eP/tAjnRdWKLBiFe6XKjUoWHTLq8DTeN35qMlgybUlD3
	 xJaz5TtbaNW9A==

From: Li RongQing <lirongqing@baidu.com>

get_cur_freq_on_cpu() reads the cached frequency as
policy->freq_table[to_perf_data(data)->state], mixing two different index
spaces: perf->state indexes perf->states[], while policy->freq_table[] is
built with duplicate frequencies removed and stores the original P-state
index in freq_table[].driver_data.

Once any _PSS entry has been skipped the two arrays no longer line up, so
the cached frequency used to detect a "BIOS changed frequency behind our
back" event could be taken from the wrong table slot.

Look up the freq_table entry whose driver_data matches perf->state instead
of indexing freq_table[] with perf->state directly.

Fixes: 8cee1eed8e78 ("cpufreq: ACPI: Remove freq_table from acpi_cpufreq_data")
Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 1abe9ab..61ede49c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -353,6 +353,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
 
 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 {
+	struct cpufreq_frequency_table *pos;
 	struct acpi_cpufreq_data *data;
 	struct cpufreq_policy *policy;
 	unsigned int freq;
@@ -368,7 +369,13 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	if (unlikely(!data || !policy->freq_table))
 		return 0;
 
-	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;
+	cached_freq = 0;
+	cpufreq_for_each_entry(pos, policy->freq_table)
+		if (pos->driver_data == to_perf_data(data)->state) {
+			cached_freq = pos->frequency;
+			break;
+		}
+
 	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
 	if (freq != cached_freq) {
 		/*
-- 
2.9.4

