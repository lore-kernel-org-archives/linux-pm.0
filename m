From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [workqueue/driver-core PATCH 2/5] async: Add support for queueing
 on specific NUMA node
Date: Fri, 05 Oct 2018 11:34:12 -0700
Message-ID: <20181005183412.8790.98606.stgit@localhost.localdomain>
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005183239.8790.28631.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, alexander.h.duyck@linux.intel.com
List-Id: linux-pm@vger.kernel.org

This patch introduces four new variants of the async_schedule_ functions
that allow scheduling on a specific NUMA node.

The first two functions are async_schedule_near and
async_schedule_near_domain which end up mapping to async_schedule and
async_schedule_domain but provide NUMA node specific functionality. They
replace the original functions which were moved to inline function
definitions that call the new functions while passing NUMA_NO_NODE.

The second two functions are async_schedule_dev and
async_schedule_dev_domain which provide NUMA specific functionality when
passing a device as the data member and that device has a NUMA node other
than NUMA_NO_NODE.

The main motivation behind this is to address the need to be able to
schedule device specific init work on specific NUMA nodes in order to
improve performance of memory initialization.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/async.h |   36 +++++++++++++++++++++++++++++++++---
 kernel/async.c        |   47 ++++++++++++++++++++++-------------------------
 2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/include/linux/async.h b/include/linux/async.h
index 6b0226bdaadc..1f6cb0d50263 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -14,6 +14,8 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/numa.h>
+#include <linux/device.h>
 
 typedef u64 async_cookie_t;
 typedef void (*async_func_t) (void *data, async_cookie_t cookie);
@@ -37,9 +39,37 @@ struct async_domain {
 	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
 				      .registered = 0 }
 
-extern async_cookie_t async_schedule(async_func_t func, void *data);
-extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
-					    struct async_domain *domain);
+async_cookie_t async_schedule_near(async_func_t func, void *data,
+				   int node);
+async_cookie_t async_schedule_near_domain(async_func_t func, void *data,
+					  int node,
+					  struct async_domain *domain);
+
+static inline async_cookie_t async_schedule(async_func_t func, void *data)
+{
+	return async_schedule_near(func, data, NUMA_NO_NODE);
+}
+
+static inline async_cookie_t
+async_schedule_domain(async_func_t func, void *data,
+		      struct async_domain *domain)
+{
+	return async_schedule_near_domain(func, data, NUMA_NO_NODE, domain);
+}
+
+static inline async_cookie_t
+async_schedule_dev(async_func_t func, struct device *dev)
+{
+	return async_schedule_near(func, dev, dev_to_node(dev));
+}
+
+static inline async_cookie_t
+async_schedule_dev_domain(async_func_t func, struct device *dev,
+			  struct async_domain *domain)
+{
+	return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
+}
+
 void async_unregister_domain(struct async_domain *domain);
 extern void async_synchronize_full(void);
 extern void async_synchronize_full_domain(struct async_domain *domain);
diff --git a/kernel/async.c b/kernel/async.c
index a893d6170944..f53d970ffdf4 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -149,7 +149,21 @@ static void async_run_entry_fn(struct work_struct *work)
 	wake_up(&async_done);
 }
 
-static async_cookie_t __async_schedule(async_func_t func, void *data, struct async_domain *domain)
+/**
+ * async_schedule_near_domain - schedule a function for asynchronous execution within a certain domain
+ * @func: function to execute asynchronously
+ * @data: data pointer to pass to the function
+ * @node: NUMA node that we want to schedule this on or close to
+ * @domain: the domain
+ *
+ * Returns an async_cookie_t that may be used for checkpointing later.
+ * @domain may be used in the async_synchronize_*_domain() functions to
+ * wait within a certain synchronization domain rather than globally.  A
+ * synchronization domain is specified via @domain.  Note: This function
+ * may be called from atomic or non-atomic contexts.
+ */
+async_cookie_t async_schedule_near_domain(async_func_t func, void *data,
+					  int node, struct async_domain *domain)
 {
 	struct async_entry *entry;
 	unsigned long flags;
@@ -195,43 +209,26 @@ static async_cookie_t __async_schedule(async_func_t func, void *data, struct asy
 	current->flags |= PF_USED_ASYNC;
 
 	/* schedule for execution */
-	queue_work(system_unbound_wq, &entry->work);
+	queue_work_near(node, system_unbound_wq, &entry->work);
 
 	return newcookie;
 }
+EXPORT_SYMBOL_GPL(async_schedule_near_domain);
 
 /**
- * async_schedule - schedule a function for asynchronous execution
+ * async_schedule_near - schedule a function for asynchronous execution
  * @func: function to execute asynchronously
  * @data: data pointer to pass to the function
+ * @node: NUMA node that we want to schedule this on or close to
  *
  * Returns an async_cookie_t that may be used for checkpointing later.
  * Note: This function may be called from atomic or non-atomic contexts.
  */
-async_cookie_t async_schedule(async_func_t func, void *data)
-{
-	return __async_schedule(func, data, &async_dfl_domain);
-}
-EXPORT_SYMBOL_GPL(async_schedule);
-
-/**
- * async_schedule_domain - schedule a function for asynchronous execution within a certain domain
- * @func: function to execute asynchronously
- * @data: data pointer to pass to the function
- * @domain: the domain
- *
- * Returns an async_cookie_t that may be used for checkpointing later.
- * @domain may be used in the async_synchronize_*_domain() functions to
- * wait within a certain synchronization domain rather than globally.  A
- * synchronization domain is specified via @domain.  Note: This function
- * may be called from atomic or non-atomic contexts.
- */
-async_cookie_t async_schedule_domain(async_func_t func, void *data,
-				     struct async_domain *domain)
+async_cookie_t async_schedule_near(async_func_t func, void *data, int node)
 {
-	return __async_schedule(func, data, domain);
+	return async_schedule_near_domain(func, data, node, &async_dfl_domain);
 }
-EXPORT_SYMBOL_GPL(async_schedule_domain);
+EXPORT_SYMBOL_GPL(async_schedule_near);
 
 /**
  * async_synchronize_full - synchronize all asynchronous function calls
