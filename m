From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 2/2] cpuset, mm: fix TIF_MEMDIE check in cpuset_change_task_nodemask
Date: Mon, 27 Jun 2016 14:15:19 +0200
Message-ID: <1467029719-17602-3-git-send-email-mhocko@kernel.org>
References: <1467029719-17602-1-git-send-email-mhocko@kernel.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1467029719-17602-1-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Miao Xie <miaox@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Michal Hocko <mhocko@suse.com>
List-Id: linux-pm@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

c0ff7453bb5c ("cpuset,mm: fix no node to alloc memory when changing
cpuset's mems") has added TIF_MEMDIE and PF_EXITING check but it is
checking the flag on the current task rather than the given one.
This doesn't make much sense and it is actually wrong. If the current
task which updates the nodemask of a cpuset got killed by the OOM killer
then a part of the cpuset cgroup processes would have incompatible
nodemask which is surprising to say the least.

The comment suggests the intention was to skip oom victim or an exiting
task so we should be checking the given task. But even then it would be
layering violation becuase it is the memory allocator to interpret the
TIF_MEMDIE meaning. Simply drop both checks. All tasks in the cpuset
should simply follow the same mask.

Cc: Miao Xie <miaox@cn.fujitsu.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/cpuset.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 73e93e53884d..c7fd2778ed50 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -1034,15 +1034,6 @@ static void cpuset_change_task_nodemask(struct task_struct *tsk,
 {
 	bool need_loop;
 
-	/*
-	 * Allow tasks that have access to memory reserves because they have
-	 * been OOM killed to get memory anywhere.
-	 */
-	if (unlikely(test_thread_flag(TIF_MEMDIE)))
-		return;
-	if (current->flags & PF_EXITING) /* Let dying task have memory */
-		return;
-
 	task_lock(tsk);
 	/*
 	 * Determine if a loop is necessary if another thread is doing
-- 
2.8.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
