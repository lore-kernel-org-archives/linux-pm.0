From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 4/7] Freezer: Introduce freezer-firendly
	waiting macros
Date: Thu, 12 Jul 2007 00:13:31 +0200
Message-ID: <200707120013.32672.rjw@sisk.pl>
References: <200707120006.50095.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707120006.50095.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce freezer-friendly wrappers around wait_event_interruptible() and
wait_event_interruptible_timeout(), originally defined in <linux/wait.h>,=
 to
be used in freezable kernel threads. =A0Make some of the freezable kernel=
 threads
use them.

This is necessary for the freezer to stop sending signals to kernel threa=
ds,
which is implemented in the next patch.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/input/gameport/gameport.c         |    3 --
 drivers/input/serio/serio.c               |    3 --
 drivers/input/touchscreen/ucb1400_ts.c    |    3 --
 drivers/media/dvb/dvb-core/dvb_frontend.c |    3 +-
 drivers/usb/core/hub.c                    |    3 --
 drivers/usb/storage/usb.c                 |    5 ---
 include/linux/freezer.h                   |   40 +++++++++++++++++++++++=
+++++--
 7 files changed, 45 insertions(+), 15 deletions(-)

Index: linux-2.6.22-rc6-mm1/include/linux/freezer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/include/linux/freezer.h	2007-07-11 20:48:04=
.000000000 +0200
+++ linux-2.6.22-rc6-mm1/include/linux/freezer.h	2007-07-11 20:51:14.0000=
00000 +0200
@@ -4,6 +4,7 @@
 #define FREEZER_H_INCLUDED
=20
 #include <linux/sched.h>
+#include <linux/wait.h>
=20
 #ifdef CONFIG_PM
 /*
@@ -126,7 +127,35 @@ static inline void set_freezable(void)
 	current->flags &=3D ~PF_NOFREEZE;
 }
=20
-#else
+/*
+ * Freezer-friendly wrappers around wait_event_interruptible() and
+ * wait_event_interruptible_timeout(), originally defined in <linux/wait=
.h>
+ */
+
+#define wait_event_freezable(wq, condition)				\
+({									\
+	int __ret;							\
+	do {								\
+		__ret =3D wait_event_interruptible(wq, 			\
+				(condition) || freezing(current));	\
+		try_to_freeze();					\
+	} while (!(condition));					\
+	__ret;								\
+})
+
+
+#define wait_event_freezable_timeout(wq, condition, timeout)		\
+({									\
+	long __ret =3D timeout;						\
+	do {								\
+		__ret =3D wait_event_interruptible_timeout(wq,		\
+				(condition) || freezing(current),	\
+				__ret); 				\
+		try_to_freeze();					\
+	} while (!(condition));					\
+	__ret;								\
+})
+#else /* CONFIG_PM */
 static inline int frozen(struct task_struct *p) { return 0; }
 static inline int freezing(struct task_struct *p) { return 0; }
 static inline void set_freeze_flag(struct task_struct *p) {}
