From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] base: fix a missing check of clk_prepare
Date: Tue, 25 Dec 2018 20:47:00 -0600
Message-ID: <20181226024700.72318-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

clk_prepare() could fail, so let's check its status, and if it fails,
issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/base/power/clock_ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 5a42ae4078c2..cb6144fb24e2 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 	if (IS_ERR(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
 	} else {
-		clk_prepare(ce->clk);
+		if (clk_prepare(ce->clk))
+			dev_err(dev, "clk_prepare failed.\n");
+
 		ce->status = PCE_STATUS_ACQUIRED;
 		dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
 			ce->clk, ce->con_id);
-- 
2.17.2 (Apple Git-113)
