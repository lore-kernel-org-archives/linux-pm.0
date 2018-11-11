From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 15/41] cpufreq/intel_pstate: Replace synchronize_sched() with synchronize_rcu()
Date: Sun, 11 Nov 2018 11:43:44 -0800
Message-ID: <20181111194410.6368-15-paulmck@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that synchronize_rcu() waits for preempt-disable regions of code
as well as RCU read-side critical sections, synchronize_sched() can be
replaced by synchronize_rcu().  This commit therefore makes this change.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9578312e43f2..ed124d72db76 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1930,7 +1930,7 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 
 	cpufreq_remove_update_util_hook(cpu);
 	cpu_data->update_util_set = false;
-	synchronize_sched();
+	synchronize_rcu();
 }
 
 static int intel_pstate_get_max_freq(struct cpudata *cpu)
-- 
2.17.1
