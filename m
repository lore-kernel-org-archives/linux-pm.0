From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [RFC PATCH v2 2/3] PM / Core: suspend_again support for
	I2C
Date: Tue, 26 Apr 2011 10:31:10 +0900
Message-ID: <1303781471-2477-2-git-send-email-myungjoo.ham@samsung.com>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, kyungmin.park@samsung.com, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/i2c/i2c-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 70c30e6..5570f61 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -251,6 +251,7 @@ static int i2c_device_pm_restore(struct device *dev)
 	else
 		return i2c_legacy_resume(dev);
 }
+#define i2c_device_pm_suspend_again	pm_generic_suspend_again
 #else /* !CONFIG_PM_SLEEP */
 #define i2c_device_pm_suspend	NULL
 #define i2c_device_pm_resume	NULL
@@ -258,6 +259,7 @@ static int i2c_device_pm_restore(struct device *dev)
 #define i2c_device_pm_thaw	NULL
 #define i2c_device_pm_poweroff	NULL
 #define i2c_device_pm_restore	NULL
+#define i2c_device_pm_suspend_again	NULL
 #endif /* !CONFIG_PM_SLEEP */
 
 static void i2c_client_dev_release(struct device *dev)
@@ -305,6 +307,7 @@ static const struct dev_pm_ops i2c_device_pm_ops = {
 	.thaw = i2c_device_pm_thaw,
 	.poweroff = i2c_device_pm_poweroff,
 	.restore = i2c_device_pm_restore,
+	.suspend_again = i2c_device_pm_suspend_again,
 	SET_RUNTIME_PM_OPS(
 		pm_generic_runtime_suspend,
 		pm_generic_runtime_resume,
-- 
1.7.1
