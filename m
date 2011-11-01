From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/10] cgroup, cpuset: don't use ss->pre_attach()
Date: Tue,  1 Nov 2011 16:46:32 -0700
Message-ID: <1320191193-8110-10-git-send-email-tj__12069.27635144$1320191278$gmane$org@kernel.org>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1320191193-8110-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paul@paulmenage.org, rjw@sisk.pl, lizf@cn.fujitsu.com
Cc: fweisbec@gmail.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, oleg@redhat.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

->pre_attach() is supposed to be called before migration, which is
observed during process migration but task migration does it the other
way around.  The only ->pre_attach() user is cpuset which can do the
same operaitons in ->can_attach().  Collapse cpuset_pre_attach() into
cpuset_can_attach().

-v2: Patch contamination from later patch removed.  Spotted by Paul
     Menage.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Paul Menage <paul@paulmenage.org>
Cc: Li Zefan <lizf@cn.fujitsu.com>
---
 kernel/cpuset.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 472ddd6..f0b8df3 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -1367,6 +1367,15 @@ static int fmeter_getrate(struct fmeter *fmp)
 	return val;
 }
 
+/*
+ * Protected by cgroup_lock. The nodemasks must be stored globally because
+ * dynamically allocating them is not allowed in can_attach, and they must
+ * persist until attach.
+ */
+static cpumask_var_t cpus_attach;
+static nodemask_t cpuset_attach_nodemask_from;
+static nodemask_t cpuset_attach_nodemask_to;
+
 /* Called by cgroups to determine if a cpuset is usable; cgroup_mutex held */
 static int cpuset_can_attach(struct cgroup_subsys *ss, struct cgroup *cgrp,
 			     struct cgroup_taskset *tset)
@@ -1393,29 +1402,16 @@ static int cpuset_can_attach(struct cgroup_subsys *ss, struct cgroup *cgrp,
 		if ((ret = security_task_setscheduler(task)))
 			return ret;
 	}
-	return 0;
-}
-
-/*
- * Protected by cgroup_lock. The nodemasks must be stored globally because
- * dynamically allocating them is not allowed in pre_attach, and they must
- * persist among pre_attach, and attach.
- */
-static cpumask_var_t cpus_attach;
-static nodemask_t cpuset_attach_nodemask_from;
-static nodemask_t cpuset_attach_nodemask_to;
-
-/* Set-up work for before attaching each task. */
-static void cpuset_pre_attach(struct cgroup *cont)
-{
-	struct cpuset *cs = cgroup_cs(cont);
 
+	/* prepare for attach */
 	if (cs == &top_cpuset)
 		cpumask_copy(cpus_attach, cpu_possible_mask);
 	else
 		guarantee_online_cpus(cs, cpus_attach);
 
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+
+	return 0;
 }
 
 static void cpuset_attach(struct cgroup_subsys *ss, struct cgroup *cgrp,
@@ -1901,7 +1897,6 @@ struct cgroup_subsys cpuset_subsys = {
 	.create = cpuset_create,
 	.destroy = cpuset_destroy,
 	.can_attach = cpuset_can_attach,
-	.pre_attach = cpuset_pre_attach,
 	.attach = cpuset_attach,
 	.populate = cpuset_populate,
 	.post_clone = cpuset_post_clone,
-- 
1.7.3.1
