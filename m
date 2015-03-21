From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v3 04/13] clk: Add safe switch hook
Date: Fri, 20 Mar 2015 23:45:23 -0700
Message-ID: <1426920332-9340-5-git-send-email-sboyd@codeaurora.org>
References: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Sometimes clocks can't accept their parent source turning off
while the source is reprogrammed to a different rate. Most
notably CPU clocks require a way to switch away from the current
PLL they're running on, reprogram that PLL to a new rate, and
then switch back to the PLL with the new rate once they're done.
Add a hook that drivers can implement allowing them to return a
'safe parent' that they can switch their parent to while the
upstream source is reprogrammed to support this.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This patch is good enough for Krait, but soon I'll need to 
support a "safe rate" where we ask a clock what rate it needs to be running
at to be sure it's within voltage constraints. Right now safe parent
handles that problem on Krait, but on other platforms it won't work.

 drivers/clk/clk.c            | 61 ++++++++++++++++++++++++++++++++++++++------
 include/linux/clk-provider.h |  1 +
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0712bea649c1..ead015a8e047 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -56,9 +56,12 @@ struct clk_core {
 	struct clk_core		**parents;
 	u8			num_parents;
 	u8			new_parent_index;
+	u8			safe_parent_index;
 	unsigned long		rate;
 	unsigned long		req_rate;
+	unsigned long		old_rate;
 	unsigned long		new_rate;
+	struct clk_core		*safe_parent;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
 	unsigned long		flags;
@@ -1550,7 +1553,8 @@ out:
 static void clk_calc_subtree(struct clk_core *clk, unsigned long new_rate,
 			     struct clk_core *new_parent, u8 p_index)
 {
-	struct clk_core *child;
+	struct clk_core *child, *parent;
+	struct clk_hw *parent_hw;
 
 	clk->new_rate = new_rate;
 	clk->new_parent = new_parent;
@@ -1560,6 +1564,18 @@ static void clk_calc_subtree(struct clk_core *clk, unsigned long new_rate,
 	if (new_parent && new_parent != clk->parent)
 		new_parent->new_child = clk;
 
+	if (clk->ops->get_safe_parent) {
+		parent_hw = clk->ops->get_safe_parent(clk->hw);
+		if (parent_hw) {
+			parent = parent_hw->core;
+			p_index = clk_fetch_parent_index(clk, parent);
+			clk->safe_parent_index = p_index;
+			clk->safe_parent = parent;
+		}
+	} else {
+		clk->safe_parent = NULL;
+	}
+
 	hlist_for_each_entry(child, &clk->children, child_node) {
 		child->new_rate = clk_recalc(child, new_rate);
 		clk_calc_subtree(child, child->new_rate, NULL, 0);
@@ -1655,14 +1671,43 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *clk,
 						  unsigned long event)
 {
 	struct clk_core *child, *tmp_clk, *fail_clk = NULL;
+	struct clk_core *old_parent;
 	int ret = NOTIFY_DONE;
 
-	if (clk->rate == clk->new_rate)
+	if (clk->rate == clk->new_rate && event != POST_RATE_CHANGE)
 		return NULL;
 
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		if (clk->safe_parent)
+			clk->ops->set_parent(clk->hw, clk->safe_parent_index);
+		clk->old_rate = clk->rate;
+		break;
+	case POST_RATE_CHANGE:
+		if (clk->safe_parent) {
+			old_parent = __clk_set_parent_before(clk,
+							     clk->new_parent);
+			if (clk->ops->set_rate_and_parent) {
+				clk->ops->set_rate_and_parent(clk->hw,
+						clk->new_rate,
+						clk->new_parent ?
+						clk->new_parent->rate : 0,
+						clk->new_parent_index);
+			} else if (clk->ops->set_parent) {
+				clk->ops->set_parent(clk->hw,
+						clk->new_parent_index);
+			}
+			__clk_set_parent_after(clk, clk->new_parent,
+					       old_parent);
+		}
+		break;
+	}
+
 	if (clk->notifier_count) {
-		ret = __clk_notify(clk, event, clk->rate, clk->new_rate);
-		if (ret & NOTIFY_STOP_MASK)
+		if (event != POST_RATE_CHANGE || clk->old_rate != clk->rate)
+			ret = __clk_notify(clk, event, clk->old_rate,
+					   clk->new_rate);
+		if (ret & NOTIFY_STOP_MASK && event != POST_RATE_CHANGE)
 			fail_clk = clk;
 	}
 
@@ -1708,7 +1753,8 @@ clk_change_rate(struct clk_core *clk, unsigned long best_parent_rate)
 
 	old_rate = clk->rate;
 
-	if (clk->new_parent && clk->new_parent != clk->parent) {
+	if (clk->new_parent && clk->new_parent != clk->parent &&
+			!clk->safe_parent) {
 		old_parent = __clk_set_parent_before(clk, clk->new_parent);
 
 		if (clk->ops->set_rate_and_parent) {
@@ -1728,9 +1774,6 @@ clk_change_rate(struct clk_core *clk, unsigned long best_parent_rate)
 
 	clk->rate = clk->new_rate;
 
-	if (clk->notifier_count && old_rate != clk->rate)
-		__clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
-
 	/*
 	 * Use safe iteration, as change_rate can actually swap parents
 	 * for certain clock types.
@@ -1790,6 +1833,8 @@ static int clk_core_set_rate_nolock(struct clk_core *clk,
 
 	clk->req_rate = req_rate;
 
+	clk_propagate_rate_change(top, POST_RATE_CHANGE);
+
 	return ret;
 }
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f7a6f60f8e0c..bc0f6faaeda4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -183,6 +183,7 @@ struct clk_ops {
 					  struct clk_hw **best_parent_hw);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
+	struct clk_hw	*(*get_safe_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate);
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
