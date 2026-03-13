Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653537881F;
	Fri, 13 Mar 2026 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404745; cv=none; b=ZQMcfvRJPmuEa0qO5OjOaRdHrTgKO9j2kjLVMiYZEwrLgGVFotnUVFgFUbR1g1PDjxG9z1o20xjNr+dHx24WcOdDfxdZ2ZZA25MB4W9b3t1HcATxyYaPr68lb8wedaNUQZFfs6JI6Xj/kX6VSCjDXKtcCSJ3KnB3VQAd/PbybXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404745; c=relaxed/simple;
	bh=RGlHNT9ssdhDedXx2+peq5rJVKfHqlT3q44gVy+2ML8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m49avC89+RjX/RCViWxOwMSSOazAk7sLQ/a2oiloiUatotdt27FhVf+n/8B0c9FpDNvHl9rpSN48jL0RdQj8lBIeXe7Gm5LXBOVFFSyLmwflwksCDJc/qmgaxp+8LqqvRsfpvZ4ShVbmxlpdk9HUC6t+kCT7MBoaA5JZg4b4RdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNQVi66j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNQVi66j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C2EC19421;
	Fri, 13 Mar 2026 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773404745;
	bh=RGlHNT9ssdhDedXx2+peq5rJVKfHqlT3q44gVy+2ML8=;
	h=From:To:Cc:Subject:Date:From;
	b=nNQVi66jjJ7vpgSTddV1Iemh9zma5pUAVEOsQVF+0aYuHsCY0QqsQLIgCHrjHkPJS
	 K5p/uIRtU7Z04Ql2/nynhWPcJSlMjAl2LH5YW7fq0+TdftcVbDKRFNBQkERWRNLnNZ
	 l/hIrVekTkBoMTDKOgoMqSfv2YWiIdE3eL/7vleF1E9tnltbCqo5ItB5IbK54TwO6W
	 5/YDgvkeu+Tqab7f4ZtRfytwuPC45UfKgli80EHglcfltDX8rvnLc9eUbyozVdkknT
	 JWmDSmRKz/mAasRNgnhjikvdJ5IqhZpCKlCT025VBOiMiFrIc5Ph7bhvouxojqml3P
	 NSfISy0pLjnBg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v1] sched: idle: Consolidate the handling of two special cases
Date: Fri, 13 Mar 2026 13:25:41 +0100
Message-ID: <4741364.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are two special cases in the idle loop that are handled
inconsistently even though they are analogous.

The first one is when a cpuidle driver is absent and the default CPU
idle time power management implemented by the architecture code is used.
In that case, the scheduler tick is stopped every time before invoking
default_idle_call().

The second one is when a cpuidle driver is present, but there is only
one idle state in its table.  In that case, the scheduler tick is never
stopped.

Since each of these approaches leads to suboptimal choices in some
cases, reconcile them with the help of one simple heuristic.  Namely,
stop the tick if the CPU has been woken up by it in the previous
iteration of the idle loop, or let it tick otherwise.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Based on today's mainline.

---
 kernel/sched/idle.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
 	return cpuidle_enter(drv, dev, next_state);
 }
 
+static void idle_call_stop_or_retain_tick(bool stop_tick)
+{
+	if (stop_tick || tick_nohz_tick_stopped())
+		tick_nohz_idle_stop_tick();
+	else
+		tick_nohz_idle_retain_tick();
+}
+
 /**
  * cpuidle_idle_call - the main idle function
  *
@@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
  * set, and it returns with polling set.  If it ever stops polling, it
  * must clear the polling bit.
  */
-static void cpuidle_idle_call(void)
+static void cpuidle_idle_call(bool stop_tick)
 {
 	struct cpuidle_device *dev = cpuidle_get_device();
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
@@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
 	}
 
 	if (cpuidle_not_available(drv, dev)) {
-		tick_nohz_idle_stop_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
 
 		default_idle_call();
 		goto exit_idle;
@@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
 	} else if (drv->state_count > 1) {
-		bool stop_tick = true;
+		/*
+		 * stop_tick is expected to be true by default by cpuidle
+		 * governors, which allows them to select idle states with
+		 * target residency above the tick period length.
+		 */
+		stop_tick = true;
 
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick || tick_nohz_tick_stopped())
-			tick_nohz_idle_stop_tick();
-		else
-			tick_nohz_idle_retain_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
 
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
@@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
 		 */
 		cpuidle_reflect(dev, entered_state);
 	} else {
-		tick_nohz_idle_retain_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
 
 		/*
 		 * If there is only a single idle state (or none), there is
@@ -268,6 +278,7 @@ exit_idle:
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+	bool got_tick = false;
 
 	/*
 	 * Check if we need to update blocked load
@@ -338,8 +349,9 @@ static void do_idle(void)
 			tick_nohz_idle_restart_tick();
 			cpu_idle_poll();
 		} else {
-			cpuidle_idle_call();
+			cpuidle_idle_call(got_tick);
 		}
+		got_tick = tick_nohz_idle_got_tick();
 		arch_cpu_idle_exit();
 	}
 