@@ -143,6 +172,13 @@ static inline void freezer_do_not_count(
 static inline void freezer_count(void) {}
 static inline int freezer_should_skip(struct task_struct *p) { return 0;=
 }
 static inline void set_freezable(void) {}
-#endif
+
+#define wait_event_freezable(wq, condition)				\
+		wait_event_interruptible(wq, condition)
+
+#define wait_event_freezable_timeout(wq, condition, timeout)		\
+		wait_event_interruptible_timeout(wq, condition, timeout)
+
+#endif /* CONFIG_PM */
=20
 #endif	/* FREEZER_H_INCLUDED */
Index: linux-2.6.22-rc6-mm1/drivers/input/gameport/gameport.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/drivers/input/gameport/gameport.c	2007-07-1=
1 20:48:04.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/input/gameport/gameport.c	2007-07-11 20:=
51:14.000000000 +0200
@@ -448,9 +448,8 @@ static int gameport_thread(void *nothing
 	set_freezable();
 	do {
 		gameport_handle_event();
-		wait_event_interruptible(gameport_wait,
+		wait_event_freezable(gameport_wait,
 			kthread_should_stop() || !list_empty(&gameport_event_list));
-		try_to_freeze();
 	} while (!kthread_should_stop());
=20
 	printk(KERN_DEBUG "gameport: kgameportd exiting\n");
Index: linux-2.6.22-rc6-mm1/drivers/input/serio/serio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/drivers/input/serio/serio.c	2007-07-11 20:4=
8:04.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/input/serio/serio.c	2007-07-11 20:51:14.=
000000000 +0200
@@ -387,9 +387,8 @@ static int serio_thread(void *nothing)
 	set_freezable();
 	do {
 		serio_handle_event();
-		wait_event_interruptible(serio_wait,
+		wait_event_freezable(serio_wait,
 			kthread_should_stop() || !list_empty(&serio_event_list));
-		try_to_freeze();
 	} while (!kthread_should_stop());
=20
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
Index: linux-2.6.22-rc6-mm1/drivers/input/touchscreen/ucb1400_ts.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/drivers/input/touchscreen/ucb1400_ts.c	2007=
-07-11 20:48:04.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/input/touchscreen/ucb1400_ts.c	2007-07-1=
1 20:51:14.000000000 +0200
@@ -334,10 +334,9 @@ static int ucb1400_ts_thread(void *_ucb)
 			timeout =3D msecs_to_jiffies(10);
 		}
=20
-		wait_event_interruptible_timeout(ucb->ts_wait,
+		wait_event_freezable_timeout(ucb->ts_wait,
 			ucb->irq_pending || ucb->ts_restart || kthread_should_stop(),
 			timeout);
-		try_to_freeze();
 	}
=20
 	/* Send the "pen off" if we are stopping with the pen still active */
Index: linux-2.6.22-rc6-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2=
007-07-11 20:48:04.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c	2007-0=
7-11 20:51:14.000000000 +0200
@@ -528,7 +528,8 @@ static int dvb_frontend_thread(void *dat
 		up(&fepriv->sem);	    /* is locked when we enter the thread... */
 restart:
 		timeout =3D wait_event_interruptible_timeout(fepriv->wait_queue,
-			dvb_frontend_should_wakeup(fe) || kthread_should_stop(),
+			dvb_frontend_should_wakeup(fe) || kthread_should_stop()
+				|| freezing(current),
 			fepriv->delay);
=20
 		if (kthread_should_stop() || dvb_frontend_is_exiting(fe)) {
Index: linux-2.6.22-rc6-mm1/drivers/usb/core/hub.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/drivers/usb/core/hub.c	2007-07-11 20:48:04.=
000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/usb/core/hub.c	2007-07-11 20:51:14.00000=
0000 +0200
@@ -2729,10 +2729,9 @@ static int hub_thread(void *__unused)
 	set_freezable();
 	do {
 		hub_events();
-		wait_event_interruptible(khubd_wait,
+		wait_event_freezable(khubd_wait,
 				!list_empty(&hub_event_list) ||
 				kthread_should_stop());
-		try_to_freeze();
 	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
=20
 	pr_debug("%s: khubd exiting\n", usbcore_name);
Index: linux-2.6.22-rc6-mm1/drivers/usb/storage/usb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/drivers/usb/storage/usb.c	2007-07-11 20:48:=
04.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/usb/storage/usb.c	2007-07-11 20:51:14.00=
0000000 +0200
@@ -913,12 +913,9 @@ static int usb_stor_scan_thread(void * _
 	if (delay_use > 0) {
 		printk(KERN_DEBUG "usb-storage: waiting for device "
 				"to settle before scanning\n");
-retry:
-		wait_event_interruptible_timeout(us->delay_wait,
+		wait_event_freezable_timeout(us->delay_wait,
 				test_bit(US_FLIDX_DISCONNECTING, &us->flags),
 				delay_use * HZ);
-		if (try_to_freeze())
-			goto retry;
 	}
=20
 	/* If the device is still connected, perform the scanning */
