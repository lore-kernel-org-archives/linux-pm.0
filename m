From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH] PM / Runtime: allow _put_sync() from
	interrupts-disabled context
Date: Fri, 22 Jul 2011 14:17:11 -0700
Message-ID: <1311369431-28775-1-git-send-email-khilman__18281.0150356547$1311369477$gmane$org@ti.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Currently the use of pm_runtime_put_sync() is not safe from
interrupts-disabled context because rpm_idle() will release the
spinlock and enable interrupts for the idle callbacks.  This enables
interrupts during a time where interrupts were expected to be
disabled, and can have strange side effects on drivers that expected
interrupts to be disabled.

This is not a bug since the documentation clearly states that only
_put_sync_suspend() is safe in IRQ-safe mode.

However, pm_runtime_put_sync() could be made safe when in IRQ-safe
mode by releasing the spinlock but not re-enabling interrupts, which
is what this patch aims to do.

Problem was found when using some buggy drivers that set
pm_runtime_irq_safe() and used _put_sync() in interrupts-disabled
context.

The offending drivers have been fixed to use _put_sync_suspend(),
But this patch is an RFC to see if it might make sense to allow
using _put_sync() from interrupts-disabled context.

Reported-by: Colin Cross <ccross@google.com>
Tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/base/power/runtime.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8dc247c..acb3f83 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -226,11 +226,17 @@ static int rpm_idle(struct device *dev, int rpmflags)
 		callback = NULL;
 
 	if (callback) {
-		spin_unlock_irq(&dev->power.lock);
+		if (dev->power.irq_safe)
+			spin_unlock(&dev->power.lock);
+		else
+			spin_unlock_irq(&dev->power.lock);
 
 		callback(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		if (dev->power.irq_safe)
+			spin_lock(&dev->power.lock);
+		else
+			spin_lock_irq(&dev->power.lock);
 	}
 
 	dev->power.idle_notification = false;
-- 
1.7.6
