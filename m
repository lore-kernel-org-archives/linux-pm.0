From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Runtime: Handle clocks correctly if
	CONFIG_PM_RUNTIME is unset
Date: Tue, 21 Jun 2011 01:28:51 +0200
Message-ID: <201106210128.52101.rjw__49258.164727553$1308612515$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit 85eb8c8d0b0900c073b0e6f89979ac9c439ade1a (PM / Runtime:
Generic clock manipulation rountines for runtime PM (v6)) converted
the shmobile platform to using generic code for runtime PM clock
management, but it changed the behavior for CONFIG_PM_RUNTIME unset
incorrectly.

Specifically, for CONFIG_PM_RUNTIME unset pm_runtime_clk_notify()
should enable clocks for action equal to BUS_NOTIFY_BIND_DRIVER and
it should disable them for action equal to BUS_NOTIFY_UNBOUND_DRIVER
(instead of BUS_NOTIFY_ADD_DEVICE and BUS_NOTIFY_DEL_DEVICE,
respectively).  Make this function behave as appropriate.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/clock_ops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/base/power/clock_ops.c
===================================================================
--- linux-2.6.orig/drivers/base/power/clock_ops.c
+++ linux-2.6/drivers/base/power/clock_ops.c
@@ -387,7 +387,7 @@ static int pm_runtime_clk_notify(struct
 	clknb = container_of(nb, struct pm_clk_notifier_block, nb);
 
 	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
+	case BUS_NOTIFY_BIND_DRIVER:
 		if (clknb->con_ids[0]) {
 			for (con_id = clknb->con_ids; *con_id; con_id++)
 				enable_clock(dev, *con_id);
@@ -395,7 +395,7 @@ static int pm_runtime_clk_notify(struct
 			enable_clock(dev, NULL);
 		}
 		break;
-	case BUS_NOTIFY_DEL_DEVICE:
+	case BUS_NOTIFY_UNBOUND_DRIVER:
 		if (clknb->con_ids[0]) {
 			for (con_id = clknb->con_ids; *con_id; con_id++)
 				disable_clock(dev, *con_id);
