Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398355;
	b=EG8s9BvRp5nWOm8FZ6qyBKPlX82haVcTTnefKeq2P9ysCj1Sy4obhBEHwjZYGq6g4fk7
	 7OBTe3YkHMLkp0mb7uW4dVj7YOP++OlyrG7b/awUjDWU2mNRONcN42mImqlMhibfSdpzC
	 N/hu7LER3ATVb58RE+Q/GV8x9MYCFVAzy5zP5ZphNZjNGM2XG8blDGExoPXVE+nG5QFLM
	 5djB2/VzMEn6Wk8s3egJ2YkWq5Bw8APy6EqM8Wl6Ef/wJNCFfMCCHw7ciNSrpdsKsuJr3
	 gKUyFkLc14emhFklvgAloz9Ap/YwjMfhbAN7wlVCohNoKF0XbGtvmVP/wNwrRqU7C+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398355;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=trU7quq0NVSybLgPWJ+Lu4zItqMZeP4pLBxtYy4RqQk=;
	b=JGDKicZPyBRSNyLmkquo0JLmr2w5qw+nuMHmx3ZTfwgIs+wrDyOlWHmacdt9BunakfiM
	 ri2nrc+zLfx4CaGQ39CUQLs8jbNnb0tO5GEH+7D6Lk2fStNuXCT9Gl4CcSGr505F/3R25
	 jFmctLkqUuduVeoSX4aAUX6l8lsoL0kN4PENa9mL5PzND56hbq1Hcm8U4rLgTnDs27+mR
	 bn8Y5Aowl9CrM90+evGQdThouD4cR6c0sd7IHkWBIUYcBlDl3QsehnB3cAiE0HLWBsVS0
	 9pIJFSzqi830zV+q6CfH4xPVrs/2+sqXaXMGxB2CpmXoTtHEcScZfhIyNxxi6fO9k9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vjCw5U4f;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF758606A897;
	Wed, 11 Nov 2026 11:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF758606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vjCw5U4f
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70EB11576;
	Wed, 11 Nov 2026 03:59:11 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2989C3F673;
	Wed, 11 Nov 2026 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794398354; bh=Jbcwb7gKCsHfkv3ZuwJ4jpNzAGC8TTWVWptArKO00+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vjCw5U4fSynEvelGmwSqYCi8bc8NLtf1l40x1oTPeOBbE2HuKknNPAe0dtTvwOP7V
	 dt8lfmECDas5x2hg1d8RtvosaIctoMsy+FffFLspSsRHOCK/ytKNux7kwUY9JR5Rsv
	 firFOIhWPQQ/o38S0zSAOgLSfja5czpTN4d7W8bA=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 2/2] cpuidle: Respect latency constraints when accounting below misses
Date: Wed, 11 Nov 2026 11:59:02 +0000
Message-Id: <20261111115902.1904523-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111115902.1904523-1-christian.loehle@arm.com>
References: <20261111115902.1904523-1-christian.loehle@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only count a below miss when an enabled deeper state meets the latency
constraint.

Sample the limit once in cpuidle_select() and share it between governors
and accounting since  a separate read before entry can already differ
from the value used for selection.

Continue checking disable flags on exit only, as they're not expected to
change as frequently.

Fixes: 04dab58a39d4 ("cpuidle: Add 'above' and 'below' idle state metrics")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 Documentation/driver-api/pm/cpuidle.rst | 13 ++++++-------
 drivers/cpuidle/cpuidle.c               |  8 +++++++-
 drivers/cpuidle/cpuidle.h               |  1 +
 drivers/cpuidle/governors/haltpoll.c    |  2 +-
 drivers/cpuidle/governors/ladder.c      |  2 +-
 drivers/cpuidle/governors/menu.c        |  2 +-
 drivers/cpuidle/governors/teo.c         |  2 +-
 include/linux/cpuidle.h                 |  2 +-
 8 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/driver-api/pm/cpuidle.rst b/Documentation/driver-api/pm/cpuidle.rst
index d477208604b8..286061495ce7 100644
--- a/Documentation/driver-api/pm/cpuidle.rst
+++ b/Documentation/driver-api/pm/cpuidle.rst
@@ -146,13 +146,12 @@ callbacks:
 
 In addition, ``CPUIdle`` governors are required to take power management
 quality of service (PM QoS) constraints on the processor wakeup latency into
