From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/05] PM: Runtime PM v13 - let bus-less devices
	succeed
Date: Fri, 07 Aug 2009 16:33:33 +0900
Message-ID: <20090807073333.22479.65407.sendpatchset@rx1.opensource.se>
References: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
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
Cc: gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch allows bus-less devices to pass as being
suspended even though there is no dev_pm_ops structure
to use to get the Runtime PM callbacks.

Workarounds the fact that "struct device platform_bus"
becomes the parent of otherwise parent-less platform
devices. Runtime suspend and resume of devices on the
platform bus is impossible without this change. It may
however be better to modify the actual struct device
than working around things in the Runtime PM core code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Please let me know if this Runtime PM core change is acceptable.

 Changes for v11->v13:
 - none

 drivers/base/power/runtime.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0008/drivers/base/power/runtime.c
+++ work/drivers/base/power/runtime.c	2009-08-07 13:45:22.000000000 +0900
@@ -174,7 +174,7 @@ int __pm_runtime_suspend(struct device *
 
 	spin_unlock_irq(&dev->power.lock);
 
-	retval = dev->bus ? pm_runtime_ops_suspend(dev, dev->bus->pm) : -ENOSYS;
+	retval = dev->bus ? pm_runtime_ops_suspend(dev, dev->bus->pm) : 0;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -329,7 +329,7 @@ int __pm_runtime_resume(struct device *d
 
 	spin_unlock_irq(&dev->power.lock);
 
-	retval = dev->bus ? pm_runtime_ops_resume(dev, dev->bus->pm) : -ENOSYS;
+	retval = dev->bus ? pm_runtime_ops_resume(dev, dev->bus->pm) : 0;
 
 	spin_lock_irq(&dev->power.lock);
 
