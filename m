Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990433;
	b=VKeKUI/CblT3vHQ9aW2DOxEJvJbBECHhbien3OlTQWQekUgByDsTHhSE1UE8rjfnbmxS
	 Q56vVuixh0JE3O0em9yh5k9OWjwlWtmGOxd1vC358gRReUCqujFNPhPWJZneGIZfq4mP9
	 5NBsdGUtqYGsDRfpgstnWi+ItqL2lVzrCuKTuc4Xs+o2QXhaNGLB2mYP5x/kC20KvQ3U1
	 3zxztxdf56y2B1g9iMn4ib0Q7/6PI7xAL4kGKZv21H6F0IcbTGEX8GIONnaxBvgfuiBSz
	 QHOdDCTOs7KayW0EuHSXyNSGo1ISjmuxh8jYdVH+5p8Z/GDIuF3KHlO/z2glWjrEWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990433;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=MFFicYYQ+mNSIUaooGgcBVZSBqGvsWJI/FHwtFroL/U=;
	b=jiTw8o+/yqKBJEtMd6EI7Zt3y8ErJRnjmEGXheqEYSoAW9GqGqsEtPDB9jTbYx2jG1pa
	 JSNXNb3wGlq57503MPjT6VVViB1EQ+AMQWCqohYLHRosGie6naRt5y/wv12wdgU8/k5aM
	 8zP1Y6jUtWX0oJv20lI/mexZqMgA186vGKVa7sKa/4yRqUBJRg39REJNixya28WKm5WsR
	 lS5Ga82CgE0Llkog8qGwZSg+mYwHnleB5ubORT2JPy0G54SKXoCylmsGlwXPdMzX7XHrE
	 W174fujwbWTmvZzGDAbuNgq2TQ0YYmYefmChHKqO2qAXHvU70TSq7qzUgUMYjQJc1qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=kgvhIwIt;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 70AAA606A326;
	Fri,  6 Nov 2026 18:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70AAA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=kgvhIwIt
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v5 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in get_cur_freq_on_cpu()
Date: Sat, 7 Nov 2026 02:40:07 +0800
Message-ID: <20261106184008.1728-2-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261106184008.1728-1-lirongqing@baidu.com>
References: <20261106184008.1728-1-lirongqing@baidu.com>
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
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793990420;
	bh=MFFicYYQ+mNSIUaooGgcBVZSBqGvsWJI/FHwtFroL/U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=kgvhIwIthVhqHE+izRNAHoQPXJlQE36LSHrYVqaF7JKmghQCNw1rcchSslsQ2xVZr
	 bc9TXEXeXyRAEiVnAq6E93PaBJq5gTgcvyS7zIJS9fLaSDC+ocXiUwxvTIVHuAHqlC
	 mmOlWwAMNeST57lvxjNP7/WF77+tWANRz5wxkUear32SVhmN58rF3u/eRLb4PEjcSi
	 k4zsYCZLNqbNfpivBfjgbo3hDntw2BMaFw4QX2gnAnT4TETS/HxIZzSaDKstuAuoYA
	 F1g/m0S42v1v9ZDY508mtCxtnfJXoLGBaGCoEJ8L02DaHPbD7Blk+MMrQnf3VCaiaF
	 RTaYE6+asQX3Q==

From: Li RongQing <lirongqing@baidu.com>

get_cur_freq_on_cpu() uses perf->state, which is an index into
perf->states[], to index policy->freq_table[]. However, freq_table[]
is built by filtering _PSS entries that are not lower in frequency
than the previous one, so its index space no longer matches
perf->states[]. The original P-state index for each remaining
freq_table entry is stored in driver_data.

Once an entry has been skipped, using perf->state as an index into
freq_table[] can therefore select the frequency of a different
P-state.

The reported current frequency itself remains correct because it is
obtained from extract_freq(). The mismatch only affects the cached
frequency used by get_cur_freq_on_cpu() to detect a firmware frequency
change behind our back.

If the wrong table entry contains a frequency different from the one
the CPU is actually running at, the check falsely detects a frequency
change and sets data->resume. The next ->target() call then performs a
redundant control-register write even if the requested P-state is
already the current P-state.

Conversely, if the wrong table entry happens to contain the frequency
to which firmware has changed the CPU, the frequency change is missed
and data->resume remains clear. A subsequent ->target() call for the
P-state that the cpufreq core believes to be current can then
short-circuit without rewriting the control register, leaving the CPU
at the firmware-selected frequency until a different P-state is
requested.

Fix this by taking the cached frequency directly from
perf->states[perf->state].core_frequency. perf->state and
perf->states[] use the same P-state index space, and converting
core_frequency to kHz yields the same value stored in the corresponding
freq_table entry during initialization.

This fixes the cached side of the comparison only. extract_msr() still
reports freq_table[0].frequency when the status read from the hardware
matches no freq_table entry, which defeats the comparison when the OS
is already at the P-state corresponding to freq_table[0]. That is
addressed by the next patch.

Fixes: e56a727b023d ("[CPUFREQ] Make acpi-cpufreq more robust against BIOS freq changes behind our back.")
Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index f64fa37..2d7d147 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -353,6 +353,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
 
 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 {
+	struct acpi_processor_performance *perf;
 	struct acpi_cpufreq_data *data;
 	struct cpufreq_policy *policy;
 	unsigned int freq;
@@ -368,7 +369,9 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	if (unlikely(!data || !policy->freq_table))
 		return 0;
 
-	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;
+	perf = to_perf_data(data);
+	cached_freq = perf->states[perf->state].core_frequency * 1000;
+
 	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
 	if (freq != cached_freq) {
 		/*
-- 
2.9.4

