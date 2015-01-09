From: Michal Hocko <mhocko@suse.cz>
Subject: [PATCH -v3 2/5] oom: thaw the OOM victim if it is frozen
Date: Fri,  9 Jan 2015 12:05:52 +0100
Message-ID: <1420801555-22659-3-git-send-email-mhocko@suse.cz>
References: <1420801555-22659-1-git-send-email-mhocko@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420801555-22659-1-git-send-email-mhocko@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

oom_kill_process only sets TIF_MEMDIE flag and sends a signal to the
victim. This is basically noop when the task is frozen though because
the task sleeps in the uninterruptible sleep.
The victim is eventually thawed later when oom_scan_process_thread meets
the task again in a later OOM invocation so the OOM killer doesn't live
lock. But this is less than optimal.

Let's add __thaw_task into mark_tsk_oom_victim after we set TIF_MEMDIE
to the victim. We are not checking whether the task is frozen
because that would be racy and __thaw_task does that already.
oom_scan_process_thread doesn't need to care about freezer anymore as
TIF_MEMDIE and freezer are excluded completely now.

Signed-off-by: Michal Hocko <mhocko@suse.cz>
---
 mm/oom_kill.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 80b34e285f96..3cbd76b8c13b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -266,8 +266,6 @@ enum oom_scan_t oom_scan_process_thread(struct task_struct *task,
 	 * Don't allow any other task to have access to the reserves.
 	 */
 	if (test_tsk_thread_flag(task, TIF_MEMDIE)) {
-		if (unlikely(frozen(task)))
-			__thaw_task(task);
 		if (!force_kill)
 			return OOM_SCAN_ABORT;
 	}
@@ -423,6 +421,14 @@ void note_oom_kill(void)
 void mark_tsk_oom_victim(struct task_struct *tsk)
 {
 	set_tsk_thread_flag(tsk, TIF_MEMDIE);
+
+	/*
+	 * Make sure that the task is woken up from uninterruptible sleep
+	 * if it is frozen because OOM killer wouldn't be able to free
+	 * any memory and livelock. freezing_slow_path will tell the freezer
+	 * that TIF_MEMDIE tasks should be ignored.
+	 */
+	__thaw_task(tsk);
 }
 
 /**
-- 
2.1.4
