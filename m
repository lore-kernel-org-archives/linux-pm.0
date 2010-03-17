From: Oren Laadan <orenl@cs.columbia.edu>
Subject: [C/R v20][PATCH 15/96] cgroup freezer: Fix buggy resume
	test for tasks frozen with cgroup freezer
Date: Wed, 17 Mar 2010 11:55:48 -0400
Message-ID: <1268841429-4515-16-git-send-email-orenl@cs.columbia.edu>
References: <1268841429-4515-1-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-2-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-3-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-4-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-5-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-6-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-7-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-8-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-9-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-10-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-11-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-12-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-13-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-14-git-send-email-orenl@cs.columbia.edu>
	<1268841429-4515-15-git-send-email-orenl@cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1268841429-4515-15-git-send-email-orenl@cs.columbia.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: orenlaadan@gmail.com
Cc: Cedric Le Goater <legoater@free.fr>, Li Zefan <lizf@cn.fujitsu.com>, Pavel Machek <pavel@suse.cz>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Matt Helsley <matthltc@us.ibm.com>

When the cgroup freezer is used to freeze tasks we do not want to thaw
those tasks during resume. Currently we test the cgroup freezer
state of the resuming tasks to see if the cgroup is FROZEN.  If so
then we don't thaw the task. However, the FREEZING state also indicates
that the task should remain frozen.

This also avoids a problem pointed out by Oren Ladaan: the freezer state
transition from FREEZING to FROZEN is updated lazily when userspace reads
or writes the freezer.state file in the cgroup filesystem. This means that
resume will thaw tasks in cgroups which should be in the FROZEN state if
there is no read/write of the freezer.state file to trigger this
transition before suspend.

NOTE: Another "simple" solution would be to always update the cgroup
freezer state during resume. However it's a bad choice for several reasons:
Updating the cgroup freezer state is somewhat expensive because it requires
walking all the tasks in the cgroup and checking if they are each frozen.
Worse, this could easily make resume run in N^2 time where N is the number
of tasks in the cgroup. Finally, updating the freezer state from this code
path requires trickier locking because of the way locks must be ordered.

Instead of updating the freezer state we rely on the fact that lazy
updates only manage the transition from FREEZING to FROZEN. We know that
a cgroup with the FREEZING state may actually be FROZEN so test for that
state too. This makes sense in the resume path even for partially-frozen
cgroups -- those that really are FREEZING but not FROZEN.

Reported-by: Oren Ladaan <orenl@cs.columbia.edu>
Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Cedric Le Goater <legoater@free.fr>
Cc: Paul Menage <menage@google.com>
Cc: Li Zefan <lizf@cn.fujitsu.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.linux-foundation.org

Seems like a candidate for -stable.
---
 include/linux/freezer.h |    7 +++++--
 kernel/cgroup_freezer.c |    9 ++++++---
 kernel/power/process.c  |    2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 5a361f8..da7e52b 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -64,9 +64,12 @@ extern bool freeze_task(struct task_struct *p, bool sig_only);
 extern void cancel_freezing(struct task_struct *p);
 
 #ifdef CONFIG_CGROUP_FREEZER
-extern int cgroup_frozen(struct task_struct *task);
+extern int cgroup_freezing_or_frozen(struct task_struct *task);
 #else /* !CONFIG_CGROUP_FREEZER */
-static inline int cgroup_frozen(struct task_struct *task) { return 0; }
+static inline int cgroup_freezing_or_frozen(struct task_struct *task)
+{
+	return 0;
+}
 #endif /* !CONFIG_CGROUP_FREEZER */
 
 /*
diff --git a/kernel/cgroup_freezer.c b/kernel/cgroup_freezer.c
index 59e9ef6..eb3f34d 100644
--- a/kernel/cgroup_freezer.c
+++ b/kernel/cgroup_freezer.c
@@ -47,17 +47,20 @@ static inline struct freezer *task_freezer(struct task_struct *task)
 			    struct freezer, css);
 }
 
-int cgroup_frozen(struct task_struct *task)
+int cgroup_freezing_or_frozen(struct task_struct *task)
 {
 	struct freezer *freezer;
 	enum freezer_state state;
 
 	task_lock(task);
 	freezer = task_freezer(task);
-	state = freezer->state;
+	if (!freezer->css.cgroup->parent)
+		state = CGROUP_THAWED; /* root cgroup can't be frozen */
+	else
+		state = freezer->state;
 	task_unlock(task);
 
-	return state == CGROUP_FROZEN;
+	return (state == CGROUP_FREEZING) || (state == CGROUP_FROZEN);
 }
 
 /*
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 5ade1bd..de53015 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -145,7 +145,7 @@ static void thaw_tasks(bool nosig_only)
 		if (nosig_only && should_send_signal(p))
 			continue;
 
-		if (cgroup_frozen(p))
+		if (cgroup_freezing_or_frozen(p))
 			continue;
 
 		thaw_process(p);
-- 
1.6.3.3
