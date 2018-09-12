From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v7 05/14] sched: Introduce a sched_feat for Energy Aware Scheduling
Date: Wed, 12 Sep 2018 10:13:00 +0100
Message-ID: <20180912091309.7551-6-quentin.perret@arm.com>
References: <20180912091309.7551-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912091309.7551-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

In order to make sure Energy Aware Scheduling (EAS) doesn't hurt
systems not using it, add a new sched_feat, called ENERGY_AWARE,
guarding the access to EAS code paths.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/features.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae8488039c..26ff6752e492 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,10 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+
+/*
+ * Energy-Aware Scheduling. Whether or not tasks will be placed into an
+ * energy-aware fashion depends on this feature being enabled and on the
+ * root domain having an Energy Model attached.
+ */
+SCHED_FEAT(ENERGY_AWARE, false)
-- 
2.18.0
