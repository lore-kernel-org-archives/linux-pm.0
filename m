Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623784E80CF;
	Wed, 14 Oct 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980459; cv=none; b=rszzPxS3sRK8GgIIqDBWoQIjTnvkDS4BiueAw9qZjlD6UFVnY6wSwftmWF3oFESViME+Z9JglhMACHGqTBdNDVmaAIWYnHPYjHwAztOGxBlrDBXI4NgFSt8l8YahJBKtPYD1oTiI4ok8F+ssxZEn3au3i7Yf4EtxHeGIIEUkAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980459; c=relaxed/simple;
	bh=zc6qLWh06NDu4rd5QNXkHPGPMnOOuyg3d+mMJwqGXco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJAlgkb/2PCMnzUQt+XeLv4sAHjqRtHo2SpaLRBbjSKdG8nTRrB4E6G/E/ptzClQGxCWg22iQ37ceOXTGustvg1a/GNwYJInoITlpKhmselBsIF22mCZA8C7N5mcyBkmBfzBlp7FvGLtOT8fM3tya6TFeYXZxgmMdnyhIjsLmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrmU9sB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrmU9sB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB79C1F000FF;
	Wed, 14 Oct 2026 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980456;
	bh=x4jPo+6MHAxWFCveFfIJpwt3kZWzwERROXfqgqQ82mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NrmU9sB4Up6zWC3nRTikP/mYqcZmFzDTNv2wVlN/N8ShNB2EnpdS6Gs9px54Ver4s
	 TTQHoUZraSmQd6BdmHdFjllTBmJE4QPklIfR6PJWvQ5tmvREKvIQjDajL9258n9Z97
	 QZRFZ0dr0A7JjkcS0R2A0YQlzuBFfn0zyDJ5wTcwu2nzBl+QcXbYiVVKO+ZTxWWbzs
	 9MlUthkxgFtFh4YO7F+wbA7vDZxNa+urrOgDK0si6xZ1V+doQkrUhowVWFp6x9zg0J
	 UY5A0SIDfkfL7baY9rFU+M2vTJ+rgwuyI7gjpGm3RH/vRAKRGMj4+3ka/pt4h0fy22
	 D+2KyG5zRV44A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:02 +0200
Subject: [PATCH RFC 02/16] clk: Acquire resources for clock transitions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-2-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=52096;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=PNHBJhOfnyg5waGKgXOb9vgF6vcsl3UIXcAf27/BoWQ=;
 b=gadC+nVWHUodhHY9voRm+wSYSUuNiMxOx/RMjQtjgseHiDyr3vFXCUBv5+2Cs/RYVqgi3SEeF
 BdbjMtiusoLBCGr3pQcKu4p/QEn5FZFvHj8KNR1i7ksYDn+fzrcIJ0R
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Preparing a clock protects its current requirements, not the resources
needed while changing its rate or parent. A transition can temporarily
use both parents or access an unprepared clock, and a parent rate change
can cause other clocks to be programmed too. Raising resources one clock
at a time leaves those operations exposed to insufficient power.

Failures make this worse: hardware may already have changed when the
operation returns an error. A matching cached rate is then not proof
that resource reconciliation finished. Retaining a temporary enable
reference without a corresponding prepare reference also breaks a
consumer's normal disable/unprepare sequence after a failed reparent.

Make CCF acquire the affected tree's and parent paths' resources before
notifiers or programming, and reconcile them only when the walk stops.
Keep fault recovery independent of rate shortcuts and subsequent
consumer reference-count changes. Require explicit recovery of an
ancestor's uncertain parent selection rather than reporting success
from a descendant request.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/Makefile            |   1 +
 drivers/clk/clk.c               | 678 +++++++++++++++++++++++++++++++++-------
 drivers/clk/clk_resource_test.c | 376 ++++++++++++++++++++++
 drivers/clk/clk_test.c          | 178 +++++++++++
 include/linux/clk-provider.h    |  39 +++
 5 files changed, 1161 insertions(+), 111 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 52d138d4ffc8..de4611df8b6d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_HAVE_CLK)		+= clk-devres.o clk-bulk.o clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o
 obj-$(CONFIG_CLK_KUNIT_TEST)	+= clk-test.o
+obj-$(CONFIG_CLK_KUNIT_TEST)	+= clk_resource_test.o
 clk-test-y			:= clk_test.o \
 				   kunit_clk_assigned_rates_u64_one.dtbo.o \
 				   kunit_clk_assigned_rates_u64_one_consumer.dtbo.o \
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 95669775f8cd..46e01d8254e5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -48,6 +48,8 @@ static LIST_HEAD(clk_notifier_list);
 static HLIST_HEAD(clk_rpm_list);
 static DEFINE_MUTEX(clk_rpm_list_lock);
 
