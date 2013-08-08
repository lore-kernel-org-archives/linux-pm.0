From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC v02 2/5] PowerCap: Add class driver
Date: Thu,  8 Aug 2013 08:23:47 -0700
Message-ID: <1375975430-9202-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1375975430-9202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40656 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965931Ab3HHPZR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Aug 2013 11:25:17 -0400
In-Reply-To: <1375975430-9202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>

Added power cap class driver, which provides an API for client drivers
to use and provide a consistant sysfs interface to user mode.
=46or details on API refer to PowerCappingFramework.txt under
Documentation/powercap.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/powercap/Kconfig        |  16 +
 drivers/powercap/Makefile       |   5 +
 drivers/powercap/powercap_sys.c | 995 ++++++++++++++++++++++++++++++++=
++++++++
 include/linux/powercap.h        | 300 ++++++++++++
 4 files changed, 1316 insertions(+)
 create mode 100644 drivers/powercap/Kconfig
 create mode 100644 drivers/powercap/Makefile
 create mode 100644 drivers/powercap/powercap_sys.c
 create mode 100644 include/linux/powercap.h

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
new file mode 100644
index 0000000..f70b7b9
--- /dev/null
+++ b/drivers/powercap/Kconfig
@@ -0,0 +1,16 @@
+#
+# Generic powercap sysfs drivers configuration
+#
+
+menuconfig POWERCAP_SUPPORT
+	tristate "Generic powercap sysfs driver"
+	help
+	  A Power Capping Sysfs driver offers a generic mechanism for
+	  power capping. Usually it's made up of one or more controllers,
+	  power zones and constraints.
+	  If you want this support, you should say Y or M here.
+
+if POWERCAP_SUPPORT
+# Add client driver config here.
+
+endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
new file mode 100644
index 0000000..f2acfed
--- /dev/null
+++ b/drivers/powercap/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for powercap drivers
+#
+
+obj-$(CONFIG_POWERCAP_SUPPORT)	+=3D powercap_sys.o
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powerca=
p_sys.c
new file mode 100644
index 0000000..c15c8d4
--- /dev/null
+++ b/drivers/powercap/powercap_sys.c
@@ -0,0 +1,995 @@
+/*
+ * powercap sysfs class driver
+ * Copyright (c) 2013, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITH=
OUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License a=
long with
+ * this program; if not, write to the Free Software Foundation, Inc.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/powercap.h>
+
+#define POWERCAP_CONSTRAINT_NAME_LEN		20
+#define POWERCAP_ZONE_CONSTRAINT_DEV_NAME_LEN	30
+
+/**
+ * struct powercap_zone_node- Defines a node containing power zones
+ * @next:		Pointer to sibling
+ * @children_count:	Number of children for this node
+ * @child:		Pointer to first child
+ * @parent:		Pointer to the parent
+ * @pcd_dev:		pointer to power zone device in this node
+ *
+ * A power zone node to be part of a tree.
+ */
+struct powercap_zone_node {
+	struct powercap_zone_node *next;
+	int children_count;
+	struct powercap_zone_node *child;
+	struct powercap_zone_node *parent;
+	struct powercap_zone_device *pcd_dev;
+};
+
+/**
+ * struct powercap_zone_constraint_attrs - Define constraint attribute
+ * @name:		Constraint attribute name.
+ * @attr:		Device attribute
+ *
+ * Define each attribute, with a name, based on the constraint id.
+ */
+struct powercap_constraint_attr {
+	char name[POWERCAP_ZONE_CONSTRAINT_DEV_NAME_LEN + 1];
+	struct device_attribute attr;
+};
+
+/**
+ * struct powercap_zone_constraint- Defines instance of a constraint
+ * @id:			Instance Id of this constraint.
+ * @pcd_dev:		Pointer to the power zone for this constraint.
+ * @ops:		Pointer to the constraint callbacks.
+ * @priv_data:		Constaint private data
+ * @list:		Link to other constraints for this power zone.
+ *
+ * This defines a constraint instance.
+ */
+struct powercap_zone_constraint {
+	int id;
+	struct powercap_zone_device *pcd_dev;
+	struct powercap_zone_constraint_ops *ops;
+	struct powercap_constraint_attr power_limit_attr;
+	struct powercap_constraint_attr time_window_attr;
+	struct powercap_constraint_attr max_power_attr;
+	struct powercap_constraint_attr min_power_attr;
+	struct powercap_constraint_attr max_time_window_attr;
+	struct powercap_constraint_attr min_time_window_attr;
+	struct powercap_constraint_attr name_attr;
+	struct list_head list;
+};
+
+/* A list of powercap controllers */
+static LIST_HEAD(powercap_cntrl_list);
+/* Mutex to protect list of powercap controllers */
+static DEFINE_MUTEX(powercap_cntrl_list_lock);
+
+/*
+ * Power Zone attributes: Each power zone registered with this framewo=
rk
+ * contains two types of attributes:
+ * One with fixed name: E.g. energy_uj
+ * One with variable name: E.g. constraint_0_power_limit_uw
+ * Using two attribute groups, which will be used during device_regist=
er.
+ * The fixed name attributes are using static DEVICE_ATTR.
+ * For variable name device_attribute fields are initialized by assign=
ing
+ * name (constraint_X_power_limit_uw, here X can be 0 to max integer).
+ */
+
+/* Power zone ro attributes define */
+#define powercap_attr_ro(_name)		\
+	static DEVICE_ATTR(_name, 0444, show_##_name, NULL)
+
+/* Power zone rw attributes define */
+#define powercap_attr_rw(_name)		\
+	static DEVICE_ATTR(_name, 0644, show_##_name, store_##_name)
+
+/* constraint attributes define rw */
+#define powercap_const_attr_rw(_name)		\
+	static DEVICE_ATTR(_name, 0644, show_constraint_##_name, \
+				store_constraint_##_name)
+/* constraint attributes define ro */
+#define powercap_const_attr_ro(_name)		\
+	static DEVICE_ATTR(_name, 0644, show_constraint_##_name, NULL)
+
+/* Power zone show function */
+#define define_device_show(_attr)		\
+static ssize_t show_##_attr(struct device *dev, \
+					struct device_attribute *dev_attr,\
+					char *buf) \
+{ \
+	u64 value; \
+	ssize_t len =3D -EINVAL; \
+	struct powercap_zone_device *pcd_dev =3D dev_get_drvdata(dev); \
+	\
+	if (pcd_dev && pcd_dev->ops && pcd_dev->ops->get_##_attr) { \
+		mutex_lock(&pcd_dev->lock); \
+		if (!pcd_dev->ops->get_##_attr(pcd_dev, &value)) \
+			len =3D sprintf(buf, "%lld\n", value); \
+		mutex_unlock(&pcd_dev->lock); \
+	} \
+	\
+	return len; \
+}
+
+/* Power zone store function; only reset is possible */
+#define define_device_store(_attr)		\
+static ssize_t store_##_attr(struct device *dev,\
+				struct device_attribute *dev_attr, \
+				const char *buf, size_t count) \
+{ \
+	int err; \
+	struct powercap_zone_device *pcd_dev =3D dev_get_drvdata(dev); \
+	u64 value; \
+	\
+	err =3D kstrtoull(buf, 10, &value); \
+	if (err) \
+		return -EINVAL; \
+	if (value) \
+		return -EINVAL; \
+	if (pcd_dev && pcd_dev->ops && pcd_dev->ops->reset_##_attr) { \
+		mutex_lock(&pcd_dev->lock); \
+		if (!pcd_dev->ops->reset_##_attr(pcd_dev)) { \
+			mutex_unlock(&pcd_dev->lock); \
+			return count; \
+		} \
+		mutex_unlock(&pcd_dev->lock); \
+	} \
+	\
+	return -EINVAL; \
+}
+
+/* Find constraint pointer from an ID */
+static struct powercap_zone_constraint *find_constraint(
+			struct powercap_zone_device *pcd_dev, int id)
+{
+	struct powercap_zone_constraint *pconst =3D NULL;
+
+	list_for_each_entry(pconst, &pcd_dev->constraint_list, list) {
+		if (pconst->id =3D=3D id) {
+			return pconst;
+			break;
+		}
+	}
+
+	return pconst;
+}
+
+/* Power zone constraint show function */
+#define define_device_constraint_show(_attr) \
+static ssize_t show_constraint_##_attr(struct device *dev, \
+				struct device_attribute *dev_attr,\
+				char *buf) \
+{ \
+	u64 value; \
+	ssize_t len =3D -ENODATA; \
+	struct powercap_zone_device *pcd_dev =3D dev_get_drvdata(dev); \
+	int id; \
+	struct powercap_zone_constraint *pconst;\
+	\
+	if (!pcd_dev) \
+		return -EINVAL; \
+	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
+		return -EINVAL; \
+	mutex_lock(&pcd_dev->lock); \
+	pconst =3D find_constraint(pcd_dev, id); \
+	if (pconst && pconst->ops && pconst->ops->get_##_attr) { \
+		if (!pconst->ops->get_##_attr(pcd_dev, id, &value)) \
+			len =3D sprintf(buf, "%lld\n", value); \
+	} \
+	mutex_unlock(&pcd_dev->lock); \
+	\
+	return len; \
+}
+
+/* Power zone constraint store function */
+#define define_device_constraint_store(_attr) \
+static ssize_t store_constraint_##_attr(struct device *dev,\
+				struct device_attribute *dev_attr, \
+				const char *buf, size_t count) \
+{ \
+	int err; \
+	u64 value; \
+	struct powercap_zone_device *pcd_dev =3D dev_get_drvdata(dev); \
+	int id; \
+	struct powercap_zone_constraint *pconst;\
+	\
+	if (!pcd_dev) \
+		return -EINVAL; \
+	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
+		return -EINVAL; \
+	err =3D kstrtoull(buf, 10, &value); \
+	if (err) \
+		return -EINVAL; \
+	mutex_lock(&pcd_dev->lock); \
+	pconst =3D find_constraint(pcd_dev, id); \
+	if (pconst && pconst->ops && pconst->ops->set_##_attr) { \
+		if (!pconst->ops->set_##_attr(pcd_dev, id, value)) { \
+			mutex_unlock(&pcd_dev->lock); \
+			return count; \
+		} \
+	} \
+	mutex_unlock(&pcd_dev->lock); \
+	\
+	return -ENODATA; \
+}
+
+/* Power zone information callbacks */
+define_device_show(power_uw);
+define_device_store(power_uw);
+define_device_show(max_power_range_uw);
+define_device_show(energy_uj);
+define_device_store(energy_uj);
+define_device_show(max_energy_range_uj);
+
+/* Power zone attributes */
+powercap_attr_ro(max_power_range_uw);
+powercap_attr_rw(power_uw);
+powercap_attr_ro(max_energy_range_uj);
+powercap_attr_rw(energy_uj);
+
+/* Power zone constraint attributes callbacks */
+define_device_constraint_show(power_limit_uw);
+define_device_constraint_store(power_limit_uw);
+define_device_constraint_show(time_window_us);
+define_device_constraint_store(time_window_us);
+define_device_constraint_show(max_power_uw);
+define_device_constraint_show(min_power_uw);
+define_device_constraint_show(max_time_window_us);
+define_device_constraint_show(min_time_window_us);
+
+static ssize_t show_constraint_name(struct device *dev,
+				struct device_attribute *dev_attr,
+				char *buf)
+{
+	const char *name;
+	struct powercap_zone_device *pcd_dev =3D dev_get_drvdata(dev);
+	int id;
+	ssize_t len =3D -ENODATA;
+	struct powercap_zone_constraint *pconst;
+
+	if (!pcd_dev)
+		return -EINVAL;
+	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id))
+		return -EINVAL;
+	mutex_lock(&pcd_dev->lock);
+	pconst =3D find_constraint(pcd_dev, id);
+	if (pconst && pconst->ops && pconst->ops->get_name) {
+		name =3D pconst->ops->get_name(pcd_dev, id);
+		if (name) {
+			snprintf(buf, POWERCAP_CONSTRAINT_NAME_LEN,
+								"%s\n", name);
+			buf[POWERCAP_CONSTRAINT_NAME_LEN] =3D '\0';
+			len =3D strlen(buf);
+		}
+	}
+	mutex_unlock(&pcd_dev->lock);
+
+	return len;
+}
+
+static void create_constraint_attribute(struct powercap_zone_constrain=
t *pconst,
+				const char *name,
+				int mode,
+				struct powercap_constraint_attr *attr,
+				ssize_t (*show)(struct device *,
+					struct device_attribute *, char *),
+				ssize_t (*store)(struct device *,
+					struct device_attribute *,
+				const char *, size_t)
+				)
+{
+	snprintf(attr->name, POWERCAP_ZONE_CONSTRAINT_DEV_NAME_LEN,
+					"constraint_%d_%s", pconst->id, name);
+	attr->name[POWERCAP_ZONE_CONSTRAINT_DEV_NAME_LEN] =3D '\0';
+	attr->attr.attr.name =3D attr->name;
+	attr->attr.attr.mode =3D mode;
+	attr->attr.show =3D show;
+	attr->attr.store =3D store;
+}
+
+/* Create a constraint attribute, if it has required call backs */
+static int create_constraints(struct powercap_zone_constraint *pconst)
+{
+	int count;
+	struct powercap_zone_device *pcd_dev;
+
+	if (!pconst->ops)
+		return -EINVAL;
+	if (!pconst->ops->get_power_limit_uw ||
+		!pconst->ops->set_power_limit_uw ||
+		!pconst->ops->get_time_window_us ||
+		!pconst->ops->set_time_window_us) {
+		return -EINVAL;
+	}
+	pcd_dev =3D pconst->pcd_dev;
+	count =3D pcd_dev->attrs.const_attr_count;
+	if (count >=3D
+		(POWERCAP_CONSTRAINTS_MAX_ATTRS - POWERCAP_CONSTRAINTS_ATTRS))
+		return -EINVAL;
+
+	create_constraint_attribute(pconst, "power_limit_uw",
+					S_IWUSR | S_IRUGO,
+					&pconst->power_limit_attr,
+					show_constraint_power_limit_uw,
+					store_constraint_power_limit_uw);
+	pcd_dev->attrs.const_dev_attrs[count++] =3D
+				&pconst->power_limit_attr.attr.attr;
+
+	create_constraint_attribute(pconst, "time_window_us",
+					S_IWUSR | S_IRUGO,
+					&pconst->time_window_attr,
+					show_constraint_time_window_us,
+					store_constraint_time_window_us);
+	pcd_dev->attrs.const_dev_attrs[count++] =3D
+				&pconst->time_window_attr.attr.attr;
+
+	if (pconst->ops->get_name) {
+		create_constraint_attribute(pconst, "name", S_IRUGO,
+				&pconst->name_attr,
+				show_constraint_name,
+				NULL);
+		pcd_dev->attrs.const_dev_attrs[count++] =3D
+				&pconst->name_attr.attr.attr;
+	}
+	if (pconst->ops->get_max_power_uw) {
+		create_constraint_attribute(pconst, "max_power_uw", S_IRUGO,
+					&pconst->max_power_attr,
+					show_constraint_max_power_uw,
+					NULL);
+		pcd_dev->attrs.const_dev_attrs[count++] =3D
+					&pconst->max_power_attr.attr.attr;
+	}
+	if (pconst->ops->get_min_power_uw) {
+		create_constraint_attribute(pconst, "min_power_uw", S_IRUGO,
+					&pconst->min_power_attr,
+					show_constraint_min_power_uw,
+					NULL);
+		pcd_dev->attrs.const_dev_attrs[count++] =3D
+					&pconst->min_power_attr.attr.attr;
+	}
+	if (pconst->ops->get_max_time_window_us) {
+		create_constraint_attribute(pconst, "max_time_window_us",
+					S_IRUGO,
+					&pconst->max_time_window_attr,
+					show_constraint_max_time_window_us,
+					NULL);
+		pcd_dev->attrs.const_dev_attrs[count++] =3D
+				&pconst->max_time_window_attr.attr.attr;
+	}
+	if (pconst->ops->get_min_time_window_us) {
+		create_constraint_attribute(pconst, "min_time_window_us",
+					S_IRUGO,
+					&pconst->min_time_window_attr,
+					show_constraint_min_time_window_us,
+					NULL);
+		pcd_dev->attrs.const_dev_attrs[count++] =3D
+				&pconst->min_time_window_attr.attr.attr;
+	}
+
+	pcd_dev->attrs.const_attr_count =3D count;
+
+	return 0;
+}
+
+struct powercap_zone_constraint *powercap_zone_add_constraint(
+				struct powercap_zone_device *pcd_dev,
+				struct powercap_zone_constraint_ops *ops)
+{
+	struct powercap_zone_constraint *pconst;
+	int result;
+
+	if (!pcd_dev)
+		return ERR_PTR(-EINVAL);
+
+	pconst =3D kzalloc(sizeof(*pconst), GFP_KERNEL);
+	if (!pconst)
+		return ERR_PTR(-ENOMEM);
+	/*
+	 * No need to hold locks as this is called when device
+	 * is not created or power zone is not in existance
+	 */
+	pconst->pcd_dev =3D pcd_dev;
+	pconst->ops =3D ops;
+	pconst->id =3D pcd_dev->const_id_cnt;
+	result =3D create_constraints(pconst);
+	if (result) {
+		kfree(pconst);
+		return ERR_PTR(result);
+	}
+	pcd_dev->const_id_cnt++;
+	list_add_tail(&pconst->list, &pcd_dev->constraint_list);
+
+	return pconst;
+}
+
+static void delete_constraints(struct powercap_zone_device *pcd_dev)
+{
+	struct powercap_zone_constraint *p, *n;
+
+	/*
+	 * No need to hold locks as this is called either when device
+	 * is not created or from device_release callback
+	 */
+	list_for_each_entry_safe(p, n, &pcd_dev->constraint_list, list) {
+		list_del(&p->list);
+		kfree(p);
+	}
+}
+
+static int create_constraint_attributes(struct powercap_zone_device *p=
cd_dev,
+				int nr_constraints,
+				struct powercap_zone_constraint_ops *const_ops)
+{
+	int i;
+	int ret =3D 0;
+
+	if (pcd_dev->attrs.attr_grp_cnt >=3D POWERCAP_MAX_ATTR_GROUPS)
+		return -ENOMEM;
+
+	for (i =3D 0; i < nr_constraints; ++i) {
+		if (!powercap_zone_add_constraint(pcd_dev, const_ops)) {
+			ret =3D -ENOMEM;
+			break;
+		}
+	}
+	if (ret) {
+		delete_constraints(pcd_dev);
+		return ret;
+	}
+	pcd_dev->attrs.const_dev_attrs[pcd_dev->attrs.const_attr_count] =3D N=
ULL;
+	pcd_dev->attrs.dev_const_attr_group.attrs =3D
+						pcd_dev->attrs.const_dev_attrs;
+	pcd_dev->attrs.dev_attr_groups[pcd_dev->attrs.attr_grp_cnt] =3D
+					&pcd_dev->attrs.dev_const_attr_group;
+
+	pcd_dev->attrs.attr_grp_cnt++;
+
+	return ret;
+}
+
+/* Allocate a node of a tree */
+static struct powercap_zone_node *create_node(
+					struct powercap_zone_device *pcd_dev)
+{
+	struct powercap_zone_node *node;
+
+	node =3D kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return NULL;
+
+	node->pcd_dev =3D pcd_dev;
+
+	return node;
+}
+
+/* Insert a node into a tree */
+static void insert_node(struct powercap_controller *ctrl,
+				struct powercap_zone_node *elem,
+				struct powercap_zone_node *parent)
+{
+	struct powercap_zone_node *node;
+
+	mutex_lock(&ctrl->node_lock);
+	if (!ctrl->root_node) {
+		ctrl->root_node =3D elem;
+		mutex_unlock(&ctrl->node_lock);
+		return;
+	}
+	if (!parent)
+		parent =3D ctrl->root_node;
+	elem->parent =3D parent;
+	if (!parent->child)
+		parent->child =3D elem;
+	else {
+		/* Not a first child */
+		node =3D parent->child;
+		while (node->next)
+			node =3D node->next;
+		node->next =3D elem;
+	}
+	parent->children_count++;
+	mutex_unlock(&ctrl->node_lock);
+}
+
+/*
+ * Delete a node, once node is deleted, its children nodes will be del=
eted.
+ * This is only deleting node, not freeing any memory for the zone.
+ * For each zone, del_callback is called, which unregister the device
+ * for the power zone. The memory is freed in the device release callb=
ack.
+ */
+static void delete_node(struct powercap_controller *ctrl,
+			struct powercap_zone_node *node,
+			void (*del_callback)(struct powercap_zone_device *))
+{
+	struct powercap_zone_node *node_store;
+	struct powercap_zone_node *node_limit =3D node;
+	bool root_node_delete =3D false;
+
+
+	mutex_lock(&ctrl->node_lock);
+
+	if (node =3D=3D ctrl->root_node)
+		root_node_delete =3D true;
+
+	while (node) {
+		node_store =3D node;
+		if (node->child) {
+			node =3D node->child;
+		} else {
+			/* reached leaf node */
+			struct powercap_zone_node *_tnode;
+			if (node_store->pcd_dev) {
+				dev_dbg(&node_store->pcd_dev->device,
+				"Delete child %s of parent %s\n",
+				node_store->pcd_dev->name,
+				node_store->parent ?
+				node_store->parent->pcd_dev->name : "ROOT");
+			}
+			/* Point node to next sibling */
+			node =3D node_store->next;
+			if (!node)
+				node =3D node_store->parent; /* back to root */
+			/*
+			 *Before the leaf is deleted, remove references from
+			 *parent and siblings
+			 */
+			_tnode =3D node_store->parent;
+			if (_tnode) {
+				_tnode->children_count--;
+				if (_tnode->child =3D=3D node_store) {
+					/*very first child*/
+					_tnode->child =3D node_store->next;
+				} else {
+					/*Not a first child*/
+					struct powercap_zone_node *_node =3D
+								_tnode->child;
+					struct powercap_zone_node *_pnode =3D
+								_node;
+
+					while (_node !=3D node_store) {
+						_pnode =3D _node;
+						_node =3D _node->next;
+					}
+					_pnode->next =3D node_store->next;
+				}
+			}
+			if (node_store->pcd_dev) {
+				/* Ready to delete */
+				(*del_callback)(node_store->pcd_dev);
+			}
+			if (node_store =3D=3D node_limit) {
+				kfree(node_store);
+				break;
+			}
+			kfree(node_store); /* Leaf node is freed */
+			/* zone memory is freed in the device_release */
+		}
+	}
+	/*
+	 * If the request was for root node,
+	 * then whole tree is deleted
+	 */
+	if (root_node_delete)
+		ctrl->root_node =3D NULL;
+
+	mutex_unlock(&ctrl->node_lock);
+}
+
+/* Search a tree for a controller for a zone instance */
+static bool search_node(struct powercap_controller *ctrl,
+			struct powercap_zone_device *pcd_dev)
+{
+	bool valid =3D true;
+	bool found =3D false;
+	struct powercap_zone_node *node;
+
+	mutex_lock(&ctrl->node_lock);
+
+	node =3D ctrl->root_node;
+
+	while (node) {
+		if (valid) {
+			if (node->pcd_dev =3D=3D pcd_dev) {
+				found =3D true;
+				break;
+			}
+		}
+		/* First check if is node has children, then siblings */
+		if (node->child && valid) {
+			node =3D node->child;
+			valid =3D true;
+		} else if (node->next) {
+			node =3D node->next;
+			valid =3D true;
+		} else {
+			/* Reached leaf, go back to parent and traverse */
+			node =3D node->parent;
+			valid =3D false;
+		}
+	}
+	mutex_unlock(&ctrl->node_lock);
+
+	return found;
+}
+
+/* Check the presence of a controller in the controller list */
+static bool check_controller_validity(void *controller)
+{
+	struct powercap_controller *pos =3D NULL;
+	bool found =3D false;
+
+	mutex_lock(&powercap_cntrl_list_lock);
+
+	list_for_each_entry(pos, &powercap_cntrl_list, ctrl_inst) {
+		if (pos =3D=3D controller) {
+			found =3D true;
+			break;
+		}
+	}
+	mutex_unlock(&powercap_cntrl_list_lock);
+
+	return found;
+}
+
+static ssize_t show_name(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct powercap_zone_device *pcd_dev =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", pcd_dev->name);
+}
+
+static DEVICE_ATTR(name, 0444, show_name, NULL);
+
+/* Create zone and attributes in sysfs */
+static int create_power_zone_attributes(struct powercap_zone_device *p=
cd_dev)
+{
+
+	int count =3D 0;
+
+	pcd_dev->attrs.attr_grp_cnt =3D 0;
+	/**
+	* Limit is POWERCAP_ZONE_MAX_ATTRS =3D 10, Only adding 5 attrs.
+	* So not checking range after each addition
+	*/
+	pcd_dev->attrs.zone_dev_attrs[count++] =3D &dev_attr_name.attr;
+	if (pcd_dev->ops->get_max_energy_range_uj)
+		pcd_dev->attrs.zone_dev_attrs[count++] =3D
+					&dev_attr_max_energy_range_uj.attr;
+	if (pcd_dev->ops->get_energy_uj)
+		pcd_dev->attrs.zone_dev_attrs[count++] =3D
+					&dev_attr_energy_uj.attr;
+	if (pcd_dev->ops->get_power_uw)
+		pcd_dev->attrs.zone_dev_attrs[count++] =3D
+					&dev_attr_power_uw.attr;
+	if (pcd_dev->ops->get_max_power_range_uw)
+		pcd_dev->attrs.zone_dev_attrs[count++] =3D
+					&dev_attr_max_power_range_uw.attr;
+	pcd_dev->attrs.zone_dev_attrs[count] =3D NULL;
+	pcd_dev->attrs.zone_attr_count =3D count;
+	pcd_dev->attrs.dev_zone_attr_group.attrs =3D
+					pcd_dev->attrs.zone_dev_attrs;
+	pcd_dev->attrs.dev_attr_groups[0] =3D
+					&pcd_dev->attrs.dev_zone_attr_group;
+	pcd_dev->attrs.attr_grp_cnt++;
+
+	return 0;
+}
+
+static void delete_zone(struct powercap_zone_device *pcd_dev)
+{
+	struct powercap_zone_constraint *p;
+
+	dev_dbg(&pcd_dev->device, "deleting %s\n", pcd_dev->name);
+	mutex_lock(&pcd_dev->lock);
+
+	list_for_each_entry(p, &pcd_dev->constraint_list, list) {
+		if (p->ops->cleanup)
+			p->ops->cleanup(pcd_dev, p->id);
+	}
+	if (pcd_dev->ops->cleanup)
+		pcd_dev->ops->cleanup(pcd_dev);
+
+	mutex_unlock(&pcd_dev->lock);
+
+	device_unregister(&pcd_dev->device);
+}
+
+static void powercap_release(struct device *dev)
+{
+	if (dev->parent) {
+		struct powercap_zone_device *pcd_dev =3D dev_get_drvdata(dev);
+
+		dev_dbg(dev, "powercap_release zone %s\n", pcd_dev->name);
+
+		delete_constraints(pcd_dev);
+		/* Remove id from parent idr struct */
+		idr_remove(pcd_dev->par_idr, pcd_dev->id);
+		/* Destroy idrs allocated for this zone */
+		idr_destroy(&pcd_dev->idr);
+		kfree(pcd_dev->zone_dev_name);
+		mutex_destroy(&pcd_dev->lock);
+		kfree(pcd_dev);
+	} else {
+		struct powercap_controller *instance =3D dev_get_drvdata(dev);
+
+		dev_dbg(dev, "powercap_release controller %s\n",
+							instance->name);
+		idr_destroy(&instance->idr);
+		mutex_destroy(&instance->node_lock);
+		kfree(instance);
+	}
+}
+
+static ssize_t type_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	if (dev->parent)
+		strcpy(buf, "power-zone\n");
+	else
+		strcpy(buf, "controller\n");
+
+	return strlen(buf);
+}
+
+static struct device_attribute powercap_def_attrs[] =3D {
+		__ATTR_RO(type),
+		__ATTR_NULL
+};
+
+static struct class powercap_class =3D {
+	.name =3D "power_cap",
+	.dev_release =3D powercap_release,
+	.dev_attrs =3D powercap_def_attrs,
+};
+
+struct powercap_zone_device *powercap_zone_register(
+				struct powercap_controller *controller,
+				const char *name,
+				struct powercap_zone_device *parent,
+				const struct powercap_zone_ops *ops,
+				int nr_constraints,
+				struct powercap_zone_constraint_ops *const_ops)
+{
+	int result;
+	struct powercap_zone_device *pcd_dev;
+	struct device *dev_ptr;
+	struct idr *idr_ptr;
+	char *parent_name;
+	int name_sz;
+
+	if (!name || !controller)
+		return ERR_PTR(-EINVAL);
+	if (strlen(name) > POWERCAP_ZONE_NAME_LENGTH)
+		return ERR_PTR(-EINVAL);
+	if (!ops)
+		return ERR_PTR(-EINVAL);
+	if (!ops->get_energy_uj && !ops->get_power_uw)
+		return ERR_PTR(-EINVAL);
+	if (!check_controller_validity(controller))
+		return ERR_PTR(-EINVAL);
+	if (parent && !search_node(controller, parent))
+		return ERR_PTR(-EINVAL);
+	pcd_dev =3D kzalloc(sizeof(*pcd_dev), GFP_KERNEL);
+	if (!pcd_dev)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&pcd_dev->constraint_list);
+	mutex_init(&pcd_dev->lock);
+	pcd_dev->ops =3D ops;
+	pcd_dev->controller_inst =3D controller;
+	strncpy(pcd_dev->name, name, POWERCAP_ZONE_NAME_LENGTH);
+	pcd_dev->name[POWERCAP_ZONE_NAME_LENGTH] =3D '\0';
+	if (!parent) {
+		dev_ptr =3D &controller->device;
+		idr_ptr =3D &controller->idr;
+		parent_name =3D controller->name;
+	} else {
+		dev_ptr =3D &parent->device;
+		idr_ptr =3D &parent->idr;
+		parent_name =3D parent->zone_dev_name;
+	}
+	pcd_dev->par_idr =3D idr_ptr;
+	pcd_dev->device.class =3D &powercap_class;
+
+	/* allocate enough which can accommodate parent + ":" + int value */
+	name_sz =3D strlen(parent_name) +	sizeof(int)*2 + 2;
+	pcd_dev->zone_dev_name =3D  kmalloc(name_sz + 1, GFP_KERNEL);
+	if (!pcd_dev->zone_dev_name) {
+		result =3D -ENOMEM;
+		goto err_name_alloc;
+	}
+	mutex_lock(&controller->node_lock);
+	/* Using idr to get the unique id */
+	result =3D idr_alloc(pcd_dev->par_idr, NULL, 0, 0, GFP_KERNEL);
+	if (result < 0) {
+		mutex_unlock(&controller->node_lock);
+		goto err_idr_alloc;
+	}
+	pcd_dev->id =3D result;
+	idr_init(&pcd_dev->idr);
+
+	snprintf(pcd_dev->zone_dev_name, name_sz - 1, "%s:%x",
+						parent_name, pcd_dev->id);
+	pcd_dev->zone_dev_name[name_sz] =3D '\0';
+	dev_set_name(&pcd_dev->device, pcd_dev->zone_dev_name);
+	pcd_dev->device.parent =3D dev_ptr;
+
+	create_power_zone_attributes(pcd_dev);
+	result =3D create_constraint_attributes(pcd_dev, nr_constraints,
+								const_ops);
+	if (result) {
+		idr_remove(pcd_dev->par_idr, pcd_dev->id);
+		mutex_unlock(&controller->node_lock);
+		goto err_dev_reg;
+	}
+	pcd_dev->attrs.dev_attr_groups[pcd_dev->attrs.attr_grp_cnt] =3D NULL;
+	pcd_dev->device.groups =3D pcd_dev->attrs.dev_attr_groups;
+
+	result =3D device_register(&pcd_dev->device);
+	if (result) {
+		delete_constraints(pcd_dev);
+		idr_remove(pcd_dev->par_idr, pcd_dev->id);
+		mutex_unlock(&controller->node_lock);
+		goto err_dev_reg;
+	}
+	mutex_unlock(&controller->node_lock);
+
+	dev_set_drvdata(&pcd_dev->device, pcd_dev);
+	pcd_dev->node =3D create_node(pcd_dev);
+	if (!pcd_dev->node) {
+		result =3D -ENOMEM;
+		goto err_dev_reg_done;
+	}
+	if (parent)
+		insert_node(controller, pcd_dev->node, parent->node);
+	else
+		insert_node(controller, pcd_dev->node, NULL);
+
+	return pcd_dev;
+
+err_dev_reg:
+	idr_destroy(&pcd_dev->idr);
+err_idr_alloc:
+	kfree(pcd_dev->zone_dev_name);
+err_name_alloc:
+	mutex_destroy(&pcd_dev->lock);
+	kfree(pcd_dev);
+	return ERR_PTR(result);
+
+err_dev_reg_done:
+	device_unregister(&pcd_dev->device);
+	return ERR_PTR(result);
+}
+EXPORT_SYMBOL_GPL(powercap_zone_register);
+
+int powercap_zone_unregister(struct powercap_controller *controller,
+				struct powercap_zone_device *pcd_dev)
+{
+	if (!pcd_dev || !controller)
+		return -EINVAL;
+
+	if (!search_node(controller, pcd_dev))
+		return -EINVAL;
+
+	delete_node(controller, pcd_dev->node, delete_zone);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(powercap_zone_unregister);
+
+struct powercap_controller *powercap_allocate_controller(
+					const char *controller_name)
+{
+	struct powercap_controller *cntrl;
+	int result;
+
+	if (!controller_name)
+		return ERR_PTR(-EINVAL);
+
+	if (strlen(controller_name) > POWERCAP_CTRL_NAME_LENGTH)
+		return ERR_PTR(-EINVAL);
+
+	cntrl =3D kzalloc(sizeof(struct powercap_controller), GFP_KERNEL);
+	if (!cntrl)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&cntrl->node_lock);
+	INIT_LIST_HEAD(&cntrl->ctrl_inst);
+	strncpy(cntrl->name, controller_name, POWERCAP_CTRL_NAME_LENGTH);
+	cntrl->name[POWERCAP_CTRL_NAME_LENGTH] =3D '\0';
+	cntrl->device.class =3D &powercap_class;
+	dev_set_name(&cntrl->device, cntrl->name);
+	result =3D device_register(&cntrl->device);
+	if (result) {
+		kfree(cntrl);
+		return ERR_PTR(result);
+	}
+	dev_set_drvdata(&cntrl->device, cntrl);
+
+	cntrl->root_node =3D create_node(NULL);
+	if (!cntrl->root_node) {
+		result =3D -ENOMEM;
+		goto unregister;
+	}
+	idr_init(&cntrl->idr);
+	mutex_lock(&powercap_cntrl_list_lock);
+	list_add_tail(&cntrl->ctrl_inst, &powercap_cntrl_list);
+	mutex_unlock(&powercap_cntrl_list_lock);
+
+	return cntrl;
+
+unregister:
+	device_unregister(&cntrl->device);
+	return ERR_PTR(result);
+}
+EXPORT_SYMBOL_GPL(powercap_allocate_controller);
+
+void powercap_deallocate_controller(struct powercap_controller *instan=
ce)
+{
+	struct powercap_controller *pos =3D NULL;
+
+	mutex_lock(&powercap_cntrl_list_lock);
+
+	list_for_each_entry(pos, &powercap_cntrl_list, ctrl_inst) {
+		if (pos =3D=3D instance)
+			break;
+	}
+	if (pos !=3D instance) {
+		/* instance not found */
+		mutex_unlock(&powercap_cntrl_list_lock);
+		return;
+	}
+	list_del(&instance->ctrl_inst);
+	delete_node(instance, instance->root_node, delete_zone);
+
+	mutex_unlock(&powercap_cntrl_list_lock);
+
+	device_unregister(&instance->device);
+}
+EXPORT_SYMBOL_GPL(powercap_deallocate_controller);
+
+static int __init powercap_init(void)
+{
+	int result =3D 0;
+
+	result =3D class_register(&powercap_class);
+	if (result)
+		return result;
+
+	return result;
+}
+
+static void __exit powercap_exit(void)
+{
+	class_unregister(&powercap_class);
+}
+
+fs_initcall(powercap_init);
+module_exit(powercap_exit);
+
+MODULE_DESCRIPTION("PowerCap sysfs Driver");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/powercap.h b/include/linux/powercap.h
new file mode 100644
index 0000000..9967bd0
--- /dev/null
+++ b/include/linux/powercap.h
@@ -0,0 +1,300 @@
+/*
+ * powercap.h : Exports all power class sysfs interface
+ * Copyright (c) 2013, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITH=
OUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License a=
long with
+ * this program; if not, write to the Free Software Foundation, Inc.
+ *
+ */
+
+#ifndef __POWERCAP_H__
+#define __POWERCAP_H__
+
+#include <linux/device.h>
+#include <linux/idr.h>
+
+/*
+ * A power cap class device can contain multiple powercap controllers.
+ * Each controller can have multiple power zones, which can be indepen=
dently
+ * controlled. Each power zone can have one or more constraints.
+ */
+
+#define POWERCAP_CTRL_NAME_LENGTH			30
+#define POWERCAP_ZONE_NAME_LENGTH			30
+
+struct powercap_zone_device;
+struct powercap_zone_constraint;
+
+/**
+ * struct powercap_zone_constraint_ops - Define constraint callbacks
+ * @set_power_limit_uw:		Set power limit in micro-watts.
+ * @get_power_limit_uw:		Get power limit in micro-watts.
+ * @set_time_window_us:		Set time window in micro-seconds.
+ * @get_time_window_us:		Get time window in micro-seconds.
+ * @get_max_power_uw:		Get max power allowed in micro-watts.
+ * @get_min_power_uw:		Get min power allowed in micro-watts.
+ * @get_max_time_window_us:	Get max time window allowed in micro-secon=
ds.
+ * @get_min_time_window_us:	Get min time window allowed in micro-secon=
ds.
+ * @get_name:			Get the name of constraint
+ * @cleanup:			Do any clean up before the constraint is freed
+ * This structure is used to define the constraint callbacks for the c=
lient
+ * drivers. The following callbacks are mandatory and can't be NULL:
+ *  set_power_limit_uw
+ *  get_power_limit_uw
+ *  set_time_window_us
+ *  get_time_window_us
+ *  get_name
+ */
+struct powercap_zone_constraint_ops {
+	int (*set_power_limit_uw)
+			(struct powercap_zone_device *, int, u64);
+	int (*get_power_limit_uw)
+			(struct powercap_zone_device *, int, u64 *);
+
+	int (*set_time_window_us)
+			(struct powercap_zone_device *, int, u64);
+	int (*get_time_window_us)
+			(struct powercap_zone_device *, int, u64 *);
+
+	int (*get_max_power_uw)
+			(struct powercap_zone_device *, int, u64 *);
+	int (*get_min_power_uw)
+			(struct powercap_zone_device *, int, u64 *);
+
+	int (*get_max_time_window_us)
+			(struct powercap_zone_device *, int, u64 *);
+	int (*get_min_time_window_us)
+			(struct powercap_zone_device *, int, u64 *);
+	const char *(*get_name) (struct powercap_zone_device *, int);
+	void (*cleanup) (struct powercap_zone_device *, int);
+};
+
+/**
+ * struct powercap_controller- Defines a powercap controller
+ * @name:		name of controller
+ * @device:		device for this controller
+ * @idr	:		idr to have unique id for its child
+ * @root_node:		Root holding power zones for this controller
+ * @node_lock:		mutex for node
+ * @ctrl_inst:		link to the controller list
+ *
+ * Defines powercap controller instance
+ */
+struct powercap_controller {
+	char name[POWERCAP_CTRL_NAME_LENGTH + 1];
+	struct device device;
+	struct idr idr;
+	void *root_node;
+	struct mutex node_lock;
+	struct list_head ctrl_inst;
+};
+
+/**
+ * struct powercap_zone_ops - Define power zone callbacks
+ * @get_max_energy_range_uj:	Get maximum range of energy counter in
+ *				micro-joules.
+ * @get_energy_uj:		Get current energy counter in micro-joules.
+ * @reset_energy_uj:		Reset micro-joules energy counter.
+ * @get_max_power_range_uw:	Get maximum range of power counter in
+ *				micro-watts.
+ * @get_power_uw:		Get current power counter in micro-watts.
+ * @reset_power_uw:		Reset micro-watts power counter.
+ * @cleanup:			Do any clean up before the zone is freed
+ *
+ * This structure defines zone callbacks to be implemented by client d=
rivers.
+ * Client drives can define both energy and power related callbacks. B=
ut at
+ * the least one type (either power or energy) is mandatory.
+ */
+struct powercap_zone_ops {
+	int (*get_max_energy_range_uj)
+			(struct powercap_zone_device *, u64 *);
+	int (*get_energy_uj)
+			(struct powercap_zone_device *, u64 *);
+	int (*reset_energy_uj)
+			(struct powercap_zone_device *);
+
+	int (*get_max_power_range_uw)
+			(struct powercap_zone_device *, u64 *);
+	int (*get_power_uw)
+			(struct powercap_zone_device *, u64 *);
+	int (*reset_power_uw) (struct powercap_zone_device *);
+
+	void (*cleanup) (struct powercap_zone_device *);
+};
+
+#define	POWERCAP_ZONE_MAX_ATTRS		10 /* Currently only max 5 */
+#define	POWERCAP_CONSTRAINTS_ATTRS	8  /*  5 attrs/constraints */
+#define	POWERCAP_CONSTRAINTS_MAX_ATTRS	10 * POWERCAP_CONSTRAINTS_ATTRS
+					/* For 10 constraints per zone */
+#define POWERCAP_MAX_ATTR_GROUPS	2 /* One for zone and constraint */
+/**
+ * struct powercap_zone_attr- Defines a per zone attribute group
+ * @zone_dev_attrs:	Device attribute list for power zone.
+ * @zone_attr_count:	Number of power zone attributes.
+ * @const_dev_attrs:	Constraint attributes.
+ * @const_attr_count:	Number of constraint related attributes
+ * @dev_zone_attr_group: Attribute group for power zone attributes
+ * @dev_const_attr_group: Attribute group for constraints
+ * @attr_grp_cnt:	Number of attribute groups
+ * @dev_attr_groups:	Used to assign to dev->group
+ *
+ * Used to add an attribute group unique to a zone based on registry.
+ */
+struct powercap_zone_attr {
+	struct attribute *zone_dev_attrs[POWERCAP_ZONE_MAX_ATTRS];
+	int zone_attr_count;
+	struct attribute *const_dev_attrs[POWERCAP_CONSTRAINTS_MAX_ATTRS];
+	int const_attr_count;
+	struct attribute_group dev_zone_attr_group;
+	struct attribute_group dev_const_attr_group;
+	int attr_grp_cnt;
+	const struct attribute_group
+			*dev_attr_groups[POWERCAP_MAX_ATTR_GROUPS + 1];
+};
+
+/**
+ * struct powercap_zone_device- Defines instance of a power cap zone
+ * @id:			Unique id
+ * @zone_dev_name:	Zone device sysfs node name
+ * @name:		Power zone name.
+ * @controller_inst:	Controller instance for this zone
+ * @ops:		Pointer to the zone operation structure.
+ * @device:		Instance of a device.
+ * @attrs:		Attributes associated with this device
+ * @node:		Node pointer to insert to a tree data structure.
+ * @const_id_cnt:	Constraint id count
+ * @lock:		Mutex to protect zone related operations.
+ * @idr:		Instance to an idr entry for children zones.
+ * @par_idr:		To remove reference from the parent idr
+ * @drv_data:		Driver private data
+ * @constraint_list:	Link to the next power zone for this controller.
+ *
+ * This defines a power zone instance. The fields of this structure ar=
e
+ * private, and should not be used by client drivers.
+ */
+struct powercap_zone_device {
+	int id;
+	char *zone_dev_name;
+	char name[POWERCAP_ZONE_NAME_LENGTH + 1];
+	void *controller_inst;
+	const struct powercap_zone_ops *ops;
+	struct device device;
+	struct powercap_zone_attr attrs;
+	void *node;
+	int const_id_cnt;
+	struct mutex lock;
+	struct idr idr;
+	struct idr *par_idr;
+	void *drv_data;
+	struct list_head constraint_list;
+};
+
+/* For clients to get their device pointer, may be used for dev_dbgs *=
/
+#define POWERCAP_GET_DEV(p_zone)	(&pzone->device)
+
+/**
+* powercap_set_zone_data() - Set private data for a zone
+* @pcd_dev:	A pointer to the valid zone instance.
+* @pdata:	A pointer to the user private data.
+*
+* Allows client drivers to associate some private data to zone instanc=
e.
+*/
+static inline void powercap_set_zone_data(struct powercap_zone_device =
*pcd_dev,
+						void *pdata)
+{
+	if (pcd_dev)
+		pcd_dev->drv_data =3D pdata;
+}
+
+/**
+* powercap_get_zone_data() - Get private data for a zone
+* @pcd_dev:	A pointer to the valid zone instance.
+*
+* Allows client drivers to get private data associate with a zone,
+* using call to powercap_set_zone_data.
+*/
+static inline void *powercap_get_zone_data(struct powercap_zone_device=
 *pcd_dev)
