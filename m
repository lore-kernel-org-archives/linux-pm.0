From: Tejun Heo <tj@kernel.org>
Subject: [PATCH pm-freezer 4/4] freezer: use lock_task_sighand()
 in fake_signal_wake_up()
Date: Wed, 31 Aug 2011 12:22:37 +0200
Message-ID: <20110831102237.GD2828__24518.2012011812$1314908984$gmane$org@mtj.dyndns.org>
References: <20110831102100.GA2828@mtj.dyndns.org>
	<20110831102143.GB2828@mtj.dyndns.org>
	<20110831102210.GC2828@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110831102210.GC2828@mtj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@redhat.com>, Paul Menage <paul@paulmenage.org>
Cc: containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: work/kernel/freezer.c
===================================================================
--- work.orig/kernel/freezer.c
+++ work/kernel/freezer.c
@@ -95,9 +95,10 @@ static void fake_signal_wake_up(struct t
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
