From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/05] PM: Runtime PM v13 - add dev_pm_ops helpers
Date: Fri, 07 Aug 2009 16:33:25 +0900
Message-ID: <20090807073325.22479.31226.sendpatchset@rx1.opensource.se>
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

This patch breaks out the dev_pm_ops handling code
for Runtime PM into separate functions. This change
makes is possible for the main code and separate
bus implementations to deal with callbacks and error
codes in a consistent fashion.

The broken out functions are used by the Runtime PM
platform device bus implementation for SuperH.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes for v11->v13:
 - solved conflicts introduced by v11->v13 update

 drivers/base/power/runtime.c |   29 ++++++++++-------------------
 include/linux/pm_runtime.h   |   19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 19 deletions(-)

--- 0007/drivers/base/power/runtime.c
+++ work/drivers/base/power/runtime.c	2009-08-07 13:42:57.000000000 +0900
@@ -77,13 +77,12 @@ static int __pm_runtime_idle(struct devi
 
 	dev->power.idle_notification = true;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irq(&dev->power.lock);
 
-		dev->bus->pm->runtime_idle(dev);
+	if (dev->bus)
+		pm_runtime_ops_idle(dev, dev->bus->pm);
 
-		spin_lock_irq(&dev->power.lock);
-	}
+	spin_lock_irq(&dev->power.lock);
 
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -173,15 +172,11 @@ int __pm_runtime_suspend(struct device *
 
 	dev->power.runtime_status = RPM_SUSPENDING;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irq(&dev->power.lock);
 
-		retval = dev->bus->pm->runtime_suspend(dev);
+	retval = dev->bus ? pm_runtime_ops_suspend(dev, dev->bus->pm) : -ENOSYS;
 
-		spin_lock_irq(&dev->power.lock);
-	} else {
-		retval = -ENOSYS;
-	}
+	spin_lock_irq(&dev->power.lock);
 
 	if (retval) {
 		dev->power.runtime_status = RPM_ACTIVE;
@@ -332,15 +327,11 @@ int __pm_runtime_resume(struct device *d
 
 	dev->power.runtime_status = RPM_RESUMING;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irq(&dev->power.lock);
 
-		retval = dev->bus->pm->runtime_resume(dev);
+	retval = dev->bus ? pm_runtime_ops_resume(dev, dev->bus->pm) : -ENOSYS;
 
-		spin_lock_irq(&dev->power.lock);
-	} else {
-		retval = -ENOSYS;
-	}
+	spin_lock_irq(&dev->power.lock);
 
 	if (retval) {
 		dev->power.runtime_status = RPM_SUSPENDED;
--- 0007/include/linux/pm_runtime.h
+++ work/include/linux/pm_runtime.h	2009-08-07 13:37:27.000000000 +0900
@@ -112,4 +112,23 @@ static inline int pm_runtime_disable(str
 	return __pm_runtime_disable(dev, true);
 }
 
+static inline int pm_runtime_ops_suspend(struct device *dev,
+					 struct dev_pm_ops *p)
+{
+	return p && p->runtime_suspend ? p->runtime_suspend(dev) : -ENOSYS;
+}
+
+static inline int pm_runtime_ops_resume(struct device *dev,
+					struct dev_pm_ops *p)
+{
+	return p && p->runtime_resume ? p->runtime_resume(dev) : -ENOSYS;
+}
+
+static inline void pm_runtime_ops_idle(struct device *dev,
+				       struct dev_pm_ops *p)
+{
+	if (p && p->runtime_idle)
+		p->runtime_idle(dev);
+}
+
 #endif
