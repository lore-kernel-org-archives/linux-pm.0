From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2] cpufreq: Don't use smp_processor_id() in preemptible context
Date: Wed, 28 Aug 2013 14:24:45 -0700
Message-ID: <1377725085-16798-1-git-send-email-sboyd@codeaurora.org>
References: <521E24CE.9090407@codeaurora.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <521E24CE.9090407@codeaurora.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Workqueues are preemptible even if works are queued on them with
queue_work_on(). Let's use raw_smp_processor_id() here to silence
the warning.

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/3:2/674
caller is gov_queue_work+0x28/0xb0
CPU: 0 PID: 674 Comm: kworker/3:2 Tainted: G        W    3.10.0 #30
Workqueue: events od_dbs_timer
[<c010c178>] (unwind_backtrace+0x0/0x11c) from [<c0109dec>] (show_stack+0x10/0x14)
[<c0109dec>] (show_stack+0x10/0x14) from [<c03885a4>] (debug_smp_processor_id+0xbc/0xf0)
[<c03885a4>] (debug_smp_processor_id+0xbc/0xf0) from [<c0635864>] (gov_queue_work+0x28/0xb0)
[<c0635864>] (gov_queue_work+0x28/0xb0) from [<c0635618>] (od_dbs_timer+0x108/0x134)
[<c0635618>] (od_dbs_timer+0x108/0x134) from [<c01aa8f8>] (process_one_work+0x25c/0x444)
[<c01aa8f8>] (process_one_work+0x25c/0x444) from [<c01aaf88>] (worker_thread+0x200/0x344)
[<c01aaf88>] (worker_thread+0x200/0x344) from [<c01b03bc>] (kthread+0xa0/0xb0)
[<c01b03bc>] (kthread+0xa0/0xb0) from [<c01061b8>] (ret_from_fork+0x14/0x3c)

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq_governor.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index b9b20fd..bfbcf9a 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -137,7 +137,14 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 		return;
 
 	if (!all_cpus) {
-		__gov_queue_work(smp_processor_id(), dbs_data, delay);
+		/*
+		 * Use raw_smp_processor_id() to avoid preemptible warnings.
+		 * We know that this is only called with all_cpus == false from
+		 * works that have been queued with *_work_on() functions and
+		 * those works are canceled during CPU_DOWN_PREPARE so they
+		 * can't possibly run on any other CPU.
+		 */
+		__gov_queue_work(raw_smp_processor_id(), dbs_data, delay);
 	} else {
 		for_each_cpu(i, policy->cpus)
 			__gov_queue_work(i, dbs_data, delay);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

