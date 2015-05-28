From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / clock_ops: Print acquired clock name instead of con_id
Date: Thu, 28 May 2015 21:04:09 +0200
Message-ID: <1432839849-1432-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53717 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbE1TEQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 15:04:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Grygorii Strashko <Grygorii.Strashko@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently the con_id of the acquired clock is printed for debugging
purposes.  But in several cases, the con_id is NULL, which doesn't
provide much debugging information when printed.  These cases are:
  - When explicitly passing a NULL con_id (which means the first clock
    tied to the device, if available),
  - When not using pm_clk_add(), but pm_clk_add_clk() (which takes a
    "struct clk *" directly).

Hence print the actual clock name instead of the con_id.

As the clock name is not available with legacy clock frameworks, and a
(non-NULL) con_id is more useful than a hex address, keep printing the
con_id if the Common Clock Framework is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/clock_ops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 442ce010559bf531..6d56577903bd01e1 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -68,7 +68,11 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 	} else {
 		clk_prepare(ce->clk);
 		ce->status = PCE_STATUS_ACQUIRED;
+#ifdef CONFIG_COMMON_CLK
+		dev_dbg(dev, "Clock %pC managed by runtime PM.\n", ce->clk);
+#else
 		dev_dbg(dev, "Clock %s managed by runtime PM.\n", ce->con_id);
+#endif
 	}
 }
 
-- 
1.9.1