+static void __clk_release(struct kref *ref);
+
 static const struct hlist_head *all_lists[] = {
 	&clk_root_list,
 	&clk_orphan_list,
@@ -64,6 +66,26 @@ struct clk_parent_map {
 	int			index;
 };
 
+struct clk_resource_acquisition {
+	struct list_head node;
+	struct clk_core *core;
+	struct clk_resource_transition transition;
+	void *cookie;
+};
+
+struct clk_resource_transaction {
+	struct list_head acquisitions;
+	struct list_head notifications;
+};
+
+struct clk_rate_notification {
+	struct list_head node;
+	struct clk_core *core;
+	unsigned long old_rate;
+	unsigned long new_rate;
+	bool sent;
+};
+
 /**
  * struct clk_core - The internal state of a clk in the clk tree.
  * @name:              Unique name of the clk for identification.
@@ -84,7 +106,6 @@ struct clk_parent_map {
  *                     clk_core->rate every time the clock is reparented, and
  *                     when we're doing the orphan -> !orphan transition.
  * @new_rate:          New rate to be set during a rate change operation.
- * @old_rate:          Rate before the current rate change operation.
  * @new_parent:        Pointer to new parent during parent change. This is also
  *                     used when a clk's rate is changed.
  * @new_child:         Pointer to new child during reparenting. This is also
@@ -93,6 +114,11 @@ struct clk_parent_map {
  *                     `clk framework flags`.
  * @orphan:            True if this clk is currently orphaned.
  * @rpm_enabled:       True if runtime power management is enabled for this clk.
+ * @resource_fault:    Resource state must be reconciled before a shortcut.
+ * @parent_fault:      Parent programming left the hardware state uncertain.
+ * @fault_migration_refs: Retained migration references and a clock prepare pin.
+ * @fault_old_parent:  Old parent retained after an uncertain parent change.
+ * @fault_new_parent:  Target parent retained after an uncertain parent change.
  * @enable_count:      Reference count of enables.
  * @prepare_count:     Reference count of prepares.
  * @protect_count:     Protection reference count against disable.
@@ -131,12 +157,16 @@ struct clk_core {
 	unsigned long		rate;
 	unsigned long		req_rate;
 	unsigned long		new_rate;
-	unsigned long		old_rate;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
 	unsigned long		flags;
 	bool			orphan;
 	bool			rpm_enabled;
+	bool			resource_fault;
+	bool			parent_fault;
+	bool			fault_migration_refs;
+	struct clk_core		*fault_old_parent;
+	struct clk_core		*fault_new_parent;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
@@ -2255,9 +2285,59 @@ static void __clk_set_parent_after(struct clk_core *core,
 	}
 }
 
-static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
-			    u8 p_index)
+static void clk_hold_parent_fault(struct clk_core *core,
+				  struct clk_core *parent,
+				  struct clk_core *old_parent)
 {
+	core->parent_fault = true;
+	core->fault_migration_refs = core->prepare_count > 0;
+	core->fault_old_parent = old_parent;
+	core->fault_new_parent = parent;
+
+	/*
+	 * Keep the retained enable reference prepared across consumer unprepare.
+	 * The clock is already prepared, so taking this reference cannot fail.
+	 */
+	if (core->fault_migration_refs)
+		clk_core_prepare(core);
+
+	if (old_parent)
+		kref_get(&old_parent->ref);
+	if (parent)
+		kref_get(&parent->ref);
+}
+
+static void clk_release_parent_fault(struct clk_core *core)
+{
+	if (!core->parent_fault)
+		return;
+
+	/* Unwind the references retained at failure, not the current state. */
+	if (core->fault_migration_refs) {
+		clk_core_disable_lock(core);
+		clk_core_disable_unprepare(core->fault_old_parent);
+	}
+	if (core->flags & CLK_OPS_PARENT_ENABLE) {
+		clk_core_disable_unprepare(core->fault_new_parent);
+		clk_core_disable_unprepare(core->fault_old_parent);
+	}
+	if (core->fault_migration_refs)
+		clk_core_unprepare(core);
+
+	if (core->fault_old_parent)
+		kref_put(&core->fault_old_parent->ref, __clk_release);
+	if (core->fault_new_parent)
+		kref_put(&core->fault_new_parent->ref, __clk_release);
+	core->fault_old_parent = NULL;
+	core->fault_new_parent = NULL;
+	core->fault_migration_refs = false;
+	core->parent_fault = false;
+}
+
+static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
+			    u8 p_index, bool retain_on_failure)
+{
+	bool retrying_fault = core->parent_fault;
 	int ret = 0;
 	struct clk_core *old_parent;
 
@@ -2274,72 +2354,33 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
 	trace_clk_set_parent_complete(core, parent);
 
 	if (ret) {
-		unsigned long flags = clk_enable_lock();
+		if (retrying_fault) {
+			__clk_set_parent_after(core, parent, old_parent);
+		} else if (retain_on_failure) {
+			clk_hold_parent_fault(core, parent, old_parent);
+		} else {
+			unsigned long flags = clk_enable_lock();
 
-		clk_reparent(core, old_parent);
-		clk_enable_unlock(flags);
-		__clk_set_parent_after(core, old_parent, parent);
+			clk_reparent(core, old_parent);
+			clk_enable_unlock(flags);
+			__clk_set_parent_after(core, old_parent, parent);
+		}
 
 		return ret;
 	}
 
 	__clk_set_parent_after(core, parent, old_parent);
+	clk_release_parent_fault(core);
 
 	return 0;
 }
 
-/**
- * __clk_speculate_rates - speculate all rates in the clk subtree
- * @core: first clk in the subtree
- * @parent_rate: the "future" rate of clk's parent
- *
- * Walks the subtree of clks starting with @core, speculating rates as it
- * goes and firing off PRE_RATE_CHANGE notifications as necessary.
- *
- * Unlike __clk_recalc_rates, __clk_speculate_rates exists only for sending
- * pre-rate change notifications and returns early if no clks in the
- * subtree have subscribed to the notifications.  Note that if a clk does not
- * implement the .recalc_rate callback then it is assumed that the clock will
- * take on the rate of its parent.
- */
-static int __clk_speculate_rates(struct clk_core *core,
-				 unsigned long parent_rate)
-{
-	struct clk_core *child;
-	unsigned long new_rate;
-	int ret = NOTIFY_DONE;
-
-	lockdep_assert_held(&prepare_lock);
-
-	new_rate = clk_recalc(core, parent_rate);
-
-	/* abort rate change if a driver returns NOTIFY_BAD or NOTIFY_STOP */
-	if (core->notifier_count)
-		ret = __clk_notify(core, PRE_RATE_CHANGE, core->rate, new_rate);
-
-	if (ret & NOTIFY_STOP_MASK) {
-		pr_debug("%s: clk notifier callback for clock %s aborted with error %d\n",
-				__func__, core->name, ret);
-		goto out;
-	}
-
-	hlist_for_each_entry(child, &core->children, child_node) {
-		ret = __clk_speculate_rates(child, new_rate);
-		if (ret & NOTIFY_STOP_MASK)
-			break;
-	}
-
-out:
-	return ret;
-}
-
 static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 			     struct clk_core *new_parent, u8 p_index)
 {
 	struct clk_core *child;
 
 	core->new_rate = new_rate;
-	core->old_rate = core->rate;
 	core->new_parent = new_parent;
 	core->new_parent_index = p_index;
 	/* include clk in new parent's PRE_RATE_CHANGE notifications */
@@ -2353,6 +2394,38 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 	}
 }
 
+static void clk_clear_new_child(struct clk_core *core)
+{
+	struct clk_core *new_child = core->new_child;
+	struct clk_core *child;
+
+	if (core->new_parent && core->new_parent->new_child == core)
+		core->new_parent->new_child = NULL;
+	core->new_child = NULL;
+	hlist_for_each_entry(child, &core->children, child_node)
+		clk_clear_new_child(child);
+
+	if (new_child && new_child->parent != core)
+		clk_clear_new_child(new_child);
+}
+
+static bool clk_parent_fault_plan_valid(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	if (core->parent_fault && core->new_parent != core->fault_new_parent)
+		return false;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		if (child->new_parent && child->new_parent != core)
+			continue;
+		if (!clk_parent_fault_plan_valid(child))
+			return false;
+	}
+
+	return !core->new_child || clk_parent_fault_plan_valid(core->new_child);
+}
+
 /*
  * calculate the new rates returning the topmost clock that has to be
  * changed.
@@ -2444,52 +2517,270 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
  * so that in case of an error we can walk down the whole tree again and
  * abort the change.
  */
