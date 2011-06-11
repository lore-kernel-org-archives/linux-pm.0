From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/8] PM / Domains: Update documentation
Date: Sat, 11 Jun 2011 22:25:18 +0200
Message-ID: <201106112225.18266.rjw__49940.9927092076$1307824933$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106112223.04972.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit 4d27e9dcff00a6425d779b065ec8892e4f391661 (PM: Make power
domain callbacks take precedence over subsystem ones) forgot to
update the device power management documentation to take changes
made by it into account.  Correct that mistake.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/devices.txt |   39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

Index: linux-2.6/Documentation/power/devices.txt
===================================================================
--- linux-2.6.orig/Documentation/power/devices.txt
+++ linux-2.6/Documentation/power/devices.txt
@@ -520,33 +520,20 @@ Support for power domains is provided th
 device.  This field is a pointer to an object of type struct dev_power_domain,
 defined in include/linux/pm.h, providing a set of power management callbacks
 analogous to the subsystem-level and device driver callbacks that are executed
-for the given device during all power transitions, in addition to the respective
-subsystem-level callbacks.  Specifically, the power domain "suspend" callbacks
-(i.e. ->runtime_suspend(), ->suspend(), ->freeze(), ->poweroff(), etc.) are
-executed after the analogous subsystem-level callbacks, while the power domain
-"resume" callbacks (i.e. ->runtime_resume(), ->resume(), ->thaw(), ->restore,
-etc.) are executed before the analogous subsystem-level callbacks.  Error codes
-returned by the "suspend" and "resume" power domain callbacks are ignored.
+for the given device during all power transitions, instead of the respective
+subsystem-level callbacks.  Specifically, if a device's pm_domain pointer is
+not NULL, the ->suspend() callback from the object pointed to by it will be
+executed instead of its subsystem's (e.g. bus type's) ->suspend() callback and
+anlogously for all of the remaining callbacks.  In other words, power management
+domain callbacks, if defined for the given device, always take precedence over
+the callbacks provided by the device's subsystem (e.g. bus type).
 
-Power domain ->runtime_idle() callback is executed before the subsystem-level
-->runtime_idle() callback and the result returned by it is not ignored.  Namely,
-if it returns error code, the subsystem-level ->runtime_idle() callback will not
-be called and the helper function rpm_idle() executing it will return error
-code.  This mechanism is intended to help platforms where saving device state
-is a time consuming operation and should only be carried out if all devices
-in the power domain are idle, before turning off the shared power resource(s).
-Namely, the power domain ->runtime_idle() callback may return error code until
-the pm_runtime_idle() helper (or its asychronous version) has been called for
-all devices in the power domain (it is recommended that the returned error code
-be -EBUSY in those cases), preventing the subsystem-level ->runtime_idle()
-callback from being run prematurely.
-
-The support for device power domains is only relevant to platforms needing to
-use the same subsystem-level (e.g. platform bus type) and device driver power
-management callbacks in many different power domain configurations and wanting
-to avoid incorporating the support for power domains into the subsystem-level
-callbacks.  The other platforms need not implement it or take it into account
-in any way.
+The support for device power management domains is only relevant to platforms
+needing to use the same device driver power management callbacks in many
+different power domain configurations and wanting to avoid incorporating the
+support for power domains into subsystem-level callbacks, for example by
+modifying the platform bus type.  Other platforms need not implement it or take
+it into account in any way.
 
 
 Device Low Power (suspend) States
