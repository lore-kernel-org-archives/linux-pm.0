From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3.0-rc1] PM / runtime: fix broken iteration over
	clock ids
Date: Sun, 5 Jun 2011 15:31:12 +0200
Message-ID: <201106051531.32878.jkrzyszt__41704.0277891376$1307400879$gmane$org@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

In its current form, pm_runtime_clk_notify() iterates through sub-
strings of pm_clk_notifier_block.con_ids[0] rather than consecutive 
pm_clk_notifier_block.con_ids[] elements. As a noticeable result, McBSP1 
port no longer worked for me on updated arch/arm/mach-omap1/pm_bus.c 
(commit 600b776eb39a13a28b090ba9efceb0c69d4508aa, "OMAP1 / PM: Use 
generic clock manipulation routines for runtime PM"), not being able to 
activate "fck" when required.

Tested on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 drivers/base/power/clock_ops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- git/drivers/base/power/clock_ops.c.orig	2011-05-30 22:16:35.000000000 +0200
+++ git/drivers/base/power/clock_ops.c	2011-06-05 15:19:55.000000000 +0200
@@ -291,7 +291,7 @@ static int pm_runtime_clk_notify(struct 
 {
 	struct pm_clk_notifier_block *clknb;
 	struct device *dev = data;
-	char *con_id;
+	char **con_id;
 	int error;
 
 	dev_dbg(dev, "%s() %ld\n", __func__, action);
@@ -309,8 +309,8 @@ static int pm_runtime_clk_notify(struct 
 
 		dev->pwr_domain = clknb->pwr_domain;
 		if (clknb->con_ids[0]) {
-			for (con_id = clknb->con_ids[0]; *con_id; con_id++)
-				pm_runtime_clk_add(dev, con_id);
+			for (con_id = &clknb->con_ids[0]; *con_id; con_id++)
+				pm_runtime_clk_add(dev, *con_id);
 		} else {
 			pm_runtime_clk_add(dev, NULL);
 		}