-static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
-						  unsigned long event)
+static int clk_collect_rate_notifications(struct clk_resource_transaction *tx,
+					  struct clk_core *core)
 {
-	struct clk_core *child, *tmp_clk, *fail_clk = NULL;
-	unsigned long old_rate = core->rate;
-	unsigned long new_rate = core->new_rate;
-	int ret = NOTIFY_DONE;
+	struct clk_rate_notification *notification;
+	struct clk_core *child;
+	int ret;
 
-	if (event != PRE_RATE_CHANGE)
-		old_rate = core->old_rate;
-	if (event == POST_RATE_CHANGE)
-		new_rate = core->rate;
+	list_for_each_entry(notification, &tx->notifications, node)
+		if (notification->core == core)
+			return 0;
 
-	if (old_rate == new_rate)
-		return NULL;
+	if (core->rate != core->new_rate && core->notifier_count) {
+		notification = kzalloc_obj(*notification);
+		if (!notification)
+			return -ENOMEM;
 
-	if (core->notifier_count) {
-		ret = __clk_notify(core, event, old_rate, new_rate);
-		if (ret & NOTIFY_STOP_MASK)
-			fail_clk = core;
+		notification->core = core;
+		notification->old_rate = core->rate;
+		notification->new_rate = core->new_rate;
+		list_add_tail(&notification->node, &tx->notifications);
 	}
 
 	hlist_for_each_entry(child, &core->children, child_node) {
-		/* Skip children who will be reparented to another clock */
 		if (child->new_parent && child->new_parent != core)
 			continue;
-		tmp_clk = clk_propagate_rate_change(child, event);
-		if (tmp_clk)
-			fail_clk = tmp_clk;
+
+		ret = clk_collect_rate_notifications(tx, child);
+		if (ret)
+			return ret;
 	}
 
-	/* handle the new child who might not be in core->children yet */
-	if (core->new_child) {
-		tmp_clk = clk_propagate_rate_change(core->new_child, event);
-		if (tmp_clk)
-			fail_clk = tmp_clk;
+	if (core->new_child)
+		return clk_collect_rate_notifications(tx, core->new_child);
+
+	return 0;
+}
+
+static int clk_send_rate_pre_notifications(struct clk_resource_transaction *tx)
+{
+	struct clk_rate_notification *notification;
+	int ret;
+
+	list_for_each_entry(notification, &tx->notifications, node) {
+		ret = __clk_notify(notification->core, PRE_RATE_CHANGE,
+				   notification->old_rate, notification->new_rate);
+		notification->sent = true;
+		if (ret & NOTIFY_STOP_MASK)
+			return -EBUSY;
 	}
 
-	return fail_clk;
+	return 0;
+}
+
+static void
+clk_finish_rate_notifications(struct clk_resource_transaction *tx,
+			      unsigned long event)
+{
+	struct clk_rate_notification *notification, *tmp;
+
+	list_for_each_entry(notification, &tx->notifications, node) {
+		if (!notification->sent)
+			break;
+
+		__clk_notify(notification->core, event, notification->old_rate,
+			     event == POST_RATE_CHANGE ?
+			     notification->core->rate : notification->new_rate);
+	}
+
+	list_for_each_entry_safe(notification, tmp, &tx->notifications, node) {
+		list_del(&notification->node);
+		kfree(notification);
+	}
+}
+
+static int clk_resource_acquire_one(struct clk_resource_transaction *tx,
+				    struct clk_core *core, bool force)
+{
+	struct clk_resource_acquisition *acquisition;
+	struct clk_core *new_parent;
+	int ret;
+
+	if (!core)
+		return 0;
+
+	list_for_each_entry(acquisition, &tx->acquisitions, node)
+		if (acquisition->core == core)
+			return 0;
+
+	if (!core->ops->resource_acquire)
+		return 0;
+
+	new_parent = core->new_parent ?: core->parent;
+	acquisition = kzalloc_obj(*acquisition);
+	if (!acquisition)
+		return -ENOMEM;
+
+	acquisition->core = core;
+	acquisition->transition.old_rate = core->rate;
+	acquisition->transition.new_rate = force ? core->rate : core->new_rate;
+	acquisition->transition.old_parent = core->parent ?
+		core->parent->hw : NULL;
+	acquisition->transition.new_parent = force ?
+		acquisition->transition.old_parent :
+		(new_parent ? new_parent->hw : NULL);
+
+	ret = core->ops->resource_acquire(core->hw,
+					  &acquisition->transition,
+					  &acquisition->cookie);
+	if (ret) {
+		kfree(acquisition);
+		return ret;
+	}
+
+	list_add_tail(&acquisition->node, &tx->acquisitions);
+	return 0;
+}
+
+static int
+clk_resource_acquire_parent_path(struct clk_resource_transaction *tx,
+				 struct clk_core *parent)
+{
+	int ret;
+
+	for (; parent; parent = parent->parent) {
+		/* A resource-only acquisition cannot repair parent programming. */
+		if (parent->parent_fault)
+			return -EBUSY;
+
+		ret = clk_resource_acquire_one(tx, parent, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int clk_resource_acquire_tree(struct clk_resource_transaction *tx,
+				     struct clk_core *core)
+{
+	struct clk_core *child;
+	int ret;
+
+	ret = clk_resource_acquire_one(tx, core, false);
+	if (ret)
+		return ret;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		if (child->new_parent && child->new_parent != core)
+			continue;
+
+		ret = clk_resource_acquire_tree(tx, child);
+		if (ret)
+			return ret;
+	}
+
+	if (core->new_child)
+		return clk_resource_acquire_tree(tx, core->new_child);
+
+	return 0;
+}
+
+static int
+clk_resource_release(struct clk_resource_transaction *tx,
+		     enum clk_resource_change_result result)
+{
+	struct clk_resource_acquisition *acquisition, *tmp;
+	int first_error = 0;
+	int ret;
+
+	list_for_each_entry_reverse(acquisition, &tx->acquisitions, node) {
+		struct clk_core *core = acquisition->core;
+
+		if (result == CLK_RESOURCE_HW_CHANGED)
+			core->resource_fault = true;
+
+		acquisition->transition.actual_rate = core->rate;
+		acquisition->transition.actual_parent = core->parent ?
+			core->parent->hw : NULL;
+
+		ret = core->ops->resource_release(core->hw,
+						  &acquisition->transition,
+						  acquisition->cookie,
+						  result);
+		if (ret) {
+			core->resource_fault = true;
+			if (!first_error)
+				first_error = ret;
+		} else if (result == CLK_RESOURCE_COMPLETE) {
+			core->resource_fault = false;
+		}
+	}
+
+	list_for_each_entry_safe(acquisition, tmp, &tx->acquisitions, node) {
+		list_del(&acquisition->node);
+		kfree(acquisition);
+	}
+
+	return first_error;
+}
+
+static bool clk_resource_tree_faulted(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	if (core->resource_fault || core->parent_fault)
+		return true;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		if (clk_resource_tree_faulted(child))
+			return true;
+	}
+
+	return false;
+}
+
+static bool clk_resource_parent_path_faulted(struct clk_core *core)
+{
+	for (core = core->parent; core; core = core->parent) {
+		if (core->resource_fault || core->parent_fault)
+			return true;
+	}
+
+	return false;
+}
+
+static bool clk_resource_tree_managed(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	if (core->ops->resource_acquire)
+		return true;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		if (child->new_parent && child->new_parent != core)
+			continue;
+		if (clk_resource_tree_managed(child))
+			return true;
+	}
+
+	return core->new_child && clk_resource_tree_managed(core->new_child);
+}
+
+static bool clk_resource_tree_recalculates(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	if (core->flags & CLK_RECALC_NEW_RATES)
+		return true;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		if (child->new_parent && child->new_parent != core)
+			continue;
+		if (clk_resource_tree_recalculates(child))
+			return true;
+	}
+
+	return core->new_child && clk_resource_tree_recalculates(core->new_child);
 }
 
 /*
  * walk down a subtree and set the new rates notifying the rate
  * change on the way
  */
-static int clk_change_rate(struct clk_core *core)
+static int clk_change_rate(struct clk_core *core, bool retain_on_failure)
 {
 	struct clk_core *child;
 	struct hlist_node *tmp;
@@ -2497,6 +2788,7 @@ static int clk_change_rate(struct clk_core *core)
 	bool skip_set_rate = false;
 	bool rate_ungated = false;
 	bool parent_enabled = false;
+	bool retrying_parent_fault = core->parent_fault;
 	struct clk_core *old_parent = NULL;
 	struct clk_core *parent = NULL;
 	int ret = 0;
@@ -2526,7 +2818,8 @@ static int clk_change_rate(struct clk_core *core)
 		rate_ungated = true;
 	}
 
-	if (core->new_parent && core->new_parent != core->parent) {
+	if ((core->new_parent && core->new_parent != core->parent) ||
+	    retrying_parent_fault) {
 		ret = __clk_set_parent_before(core, core->new_parent,
 					      &old_parent);
 		if (ret)
@@ -2545,17 +2838,26 @@ static int clk_change_rate(struct clk_core *core)
 
 		trace_clk_set_parent_complete(core, core->new_parent);
 		if (ret) {
-			unsigned long flags = clk_enable_lock();
+			if (retrying_parent_fault) {
+				__clk_set_parent_after(core, core->new_parent,
+						       old_parent);
+			} else if (retain_on_failure) {
+				clk_hold_parent_fault(core, core->new_parent,
+						      old_parent);
+			} else {
+				unsigned long flags = clk_enable_lock();
 
-			clk_reparent(core, old_parent);
-			clk_enable_unlock(flags);
-			__clk_set_parent_after(core, old_parent,
-					       core->new_parent);
+				clk_reparent(core, old_parent);
+				clk_enable_unlock(flags);
+				__clk_set_parent_after(core, old_parent,
+						       core->new_parent);
+			}
 			goto cleanup;
 		}
 
 		__clk_set_parent_after(core, core->new_parent,
 				       old_parent);
+		clk_release_parent_fault(core);
 	}
 
 	if (core->flags & CLK_OPS_PARENT_ENABLE) {
@@ -2598,14 +2900,14 @@ static int clk_change_rate(struct clk_core *core)
 		/* Skip children who will be reparented to another clock */
 		if (child->new_parent && child->new_parent != core)
 			continue;
-		ret = clk_change_rate(child);
+		ret = clk_change_rate(child, retain_on_failure);
 		if (ret)
 			goto runtime_put;
 	}
 
 	/* handle the new child who might not be in core->children yet */
 	if (core->new_child) {
-		ret = clk_change_rate(core->new_child);
+		ret = clk_change_rate(core->new_child, retain_on_failure);
 		if (ret)
 			goto runtime_put;
 	}
@@ -2649,8 +2951,14 @@ static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
 static int clk_core_set_rate_nolock(struct clk_core *core,
 				    unsigned long req_rate)
 {
-	struct clk_core *top, *fail_clk;
+	struct clk_resource_transaction tx = {
+		.acquisitions = LIST_HEAD_INIT(tx.acquisitions),
+		.notifications = LIST_HEAD_INIT(tx.notifications),
+	};
+	struct clk_core *top;
+	bool resource_managed;
 	unsigned long rate;
+	int release_ret;
 	int ret;
 
 	if (!core)
@@ -2659,7 +2967,9 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	rate = clk_core_req_round_rate_nolock(core, req_rate);
 
 	/* bail early if nothing to do */
-	if (rate == clk_core_get_rate_nolock(core))
+	if (rate == clk_core_get_rate_nolock(core) &&
+	    !clk_resource_tree_faulted(core) &&
+	    !clk_resource_parent_path_faulted(core))
 		return 0;
 
 	/* fail on a direct rate set of a protected provider */
@@ -2670,36 +2980,98 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	top = clk_calc_new_rates(core, req_rate);
 	if (!top)
 		return -EINVAL;
+	if (clk_resource_tree_managed(top) &&
+	    clk_resource_tree_recalculates(top)) {
+		clk_clear_new_child(top);
+		return -EOPNOTSUPP;
+	}
+	if (!clk_parent_fault_plan_valid(top)) {
+		clk_clear_new_child(top);
+		return -EBUSY;
+	}
 
 	ret = clk_pm_runtime_get(core);
-	if (ret)
+	if (ret) {
+		clk_clear_new_child(top);
 		return ret;
+	}
 
-	/* notify that we are about to change rates */
-	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
-	if (fail_clk) {
-		pr_debug("%s: failed to set %s rate\n", __func__,
-				fail_clk->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
-		ret = -EBUSY;
+	ret = clk_resource_acquire_tree(&tx, top);
+	if (ret) {
+		core->resource_fault = true;
+		release_ret = clk_resource_release(&tx,
+						    CLK_RESOURCE_NO_HW_CHANGE);
+		if (release_ret)
+			ret = release_ret;
+		goto err;
+	}
+	ret = clk_resource_acquire_parent_path(&tx, core->parent);
+	if (ret)
+		goto acquire_failed;
+	ret = clk_resource_acquire_parent_path(&tx, core->new_parent);
+	if (ret)
+		goto acquire_failed;
+
+	resource_managed = !list_empty(&tx.acquisitions);
+
+	ret = clk_collect_rate_notifications(&tx, top);
+	if (ret)
+		goto notify_failed;
+
+	ret = clk_send_rate_pre_notifications(&tx);
+	if (ret) {
+		clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+		release_ret = clk_resource_release(&tx,
+						    CLK_RESOURCE_NO_HW_CHANGE);
+		if (release_ret)
+			ret = release_ret;
 		goto err;
 	}
 
 	/* change the rates */
-	ret = clk_change_rate(top);
+	ret = clk_change_rate(top, resource_managed);
 	if (ret) {
 		__clk_recalc_rates(top, true, 0);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
+		clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+		release_ret = clk_resource_release(&tx,
+						    CLK_RESOURCE_HW_CHANGED);
+		if (release_ret)
+			ret = release_ret;
 		goto err;
 	}
 
-	clk_propagate_rate_change(top, POST_RATE_CHANGE);
+	ret = clk_resource_release(&tx, CLK_RESOURCE_COMPLETE);
+	if (ret) {
+		core->resource_fault = true;
+		clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+		goto err;
+	}
+	core->resource_fault = false;
+
+	clk_finish_rate_notifications(&tx, POST_RATE_CHANGE);
 
 	core->req_rate = req_rate;
 err:
+	clk_clear_new_child(top);
 	clk_pm_runtime_put(core);
 
 	return ret;
+
+acquire_failed:
+	core->resource_fault = true;
+	release_ret = clk_resource_release(&tx,
+					    CLK_RESOURCE_NO_HW_CHANGE);
+	if (release_ret)
+		ret = release_ret;
+	goto err;
+
+notify_failed:
+	clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+	release_ret = clk_resource_release(&tx,
+					    CLK_RESOURCE_NO_HW_CHANGE);
+	if (release_ret)
+		ret = release_ret;
+	goto err;
 }
 
 /**
@@ -3037,6 +3409,13 @@ EXPORT_SYMBOL_GPL(clk_has_parent);
 static int clk_core_set_parent_nolock(struct clk_core *core,
 				      struct clk_core *parent)
 {
+	struct clk_resource_transaction tx = {
+		.acquisitions = LIST_HEAD_INIT(tx.acquisitions),
+		.notifications = LIST_HEAD_INIT(tx.notifications),
+	};
+	unsigned long new_rate;
+	bool resource_managed;
+	int release_ret;
 	int ret = 0;
 	int p_index = 0;
 	unsigned long p_rate = 0;
@@ -3046,8 +3425,11 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 	if (!core)
 		return 0;
 
-	if (core->parent == parent)
+	if (core->parent == parent && !clk_resource_tree_faulted(core) &&
+	    !clk_resource_parent_path_faulted(core))
 		return 0;
+	if (core->parent_fault && core->fault_new_parent != parent)
+		return -EBUSY;
 
 	/* verify ops for multi-parent clks */
 	if (core->num_parents > 1 && !core->ops->set_parent)
@@ -3075,28 +3457,86 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 	if (ret)
 		return ret;
 
-	/* propagate PRE_RATE_CHANGE notifications */
-	ret = __clk_speculate_rates(core, p_rate);
+	new_rate = clk_recalc(core, p_rate);
+	clk_calc_subtree(core, new_rate, parent, p_index);
 
-	/* abort if a driver objects */
-	if (ret & NOTIFY_STOP_MASK)
+	ret = clk_resource_acquire_tree(&tx, core);
+	if (ret) {
+		core->resource_fault = true;
+		release_ret = clk_resource_release(&tx,
+						    CLK_RESOURCE_NO_HW_CHANGE);
+		if (release_ret)
+			ret = release_ret;
 		goto runtime_put;
+	}
+	ret = clk_resource_acquire_parent_path(&tx, core->parent);
+	if (ret)
+		goto acquire_failed;
+	ret = clk_resource_acquire_parent_path(&tx, parent);
+	if (ret)
+		goto acquire_failed;
+
+	resource_managed = !list_empty(&tx.acquisitions);
+
+	ret = clk_collect_rate_notifications(&tx, core);
+	if (ret)
+		goto notify_failed;
+
+	ret = clk_send_rate_pre_notifications(&tx);
+	if (ret) {
+		clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+		release_ret = clk_resource_release(&tx,
+						    CLK_RESOURCE_NO_HW_CHANGE);
+		if (release_ret)
+			ret = release_ret;
+		goto runtime_put;
+	}
 
 	/* do the re-parent */
-	ret = __clk_set_parent(core, parent, p_index);
+	ret = __clk_set_parent(core, parent, p_index, resource_managed);
 
 	/* propagate rate an accuracy recalculation accordingly */
 	if (ret) {
-		__clk_recalc_rates(core, true, ABORT_RATE_CHANGE);
+		__clk_recalc_rates(core, true, 0);
+		clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+		release_ret = clk_resource_release(&tx,
+						    CLK_RESOURCE_HW_CHANGED);
+		if (release_ret)
+			ret = release_ret;
 	} else {
-		__clk_recalc_rates(core, true, POST_RATE_CHANGE);
+		__clk_recalc_rates(core, true, 0);
+		ret = clk_resource_release(&tx, CLK_RESOURCE_COMPLETE);
+		if (ret) {
+			core->resource_fault = true;
+			clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+			goto runtime_put;
+		}
+		core->resource_fault = false;
+		clk_finish_rate_notifications(&tx, POST_RATE_CHANGE);
 		__clk_recalc_accuracies(core);
 	}
 
 runtime_put:
+	clk_clear_new_child(core);
 	clk_pm_runtime_put(core);
 
 	return ret;
+
+acquire_failed:
+	core->resource_fault = true;
+	release_ret = clk_resource_release(&tx,
+					    CLK_RESOURCE_NO_HW_CHANGE);
+	if (release_ret)
+		ret = release_ret;
+	goto runtime_put;
+
+notify_failed:
+	clk_finish_rate_notifications(&tx, ABORT_RATE_CHANGE);
+	release_ret = clk_resource_release(&tx,
+					    CLK_RESOURCE_NO_HW_CHANGE);
+	if (release_ret)
+		ret = release_ret;
+	goto runtime_put;
 }
 
 int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *parent)
@@ -4532,6 +4972,10 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		ret = -EINVAL;
 		goto fail_ops;
 	}
+	if (!!init->ops->resource_acquire != !!init->ops->resource_release) {
+		ret = -EINVAL;
+		goto fail_ops;
+	}
 	core->ops = init->ops;
 
 	core->dev = dev;
@@ -4581,6 +5025,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 fail_name:
 	kref_put(&core->ref, __clk_release);
 fail_out:
+	hw->init = init;
 	if (dev) {
 		dev_err_probe(dev, ret, "failed to register clk '%s' (%pS)\n",
 			      init->name, hw);
@@ -4776,14 +5221,25 @@ void clk_unregister(struct clk *clk)
 
 		/* Reparent all children to the orphan list. */
 		hlist_for_each_entry_safe(child, t, &clk->core->children,
-					  child_node)
+					  child_node) {
+			if (child->parent_fault) {
+				pr_warn("%s: releasing unresolved parent fault for %s\n",
+					__func__, child->name);
+				clk_release_parent_fault(child);
+			}
 			clk_core_set_parent_nolock(child, NULL);
+		}
 	}
 
 	clk_core_evict_parent_cache(clk->core);
 
 	hash_del(&clk->core->hashtable_node);
 	hlist_del_init(&clk->core->child_node);
