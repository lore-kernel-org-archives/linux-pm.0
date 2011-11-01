From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/10] cgroup: subsys->attach_task() should be
	called after migration
Date: Tue,  1 Nov 2011 16:46:28 -0700
Message-ID: <1320191193-8110-6-git-send-email-tj__11990.3914318003$1320191253$gmane$org@kernel.org>
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

cgroup_attach_task() calls subsys->attach_task() after
cgroup_task_migrate(); however, cgroup_attach_proc() calls it before
migration.  This actually affects some of the users.  Update
cgroup_attach_proc() such that ->attach_task() is called after
migration.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@Jp.fujitsu.com>
Cc: Paul Menage <paul@paulmenage.org>
Cc: Li Zefan <lizf@cn.fujitsu.com>
---
 kernel/cgroup.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index 83e10f9..3679fb6 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -2152,13 +2152,15 @@ int cgroup_attach_proc(struct cgroup *cgrp, struct task_struct *leader)
 		oldcgrp = task_cgroup_from_root(tsk, root);
 		if (cgrp == oldcgrp)
 			continue;
+
+		retval = cgroup_task_migrate(cgrp, oldcgrp, tsk, true);
+		BUG_ON(retval != 0);
+
 		/* attach each task to each subsystem */
 		for_each_subsys(root, ss) {
 			if (ss->attach_task)
 				ss->attach_task(cgrp, tsk);
 		}
-		retval = cgroup_task_migrate(cgrp, oldcgrp, tsk, true);
-		BUG_ON(retval != 0);
 	}
 	/* nothing is sensitive to fork() after this point. */
 
-- 
1.7.3.1
