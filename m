From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] pm: remove bus_type
	suspend_late()/resume_early() V2
Date: Thu, 21 May 2009 17:27:54 +0900
Message-ID: <20090521082754.1020.73349.sendpatchset@rx1.opensource.se>
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
Cc: akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove the ->suspend_late() and ->resume_early() callbacks
from struct bus_type V2. These callbacks are legacy stuff
at this point and since there seem to be no in-tree users
we may as well remove them. New users should use dev_pm_ops.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1:
 - Documentation/power/devices.txt changes

 Documentation/power/devices.txt |   34 +++++-----------------------------
 drivers/base/power/main.c       |    7 -------
 include/linux/device.h          |    2 --
 3 files changed, 5 insertions(+), 38 deletions(-)

--- 0001/Documentation/power/devices.txt
+++ work/Documentation/power/devices.txt	2009-05-21 17:19:48.000000000 +0900
@@ -75,9 +75,6 @@ may need to apply in domain-specific way
 struct bus_type {
 	...
 	int  (*suspend)(struct device *dev, pm_message_t state);
-	int  (*suspend_late)(struct device *dev, pm_message_t state);
-
-	int  (*resume_early)(struct device *dev);
 	int  (*resume)(struct device *dev);
 };
 
@@ -226,20 +223,7 @@ The phases are seen by driver notificati
 
 	This call should handle parts of device suspend logic that require
 	sleeping.  It probably does work to quiesce the device which hasn't
-	been abstracted into class.suspend() or bus.suspend_late().
-
-   3	bus.suspend_late(dev, message) is called with IRQs disabled, and
-	with only one CPU active.  Until the bus.resume_early() phase
-	completes (see later), IRQs are not enabled again.  This method
-	won't be exposed by all busses; for message based busses like USB,
-	I2C, or SPI, device interactions normally require IRQs.  This bus
-	call may be morphed into a driver call with bus-specific parameters.
-
-	This call might save low level hardware state that might otherwise
-	be lost in the upcoming low power state, and actually put the
-	device into a low power state ... so that in some cases the device
-	may stay partly usable until this late.  This "late" call may also
-	help when coping with hardware that behaves badly.
+	been abstracted into class.suspend().
 
 The pm_message_t parameter is currently used to refine those semantics
 (described later).
@@ -351,19 +335,11 @@ devices processing each phase's calls be
 
 The phases are seen by driver notifications issued in this order:
 
-   1	bus.resume_early(dev) is called with IRQs disabled, and with
-   	only one CPU active.  As with bus.suspend_late(), this method
-	won't be supported on busses that require IRQs in order to
-	interact with devices.
-
-	This reverses the effects of bus.suspend_late().
-
-   2	bus.resume(dev) is called next.  This may be morphed into a device
-   	driver call with bus-specific parameters; implementations may sleep.
-
-	This reverses the effects of bus.suspend().
+   1	bus.resume(dev) reverses the effects of bus.suspend().  This may
+	be morphed into a device driver call with bus-specific parameters;
+	implementations may sleep.
 
-   3	class.resume(dev) is called for devices associated with a class
+   2	class.resume(dev) is called for devices associated with a class
 	that has such a method.  Implementations may sleep.
 
 	This reverses the effects of class.suspend(), and would usually
--- 0001/drivers/base/power/main.c
+++ work/drivers/base/power/main.c	2009-05-21 17:19:42.000000000 +0900
@@ -334,9 +334,6 @@ static int __device_resume_noirq(struct 
 	if (dev->bus->pm) {
 		pm_dev_dbg(dev, state, "EARLY ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
-	} else if (dev->bus->resume_early) {
-		pm_dev_dbg(dev, state, "legacy EARLY ");
-		error = dev->bus->resume_early(dev);
 	}
  End:
 	TRACE_RESUME(error);
@@ -591,10 +588,6 @@ static int __device_suspend_noirq(struct
 	if (dev->bus->pm) {
 		pm_dev_dbg(dev, state, "LATE ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
-	} else if (dev->bus->suspend_late) {
-		pm_dev_dbg(dev, state, "legacy LATE ");
-		error = dev->bus->suspend_late(dev, state);
-		suspend_report_result(dev->bus->suspend_late, error);
 	}
 	return error;
 }
--- 0001/include/linux/device.h
+++ work/include/linux/device.h	2009-05-21 17:19:42.000000000 +0900
@@ -62,8 +62,6 @@ struct bus_type {
 	void (*shutdown)(struct device *dev);
 
 	int (*suspend)(struct device *dev, pm_message_t state);
-	int (*suspend_late)(struct device *dev, pm_message_t state);
-	int (*resume_early)(struct device *dev);
 	int (*resume)(struct device *dev);
 
 	struct dev_pm_ops *pm;
