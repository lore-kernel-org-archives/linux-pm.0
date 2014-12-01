From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2][Resend] ACPI / sleep: Drain outstanding events after disabling multiple GPEs
Date: Mon, 01 Dec 2014 02:54:31 +0100
Message-ID: <1548126.AOIkidq1WT@vostro.rjw.lan>
References: <2017469.J3BZteXtBu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2017469.J3BZteXtBu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After multiple GPEs have been disabled at the low level in one go,
like when acpi_disable_all_gpes() is called, we should always drain
all of the outstanding events from them, or interesting races become
possible.

For this reason, call acpi_os_wait_events_complete() after
acpi_enable_all_wakeup_gpes() and acpi_disable_all_gpes() in
acpi_freeze_prepare() and acpi_power_off_prepare(), respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -630,6 +630,7 @@ static int acpi_freeze_begin(void)
 static int acpi_freeze_prepare(void)
 {
 	acpi_enable_all_wakeup_gpes();
+	acpi_os_wait_events_complete();
 	enable_irq_wake(acpi_gbl_FADT.sci_interrupt);
 	return 0;
 }
@@ -825,6 +826,7 @@ static void acpi_power_off_prepare(void)
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
 	acpi_disable_all_gpes();
+	acpi_os_wait_events_complete();
 }
 
 static void acpi_power_off(void)

