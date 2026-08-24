Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5A376475;
	Mon, 24 Aug 2026 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577604; cv=none; b=Q1wdw/+kc1dxVTXPkGoD60DP4Q5edXJ+AFH9JvDNTQOWrLrT/QY/kIsrx6gv5dE25U+cXQtN9NkJ/85c6GVPTB7xASMJaxSAzeLgRSlOuGOMw+sxJ3KMU4xBZsSN7i4jd33OdW9jnB6eXmlEwqRXGDrA+snkOCI8Y2S7GmFLrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577604; c=relaxed/simple;
	bh=QQ/cCF7MFdUy6eoXraK/wjFX7MonCZAUdwBrhNkYXhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4NIM/9f2t+qQ8Dl0hsCdqqQnin7YA3IeGGJhmkQgq/OH9nFI/mDG6RKhDNgp7/NC4nWdqKVPPFN5RARZfITR0bCs/SF8+cvKY9B6+3H3C1Z4/HLKHELPFb9xwnOuWn5rQh3LH56rjvrpSvFv/VVLpS76DUR6PJYBh6OzBLoy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ephCMBWX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ephCMBWX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E10F41756;
	Mon, 24 Aug 2026 06:19:50 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE49D3F7D8;
	Mon, 24 Aug 2026 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787577594; bh=QQ/cCF7MFdUy6eoXraK/wjFX7MonCZAUdwBrhNkYXhY=;
	h=From:To:Cc:Subject:Date:From;
	b=ephCMBWXLfbslFQOYPce/vd9SmO6hj6QYfzHGtPAm3WQa9ym+UmU67IKTRw0WAhmA
	 nY9FfMsN5nX+Y9Pom4Hp6M9axMWk43uxSZ0f2SMmp9oxm2NqAFclGTur+PfnGudLMI
	 kVqCz5nCZOICio5OFiThc67dP+7KFHmp8Qo7GuWM=
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	vincent.guittot@linaro.org,
	daniel.lezcano@kernel.org
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	dietmar.eggemann@arm.com,
	jstultz@google.com,
	qyousef@layalina.io,
	hongyan.xia@transsion.com,
	sibi.sankar@oss.qualcomm.com,
	lukasz.luba@arm.com,
	morten.rasmussen@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/cpufreq: Reevaluate frequency before tickless idle
Date: Mon, 24 Aug 2026 14:18:42 +0100
Message-Id: <20260824131842.2443385-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sugov_hold_freq() can preserve a UCLAMP_MIN-driven high frequency when
the runqueue goes idle. If cpuidle then stops the tick, no later
utilization update is guaranteed and a CPU using WFI can remain at an
unnecessarily high voltage for the entire idle period.

Issue a final cpufreq update when the idle tick actually transitions to
stopped and force single-policy schedutil past its rate limit. Keep the
existing hold behavior when the tick is retained.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 include/linux/sched/cpufreq.h    |  1 +
 kernel/sched/cpufreq_schedutil.c |  5 ++++-
 kernel/sched/idle.c              | 29 +++++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..0814f6c79315 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -9,6 +9,7 @@
  */
 
 #define SCHED_CPUFREQ_IOWAIT	(1U << 0)
+#define SCHED_CPUFREQ_IDLE	(1U << 1)
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a1782755efcc..90bf8d8bffb7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -100,7 +100,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 		return true;
 	} else if (sg_policy->need_freq_update) {
-		/* ignore_dl_rate_limit() wants a new frequency to be found. */
+		/* A forced update needs a new frequency to be found. */
 		return true;
 	}
 
@@ -407,6 +407,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
+	if (flags & SCHED_CPUFREQ_IDLE)
+		sg_cpu->sg_policy->need_freq_update = true;
+
 	ignore_dl_rate_limit(sg_cpu);
 
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index eb73b65ce6c4..36f8840d0562 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -161,10 +161,35 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	return cpuidle_enter(drv, dev, next_state);
 }
 
+static void idle_stop_tick(void)
+{
+#ifdef CONFIG_CPU_FREQ
+	bool was_stopped = tick_nohz_tick_stopped();
+#endif
+
+	tick_nohz_idle_stop_tick();
+
+#ifdef CONFIG_CPU_FREQ
+	/*
+	 * Run one last cpufreq update before entering idle with the tick
+	 * stopped, because no later update is guaranteed.
+	 */
+	if (!was_stopped && tick_nohz_tick_stopped()) {
+		struct rq *rq = this_rq();
+		struct rq_flags rf;
+
+		rq_lock(rq, &rf);
+		update_rq_clock(rq);
+		cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);
+		rq_unlock(rq, &rf);
+	}
+#endif
+}
+
 static void idle_call_stop_or_retain_tick(bool stop_tick)
 {
 	if (stop_tick || tick_nohz_tick_stopped())
-		tick_nohz_idle_stop_tick();
+		idle_stop_tick();
 	else
 		tick_nohz_idle_retain_tick();
 }
@@ -225,7 +250,7 @@ static void cpuidle_idle_call(bool stop_tick)
 			max_latency_ns = dev->forced_idle_latency_limit_ns;
 		}
 
-		tick_nohz_idle_stop_tick();
+		idle_stop_tick();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
-- 
2.34.1

