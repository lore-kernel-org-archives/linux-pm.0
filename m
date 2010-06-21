From: mark gross <640e9920@gmail.com>
Subject: [RFC] adding pm_qos trace support "patch" discussion
Date: Sun, 20 Jun 2010 21:44:48 -0700
Message-ID: <20100621044448.GD9735@gvim.org>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: swetland@google.com, tglx@linutronix.de, James.Bottomley@suse.de
List-Id: linux-pm@vger.kernel.org

The following is a start on a patch for turning on some basic debug
state dumping support for PM_QOS.  It feels week to me and I would like
some discussion and ideas on what to trace, that I could use to make it
better.

FWIW I did look closely at the statitsics gathering in the android wake
lock patches used by android.  But most of that tracing support was
around timer and time out tracing.  As pm_qos doesn't have fire and
forget time-out requests most of that debug support doesn't really
apply.

Also, I think looking into using f-trace somehow.  I think it may have a
natural fit but, any advice would be very much welcome.

Attached is a starter patch, it compiles but has not been booted.

I'm posting it early to get feed back and ideas for state, stats and
tracing that could be helpful.

The user mode tracing ABI is to read from the misc device for the
particular pm_qos request class of intrest to get a dump of all the
requests currently in the list.

I think its not a very good design, but can't think of more that
cosmetic changes to make it better.  I'm also on the fence for making
the tracing part of the API and not a compile time switch.  Using the
wake lock /proc interface I have found to be *realy* helpful in getting
the android power mangement to start working on the moorestown and can't
think of a good reason to turn it off at the moment.  As the application
of pm_qos is expected to evolve to include android suspend blocking
it may make sence to have some debug tracing just there all the time.

Note: this patch applies to James Bottomly's plist version of pm_qos we
are working on to provide equivelent (well mostly) infrastructure to
implement suspend blockers on top of pm_qos with.

Design comments and advice welcome!

--mgross

signed-off-by : mark gross <markgross@thegnar.org>


>From b9b135f39afca8f64e67e1babe4f93f45f81e891 Mon Sep 17 00:00:00 2001
From: markgross <markgross@thegnar.org>
Date: Sat, 19 Jun 2010 20:48:27 -0700
Subject: [PATCH] add pq_qos_trace support for getting the current collection of pm_qos
 requests from the plists and dumping out via a read function for the
 misc device that is used by user mode to register its requests.

---
 include/linux/pm_qos_params.h |   10 ++++-
 kernel/pm_qos_params.c        |   74 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
index d823cc0..51fafdb 100644
--- a/include/linux/pm_qos_params.h
+++ b/include/linux/pm_qos_params.h
@@ -15,13 +15,19 @@
 
 #define PM_QOS_NUM_CLASSES 4
 #define PM_QOS_DEFAULT_VALUE -1
-
+#define PM_QOS_TRACING
 struct pm_qos_request_list {
 	struct plist_node list;
 	int pm_qos_class;
+#ifdef PM_QOS_TRACING
+	#define ID_LEN 64
+	char requester[ID_LEN];
+	struct timespec lastupdate;
+#endif
 };
 
-void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class, s32 value);
+void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class,
+		s32 value);
 void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
 		s32 new_value);
 void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index 4bded27..41a8335 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -103,11 +103,14 @@ static DEFINE_SPINLOCK(pm_qos_lock);
 
 static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos);
+static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
+	size_t count, loff_t *f_pos);
 static int pm_qos_power_open(struct inode *inode, struct file *filp);
 static int pm_qos_power_release(struct inode *inode, struct file *filp);
 
 static const struct file_operations pm_qos_power_fops = {
 	.write = pm_qos_power_write,
+	.read = pm_qos_power_read,
 	.open = pm_qos_power_open,
 	.release = pm_qos_power_release,
 };
@@ -125,8 +128,13 @@ static inline int pm_qos_get_value(struct pm_qos_object *o)
 	case PM_QOS_MAX:
 		return plist_first(&o->requests)->prio;
 	}