+	if (clk->core->parent_fault) {
+		pr_warn("%s: releasing unresolved parent fault for %s\n",
+			__func__, clk->core->name);
+		clk_release_parent_fault(clk->core);
+	}
 
 	if (clk->core->prepare_count)
 		pr_warn("%s: unregistering prepared clock: %s\n",
diff --git a/drivers/clk/clk_resource_test.c b/drivers/clk/clk_resource_test.c
new file mode 100644
index 000000000000..99f6888e5480
--- /dev/null
+++ b/drivers/clk/clk_resource_test.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Tests for resource and parent-fault recovery during clock transitions. */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+
+#include <kunit/clk.h>
+#include <kunit/test.h>
+
+struct clk_resource_test_clock {
+	struct clk_hw hw;
+	struct clk *clk;
+	unsigned long rate;
+	unsigned int acquire_calls;
+	unsigned int release_calls;
+	unsigned int set_rate_calls;
+	int release_error;
+	int parent_error;
+	u8 parent_index;
+};
+
+#define to_clk_resource_test(_hw) \
+	container_of(_hw, struct clk_resource_test_clock, hw)
+
+static unsigned long clk_resource_test_recalc(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	return to_clk_resource_test(hw)->rate;
+}
+
+static unsigned long clk_resource_test_pass_recalc(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	return parent_rate;
+}
+
+static int clk_resource_test_determine(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	return 0;
+}
+
+static int clk_resource_test_pass_determine(struct clk_hw *hw,
+					    struct clk_rate_request *req)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	struct clk_rate_request parent_req;
+	int ret;
+
+	clk_hw_forward_rate_request(hw, req, parent, &parent_req, req->rate);
+	ret = __clk_determine_rate(parent, &parent_req);
+	if (ret)
+		return ret;
+
+	req->rate = parent_req.rate;
+	req->best_parent_rate = parent_req.rate;
+	req->best_parent_hw = parent;
+
+	return 0;
+}
+
+static int clk_resource_test_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_resource_test_clock *clock = to_clk_resource_test(hw);
+
+	clock->rate = rate;
+	clock->set_rate_calls++;
+
+	return 0;
+}
+
+static int
+clk_resource_test_acquire(struct clk_hw *hw,
+			  const struct clk_resource_transition *transition,
+			  void **cookie)
+{
+	to_clk_resource_test(hw)->acquire_calls++;
+	*cookie = NULL;
+
+	return 0;
+}
+
+static int
+clk_resource_test_release(struct clk_hw *hw,
+			  const struct clk_resource_transition *transition,
+			  void *cookie, enum clk_resource_change_result result)
+{
+	struct clk_resource_test_clock *clock = to_clk_resource_test(hw);
+
+	clock->release_calls++;
+
+	return clock->release_error;
+}
+
+static u8 clk_resource_test_get_parent(struct clk_hw *hw)
+{
+	return to_clk_resource_test(hw)->parent_index;
+}
+
+static int clk_resource_test_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_resource_test_clock *clock = to_clk_resource_test(hw);
+
+	if (clock->parent_error)
+		return clock->parent_error;
+	clock->parent_index = index;
+
+	return 0;
+}
+
+static const struct clk_ops clk_resource_test_rate_ops = {
+	.recalc_rate = clk_resource_test_recalc,
+	.determine_rate = clk_resource_test_determine,
+	.set_rate = clk_resource_test_set_rate,
+	.resource_acquire = clk_resource_test_acquire,
+	.resource_release = clk_resource_test_release,
+};
+
+static const struct clk_ops clk_resource_test_pass_ops = {
+	.recalc_rate = clk_resource_test_pass_recalc,
+	.determine_rate = clk_resource_test_pass_determine,
+};
+
+static const struct clk_ops clk_resource_test_mux_ops = {
+	.determine_rate = __clk_mux_determine_rate,
+	.recalc_rate = clk_resource_test_pass_recalc,
+	.get_parent = clk_resource_test_get_parent,
+	.set_parent = clk_resource_test_set_parent,
+};
+
+static struct clk_resource_test_clock *
+clk_resource_test_register(struct kunit *test, const char *name,
+			   const struct clk_ops *ops,
+			   const struct clk_hw **parents, u8 num_parents,
+			   unsigned long flags)
+{
+	struct clk_init_data init = {
+		.name = name,
+		.ops = ops,
+		.parent_hws = parents,
+		.num_parents = num_parents,
+		.flags = flags,
+	};
+	struct clk_resource_test_clock *clock;
+	int ret;
+
+	clock = kunit_kzalloc(test, sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return ERR_PTR(-ENOMEM);
+
+	clock->rate = 100;
+	clock->hw.init = &init;
+	ret = clk_hw_register_kunit(test, NULL, &clock->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	clock->clk = clk_hw_get_clk_kunit(test, &clock->hw, NULL);
+	if (IS_ERR(clock->clk))
+		return ERR_CAST(clock->clk);
+
+	return clock;
+}
+
+static void clk_resource_retry_reconciles_ancestor_test(struct kunit *test)
+{
+	struct clk_resource_test_clock *root, *middle, *leaf;
+	const struct clk_hw *parents[1];
+
+	root = clk_resource_test_register(test, "resource-root",
+					  &clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	parents[0] = &root->hw;
+	middle = clk_resource_test_register(test, "resource-middle",
+					    &clk_resource_test_pass_ops, parents, 1,
+					    CLK_SET_RATE_PARENT);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, middle);
+	parents[0] = &middle->hw;
+	leaf = clk_resource_test_register(test, "resource-leaf",
+					  &clk_resource_test_pass_ops, parents, 1,
+					  CLK_SET_RATE_PARENT);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, leaf);
+
+	root->release_error = -EIO;
+	KUNIT_ASSERT_EQ(test, -EIO, clk_set_rate(leaf->clk, 200));
+	KUNIT_ASSERT_EQ(test, 1U, root->release_calls);
+	root->release_error = 0;
+	KUNIT_EXPECT_EQ(test, 0, clk_set_rate(leaf->clk, 200));
+	KUNIT_EXPECT_EQ(test, 2U, root->release_calls);
+}
+
+static void clk_resource_unchanged_child_acquires_resources_test(struct kunit *test)
+{
+	struct clk_resource_test_clock *root, *child;
+	const struct clk_hw *parents[1];
+
+	root = clk_resource_test_register(test, "resource-root",
+					  &clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	parents[0] = &root->hw;
+	child = clk_resource_test_register(test, "resource-child",
+					   &clk_resource_test_rate_ops, parents, 1, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, child);
+
+	KUNIT_ASSERT_EQ(test, 0, clk_set_rate(root->clk, 200));
+	KUNIT_ASSERT_EQ(test, 1U, child->set_rate_calls);
+	KUNIT_EXPECT_EQ(test, 1U, child->acquire_calls);
+}
+
+static void clk_resource_unprepare_after_parent_fault_test(struct kunit *test)
+{
+	struct clk_resource_test_clock *old_parent, *new_parent, *mux;
+	const struct clk_hw *parents[2];
+
+	old_parent = clk_resource_test_register(test, "resource-old",
+						&clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_parent);
+	new_parent = clk_resource_test_register(test, "resource-new",
+						&clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_parent);
+	parents[0] = &old_parent->hw;
+	parents[1] = &new_parent->hw;
+	mux = clk_resource_test_register(test, "resource-mux",
+					 &clk_resource_test_mux_ops, parents, 2, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mux);
+
+	KUNIT_ASSERT_EQ(test, 0, clk_prepare_enable(mux->clk));
+	mux->parent_error = -EIO;
+	KUNIT_ASSERT_EQ(test, -EIO, clk_set_parent(mux->clk, new_parent->clk));
+	clk_disable_unprepare(mux->clk);
+	mux->parent_error = 0;
+	KUNIT_EXPECT_EQ(test, 0, clk_set_parent(mux->clk, new_parent->clk));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(&old_parent->hw));
+	KUNIT_EXPECT_EQ(test, 0U, __clk_get_enable_count(mux->clk));
+}
+
+static void clk_resource_prepare_after_parent_fault_test(struct kunit *test)
+{
+	struct clk_resource_test_clock *old_parent, *new_parent, *mux;
+	const struct clk_hw *parents[2];
+
+	old_parent = clk_resource_test_register(test, "resource-old",
+						&clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_parent);
+	new_parent = clk_resource_test_register(test, "resource-new",
+						&clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_parent);
+	parents[0] = &old_parent->hw;
+	parents[1] = &new_parent->hw;
+	mux = clk_resource_test_register(test, "resource-mux",
+					 &clk_resource_test_mux_ops, parents, 2,
+					 CLK_OPS_PARENT_ENABLE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mux);
+
+	mux->parent_error = -EIO;
+	KUNIT_ASSERT_EQ(test, -EIO, clk_set_parent(mux->clk, new_parent->clk));
+	KUNIT_ASSERT_EQ(test, 0, clk_prepare_enable(mux->clk));
+	mux->parent_error = 0;
+	KUNIT_EXPECT_EQ(test, 0, clk_set_parent(mux->clk, new_parent->clk));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(&old_parent->hw));
+	KUNIT_EXPECT_EQ(test, 1U, __clk_get_enable_count(mux->clk));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(&mux->hw));
+	clk_disable_unprepare(mux->clk);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(&new_parent->hw));
+}
+
+static void clk_resource_ancestor_parent_fault_recovery_test(struct kunit *test)
+{
+	struct clk_resource_test_clock *old_parent, *new_parent, *mux, *leaf;
+	const struct clk_hw *parents[2];
+
+	old_parent = clk_resource_test_register(test, "resource-old",
+						&clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_parent);
+	new_parent = clk_resource_test_register(test, "resource-new",
+						&clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_parent);
+	parents[0] = &old_parent->hw;
+	parents[1] = &new_parent->hw;
+	mux = clk_resource_test_register(test, "resource-mux",
+					 &clk_resource_test_mux_ops, parents, 2, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mux);
+	parents[0] = &mux->hw;
+	leaf = clk_resource_test_register(test, "resource-leaf",
+					  &clk_resource_test_pass_ops, parents, 1,
+					  CLK_SET_RATE_PARENT);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, leaf);
+
+	mux->parent_error = -EIO;
+	KUNIT_ASSERT_EQ(test, -EIO, clk_set_parent(mux->clk, new_parent->clk));
+	KUNIT_EXPECT_EQ(test, -EBUSY, clk_set_rate(leaf->clk, 100));
+	mux->parent_error = 0;
+	KUNIT_ASSERT_EQ(test, 0, clk_set_parent(mux->clk, new_parent->clk));
+	KUNIT_EXPECT_EQ(test, 0, clk_set_rate(leaf->clk, 100));
+}
+
+static void clk_resource_grandparent_fault_test(struct kunit *test, bool rate_change)
+{
+	struct clk_resource_test_clock *old_root, *new_root;
+	struct clk_resource_test_clock *old_parent, *new_parent, *mux;
+	const struct clk_hw *parents[2];
+	int ret;
+
+	old_root = clk_resource_test_register(test, "resource-old-root",
+					      &clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_root);
+	new_root = clk_resource_test_register(test, "resource-new-root",
+					      &clk_resource_test_rate_ops, NULL, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_root);
+	KUNIT_ASSERT_EQ(test, 0, clk_set_rate(new_root->clk, 200));
+
+	parents[0] = &old_root->hw;
+	old_parent = clk_resource_test_register(test, "resource-old-parent",
+						&clk_resource_test_pass_ops, parents, 1, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_parent);
+	parents[0] = &new_root->hw;
+	new_parent = clk_resource_test_register(test, "resource-new-parent",
+						&clk_resource_test_pass_ops, parents, 1, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_parent);
+	parents[0] = &old_parent->hw;
+	parents[1] = &new_parent->hw;
+	mux = clk_resource_test_register(test, "resource-grandparent-mux",
+					 &clk_resource_test_mux_ops, parents, 2, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mux);
+
+	KUNIT_ASSERT_EQ(test, 0, clk_prepare_enable(mux->clk));
+	mux->parent_error = -EIO;
+	if (rate_change)
+		ret = clk_set_rate(mux->clk, 200);
+	else
+		ret = clk_set_parent(mux->clk, new_parent->clk);
+	KUNIT_EXPECT_EQ(test, -EIO, ret);
+
+	clk_disable_unprepare(mux->clk);
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(&old_root->hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(&new_root->hw));
+
+	mux->parent_error = 0;
+	if (rate_change)
+		ret = clk_set_rate(mux->clk, 200);
+	else
+		ret = clk_set_parent(mux->clk, new_parent->clk);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(&old_root->hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(&new_root->hw));
+	KUNIT_EXPECT_EQ(test, 0U, __clk_get_enable_count(mux->clk));
+}
+
+static void clk_resource_grandparent_set_parent_fault_test(struct kunit *test)
+{
+	clk_resource_grandparent_fault_test(test, false);
+}
+
+static void clk_resource_grandparent_set_rate_fault_test(struct kunit *test)
+{
+	clk_resource_grandparent_fault_test(test, true);
+}
+
+static struct kunit_case clk_resource_recovery_test_cases[] = {
+	KUNIT_CASE(clk_resource_retry_reconciles_ancestor_test),
+	KUNIT_CASE(clk_resource_unchanged_child_acquires_resources_test),
+	KUNIT_CASE(clk_resource_unprepare_after_parent_fault_test),
+	KUNIT_CASE(clk_resource_prepare_after_parent_fault_test),
+	KUNIT_CASE(clk_resource_ancestor_parent_fault_recovery_test),
+	KUNIT_CASE(clk_resource_grandparent_set_parent_fault_test),
+	KUNIT_CASE(clk_resource_grandparent_set_rate_fault_test),
+	{}
+};
+
+static struct kunit_suite clk_resource_recovery_test_suite = {
+	.name = "clk-resource-recovery",
+	.test_cases = clk_resource_recovery_test_cases,
+};
+
+kunit_test_suite(clk_resource_recovery_test_suite);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 8860e9a6e43e..5e045faed198 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -26,6 +26,183 @@ static const struct clk_ops empty_clk_ops = { };
 #define DUMMY_CLOCK_RATE_1		(142 * HZ_PER_MHZ)
 #define DUMMY_CLOCK_RATE_2		(242 * HZ_PER_MHZ)
 
