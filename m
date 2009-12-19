From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: runtime PM documentation update
Date: Sat, 19 Dec 2009 22:47:17 +0100
Message-ID: <200912192247.17120.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912151710260.2643-100000@iolanthe.rowland.org>
	<200912182356.47978.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912182356.47978.rjw@sisk.pl>
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
List-Id: linux-pm@vger.kernel.org

On Friday 18 December 2009, Rafael J. Wysocki wrote:
> On Tuesday 15 December 2009, Alan Stern wrote:
> > This patch (as1318) updates the runtime PM documentation, adding a
> > section discussing the interaction between runtime PM and system sleep.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > ---
> > 
> > Rafael, if you want to edit or rephrase some of this, go right ahead.
> 
> OK, I'll send you back the edited version when it's ready.

It's appended, rebased on the patch sent here:
https://lists.linux-foundation.org/pipermail/linux-pm/2009-December/023712.html

Rafael

__
From: Alan Stern <stern@rowland.harvard.edu>
Subject: PM: Runtime PM documentation update

This patch (as1318) updates the runtime PM documentation, adding a
section discussing the interaction between runtime PM and system sleep.

[rjw: Rebased and modified to reflect the changes allowing device types and
 device classes to provide runtime PM callbacks.]

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/runtime_pm.txt |   50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

Index: linux-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- linux-2.6.orig/Documentation/power/runtime_pm.txt
+++ linux-2.6/Documentation/power/runtime_pm.txt
@@ -381,3 +381,53 @@ incremented by the core before executing
 may be desirable to suspend the device as soon as ->probe() or ->remove() has
 finished, so the PM core uses pm_runtime_idle_sync() to invoke the
 subsystem-level idle callback for the device at that time.
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
+for system sleep (device_may_wakeup(dev) returns 'false').  When this happens,
+the subsystem-level system suspend callback is responsible for changing the
+device's wake-up setting (it may leave that to the device driver's system
+suspend routine).  It may be necessary to resume the device and suspend it again
+in order to do so.  The same is true if the driver uses different power levels
+or other settings for run-time suspend and system sleep.
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
+If the device was suspended before the sleep began, then its run-time PM status
+will have to be updated to reflect the actual post-system sleep status.  The way
+to do this is:
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+The PM core always increments the run-time usage counter before calling the
+->prepare() callback and decrements it after calling the ->complete() callback.
+Hence disabling run-time PM temporarily like this will not cause any run-time
+suspend callbacks to be lost.
