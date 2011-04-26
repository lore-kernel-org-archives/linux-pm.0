From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [RFC PATCH v2 3/3] PM / Core: suspend_again support for
	platform_device
Date: Tue, 26 Apr 2011 10:31:11 +0900
Message-ID: <1303781471-2477-3-git-send-email-myungjoo.ham@samsung.com>
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
 drivers/base/platform.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f051cff..2586f06 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -909,6 +909,8 @@ static int platform_pm_restore_noirq(struct device *dev)
 	return ret;
 }
 
+#define platform_pm_suspend_again	pm_generic_suspend_again
+
 #else /* !CONFIG_HIBERNATION */
 
 #define platform_pm_freeze		NULL
@@ -919,6 +921,7 @@ static int platform_pm_restore_noirq(struct device *dev)
 #define platform_pm_thaw_noirq		NULL
 #define platform_pm_poweroff_noirq	NULL
 #define platform_pm_restore_noirq	NULL
+#define platform_pm_suspend_again	NULL
 
 #endif /* !CONFIG_HIBERNATION */
 
@@ -965,6 +968,7 @@ static const struct dev_pm_ops platform_dev_pm_ops = {
 	.runtime_suspend = platform_pm_runtime_suspend,
 	.runtime_resume = platform_pm_runtime_resume,
 	.runtime_idle = platform_pm_runtime_idle,
+	.suspend_again = platform_pm_suspend_again,
 };
 
 struct bus_type platform_bus_type = {
-- 
1.7.1
