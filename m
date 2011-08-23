From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] cgroup: subsys->attach_task() should be
	called after migration
Date: Wed, 24 Aug 2011 00:19:55 +0200
Message-ID: <1314138000-2049-2-git-send-email-tj__23288.525423459$1314138110$gmane$org@kernel.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314138000-2049-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, paul@paulmenage.org, lizf@cn.fujitsu.com
Cc: Tejun Heo <tj@kernel.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cgroup_attach_task() calls subsys->attach_task() after
cgroup_task_migrate(); however, cgroup_attach_proc() calls it before
migration.  This actually affects some of the users.  Update
cgroup_attach_proc() such that ->attach_task() is called after
migration.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Paul Menage <paul@paulmenage.org>
Cc: Li Zefan <lizf@cn.fujitsu.com>
---
 kernel/cgroup.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index 1d2b6ce..a606fa2 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -2135,14 +2135,16 @@ int cgroup_attach_proc(struct cgroup *cgrp, struct task_struct *leader)
 		oldcgrp = task_cgroup_from_root(tsk, root);
 		if (cgrp == oldcgrp)
 			continue;
+
+		/* if the thread is PF_EXITING, it can just get skipped. */
+		retval = cgroup_task_migrate(cgrp, oldcgrp, tsk, true);
+		BUG_ON(retval != 0 && retval != -ESRCH);
+
 		/* attach each task to each subsystem */
 		for_each_subsys(root, ss) {
 			if (ss->attach_task)
 				ss->attach_task(cgrp, tsk);
 		}
-		/* if the thread is PF_EXITING, it can just get skipped. */
-		retval = cgroup_task_migrate(cgrp, oldcgrp, tsk, true);
-		BUG_ON(retval != 0 && retval != -ESRCH);
 	}
 	/* nothing is sensitive to fork() after this point. */
 
-- 
1.7.6
