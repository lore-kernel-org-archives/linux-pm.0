Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1B469836
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392861; cv=none; b=EdlhyKvpjElMV+GVZ6FZ88MZJHhSAcOJM0QRwDbSed91huzbI0UCzgosUs1TLJfERs5a+KQ1fZ0VdphIqIqBjgRjKxO7dL8+OkX9ziqZRHMyQgvJsksgr9I06kcRrguAj+UPlShJM1NSZvz6M8Mb9iQzea5rZHB/RBK+9AJJrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392861; c=relaxed/simple;
	bh=G2LQVsnTGKH481zBZmjUzuxsieJMbKq3WqfesaSHy6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAHqA9L772zAXLuziLI5ITxbDGZr5lMR8jzsVK0cWtUifE/Sj5jlhZhbJFNOgUg11DnHU05YCbbqHlgPvsHpMfGFbRbnAsMg03zUXLjpxXC2V3jIArJjJc06H5tqPJJoyriqBeqXlH4eO51k4Xect36JSBFfL7Ze2gS7Psb8veM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RohF+C9I; arc=none smtp.client-ip=91.218.175.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RohF+C9I"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=G2LQVsnTGKH481zBZmjUzuxsieJMbKq3WqfesaSHy6U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792392856; v=1; x=1792997656;
 b=RohF+C9IB/+SIZYVo8SGvMFm2bd3LTQGE2redmD2iGkoBgS0gv9cgOCs2KYTtm3ccJOSB+Pm
 ZnF8Gi+E6iCrQdvardVYK69/WOx00QQz7Y2BPynEx5PoADXkEN5tQoC6Qzj7z8022eNdWGaVIsX
 kFC5erPqDNCwnPBfviDguVbc=
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 254b41f0bd8203ad;
	Mon, 19 Oct 2026 06:54:16 +0000
X-Mizu-Trace-ID: 254b41f0bd8203ad
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: tglx@kernel.org
Cc: mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Avoid fallback values in cpuinfo_avg_freq
Date: Mon, 19 Oct 2026 14:53:58 +0800
Message-ID: <20261019065358.66115-1-liu.yun@linux.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Liu <liuyun01@kylinos.cn>

On x86, arch_freq_get_on_cpu() can return the requested or nominal
frequency when hardware feedback is unavailable. cpuinfo_avg_freq then
reports fallback values as hardware averages, even without APERF/MPERF.

Use a separate sampling hook for the attribute and its support probe:
return -EOPNOTSUPP without APERF/MPERF and -EAGAIN for zero MPERF deltas
or stale samples. Preserve the scaling_cur_freq and /proc/cpuinfo fallback
and the existing ARM64 AMU implementation.

Fixes: fbb4a4759b54 ("cpufreq: Introduce an optional cpuinfo_avg_freq sysfs entry")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 arch/x86/kernel/cpu/aperfmperf.c | 18 +++++++++++++-----
 drivers/cpufreq/cpufreq.c        |  9 +++++++--
 include/linux/cpufreq.h          |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 7ffc78d5ebf2..fa8376d9ce94 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -503,15 +503,15 @@ void arch_scale_freq_tick(void)
  */
 #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
 
-int arch_freq_get_on_cpu(int cpu)
+int arch_freq_get_avg_on_cpu(int cpu)
 {
 	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
-	unsigned int seq, freq;
+	unsigned int seq;
 	unsigned long last;
 	u64 acnt, mcnt;
 
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
-		goto fallback;
+		return -EOPNOTSUPP;
 
 	do {
 		seq = raw_read_seqcount_begin(&s->seq);
@@ -525,11 +525,19 @@ int arch_freq_get_on_cpu(int cpu)
 	 * which covers idle and NOHZ full CPUs.
 	 */
 	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
-		goto fallback;
+		return -EAGAIN;
 
 	return div64_u64((cpu_khz * acnt), mcnt);
+}
+
+int arch_freq_get_on_cpu(int cpu)
+{
+	int avg_freq = arch_freq_get_avg_on_cpu(cpu);
+	unsigned int freq;
+
+	if (avg_freq >= 0)
+		return avg_freq;
 
-fallback:
 	freq = cpufreq_quick_get(cpu);
 	return freq ? freq : cpu_khz;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..2e44b6ee14c9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -705,9 +705,14 @@ __weak int arch_freq_get_on_cpu(int cpu)
 	return -EOPNOTSUPP;
 }
 
+__weak int arch_freq_get_avg_on_cpu(int cpu)
+{
+	return arch_freq_get_on_cpu(cpu);
+}
+
 static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *policy)
 {
-	return arch_freq_get_on_cpu(policy->cpu) != -EOPNOTSUPP;
+	return arch_freq_get_avg_on_cpu(policy->cpu) != -EOPNOTSUPP;
 }
 
 static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
@@ -769,7 +774,7 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
 				     char *buf)
 {
-	int avg_freq = arch_freq_get_on_cpu(policy->cpu);
+	int avg_freq = arch_freq_get_avg_on_cpu(policy->cpu);
 
 	if (avg_freq > 0)
 		return sysfs_emit(buf, "%u\n", avg_freq);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4..925a3d3b6c31 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1228,6 +1228,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 #endif
 
 extern int arch_freq_get_on_cpu(int cpu);
+extern int arch_freq_get_avg_on_cpu(int cpu);
 
 #ifndef arch_set_freq_scale
 static __always_inline
-- 
2.56.0

