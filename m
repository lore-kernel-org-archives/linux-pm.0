From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/04] PM: Runtime PM v11 - add dev_pm_ops helpers
Date: Fri, 31 Jul 2009 21:26:49 +0900
Message-ID: <20090731122649.31004.17555.sendpatchset@rx1.opensource.se>
References: <20090731122639.31004.95390.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090731122639.31004.95390.sendpatchset@rx1.opensource.se>
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

 drivers/base/power/runtime.c |   10 ++++------
 include/linux/pm_runtime.h   |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

--- 0010/drivers/base/power/runtime.c
+++ work/drivers/base/power/runtime.c	2009-07-30 19:20:23.000000000 +0900
@@ -79,8 +79,8 @@ static int __pm_runtime_idle(struct devi
 
 	spin_unlock_irq(&dev->power.lock);
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle)
-		dev->bus->pm->runtime_idle(dev);
+	if (dev->bus)
+		pm_runtime_ops_idle(dev, dev->bus->pm);
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -177,8 +177,7 @@ int __pm_runtime_suspend(struct device *
 
 	spin_unlock_irq(&dev->power.lock);
 
-	retval = dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend ?
-		dev->bus->pm->runtime_suspend(dev) : -ENOSYS;
+	retval = dev->bus ? pm_runtime_ops_suspend(dev, dev->bus->pm) : -ENOSYS;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -319,8 +318,7 @@ int __pm_runtime_resume(struct device *d
 
 	spin_unlock_irq(&dev->power.lock);
 
-	retval = dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume ?
-		dev->bus->pm->runtime_resume(dev) : -ENOSYS;
+	retval = dev->bus ? pm_runtime_ops_resume(dev, dev->bus->pm) : -ENOSYS;
 
 	spin_lock_irq(&dev->power.lock);
 
--- 0010/include/linux/pm_runtime.h
+++ work/include/linux/pm_runtime.h	2009-07-30 19:27:17.000000000 +0900
@@ -108,4 +108,23 @@ static inline void pm_runtime_set_suspen
 	__pm_runtime_set_status(dev, RPM_SUSPENDED);
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
