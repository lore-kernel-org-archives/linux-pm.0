From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [PATCH] PM: Fix kernel-doc notation
Date: Sun, 22 Nov 2009 13:43:57 +0530
Message-ID: <1258877637.4495.45.camel__20463.4833186448$1258877888$gmane$org@ht.satnam>
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
To: Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Fix the following htmldocs warnings:

  Warning(drivers/base/power/main.c:249): No description found for parameter 'master'
  Warning(drivers/base/power/main.c:249): Excess function parameter 'slave' description in 'device_pm_wait_for_slaves'
  Warning(drivers/base/power/main.c:292): No description found for parameter 'master'
  Warning(drivers/base/power/main.c:292): Excess function parameter 'slave' description in 'device_pm_check_slaves'

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/base/power/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e8d1ea6..5f13084 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -243,7 +243,7 @@ static void device_pm_wait_for_masters(struct device *slave)
 
 /**
  * device_pm_wait_for_slaves - Wait for all slaves of given device.
- * @slave: Device to wait for the slaves of.
+ * @master: Device to wait for the slaves of.
  */
 static void device_pm_wait_for_slaves(struct device *master)
 {
@@ -286,7 +286,7 @@ static int device_pm_check_masters(struct device *slave)
 
 /**
  * device_pm_check_slaves - Check power.op_complete for slaves of a device.
- * @slave: Device to check the slaves of.
+ * @master: Device to check the slaves of.
  */
 static int device_pm_check_slaves(struct device *master)
 {
-- 
1.6.5.3
