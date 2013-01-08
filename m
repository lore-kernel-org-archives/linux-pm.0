From: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Subject: [PATCH] clk: remove unreachable code
Date: Tue,  8 Jan 2013 18:33:11 +0530
Message-ID: <1357650191-30842-1-git-send-email-rajagopal.venkat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:64446 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab3AHNHk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jan 2013 08:07:40 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so187989dan.23
        for <linux-pm@vger.kernel.org>; Tue, 08 Jan 2013 05:07:39 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mturquette@linaro.org
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajagopal Venkat <rajagopal.venkat@linaro.org>

while reparenting a clock, NULL check is done for clock in
consideration and its new parent. So re-check is not required.
If done, else part becomes unreachable.

Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
---
 drivers/clk/clk.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 251e45d..f896584 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1048,10 +1048,7 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
 
 	hlist_del(&clk->child_node);
 
-	if (new_parent)
-		hlist_add_head(&clk->child_node, &new_parent->children);
-	else
-		hlist_add_head(&clk->child_node, &clk_orphan_list);
+	hlist_add_head(&clk->child_node, &new_parent->children);
 
 #ifdef CONFIG_COMMON_CLK_DEBUG
 	if (!inited)
-- 
1.7.10.4

