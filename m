Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23F2236E0;
	Tue,  2 Jun 2026 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435289; cv=none; b=ssPPHylQljV3iMp515HIwLXJEDSWPnpgdvmMzNytaOHjvhKld4mVYajs+dvjZ7JL0y7Djb0nzcNEH7FDGq662knUEmNjWa/8w1/DdQm0jNoaOWQXTkJwLVULnsRC6LC+rSw2WKPII5sBQEnCzldcGjs4q1aIfcdNuSwjO9bAGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435289; c=relaxed/simple;
	bh=ycyk/0BdjlJomF5MbiuTghmXGbhy80Qj+o+LzoMjj/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGMDZB4xaocFOp4w1pElbzmuckMKirWD6I6ub8IFUDHhM9GJJFMumD6Ur1/+cwmReXzCEPtNSAyrIEl+zKV1itLfkan5B6El9soZLjmEnLa3wOgT6CqqKgrt8YMmZozgtsDIvMbnWUKTN40g2TrrmTQzClvde2vqpsRTmKCr8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PdlDpfEY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PdlDpfEY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35CEF3293;
	Tue,  2 Jun 2026 14:21:21 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D32A63F632;
	Tue,  2 Jun 2026 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780435286; bh=ycyk/0BdjlJomF5MbiuTghmXGbhy80Qj+o+LzoMjj/k=;
	h=From:To:Cc:Subject:Date:From;
	b=PdlDpfEY8CPVZB/wakY+njADVOWhafcwQZGZnrlpgUNjGD1LM7Rk3OXhNKrQgW0V2
	 4K59tQ5Qy4jSXz2OBP/4cFHWiO7oJeaCRdWpp8/6efqu7rknRVStTIJ1MPR9P9TQKZ
	 HKyj3BwnTRnZ5y7LkbvGmsIdQJ5AwIfKGQS2r09s=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-pm@vger.kernel.org
Cc: sumitg@nvidia.com,
	pierre.gondois@arm.com,
	zhenglifeng1@huawei.com,
	zhanjie9@hisilicon.com,
	viresh.kumar@linaro.org,
	leitao@debian.org,
	rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] cpufreq: cppc: Reduce cppc delivered perf sampling jitter
Date: Tue,  2 Jun 2026 16:20:52 -0500
Message-ID: <20260602212052.1278365-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPPC uses a pair of registers cycling at different frequencies to
determine an accumulated performance level. For userspace reporting we
want to convert this to an instantaneous CPU frequency, but over short
time periods small errors caused by CPPC counter reads can cause
fairly significant reported frequency variations even when the core
CPU clock isn't changing.

Reduce this by keeping a start sample fixed and retrying the end
sample until the counter deltas are large enough to reduce short
window error, or until adjacent delivered performance estimates are
within the CPU's observed CPPC read noise floor.

To begin, resample the initial pair a small fixed number of times
looking for matching delivered performance deltas.  This reduces the
chance that a disturbed start sample anchors the rest of the
calculation.

Then look for an end sample while updating the noise floor from the
best error seen between samples.  The floor remains zero on systems
with stable feedback reads, but lets noisy systems stop early once
another retry is unlikely to improve the result.  The retry loop is
capped at 200 iterations, giving an ~20 usec explicit delay budget
derived from ndelay(100).

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 68 ++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..362c08def420 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -50,7 +50,7 @@ struct cppc_freq_invariance {
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
 static struct kthread_worker *kworker_fie;
 
-static int cppc_perf_from_fbctrs(u64 reference_perf,
+static u64 cppc_perf_from_fbctrs(u64 reference_perf,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
 
@@ -750,7 +750,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_perf_from_fbctrs(u64 reference_perf,
+static u64 cppc_perf_from_fbctrs(u64 reference_perf,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
@@ -771,19 +771,71 @@ static int cppc_perf_from_fbctrs(u64 reference_perf,
 	return (reference_perf * delta_delivered) / delta_reference;
 }
 
-static int cppc_get_perf_ctrs_sample(int cpu,
+/* CPPC read noise floor for early retry exit. */
+static DEFINE_PER_CPU(u64, err_floor);
+
+#define CPPC_SAMPLE_MAX_RETRIES	200
+
+static int cppc_get_perf_ctrs_sample(int cpu, u64 ref,
 				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	int ret;
+	s64 last_delivered = 0;
+	u64 smallest_error = 0;
+	int tries = 0;
+	u64 min_counts = ref * 2000;
+
+	/* Two subsequent reads with the same offset avoids one off large jitter values */
+	for (int x = 0; x < 10; x++) {
+		ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
+		if (ret)
+			return ret;
+
+		ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
+		if (ret)
+			return ret;
+
+		if (last_delivered == cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1))
+			break;
+
+		last_delivered = cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1);
+	}
+	last_delivered = 0;
+again:
+	ndelay(100);
 
-	ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
+	ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
 	if (ret)
 		return ret;
 
-	udelay(2); /* 2usec delay between sampling */
+	/*
+	 * We want at least two significant figures, if the counts are low, then there
+	 * can be rounding errors that show up as frequency that is swinging around a few hundred
+	 * Mhz. OTOH, if the delay gets too long the clock rate can be affected.
+	 * So we want it exactly long enough to have sufficient counter turn over, and
+	 * a repeatable low error value.
+	 */
+	if ((get_delta(fb_ctrs_t1->reference, fb_ctrs_t0->reference) < min_counts) ||
+	    (get_delta(fb_ctrs_t1->delivered, fb_ctrs_t0->delivered) < min_counts)) {
+		s64 delivered = cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1);
+		u64 error = abs(last_delivered - delivered);
+
+		if (smallest_error == 0 || smallest_error > error)
+			smallest_error = error;
+
+		if (error > per_cpu(err_floor, cpu)) {
+			last_delivered = delivered;
+			tries++;
+			if (tries < CPPC_SAMPLE_MAX_RETRIES)
+				goto again;
+		}
+	}
 
-	return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
+	/* compute a running error */
+	per_cpu(err_floor, cpu) = (per_cpu(err_floor, cpu) + smallest_error) / 2;
+
+	return ret;
 }
 
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
@@ -799,7 +851,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 	cpu_data = policy->driver_data;
 
-	ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
+	ret = cppc_get_perf_ctrs_sample(cpu, cpu_data->perf_caps.reference_perf,
+					&fb_ctrs_t0, &fb_ctrs_t1);
+
 	if (ret) {
 		if (ret == -EFAULT)
 			/* Any of the associated CPPC regs is 0. */
-- 
2.54.0

