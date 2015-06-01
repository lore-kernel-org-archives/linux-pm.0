From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/8] klist: implement klist_prev()
Date: Mon,  1 Jun 2015 17:47:58 +0300
Message-ID: <1433170082-117462-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

klist_prev() gets the previous element in the list. It is useful to traverse
through the list in reverse order, for example, to provide LIFO (last in first
out) variant of access.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/klist.h |  1 +
 lib/klist.c           | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/klist.h b/include/linux/klist.h
index 61e5b72..953f283 100644
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -63,6 +63,7 @@ extern void klist_iter_init(struct klist *k, struct klist_iter *i);
 extern void klist_iter_init_node(struct klist *k, struct klist_iter *i,
 				 struct klist_node *n);
 extern void klist_iter_exit(struct klist_iter *i);
+extern struct klist_node *klist_prev(struct klist_iter *i);
 extern struct klist_node *klist_next(struct klist_iter *i);
 
 #endif
diff --git a/lib/klist.c b/lib/klist.c
index 89b485a..d74cf7a 100644
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -324,6 +324,47 @@ static struct klist_node *to_klist_node(struct list_head *n)
 }
 
 /**
+ * klist_prev - Ante up prev node in list.
+ * @i: Iterator structure.
+ *
+ * First grab list lock. Decrement the reference count of the previous
+ * node, if there was one. Grab the prev node, increment its reference
+ * count, drop the lock, and return that prev node.
+ */
+struct klist_node *klist_prev(struct klist_iter *i)
+{
+	void (*put)(struct klist_node *) = i->i_klist->put;
+	struct klist_node *last = i->i_cur;
+	struct klist_node *prev;
+
+	spin_lock(&i->i_klist->k_lock);
+
+	if (last) {
+		prev = to_klist_node(last->n_node.prev);
+		if (!klist_dec_and_del(last))
+			put = NULL;
+	} else
+		prev = to_klist_node(i->i_klist->k_list.prev);
+
+	i->i_cur = NULL;
+	while (prev != to_klist_node(&i->i_klist->k_list)) {
+		if (likely(!knode_dead(prev))) {
+			kref_get(&prev->n_ref);
+			i->i_cur = prev;
+			break;
+		}
+		prev = to_klist_node(prev->n_node.prev);
+	}
+
+	spin_unlock(&i->i_klist->k_lock);
+
+	if (put && last)
+		put(last);
+	return i->i_cur;
+}
+EXPORT_SYMBOL_GPL(klist_prev);
+
+/**
  * klist_next - Ante up next node in list.
  * @i: Iterator structure.
  *
-- 
2.1.4
