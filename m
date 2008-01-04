From: Yi Yang <yi.y.yang@intel.com>
Subject: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Fri, 04 Jan 2008 18:10:14 +0800
Message-ID: <1199441414.19185.9.camel__20351.7906404615$1199461152$gmane$org@yangyi-dev.bj.intel.com>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
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
To: pavel@ucw.cz, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If a device can't support wakeup, its /sys/devices/.../power/wakeup output is
empty, this is confusing, a user doesn't know if it supports wakeup feature
unless he/she read the ralated source code, for this case, it is more
reasonable to output "unsupported". Otherwise, no matter what value the user
sets to /sys/devices/.../power/wakeup, the result is the same:  Invalid argument,
so the user doesn't know why.

This patch changes empty output to "unsupported" in order that a user knows
wakeup feature isn't supported by this device when he/she
'cat /sys/devices/.../power/wakeup', please consider to apply, thanks.

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
---
 sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/sysfs.c	2008-01-04 16:50:54.000000000 +0800
+++ b/drivers/base/power/sysfs.c	2008-01-04 17:14:42.000000000 +0800
@@ -49,7 +49,7 @@ wake_show(struct device * dev, struct de
 {
 	return sprintf(buf, "%s\n", device_can_wakeup(dev)
 		? (device_may_wakeup(dev) ? enabled : disabled)
-		: "");
+		: "unsupported");
 }
 
 static ssize_t