+enum clk_resource_test_event {
+	CLK_RESOURCE_TEST_PREPARE,
+	CLK_RESOURCE_TEST_UNPREPARE,
+	CLK_RESOURCE_TEST_ACQUIRE,
+	CLK_RESOURCE_TEST_SET_RATE,
+	CLK_RESOURCE_TEST_RELEASE,
+};
+
+struct clk_resource_test_context {
+	struct clk_hw hw;
+	struct clk *clk;
+	enum clk_resource_test_event events[16];
+	unsigned int num_events;
+	int resource_release_error;
+	unsigned long rate;
+};
+
+static void clk_resource_test_record(struct clk_resource_test_context *ctx,
+				     enum clk_resource_test_event event)
+{
+	ctx->events[ctx->num_events++] = event;
+}
+
+static int clk_resource_test_prepare(struct clk_hw *hw)
+{
+	struct clk_resource_test_context *ctx =
+		container_of(hw, struct clk_resource_test_context, hw);
+
+	clk_resource_test_record(ctx, CLK_RESOURCE_TEST_PREPARE);
+
+	return 0;
+}
+
+static void clk_resource_test_unprepare(struct clk_hw *hw)
+{
+	struct clk_resource_test_context *ctx =
+		container_of(hw, struct clk_resource_test_context, hw);
+
+	clk_resource_test_record(ctx, CLK_RESOURCE_TEST_UNPREPARE);
+}
+
+static int
+clk_resource_test_acquire(struct clk_hw *hw,
+			  const struct clk_resource_transition *transition,
+			  void **cookie)
+{
+	struct clk_resource_test_context *ctx =
+		container_of(hw, struct clk_resource_test_context, hw);
+
+	clk_resource_test_record(ctx, CLK_RESOURCE_TEST_ACQUIRE);
+
+	return 0;
+}
+
+static int
+clk_resource_test_release(struct clk_hw *hw,
+			  const struct clk_resource_transition *transition,
+			  void *cookie,
+			  enum clk_resource_change_result result)
+{
+	struct clk_resource_test_context *ctx =
+		container_of(hw, struct clk_resource_test_context, hw);
+
+	clk_resource_test_record(ctx, CLK_RESOURCE_TEST_RELEASE);
+
+	return ctx->resource_release_error;
+}
+
+static unsigned long
+clk_resource_test_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_resource_test_context *ctx =
+		container_of(hw, struct clk_resource_test_context, hw);
+
+	return ctx->rate;
+}
+
+static int clk_resource_test_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
+{
+	return 0;
+}
+
+static int clk_resource_test_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_resource_test_context *ctx =
+		container_of(hw, struct clk_resource_test_context, hw);
+
+	clk_resource_test_record(ctx, CLK_RESOURCE_TEST_SET_RATE);
+	ctx->rate = rate;
+
+	return 0;
+}
+
+static const struct clk_ops clk_resource_test_ops = {
+	.prepare = clk_resource_test_prepare,
+	.unprepare = clk_resource_test_unprepare,
+	.recalc_rate = clk_resource_test_recalc_rate,
+	.determine_rate = clk_resource_test_determine_rate,
+	.set_rate = clk_resource_test_set_rate,
+	.resource_acquire = clk_resource_test_acquire,
+	.resource_release = clk_resource_test_release,
+};
+
+static int clk_resource_test_init(struct kunit *test)
+{
+	struct clk_resource_test_context *ctx;
+	struct clk_init_data init = {
+		.name = "clk_resource_test",
+		.ops = &clk_resource_test_ops,
+	};
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->hw.init = &init;
+	ctx->rate = DUMMY_CLOCK_INIT_RATE;
+	test->priv = ctx;
+
+	ret = clk_hw_register_kunit(test, NULL, &ctx->hw);
+	if (ret)
+		return ret;
+
+	ctx->clk = clk_hw_get_clk_kunit(test, &ctx->hw, NULL);
+	if (IS_ERR(ctx->clk))
+		return PTR_ERR(ctx->clk);
+
+	return 0;
+}
+
+static void clk_resource_set_rate_test(struct kunit *test)
+{
+	struct clk_resource_test_context *ctx = test->priv;
+
+	KUNIT_ASSERT_EQ(test, 0, clk_set_rate(ctx->clk, DUMMY_CLOCK_RATE_1));
+	KUNIT_ASSERT_EQ(test, 3, ctx->num_events);
+	KUNIT_EXPECT_EQ(test, CLK_RESOURCE_TEST_ACQUIRE, ctx->events[0]);
+	KUNIT_EXPECT_EQ(test, CLK_RESOURCE_TEST_SET_RATE, ctx->events[1]);
+	KUNIT_EXPECT_EQ(test, CLK_RESOURCE_TEST_RELEASE, ctx->events[2]);
+}
+
+static void clk_resource_set_rate_release_failure_test(struct kunit *test)
+{
+	struct clk_resource_test_context *ctx = test->priv;
+	unsigned int first_event = ctx->num_events;
+
+	ctx->resource_release_error = -EIO;
+	KUNIT_EXPECT_EQ(test, -EIO,
+			clk_set_rate(ctx->clk, DUMMY_CLOCK_RATE_1));
+	KUNIT_EXPECT_EQ(test, DUMMY_CLOCK_RATE_1, clk_get_rate(ctx->clk));
+
+	ctx->resource_release_error = 0;
+	KUNIT_EXPECT_EQ(test, 0, clk_set_rate(ctx->clk, DUMMY_CLOCK_RATE_1));
+	KUNIT_ASSERT_EQ(test, first_event + 6, ctx->num_events);
+	KUNIT_EXPECT_EQ(test, CLK_RESOURCE_TEST_ACQUIRE,
+			ctx->events[first_event + 3]);
+	KUNIT_EXPECT_EQ(test, CLK_RESOURCE_TEST_SET_RATE,
+			ctx->events[first_event + 4]);
+	KUNIT_EXPECT_EQ(test, CLK_RESOURCE_TEST_RELEASE,
+			ctx->events[first_event + 5]);
+}
+
+static struct kunit_case clk_resource_test_cases[] = {
+	KUNIT_CASE(clk_resource_set_rate_test),
+	KUNIT_CASE(clk_resource_set_rate_release_failure_test),
+	{}
+};
+
+static struct kunit_suite clk_resource_test_suite = {
+	.name = "clk-resource",
+	.init = clk_resource_test_init,
+	.test_cases = clk_resource_test_cases,
+};
+
 struct clk_dummy_context {
 	struct clk_hw hw;
 	unsigned long rate;
@@ -3895,6 +4072,7 @@ kunit_test_suites(
 	&clk_assigned_sscs_suite,
 	&clk_hw_get_dev_of_node_test_suite,
 	&clk_parse_clkspec_test_suite,
+	&clk_resource_test_suite,
 	&clk_leaf_mux_set_rate_parent_test_suite,
 	&clk_test_suite,
 	&clk_multiple_parents_mux_test_suite,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a355d1ee5189..f2b4053ee8c0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -119,6 +119,21 @@ struct clk_spread_spectrum {
 	enum clk_ssc_method method;
 };
 
+enum clk_resource_change_result {
+	CLK_RESOURCE_NO_HW_CHANGE,
+	CLK_RESOURCE_HW_CHANGED,
+	CLK_RESOURCE_COMPLETE,
+};
+
+struct clk_resource_transition {
+	unsigned long old_rate;
+	unsigned long new_rate;
+	unsigned long actual_rate;
+	struct clk_hw *old_parent;
+	struct clk_hw *new_parent;
+	struct clk_hw *actual_parent;
+};
+
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
@@ -256,6 +271,23 @@ struct clk_spread_spectrum {
  *		directory is provided as an argument.  Called with
  *		prepare_lock held.  Returns 0 on success, -EERROR otherwise.
  *
+ * @resource_acquire: Acquire the resources required for a planned rate or parent
+ *		transition. Called for the affected tree before PRE rate notifiers.
+ * @resource_release: Reconcile resource requirements and release temporary
+ *		resources after the whole affected tree has completed or stopped.
+ *		The result describes whether hardware was untouched, may have
+ *		changed, or completed successfully. The actual clock state is
+ *		reported in the transition.
+ *
+ * The resource operations allow a clock provider to describe resources which
+ * must remain available during a rate or parent transition. Callback pairs are
+ * mandatory: a provider defining @resource_acquire must define
+ * @resource_release. Both callbacks may sleep and run under the CCF prepare
+ * lock. A successful @resource_acquire transfers ownership of the cookie to
+ * @resource_release, which must consume it for every result even when
+ * release returns an error. For CLK_RESOURCE_HW_CHANGED, the actual fields
+ * contain CCF's best configured state and may not describe partially programmed
+ * hardware.
  *
  * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
  * implementations to split any work between atomic (enable) and sleepable
@@ -303,6 +335,13 @@ struct clk_ops {
 	int		(*init)(struct clk_hw *hw);
 	void		(*terminate)(struct clk_hw *hw);
 	void		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
+	int		(*resource_acquire)(struct clk_hw *hw,
+				const struct clk_resource_transition *transition,
+				void **cookie);
+	int		(*resource_release)(struct clk_hw *hw,
+				 const struct clk_resource_transition *transition,
+				 void *cookie,
+				 enum clk_resource_change_result result);
 };
 
 /**

-- 
2.56.0

