From: Parth Shah <parth@linux.ibm.com>
Subject: [RFCv2 3/6] sched/core: Update turbo_sched count only when required
Date: Wed, 15 May 2019 19:23:19 +0530
Message-ID: <20190515135322.19393-4-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

Use the get/put methods to add/remove the use of TurboSched support from
the cgroup.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index facbedd2554e..4c55b5399985 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7216,10 +7216,13 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	 * Classify the tasks belonging to the last bucket of MAX UCLAMP as
 	 * jitters
 	 */
-	if (uclamp_bucket_id(max_value) == 0)
+	if (uclamp_bucket_id(max_value) == 0) {
 		tg->turbo_sched_enabled = 1;
-	else if (tg->turbo_sched_enabled)
+		turbo_sched_get();
+	} else if (tg->turbo_sched_enabled) {
 		tg->turbo_sched_enabled = 0;
+		turbo_sched_put();
+	}
 
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(css, UCLAMP_MAX);
-- 
2.17.1