-account when selecting idle states.  In order to obtain the current effective
-PM QoS wakeup latency constraint for a given CPU, a ``CPUIdle`` governor is
-expected to pass the number of the CPU to
-:c:func:`cpuidle_governor_latency_req()`.  Then, the governor's ``->select()``
-callback must not return the index of an indle state whose
-:c:member:`exit_latency` value is greater than the number returned by that
-function.
+account when selecting idle states.  Before invoking the governor's
+``->select()`` callback, the core saves the effective PM QoS wakeup latency
+constraint in ``dev->latency_req``, in nanoseconds.  Governors use this value
+to constrain the :c:member:`exit_latency_ns` of the selected idle state.
+The core also uses the saved value for below miss accounting, so subsequent
+PM QoS updates do not change the constraint used to evaluate that selection.
 
 
 CPU Idle Time Management Drivers
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index faa29f58738e..9af704473f6e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -131,12 +131,15 @@ void cpuidle_use_deepest_state(u64 latency_limit_ns)
  * @dev: cpuidle device for the given CPU.
  * @latency_limit_ns: Idle state exit latency limit
  *
+ * Save the limit for miss accounting on the subsequent idle entry.
+ *
  * Return: the index of the deepest available idle state.
  */
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev,
 			       u64 latency_limit_ns)
 {
+	dev->latency_req = min_t(u64, latency_limit_ns, S64_MAX);
 	return find_deepest_state(drv, dev, latency_limit_ns, 0, false);
 }
 
@@ -327,7 +330,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 			}
 		} else if (diff > delay) {
 			for (i = entered_state + 1; i < drv->state_count; i++) {
-				if (dev->states_usage[i].disable)
+				if (dev->states_usage[i].disable ||
+				    drv->states[i].exit_latency_ns > dev->latency_req)
 					continue;
 
 				/*
@@ -369,6 +373,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
+	/* Use the same constraint for state selection and miss accounting. */
+	dev->latency_req = cpuidle_governor_latency_req(dev->cpu);
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index 52701d9588f1..3a00d8db6d28 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -23,6 +23,7 @@ extern void cpuidle_install_idle_handler(void);
 extern void cpuidle_uninstall_idle_handler(void);
 
 /* governors */
+s64 cpuidle_governor_latency_req(unsigned int cpu);
 extern struct cpuidle_governor *cpuidle_find_governor(const char *str);
 extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
 
diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index b367d10279c8..0ab38f093ef1 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -50,7 +50,7 @@ static int haltpoll_select(struct cpuidle_driver *drv,
 			   struct cpuidle_device *dev,
 			   bool *stop_tick)
 {
-	if (cpuidle_governor_latency_req(dev->cpu) == 0) {
+	if (dev->latency_req == 0) {
 		*stop_tick = false;
 		return 0;
 	}
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 6617eb494a11..67e0e98e699e 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -71,7 +71,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 	struct ladder_device_state *last_state;
 	int last_idx = dev->last_state_idx;
 	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
-	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
+	s64 latency_req = dev->latency_req;
 	s64 last_residency;
 
 	/* Special case when user has set very strict latency requirement */
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index eb529d73d4b7..e0145417ffe7 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -219,7 +219,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		       bool *stop_tick)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
-	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
+	s64 latency_req = dev->latency_req;
 	u64 predicted_ns;
 	ktime_t delta, delta_tick;
 	int i, idx;
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 906f4f89e365..735894a1a7fc 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -309,7 +309,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		      bool *stop_tick)
 {
 	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
-	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
+	s64 latency_req = dev->latency_req;
 	ktime_t delta_tick = TICK_NSEC / 2;
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a2485348def3..14ba5e1f3cdb 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -101,6 +101,7 @@ struct cpuidle_device {
 	u64			last_residency_ns;
 	u64			poll_limit_ns;
 	u64			forced_idle_latency_limit_ns;
+	s64			latency_req;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
@@ -306,7 +307,6 @@ struct cpuidle_governor {
 };
 
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
-extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 
 #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,			\
 				idx,					\
-- 
2.34.1

