From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.12-rc4] pm diagnostics update,
	check for errors
Date: Sun, 8 May 2005 17:15:20 -0700
Message-ID: <200505081715.20470.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YuqfCs0gvrt7951"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_YuqfCs0gvrt7951
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've had this for a while, and converting to a GIT repository is
incentive enough to send it out.  Mostly it just makes existing
diagnostics be more useful, but it also adds some error checking
for cases that can happen on non-trivial systems ... or when
userspace actions through /sys/.../power/state files break some
system integrity rules.

If nobody objects, I'll probably ask to merge this at some point.

- Dave

--Boundary-00=_YuqfCs0gvrt7951
Content-Type: text/x-diff;
  charset="us-ascii";
  name="power.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="power.patch"

This patch includes various tweaks in the messaging that appears during
system pm state transitions:

  * Warn about certain illegal calls in the device tree, like resuming
    child before parent or suspending parent before child.  This could
    happen easily enough through sysfs, or in some cases when drivers
    use device_pm_set_parent().

  * Be more consistent about dev_dbg() tracing ... do it for resume() and
    shutdown() too, and never if the driver doesn't have that method.

  * Say which type of system sleep state is being entered.

Except for the warnings, these only affect debug messaging.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/drivers/base/power/resume.c	2005-05-08 06:48:13 -07:00
+++ b/drivers/base/power/resume.c	2005-05-08 06:48:13 -07:00
@@ -22,8 +22,17 @@
 
 int resume_device(struct device * dev)
 {
-	if (dev->bus && dev->bus->resume)
+	if (dev->power.pm_parent
+			&& dev->power.pm_parent->power.power_state) {
+		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
+			dev->power.power_state,
+			dev->power.pm_parent->bus_id,
+			dev->power.pm_parent->power.power_state);
+	}
+	if (dev->bus && dev->bus->resume) {
+		dev_dbg(dev,"resuming\n");
 		return dev->bus->resume(dev);
+	}
 	return 0;
 }
 
--- a/drivers/base/power/shutdown.c	2005-05-08 06:48:13 -07:00
+++ b/drivers/base/power/shutdown.c	2005-05-08 06:48:13 -07:00
@@ -25,8 +25,10 @@
 		return 0;
 
 	if (dev->detach_state == DEVICE_PM_OFF) {
-		if (dev->driver && dev->driver->shutdown)
+		if (dev->driver && dev->driver->shutdown) {
+			dev_dbg(dev, "shutdown\n");
 			dev->driver->shutdown(dev);
+		}
 		return 0;
 	}
 	return dpm_runtime_suspend(dev, dev->detach_state);
@@ -52,13 +54,12 @@
 	struct device * dev;
 
 	down_write(&devices_subsys.rwsem);
-	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
-		pr_debug("shutting down %s: ", dev->bus_id);
+	list_for_each_entry_reverse(dev, &devices_subsys.kset.list,
+				kobj.entry) {
 		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("Ok\n");
+			dev_dbg(dev, "shutdown\n");
 			dev->driver->shutdown(dev);
-		} else
-			pr_debug("Ignored.\n");
+		}
 	}
 	up_write(&devices_subsys.rwsem);
 
--- a/drivers/base/power/suspend.c	2005-05-08 06:48:13 -07:00
+++ b/drivers/base/power/suspend.c	2005-05-08 06:48:13 -07:00
@@ -39,12 +39,25 @@
 {
 	int error = 0;
 
-	dev_dbg(dev, "suspending\n");
+	if (dev->power.power_state) {
+		dev_dbg(dev, "PM: suspend %d-->%d\n",
+			dev->power.power_state, state);
+	}
+	if (dev->power.pm_parent
+			&& dev->power.pm_parent->power.power_state) {
+		dev_err(dev,
+			"PM: suspend %d->%d, parent %s already %d\n",
+			dev->power.power_state, state,
+			dev->power.pm_parent->bus_id,
+			dev->power.pm_parent->power.power_state);
+	}
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && !dev->power.power_state) {
+		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
+	}
 
 	return error;
 }
--- a/kernel/power/main.c	2005-05-08 06:48:13 -07:00
+++ b/kernel/power/main.c	2005-05-08 06:48:13 -07:00
@@ -156,14 +156,14 @@
 		goto Unlock;
 	}
 
-	pr_debug("PM: Preparing system for suspend\n");
+	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
 
-	pr_debug("PM: Entering state.\n");
+	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
 	error = suspend_enter(state);
 
-	pr_debug("PM: Finishing up.\n");
+	pr_debug("PM: Finishing wakeup.\n");
 	suspend_finish(state);
  Unlock:
 	up(&pm_sem);

--Boundary-00=_YuqfCs0gvrt7951
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_YuqfCs0gvrt7951--
