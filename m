From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] cgroup: change locking order in
	attach_task_by_pid()
Date: Mon,  5 Sep 2011 03:01:17 +0900
Message-ID: <1315159280-25032-2-git-send-email-htejun__17302.1059869372$1315159446$gmane$org@gmail.com>
References: <1315159280-25032-1-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1315159280-25032-1-git-send-email-htejun@gmail.com>
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
Cc: Paul Menage <menage@google.com>, fweisbec@gmail.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

cgroup_mutex is updated to nest inside threadgroup_fork_lock instead
of the other way around.  threadgroup locking is scheduled to be
updated to cover all threadgroup altering operations and nesting it
inside cgroup_mutex complicates locking dependency unnecessarily.
This also simplifies code a bit.

The ugly "if (threadgroup)" conditionals for threadgroup locking will
soon be removed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Menage <menage@google.com>
Cc: Li Zefan <lizf@cn.fujitsu.com>
---
 kernel/cgroup.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index 1d2b6ce..bd1fb5f 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -2203,15 +2203,11 @@ static int attach_task_by_pid(struct cgroup *cgrp, u64 pid, bool threadgroup)
 	const struct cred *cred = current_cred(), *tcred;
 	int ret;
 
-	if (!cgroup_lock_live_group(cgrp))
-		return -ENODEV;
-
 	if (pid) {
 		rcu_read_lock();
 		tsk = find_task_by_vpid(pid);
 		if (!tsk) {
 			rcu_read_unlock();
-			cgroup_unlock();
 			return -ESRCH;
 		}
 		if (threadgroup) {
@@ -2225,7 +2221,6 @@ static int attach_task_by_pid(struct cgroup *cgrp, u64 pid, bool threadgroup)
 		} else if (tsk->flags & PF_EXITING) {
 			/* optimization for the single-task-only case */
 			rcu_read_unlock();
-			cgroup_unlock();
 			return -ESRCH;
 		}
 
@@ -2238,7 +2233,6 @@ static int attach_task_by_pid(struct cgroup *cgrp, u64 pid, bool threadgroup)
 		    cred->euid != tcred->uid &&
 		    cred->euid != tcred->suid) {
 			rcu_read_unlock();
-			cgroup_unlock();
 			return -EACCES;
 		}
 		get_task_struct(tsk);
@@ -2251,15 +2245,19 @@ static int attach_task_by_pid(struct cgroup *cgrp, u64 pid, bool threadgroup)
 		get_task_struct(tsk);
 	}
 
-	if (threadgroup) {
+	if (threadgroup)
 		threadgroup_fork_write_lock(tsk);
-		ret = cgroup_attach_proc(cgrp, tsk);
-		threadgroup_fork_write_unlock(tsk);
-	} else {
-		ret = cgroup_attach_task(cgrp, tsk);
+	ret = -ENODEV;
+	if (cgroup_lock_live_group(cgrp)) {
+		if (threadgroup)
+			ret = cgroup_attach_proc(cgrp, tsk);
+		else
+			ret = cgroup_attach_task(cgrp, tsk);
+		cgroup_unlock();
 	}
+	if (threadgroup)
+		threadgroup_fork_write_unlock(tsk);
 	put_task_struct(tsk);
-	cgroup_unlock();
 	return ret;
 }
 
-- 
1.7.6
