From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: suspend-to-mem broken by eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
Date: Mon, 05 Jun 2017 15:08:57 +0200
Message-ID: <21111815.riZgbS9lI9@aspire.rjw.lan>
References: <20170605090521.GA1912@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170605090521.GA1912@light.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 05, 2017 11:05:21 AM Dominik Brodowski wrote:
> Rafael,

Thanks for the report!

> unfortunately, commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI
> wakeups from suspend-to-idle) breaks suspend-to-mem on my Dell XPS 13
> (9343) up to v4.12-rc4: Issuing
> 
> 	$ echo "mem" > /sys/power/state
> 
> in the initramfs returns, after a while, with "write error: Resource
> busy", and the system *not* having entered the sleep state in between.

Why initramfs?

> In contrast thereto, 8a537ece3d94 (PM / wakeup: Integrate mechanism to abort
> transitions in progress) still works fine, and allows to enter
> suspend-to-mem. No real difference is to be seen in dmesg, with the notable
> exception of
> 
> 	ACPI: Low-level resume complete
> 	ACPI : EC: EC started
> 	PM: Restoring platform NVS memory
> 	Suspended for N.NNNN seconds
> 
> only showing up on working kernels. Reverting eed4d47efe95 on top of
> v4.12-rc4 restores suspend-to-mem to work as expected.

I'm sure it is not necessary to revert all of it.

I guess what happens is that you get a wakeup event during suspend which is
aborted as a result.

Please apply the partial revert below and see if it makes the issue go away.

---
 drivers/acpi/battery.c   |    2 +-
 drivers/acpi/button.c    |    4 ++--
 drivers/acpi/device_pm.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/battery.c
===================================================================
--- linux-pm.orig/drivers/acpi/battery.c
+++ linux-pm/drivers/acpi/battery.c
@@ -782,7 +782,7 @@ static int acpi_battery_update(struct ac
 	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
 	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
             (battery->capacity_now <= battery->alarm)))
-		pm_wakeup_hard_event(&battery->device->dev);
+		pm_wakeup_event(&battery->device->dev, 0);
 
 	return result;
 }
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -400,7 +400,7 @@ static void acpi_pm_notify_handler(acpi_
 	mutex_lock(&acpi_pm_notifier_lock);
 
 	if (adev->wakeup.flags.notifier_present) {
-		pm_wakeup_ws_event(adev->wakeup.ws, 0, true);
+		__pm_wakeup_event(adev->wakeup.ws, 0);
 		if (adev->wakeup.context.work.func)
 			queue_pm_work(&adev->wakeup.context.work);
 	}
Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -217,7 +217,7 @@ static int acpi_lid_notify_state(struct
 	}
 
 	if (state)
-		pm_wakeup_hard_event(&device->dev);
+		pm_wakeup_event(&device->dev, 0);
 
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
@@ -402,7 +402,7 @@ static void acpi_button_notify(struct ac
 		} else {
 			int keycode;
 
-			pm_wakeup_hard_event(&device->dev);
+			pm_wakeup_event(&device->dev, 0);
 			if (button->suspended)
 				break;
 

