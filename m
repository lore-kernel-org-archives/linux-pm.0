From: Adam Belay <abelay@novell.com>
Subject: [RFC] power trees
Date: Thu, 11 Aug 2005 04:50:41 +0000
Message-ID: <1123735844.4380.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81087996382987493=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============81087996382987493==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,

I've been experimenting with a power object tree for handling power
state dependencies.  Many major bus specifications fit well in a
power-state based model.  They include PCI/Cardbus, ACPI, IDE, and
probably even USB.  More complex dependencies generally rely on out of
tree elements (e.g. power planes, clocks, processor states, etc.) or are
isolated to a specific parent and its child.  Therefore, I think a power
tree would be useful for a wide range of device drivers.  Nonetheless,
the power tree is provided as an optional library only.

My implementation has two primary goals:

1.) To help device drivers track and control their device's power state

2.) To bubble power state dependency changes from a leaf node to the
last affected parent node in the chain.

The basic unit of the tree is referred to as a "pm_node".  Each
"pm_node" has a list of states it supports, a current state, and a
driver to handle state transitions.  Any "pm_node" can have children and
therefore act as a power container.

struct pm_state {
	char			*name;
	unsigned long		index;
	unsigned long		link_req;
	void			*link_data;
};

"index" is a driver specific value that indicates the state.  "link_req"
is a set of flags that indicate requirements from the parent "pm_node".
"link_data" provides additional requirement information.

struct pm_node {
	struct semaphore	sem;
	struct list_head	children;
	struct list_head	child_list;
	struct pm_node		*parent;
	struct pm_node		*tmp_path;
	struct device		*dev;

	struct pm_node_driver	*drv;
	unsigned int		current_state;
	unsigned int		target_state;

	unsigned int		num_states;
	struct pm_state		*states;
};

"states" is a list of power states sorted from most functional to least
functional.  "current_state" and "target_state" are index values for
that list.

struct pm_node_driver {
	int (*set_state) 	(struct pm_node *node);
	int (*raise_event)	(struct pm_node *domain,
				 struct pm_node *child,
				 unsigned long *new_state);
	void (*lower_event)	(struct pm_node *domain);
};

"raise_event" notifies the power domain when a child has increased its
state.  "new_state" allows for a domain to pass an index of the new
state it would need in response to the new requirements.  "lower_event"
is called when power is decreased.  It is expected to return immediately
and defer any power transitions for later (generally with a timeout
value).

I apologize for the unpolished/untested state of the code as it's
primarily intended to illustrate a concept.  I'll need to look over the
problem more carefully if we decide this is the right direction.  Power
dependency notifications are entirely iterative in this implementation.
Locking is always from leaf nodes down.  The "iterative" requirement
seems to be a little inflexible with notifications, so we may want to
start with a recursive algorithm if this proves to be too difficult.
Are there any known cases of deep power trees?  I look forward to any
comments or suggestions.

Thanks,
Adam

