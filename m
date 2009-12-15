From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: runtime PM documentation update
Date: Tue, 15 Dec 2009 17:11:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912151710260.2643-100000@iolanthe.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1318) updates the runtime PM documentation, adding a
section discussing the interaction between runtime PM and system sleep.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Rafael, if you want to edit or rephrase some of this, go right ahead.


Index: usb-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- usb-2.6.orig/Documentation/power/runtime_pm.txt
+++ usb-2.6/Documentation/power/runtime_pm.txt
@@ -376,3 +376,51 @@ incremented by the core before executing
 may be desirable to suspend the device as soon as ->probe() or ->remove() has
 finished, so the PM core uses pm_runtime_idle_sync() to invoke the device bus
 type's ->runtime_idle() callback at that time.
+
+6. Run-time PM and System Sleep
+
+Run-time PM and system sleep (i.e., system suspend and hibernation, also known
+as suspend-to-RAM and suspend-to-disk) interact with each other in a couple of
+ways.  If a device is active when a system sleep starts, everything is
+straightforward.  But what should happen if the device is already suspended?
+
+The device may have different wake-up settings for run-time PM and system sleep.
+For example, remote wake-up may be enabled for run-time suspend but disallowed
+for system sleep (device_may_wakeup(dev) returns 'false').  When this happens
+the driver is responsible for changing the device's wake-up setting.  It may be
+necessary to resume the device and suspend it again in order to do so.  The same
+is true if the driver uses different power levels or other settings for run-time
+suspend and system sleep.
+
+During system resume, devices generally should be brought back to full power,
+even if they were suspended before the system sleep began.  There are several
+reasons for this, including:
+
+  * The device might need to switch power levels, wake-up settings, etc.
+
+  * Remote wake-up events might have been lost by the firmware.
+
+  * The device's children may need the device to be at full power in order
+    to resume themselves.
+
+  * The driver's idea of the device state may not agree with the device's
+    physical state.  This can happen during resume from hibernation.
+
+  * The device might need to be reset.
+
+  * Even though the device was suspended, if its usage counter was > 0 then most
+    likely it would need a run-time resume in the near future anyway.
+
+  * Always going back to full power is simplest.
+
+If the device was suspended before the sleep began then the driver will have to
+update the device's run-time PM status.  The way to do this is:
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+The PM core always increments the run-time usage counter before calling the
+->prepare() callback and decrements it after calling the ->complete() callback.
+Hence disabling run-time PM temporarily like this will not cause any run-time
+suspend callbacks to be lost.
