From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] freezer: use lock_task_sighand() in
	fake_signal_wake_up()
Date: Sat,  3 Sep 2011 03:27:48 +0900
Message-ID: <1314988070-12244-5-git-send-email-tj__28317.6923440353$1314988206$gmane$org@kernel.org>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314988070-12244-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oleg@redhat.com, matthltc@us.ibm.com, rjw@sisk.pl, paul@paulmenage.org
Cc: Tejun Heo <tj@kernel.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cgroup_freezer calls freeze_task() without holding tasklist_lock and,
if the task is exiting, its ->sighand may be gone by the time
fake_signal_wake_up() is called.  Use lock_task_sighand() instead of
accessing ->sighand directly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Menage <paul@paulmenage.org>
---
 kernel/freezer.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index ebee1ab..9846133 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -93,9 +93,10 @@ static void fake_signal_wake_up(struct task_struct *p)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->sighand->siglock, flags);
-	signal_wake_up(p, 0);
-	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	if (lock_task_sighand(p, &flags)) {
+		signal_wake_up(p, 0);
+		unlock_task_sighand(p, &flags);
+	}
 }
 
 /**
-- 
1.7.6