--- a/drivers/base/power/Makefile	2005-06-17 19:48:29.000000000 +0000
+++ b/drivers/base/power/Makefile	2005-08-09 15:52:50.000000000 +0000
@@ -1,5 +1,5 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
+obj-$(CONFIG_PM)	+= main.o node.o suspend.o resume.o runtime.o sysfs.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
--- a/drivers/base/power/node.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/power/node.c	2005-08-11 03:46:46.000000000 +0000
@@ -0,0 +1,188 @@
+/*
+ * drivers/base/power/node.c - power node registration and control
+ *
+ * This file is released under the GPLv2
+ */
+
+#include <linux/config.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include "power.h"
+
+
+/*
+ * Registration
+ */
+
+/**
+ * pm_register_node - registers a power management node with the driver core
+ * @node - the node
+ */
+int pm_register_node(struct pm_node *node)
+{
+	if (!node->drv || !node->current_state)
+		return -EINVAL;
+
+	init_MUTEX(&node->sem);
+	INIT_LIST_HEAD(&node->children);
+
+	if (node->parent) {
+		down(&node->parent->sem);
+		list_add_tail(&node->child_list, &node->parent->children);
+		up(&node->parent->sem);
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(pm_register_node);
+
+/**
+ * pm_unregister_node - removes a power management node from the driver core
+ * @node - the node
+ */
+void pm_unregister_node(struct pm_node *node)
+{
+	if (node->parent) {
+		down(&node->parent->sem);
+		list_del(&node->child_list);
+		up(&node->parent->sem);
+	}
+}
+
+EXPORT_SYMBOL_GPL(pm_unregister_node);
+
+
+/*
+ * Power State Control
+ */
+
+static int pm_set_target(struct pm_node *node, unsigned long state_index)
+{
+	int i;
+
+	for (i = 0; i < node->num_states; i++) {
+		struct pm_state *s = &node->states[i];
+		if (s->index == state_index) {
+			node->target_state = i;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static void pm_recover_nodes(struct pm_node *bottom)
+{
+	struct pm_node *next, *pos = bottom;
+
+	while (pos->tmp_path) {
+		next = pos->tmp_path;
+		pos->tmp_path = NULL;
+		pos->target_state = pos->current_state;
+		up(&pos->sem);
+		pos = next;
+	}
+}
+
+static int pm_raise_nodes(struct pm_node *node)
+{
+	int ret;
+	unsigned long state_index;
+	struct pm_node *prev = node;
+	struct pm_node *pos = node->parent;
+
+	for (;;) {
+		down(&pos->sem);
+		pos->tmp_path = prev;
+
+		ret = pos->drv->raise_event(pos, prev, &state_index);
+		if (ret)
+			goto fail;
+		
+		pm_set_target(pos, state_index);
+
+		if (pos->current_state == pos->target_state) {
+			pos = prev;
+			break;
+		}
+
+		if (!pos->parent)
+			break;
+
+		prev = pos;
+		pos = pos->parent;
+	}
+
+	while (pos) {
+		ret = node->drv->set_state(node);
+		if (ret)
+			goto fail;
+
+		if (pos->parent) {
+			pos->parent->tmp_path = NULL;
+			up(&pos->parent->sem);
+		}
+
+		pos = pos->tmp_path;
+	}
+
+	return 0;
+
+fail:
+	pm_recover_nodes(pos);
+	return ret;
+}
+
+static int pm_lower_nodes(struct pm_node *node)
+{
+	int ret;
+	struct pm_node *pos = node->parent;
+
+	ret = node->drv->set_state(node);
+	if (ret)
+		return ret;
+
+	down(&pos->sem);
+	pos->drv->lower_event(pos);
+	up(&pos->sem);
+
+	return 0;
+}
+ 
+/**
+ * pm_set_state - sets the power state of a pm_node
+ * @node - the node
+ * @state - the index value of the target power state
+ */
+int pm_set_state(struct pm_node *node, unsigned long state)
+{
+	int ret;
+
+	down(&node->sem);
+
+	if (!pm_set_target(node, state)) {
+		up(&node->sem);
+		return -EINVAL;
+	}
+	
+	if (node->target_state == node->current_state) {
+		up(&node->sem);
+		return 0;
+	}
+
+	if (!node->parent)
+		ret = node->drv->set_state(node);
+	else if (node->target_state > node->current_state) 
+		ret = pm_raise_nodes(node);
+	else
+		ret = pm_lower_nodes(node);
+
+	up(&node->sem);
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(pm_set_state);
--- a/include/linux/pm.h	2005-08-09 17:49:51.000000000 +0000
+++ b/include/linux/pm.h	2005-08-11 03:16:13.000000000 +0000
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/list.h>
 #include <asm/atomic.h>
+#include <asm/semaphore.h>
 
 #include <linux/pm_legacy.h>
 
@@ -108,6 +109,58 @@
 }
 #endif
 
+
+/*
+ * Power Nodes
+ */
+
+struct pm_state {
+	char			*name;
+	unsigned long		index;
+	unsigned long		link_req;
+	void			*link_data;
+};
+
+struct pm_node;
+
+struct pm_node_driver {
+	int (*set_state) 	(struct pm_node *node);
+	int (*raise_event)	(struct pm_node *domain,
+				 struct pm_node *child,
+				 unsigned long *new_state);
+	void (*lower_event)	(struct pm_node *domain);
+};
+
+struct pm_node {
+	struct semaphore	sem;
+	struct list_head	children;
+	struct list_head	child_list;
+	struct pm_node		*parent;
+	struct pm_node		*tmp_path;
+	struct device		*dev;
+
+	struct pm_node_driver	*drv;
+	unsigned int		current_state;
+	unsigned int		target_state;
+
+	unsigned int		num_states;
+	struct pm_state		*states;
+};
+
+static inline struct pm_state * __pm_get_state(struct pm_node *node)
+{
+	return &node->states[node->current_state];
+}
+
+static inline struct pm_state * __pm_get_target_state(struct pm_node *node)
+{
+	return &node->states[node->target_state];
+}
+
+extern int pm_register_node(struct pm_node *node);
+extern void pm_unregister_node(struct pm_node *node);
+extern int pm_set_state(struct pm_node *node, unsigned long state);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PM_H */





--===============81087996382987493==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81087996382987493==--
