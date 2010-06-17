From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Do not enable GPEs for system wakeup
	in advance
Date: Thu, 17 Jun 2010 17:40:57 +0200
Message-ID: <201006171740.57315.rjw__18270.9942957901$1276789523$gmane$org@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, kernel list <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

After commit 9630bdd9b15d2f489c646d8bc04b60e53eb5ec78
(ACPI: Use GPE reference counting to support shared GPEs) the wakeup
enable mask bits of GPEs are set as soon as the GPEs are enabled to
wake up the system.  Unfortunately, this leads to a regression
reported by Michal Hocko, where a system is woken up from ACPI S5 by
a device that is not supposed to do that, because the wakeup enable
mask bit of this device's GPE is always set when
acpi_enter_sleep_state() calls acpi_hw_enable_all_wakeup_gpes(),
although it should only be set if the device is supposed to wake up
the system from the target state.

To work around this issue, rework the ACPI power management code so
that GPEs are not enabled to wake up the system upfront, but only
during a system state transition when the target state of the system
is known.  [Of course, this means that the reference counting of
"wakeup" GPEs doesn't really make sense and it is sufficient to
set/unset the wakeup mask bits for them during system sleep
transitions.  This will allow us to simplify the GPE handling code
quite a bit, but that change is too intrusive for 2.6.35.]

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=15951

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Michal Hocko <mhocko@suse.cz>
---
Hi Len,

This is on top of the GPE fixes I send before that are in your tree.

Please apply.

Rafael
---
 drivers/acpi/button.c |    4 ++--
 drivers/acpi/wakeup.c |   20 +++++++-------------
 2 files changed, 9 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -425,7 +425,7 @@ static int acpi_button_add(struct acpi_d
 		/* Button's GPE is run-wake GPE */
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE_RUN);
+				ACPI_GPE_TYPE_RUNTIME);
 		device->wakeup.run_wake_count++;
 		device->wakeup.state.enabled = 1;
 	}
@@ -449,7 +449,7 @@ static int acpi_button_remove(struct acp
 	if (device->wakeup.flags.valid) {
 		acpi_disable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE_RUN);
+				ACPI_GPE_TYPE_RUNTIME);
 		device->wakeup.run_wake_count--;
 		device->wakeup.state.enabled = 0;
 	}
Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -64,16 +64,13 @@ void acpi_enable_wakeup_device(u8 sleep_
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
 
-		if (!dev->wakeup.flags.valid)
-			continue;
-
-		if ((!dev->wakeup.state.enabled && !dev->wakeup.prepare_count)
+		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled
 		    || sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
 		/* The wake-up power should have been enabled already. */
-		acpi_set_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
-				ACPI_GPE_ENABLE);
+		acpi_enable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+				ACPI_GPE_TYPE_WAKE);
 	}
 }
 
@@ -96,6 +93,8 @@ void acpi_disable_wakeup_device(u8 sleep
 		    || (sleep_state > (u32) dev->wakeup.sleep_state))
 			continue;
 
+		acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+				ACPI_GPE_TYPE_WAKE);
 		acpi_disable_wakeup_device_power(dev);
 	}
 }
@@ -109,13 +108,8 @@ int __init acpi_wakeup_device_init(void)
 		struct acpi_device *dev = container_of(node,
 						       struct acpi_device,
 						       wakeup_list);
-		/* In case user doesn't load button driver */
-		if (!dev->wakeup.flags.always_enabled ||
-		    dev->wakeup.state.enabled)
-			continue;
- 		acpi_enable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
- 				ACPI_GPE_TYPE_WAKE);
-		dev->wakeup.state.enabled = 1;
+		if (dev->wakeup.flags.always_enabled)
+			dev->wakeup.state.enabled = 1;
 	}
 	mutex_unlock(&acpi_device_lock);
 	return 0;
