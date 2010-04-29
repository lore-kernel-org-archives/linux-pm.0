From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/2] workqueues: export keventd_wq
Date: Thu, 29 Apr 2010 21:45:45 +0200
Message-ID: <20100429194545.GC17280@redhat.com>
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

Export keventd_wq. Otherwise, any helper on top of queue_work() has
to be copy-and-pasted to create the version which uses keventd_wq.

Note: we can do more cleanups with this change and kill EXPORT_SYMBOLs,
almost any function which currently uses keventd_wq can become the
trivial inline.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---

 include/linux/workqueue.h |    1 +
 kernel/workqueue.c        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- 34-rc1/include/linux/workqueue.h~EXPORT_KEVENT_WQ	2009-12-18 19:05:38.000000000 +0100
+++ 34-rc1/include/linux/workqueue.h	2010-04-29 21:25:12.000000000 +0200
@@ -12,6 +12,7 @@
 #include <asm/atomic.h>
 
 struct workqueue_struct;
+extern struct workqueue_struct *keventd_wq;
 
 struct work_struct;
 typedef void (*work_func_t)(struct work_struct *work);
--- 34-rc1/kernel/workqueue.c~EXPORT_KEVENT_WQ	2010-04-29 21:08:32.000000000 +0200
+++ 34-rc1/kernel/workqueue.c	2010-04-29 21:23:46.000000000 +0200
@@ -717,7 +717,8 @@ int cancel_delayed_work_sync(struct dela
 }
 EXPORT_SYMBOL(cancel_delayed_work_sync);
 
-static struct workqueue_struct *keventd_wq __read_mostly;
+struct workqueue_struct *keventd_wq __read_mostly;
+EXPORT_SYMBOL(keventd_wq);
 
 /**
  * schedule_work - put work task in global workqueue
