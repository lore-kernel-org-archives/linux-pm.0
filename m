From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3] PM / OPP: fix debug/error messages in dev_pm_opp_of_get_sharing_cpus()
Date: Thu, 20 Oct 2016 16:12:49 +0900
Message-ID: <1476947569-23552-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conuserg-10.nifty.com ([210.131.2.77]:48029 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbcJTHLr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 03:11:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

These log messages are wrong because _of_get_opp_desc_node() returns
an operating-points-v2 node.

Commit a6eed752f5fb ("PM / OPP: passing NULL to PTR_ERR()") fixed
static checker warnings, and reworded the messages at the same time
(but the latter was not mentioned in the git-log).

Restore the correct messages.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Revive __func__

Changes in v2:
  - Reword git-log slightly
     comments -> log messages

 drivers/base/power/opp/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 6480137..5b3755e 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -562,7 +562,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 	/* Get OPP descriptor node */
 	np = _of_get_opp_desc_node(cpu_dev);
 	if (!np) {
-		dev_dbg(cpu_dev, "%s: Couldn't find cpu_dev node.\n", __func__);
+		dev_dbg(cpu_dev, "%s: Couldn't find opp node.\n", __func__);
 		return -ENOENT;
 	}
 
@@ -587,7 +587,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		/* Get OPP descriptor node */
 		tmp_np = _of_get_opp_desc_node(tcpu_dev);
 		if (!tmp_np) {
-			dev_err(tcpu_dev, "%s: Couldn't find tcpu_dev node.\n",
+			dev_err(tcpu_dev, "%s: Couldn't find opp node.\n",
 				__func__);
 			ret = -ENOENT;
 			goto put_cpu_node;
-- 
1.9.1

