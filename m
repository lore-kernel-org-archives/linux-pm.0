From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 10/14] sched/fair: add function to convert boost value into "margin"
Date: Wed, 19 Aug 2015 19:47:20 +0100
Message-ID: <1440010044-3402-11-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The basic idea of the boost knob is to "artificially inflate" a signal
to make a task or logical CPU appears more demanding than it actually
is. Independently from the specific signal, a consistent and possibly
simple semantic for the concept of "signal boosting" must define:
1. how we translate the boost percentage into a "margin" value to be added
   to the original signal to inflate
2. what is the meaning of a boost value from a user-space perspective

This patch provides the implementation of a possible boost semantic,
named "Signal Proportional Compensation" (SPC), where the boost
percentage (BP) is used to compute a margin (M) which is proportional to
the complement of the original signal (OS):
  M = BP * (SCHED_LOAD_SCALE - OS)
The computed margin then added to the OS to obtain the Boosted Signal (BS)
  BS = OS + M

The proposed boost semantic has these main features:
- each signal gets a boost which is proportional to its delta with respect
  to the maximum available capacity in the system (i.e. SCHED_LOAD_SCALE)
- a 100% boosting has a clear understanding from a user-space perspective,
  since it means simply to run (possibly) "all" tasks at the max OPP
- each boosting value means to improve the task performance by a quantity
  which is proportional to the maximum achievable performance on that
  system
Thus this semantics is somehow forcing a behaviour which is:

  50% boosting means to run at half-way between the current and the
    maximum performance which a task could achieve on that system

This patch provides the code to implement a fast integer division to
convert a boost percentage (BP) value into a margin (M).

NOTE: this code is suitable for all signals operating in range
      [0..SCHED_LOAD_SCALE]

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
---
 kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 955dfe1..15fde75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4730,6 +4730,44 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p, int sync)
 	return 1;
 }
 
+#ifdef CONFIG_SCHED_TUNE
+
+static unsigned long
+schedtune_margin(unsigned long signal, unsigned long boost)
+{
+	unsigned long long margin = 0;
+
+	/*
+	 * Signal proportional compensation (SPC)
+	 *
+	 * The Boost (B) value is used to compute a Margin (M) which is
+	 * proportional to the complement of the original Signal (S):
+	 *   M = B * (SCHED_LOAD_SCALE - S)
+	 * The obtained M could be used by the caller to "boost" S.
+	 */
+	margin  = SCHED_LOAD_SCALE - signal;
+	margin *= boost;
+
+	/*
+	 * Fast integer division by constant:
+	 *  Constant   :                 (C) = 100
+	 *  Precision  : 0.1%            (P) = 0.1
+	 *  Reference  : C * 100 / P     (R) = 100000
+	 *
+	 * Thus:
+	 *  Shift bits : ceil(log(R,2))  (S) = 17
+	 *  Mult const : round(2^S/C)    (M) = 1311
+	 *
+	 *
+	 * */
+	margin  *= 1311;
+	margin >>= 17;
+
+	return margin;
+}
+
+#endif /* CONFIG_SCHED_TUNE */
+
 /*
  * find_idlest_group finds and returns the least busy CPU group within the
  * domain.
-- 
2.5.0