+
+	return -1; /* quite the compiler warnings */
 }
 
+#define DELETE 1
+#define ADD 0
+
 static void update_target(struct pm_qos_object *o, struct plist_node *node,
 			  int del)
 {
@@ -218,9 +226,12 @@ void pm_qos_add_request(struct pm_qos_request_list *dep,
 		new_value = o->default_value;
 	else
 		new_value = value;
+#ifdef PM_QOS_TRACING
+	getnstimeofday(&dep->lastupdate);
+#endif
 	plist_node_init(&dep->list, new_value);
 	dep->pm_qos_class = pm_qos_class;
-	update_target(o, &dep->list, 0);
+	update_target(o, &dep->list, ADD);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_request);
 
@@ -264,8 +275,13 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
 		plist_node_init(&pm_qos_req->list, temp);
 		spin_unlock_irqrestore(&pm_qos_lock, flags);
 	}
+
+#ifdef PM_QOS_TRACING
+	getnstimeofday(&pm_qos_req->lastupdate);
+#endif
+
 	if (pending_update)
-		update_target(o, &pm_qos_req->list, 0);
+		update_target(o, &pm_qos_req->list, ADD);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
@@ -291,7 +307,7 @@ void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
 	}
 
 	o = pm_qos_array[pm_qos_req->pm_qos_class];
-	update_target(o, &pm_qos_req->list, 1);
+	update_target(o, &pm_qos_req->list, DELETE);
 	memset(pm_qos_req, 0, sizeof(*pm_qos_req));
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_request);
@@ -343,7 +359,9 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
 		struct pm_qos_request_list *req = kzalloc(GFP_KERNEL, sizeof(*req));
 		if (!req)
 			return -ENOMEM;
-
+#ifdef PM_QOS_TRACING
+		snprintf(req->requester, ID_LEN, "%d", current->pid);
+#endif
 		pm_qos_add_request(req, pm_qos_class, PM_QOS_DEFAULT_VALUE);
 		filp->private_data = req;
 
@@ -393,6 +411,54 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 }
 
 
+#define LOCAL_LEN (4*1024)
+static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
+	size_t count, loff_t *f_pos)
+{
+	struct pm_qos_object *o;
+	struct pm_qos_request_list *req, *x;
+	unsigned long flags;
+	char *temp, *localbuf;
+
+	if (f_pos) /* get all the data in one read for it to be valid */
+		return 0;
+
+	temp = localbuf = kmalloc(GFP_KERNEL, LOCAL_LEN);
+	if(!localbuf)
+		return -ENOMEM;
+
+	req = (struct pm_qos_request_list *)filp->private_data;
+	o = pm_qos_array[req->pm_qos_class];
+
+	spin_lock_irqsave(&pm_qos_lock, flags);
+	plist_for_each_entry(x, &o->requests, list) {
+#ifdef PM_QOS_TRACING
+		if (LOCAL_LEN < (temp-localbuf))
+			continue;
+		temp += snprintf(temp, LOCAL_LEN - (temp-localbuf), "%s\t",
+				x->requester);
+		if (LOCAL_LEN < (temp-localbuf))
+			continue;
+		temp += snprintf(temp, LOCAL_LEN - (temp-localbuf), "%ld\t%lu\t",
+				x->lastupdate.tv_sec, x->lastupdate.tv_nsec);
+		if (LOCAL_LEN < (temp-localbuf))
+			continue;
+#endif
+		temp += snprintf(temp, LOCAL_LEN - (temp-localbuf),
+				"%d\n", x->list.prio);
+		if (LOCAL_LEN < (temp-localbuf))
+			continue;
+	}
+	spin_unlock_irqrestore(&pm_qos_lock, flags);
+
+	if (copy_to_user(buf, localbuf, min((int) count, LOCAL_LEN))) {
+		kfree(localbuf);
+		return -EFAULT;
+	}
+	return (temp - localbuf);
+}
+
+
 static int __init pm_qos_power_init(void)
 {
 	int ret = 0;
-- 
1.6.3.3
