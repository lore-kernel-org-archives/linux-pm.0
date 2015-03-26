From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] [RFC]ACPI: enable wakeup GPE in freeze mode
Date: Thu, 26 Mar 2015 21:51:45 +0100
Message-ID: <2658941.bWdUA4mxsM@vostro.rjw.lan>
References: <1427175480-22066-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59106 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751455AbbCZU1k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 16:27:40 -0400
In-Reply-To: <1427175480-22066-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: len.brown@intel.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Tuesday, March 24, 2015 01:38:00 PM Chen Yu wrote:
> Currently, in freeze state, wakeup GPE for PCI devices are
> handled properly because acpi_pci_sleep_wake() invokes acpi_enable_gpe()
> to enable the wakeup GPE directly. But for the other wakeup-capable
> devices in ACPI bus, acpi_enable_wakeup_devices() should be invoked
> to update enable_for_wake mask in gpe_register_info structure, thus
> acpi_enable_all_wakeup_gpes() can enable the wakeup GPE referred in
> _PRW methods.
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
> ---
>  drivers/acpi/sleep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 7f251dd..91b55e6 100644
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

This looks OK to me, but I think that we need a complementary
acpi_disable_wakeup_devices() call in acpi_freeze_restore().

Without it, user space may not be able to prevent devices from
waking up the system from suspend-to-idle.  Or am I missing
anything?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
