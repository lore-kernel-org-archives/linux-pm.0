From: "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: RE: [PATCH] ACPICA: Clear status of all events when entering S5
Date: Mon, 16 Jul 2018 17:59:27 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB4D759@ORSMSX110.amr.corp.intel.com>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <1704080.gFTvVrrZA1@aspire.rjw.lan>
 <6f01a906-b27c-0e1a-e9f6-fa27c015faa3@cosifan.de>
 <2396867.eZQXUlvGZn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2396867.eZQXUlvGZn@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: =?iso-8859-1?Q?Thomas_H=E4nig?= <haenig@cosifan.de>, Takashi Iwai <tiwai@suse.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Sunday, July 8, 2018 2:10 AM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: Thomas Hänig <haenig@cosifan.de>; Takashi Iwai <tiwai@suse.de>;
> Schmauss, Erik <erik.schmauss@intel.com>; Linux PM <linux-
> pm@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [PATCH] ACPICA: Clear status of all events when entering S5
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI
> IRQs during suspend/resume) the status of ACPI events is not cleared any more
> when entering the ACPI S5 system state (power
> off) which causes some systems to power up immediately after turing off power
> in certain situations.
> 
> That is a functional regression, so address it by making the code clear the status
> of all ACPI events again when entering S5 (for system-wide suspend or
> hibernation the clearing of the status of all events is not desirable, as it might
> cause the kernel to miss wakeup events sometimes).
> 
> Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs
> during suspend/resume)
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Thomas Hänig <haenig@cosifan.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Resend https://patchwork.kernel.org/patch/10511451/ with a changelig and
> tags.
> 
> ---
>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
> =================================================================
> ==
> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
> @@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>  		return_ACPI_STATUS(status);
>  	}
> 
> -	/*
> -	 * 1) Disable all GPEs
> -	 * 2) Enable all wakeup GPEs
> -	 */
> +	/* Disable all GPEs */
>  	status = acpi_hw_disable_all_gpes();
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
>  	}
> +	/*
> +	 * If the target sleep state is S5, clear all GPEs and fixed events too
> +	 */
> +	if (sleep_state == ACPI_STATE_S5) {
> +		status = acpi_hw_clear_acpi_status();
> +		if (ACPI_FAILURE(status)) {
> +			return_ACPI_STATUS(status);
> +		}
> +	}
>  	acpi_gbl_system_awake_and_running = FALSE;
> 
> +	 /* Enable all wakeup GPEs */
>  	status = acpi_hw_enable_all_wakeup_gpes();
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);

Rafael, I've created an ACPICA pull request containing this patch.

Thanks,
Erik
