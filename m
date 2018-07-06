From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Fri, 06 Jul 2018 14:13:04 +0200
Message-ID: <1704080.gFTvVrrZA1@aspire.rjw.lan>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de> <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas =?ISO-8859-1?Q?H=E4nig?= <haenig@cosifan.de>
Cc: Takashi Iwai <tiwai@suse.de>, Erik Schmauss <erik.schmauss@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 6, 2018 1:21:50 PM CEST Rafael J. Wysocki wrote:
> On Fri, Jul 6, 2018 at 1:12 PM, Thomas Hänig <haenig@cosifan.de> wrote:

[cut]
 
> So the latest patch:
> 
> https://patchwork.kernel.org/patch/10511211/
> 
> should work for you (please verify) and the change in
> drivers/acpi/sleep.c in it most likely is not necessary.
> 
> If you can confirm that this one works for you, I'll send a smaller
> one with the acpi_hw_legacy_sleep() part alone.

Well, scratch this, sorry.

The power button probably is a fixed event and it won't be effected by
that patch.

Instead, please test the patch below.

---
 drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
+++ linux-pm/drivers/acpi/acpica/hwsleep.c
@@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
 		return_ACPI_STATUS(status);
 	}
 
-	/*
-	 * 1) Disable all GPEs
-	 * 2) Enable all wakeup GPEs
-	 */
+	/* Disable all GPEs */
 	status = acpi_hw_disable_all_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
+	/*
+	 * If the target sleep state is S5, clear all GPEs and fixed events too
+	 */
+	if (sleep_state == ACPI_STATE_S5) {
+		status = acpi_hw_clear_acpi_status();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	}
 	acpi_gbl_system_awake_and_running = FALSE;
 
+	 /* Enable all wakeup GPEs */
 	status = acpi_hw_enable_all_wakeup_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