+{
+	if (pcd_dev)
+		return pcd_dev->drv_data;
+	return NULL;
+}
+
+/* Controller allocate/deallocate API */
+
+/**
+* powercap_allocate_controller() - Allocates a controller
+* @controller_name:	The Name of this controller, which will be shown
+*			in the sysfs Interface.
+*
+* Used to create a controller with the power capping class. Here contr=
oller
+* can represent a type of technology, which can control a range of pow=
er zones.
+* For example a controller can be RAPL (Running Average Power Limit)
+* Intel=C2=AE 64 and IA-32 Processor Architectures. The name can be an=
y string
+* which must be unique, otherwise this function returns NULL.
+* On successful allocation, this API returns a pointer to the
+* controller instance.
+*/
+struct powercap_controller *powercap_allocate_controller(
+						const char *controller_name);
+
+/**
+* powercap_deallocate_controller() - Deallocates a controller
+* @instance:	A pointer to the valid controller instance.
+*
+* Used to deallocate a controller with the power capping class. This
+* takes only one argument, which is the pointer to the instance return=
ed
+* by a call to powercap_allocate_controller.
+* When a controller is deallocated, all zones and associated constrain=
ts
+* are freed.
+*/
+void powercap_deallocate_controller(struct powercap_controller *instan=
ce);
+
+/* Zone register/unregister API */
+
+/**
+* powercap_zone_register() - Register a power zone
+* @controller:	A controller instance under which this zone operates.
+* @name:	A name for this zone.
+* @parent:	A pointer to the parent power zone instance if any or NULL
+* @ops:		Pointer to zone operation callback structure.
+* @no_constraints: Number of constraints for this zone
+* @const_ops:	Pointer to constraint callback structure
+*
+* Used to register a power zone for a controller. Zones are organized =
in
+* a tree like structure in sysfs under a controller.
+* A power zone must a register a pointer to a structure representing z=
one
+* callbacks.
+* A power zone can have a some other power zone as a parent or it can =
be
+* NULL to appear as a direct descendant of a controller.
+* Each power zone can have number of constraints. Constraints appears
+* under zones as attributes with unique id.
+*/
+struct powercap_zone_device *powercap_zone_register(
+			struct powercap_controller *controller,
+			const char *name,
+			struct powercap_zone_device *parent,
+			const struct powercap_zone_ops *ops,
+			int no_constraints,
+			struct powercap_zone_constraint_ops *const_ops);
+/**
+* powercap_zone_unregister() - Unregister a zone device
+* @controller:	A pointer to the valid instance of a controller.
+* @pcd_dev:	A pointer to the valid zone instance for a controller
+*
+* Used to unregister a zone device for a controller. Once a zone is
+* unregistered then all its children and associated constraints are fr=
eed.
+*/
+int powercap_zone_unregister(struct powercap_controller *controller,
+				struct powercap_zone_device *pcd_dev);
+
+#endif
--=20
1.8.3.1

