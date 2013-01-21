From: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Subject: [PATCH] clk: allow reparenting of a clock to the orphan list
Date: Mon, 21 Jan 2013 18:33:57 +0530
Message-ID: <1358773437-21163-1-git-send-email-rajagopal.venkat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:62048 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab3AUNIG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jan 2013 08:08:06 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so3305563pbb.25
        for <linux-pm@vger.kernel.org>; Mon, 21 Jan 2013 05:08:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mturquette@linaro.org
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajagopal Venkat <rajagopal.venkat@linaro.org>

Allow reparenting of a clock(multiple and single parent)
to the orphan list when new parent clock is NULL.

Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
---
 drivers/clk/clk.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e964994..5c9277a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1102,7 +1102,7 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
 	struct dentry *new_parent_d;
 #endif
 
-	if (!clk || !new_parent)
+	if (!clk)
 		return;
 
 	hlist_del(&clk->child_node);
@@ -1140,11 +1140,14 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct clk *old_parent;
 	unsigned long flags;
-	int ret = -EINVAL;
-	u8 i;
+	int ret = 0;
+	u8 i = 0;
 
 	old_parent = clk->parent;
 
+	if (clk->num_parents == 1 || !parent)
+		goto migrate;
+
 	if (!clk->parents)
 		clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
 								GFP_KERNEL);
@@ -1165,11 +1168,13 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	}
 
 	if (i == clk->num_parents) {
+		ret = -EINVAL;
 		pr_debug("%s: clock %s is not a possible parent of clock %s\n",
 				__func__, parent->name, clk->name);
 		goto out;
 	}
 
+migrate:
 	/* migrate prepare and enable */
 	if (clk->prepare_count)
 		__clk_prepare(parent);
@@ -1181,7 +1186,8 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	spin_unlock_irqrestore(&enable_lock, flags);
 
 	/* change clock input source */
-	ret = clk->ops->set_parent(clk->hw, i);
+	if (clk->ops->set_parent)
+		ret = clk->ops->set_parent(clk->hw, i);
 
 	/* clean up old prepare and enable */
 	spin_lock_irqsave(&enable_lock, flags);
@@ -1215,7 +1221,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!clk || !clk->ops)
 		return -EINVAL;
 
-	if (!clk->ops->set_parent)
+	if (clk->num_parents > 1 && !clk->ops->set_parent)
 		return -ENOSYS;
 
 	/* prevent racing with updates to the clock topology */
@@ -1226,7 +1232,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	/* propagate PRE_RATE_CHANGE notifications */
 	if (clk->notifier_count)
-		ret = __clk_speculate_rates(clk, parent->rate);
+		ret = __clk_speculate_rates(clk, parent ? parent->rate : 0);
 
 	/* abort if a driver objects */
 	if (ret == NOTIFY_STOP)
-- 
1.7.10.4

