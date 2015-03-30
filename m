From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI: Enable wakeup GPE in freeze mode
Date: Mon, 30 Mar 2015 21:12:09 +0200
Message-ID: <4698835.VT8nBgTpoe@vostro.rjw.lan>
References: <1427450928-7049-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1427450928-7049-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: len.brown@intel.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 27, 2015 06:08:48 PM Chen Yu wrote:
> Currently, in freeze state, wakeup GPE for PCI devices are
> handled properly because acpi_pci_sleep_wake() invokes acpi_enable_gpe()
> to enable the wakeup GPE directly. But for the other wakeup-capable
> devices in ACPI bus, acpi_enable_wakeup_devices() should be invoked
> to update enable_for_wake mask in gpe_register_info structure, thus
> acpi_enable_all_wakeup_gpes() can enable the wakeup GPE referred in
> _PRW methods. And acpi_disable_wakeup_devices() will be called
> before disable_irq_wake() in acpi_freeze_restore() to restore the mask.
> 
> This patch fixes a power button wakeup problem on Surface Pro 3,
> on which platform power button uses EC to deliver event
> (EC GPE is referred in _PRW).
> 
> Note: enabling EC GPE during freeze state may bring some risks
> because EC events are expected to fire more frequently than others.
> Thus it may bring the system out of freeze state unnecessarily.
> (We already have comments about this in bugzilla)
> 
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=84651
> 
> Reported-and-tested-by: Ethan Schoonover <es@ethanschoonover.com>
> Tested-by: Peter Amidon <psa.pub.0@picnicpark.org>
> Tested-by: Yani Ioadnnou <yani.ioannou@gmail.com>
> Tested-by: Mister Wardrop <mister.wardrop@gmail.com>
> Tested-by: Anton Anikin <anton@anikin.name>
> Tested-by: Keith McClelland <zismylaptop@gmail.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Queued up for 4.1 with minor changes in the changelog/subject, thanks!

> ---
>  drivers/acpi/sleep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 7f251dd..81e5bd4 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -629,6 +629,7 @@ static int acpi_freeze_begin(void)
>  
>  static int acpi_freeze_prepare(void)
>  {
> +	acpi_enable_wakeup_devices(ACPI_STATE_S0);
>  	acpi_enable_all_wakeup_gpes();
>  	acpi_os_wait_events_complete();
>  	enable_irq_wake(acpi_gbl_FADT.sci_interrupt);
> @@ -637,6 +638,7 @@ static int acpi_freeze_prepare(void)
>  
>  static void acpi_freeze_restore(void)
>  {
> +	acpi_disable_wakeup_devices(ACPI_STATE_S0);
>  	disable_irq_wake(acpi_gbl_FADT.sci_interrupt);
>  	acpi_enable_all_runtime_gpes();
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
