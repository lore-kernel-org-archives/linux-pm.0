From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] PM / OPP: fix debug/error messages in dev_pm_opp_of_get_sharing_cpus()
Date: Thu, 20 Oct 2016 15:53:56 +0900
Message-ID: <1476946436-27425-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conuserg-10.nifty.com ([210.131.2.77]:55919 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbcJTGwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 02:52:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

These comments are wrong because _of_get_opp_desc_node() returns
an operating-points-v2 node.

Commit a6eed752f5fb ("PM / OPP: passing NULL to PTR_ERR()") fixed
static checker warnings, and reworded the messages at the same time
(but the latter was not mentioned in the git-log).

Restore the correct messages, dropping __func__.  We can grep the
message string, so the function name would not carry much value.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/base/power/opp/of.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 6480137..92e6d53 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -562,7 +562,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 	/* Get OPP descriptor node */
 	np = _of_get_opp_desc_node(cpu_dev);
 	if (!np) {
-		dev_dbg(cpu_dev, "%s: Couldn't find cpu_dev node.\n", __func__);
+		dev_dbg(cpu_dev, "Couldn't find opp node.\n");
 		return -ENOENT;
 	}
 
@@ -587,8 +587,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		/* Get OPP descriptor node */
 		tmp_np = _of_get_opp_desc_node(tcpu_dev);
 		if (!tmp_np) {
-			dev_err(tcpu_dev, "%s: Couldn't find tcpu_dev node.\n",
-				__func__);
+			dev_err(tcpu_dev, "Couldn't find opp node.\n");
 			ret = -ENOENT;
 			goto put_cpu_node;
 		}
-- 
1.9.1

