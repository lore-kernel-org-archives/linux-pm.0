From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/37] PM: Remove obsolete
	/sys/devices/.../power/state docs
Date: Thu, 31 Jan 2008 23:37:08 -0500
Message-ID: <ee128c59cf30f5a013b309cf95c80f1561ca4388.1201840183.git.len.brown__17785.1319931962$1201843720$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
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
Cc: David Brownell <dbrownell@users.sourceforge.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

The /sys/devices/.../power/state files have been gone for a while
now, but I just noticed some documentation that still refers to
them.  (Fortunately described as DEPRECATED and WILL REMOVE).

Time to remove that obsolete documentation too ...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/power/devices.txt |   49 ---------------------------------------
 1 files changed, 0 insertions(+), 49 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index d0e79d5..c53d263 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -502,52 +502,3 @@ If the CPU can have a "cpufreq" driver, there also may be opportunities
 to shift to lower voltage settings and reduce the power cost of executing
 a given number of instructions.  (Without voltage adjustment, it's rare
 for cpufreq to save much power; the cost-per-instruction must go down.)
-
-
-/sys/devices/.../power/state files
-==================================
-For now you can also test some of this functionality using sysfs.
-
-	DEPRECATED:  USE "power/state" ONLY FOR DRIVER TESTING, AND
-	AVOID USING dev->power.power_state IN DRIVERS.
-
-	THESE WILL BE REMOVED.  IF THE "power/state" FILE GETS REPLACED,
-	IT WILL BECOME SOMETHING COUPLED TO THE BUS OR DRIVER.
-
-In each device's directory, there is a 'power' directory, which contains
-at least a 'state' file.  The value of this field is effectively boolean,
-PM_EVENT_ON or PM_EVENT_SUSPEND.
-
-   *	Reading from this file displays a value corresponding to
-	the power.power_state.event field.  All nonzero values are
-	displayed as "2", corresponding to a low power state; zero
-	is displayed as "0", corresponding to normal operation.
-
-   *	Writing to this file initiates a transition using the
-   	specified event code number; only '0', '2', and '3' are
-	accepted (without a newline); '2' and '3' are both
-	mapped to PM_EVENT_SUSPEND.
-
-On writes, the PM core relies on that recorded event code and the device/bus
-capabilities to determine whether it uses a partial suspend() or resume()
-sequence to change things so that the recorded event corresponds to the
-numeric parameter.
-
-   -	If the bus requires the irqs-disabled suspend_late()/resume_early()
-	phases, writes fail because those operations are not supported here.
-
-   -	If the recorded value is the expected value, nothing is done.
-
-   -	If the recorded value is nonzero, the device is partially resumed,
-	using the bus.resume() and/or class.resume() methods.
-
-   -	If the target value is nonzero, the device is partially suspended,
-	using the class.suspend() and/or bus.suspend() methods and the
-	PM_EVENT_SUSPEND message.
-
-Drivers have no way to tell whether their suspend() and resume() calls
-have come through the sysfs power/state file or as part of entering a
-system sleep state, except that when accessed through sysfs the normal
-parent/child sequencing rules are ignored.  Drivers (such as bus, bridge,
-or hub drivers) which expose child devices may need to enforce those rules
-on their own.
-- 
1.5.4.rc5.16.gc0279
