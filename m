From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] pm: fix comments to match runtime callback code
Date: Fri, 19 Nov 2010 17:48:52 +0200
Message-ID: <1290181732-9124-1-git-send-email-aaro.koskinen__12468.7454001561$1290188052$gmane$org@nokia.com>
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
To: linux-pm@lists.linux-foundation.org, rjw@sisk.pl, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit 05aa55dddb9ee4045c320661068bea78dad6a6e5 changed routines to
succeed if the driver handler is not defined. Comments were not updated.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/base/power/generic_ops.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 81f2c84..3d2c350 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_idle);
  *
  * If PM operations are defined for the @dev's driver and they include
  * ->runtime_suspend(), execute it and return its error code.  Otherwise,
- * return -EINVAL.
+ * return 0.
  */
 int pm_generic_runtime_suspend(struct device *dev)
 {
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
  *
  * If PM operations are defined for the @dev's driver and they include
  * ->runtime_resume(), execute it and return its error code.  Otherwise,
- * return -EINVAL.
+ * return 0.
  */
 int pm_generic_runtime_resume(struct device *dev)
 {
-- 
1.5.6.5
