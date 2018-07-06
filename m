From: =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Fri, 6 Jul 2018 14:49:42 +0200
Message-ID: <6f01a906-b27c-0e1a-e9f6-fa27c015faa3@cosifan.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de>
 <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
 <1704080.gFTvVrrZA1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1704080.gFTvVrrZA1@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Takashi Iwai <tiwai@suse.de>, Erik Schmauss <erik.schmauss@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



Am 06.07.2018 um 14:13 schrieb Rafael J. Wysocki:
> On Friday, July 6, 2018 1:21:50 PM CEST Rafael J. Wysocki wrote:
>> On Fri, Jul 6, 2018 at 1:12 PM, Thomas Hänig <haenig@cosifan.de> wrote:
> 
> [cut]
>  
>> So the latest patch:
>>
>> https://patchwork.kernel.org/patch/10511211/
>>
>> should work for you (please verify) and the change in
>> drivers/acpi/sleep.c in it most likely is not necessary.
>>
>> If you can confirm that this one works for you, I'll send a smaller
>> one with the acpi_hw_legacy_sleep() part alone.
> 
> Well, scratch this, sorry.
> 
> The power button probably is a fixed event and it won't be effected by
> that patch.
> 
> Instead, please test the patch below.
> 
> ---
>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
> ===================================================================
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
> 
after cancelling the build with patch 10511211 and rolling everything
back, I applied the patch above to my kernel 4.17.3-1-default and when
pressing the power button the system shuts down and stays off! :-)

Thanks
Thomas
