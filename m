From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 1/2] workqueues: flush_delayed_work: keep the
	original	workqueue for re-queueing
Date: Thu, 29 Apr 2010 21:45:16 +0200
Message-ID: <20100429194516.GB17280@redhat.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<20100428194028.GA16389@redhat.com>
	<4BD89922.1040306@kernel.org> <201004282308.10751.rjw@sisk.pl>
	<20100429185851.GA13862@redhat.com>
	<20100429194447.GA17280@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100429194447.GA17280@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

flush_delayed_work() always uses keventd_wq for re-queueing,
but it should use the workqueue this dwork was queued on.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---

 kernel/workqueue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 34-rc1/kernel/workqueue.c~FDW_DONT_USE_KEVENT_WQ	2009-12-18 19:05:38.000000000 +0100
+++ 34-rc1/kernel/workqueue.c	2010-04-29 21:08:32.000000000 +0200
@@ -774,7 +774,7 @@ void flush_delayed_work(struct delayed_w
 {
 	if (del_timer_sync(&dwork->timer)) {
 		struct cpu_workqueue_struct *cwq;
-		cwq = wq_per_cpu(keventd_wq, get_cpu());
+		cwq = wq_per_cpu(get_wq_data(&dwork->work)->wq, get_cpu());
 		__queue_work(cwq, &dwork->work);
 		put_cpu();
 	}
