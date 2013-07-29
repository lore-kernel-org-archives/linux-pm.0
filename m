From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 1/3] ACPI / PM: Only set power states of devices that
 are power manageable
Date: Mon, 29 Jul 2013 22:09:53 +0800
Message-ID: <51F677B1.9090502@intel.com>
References: <10433383.dueoNg39qi@vostro.rjw.lan> <1657971.1utElu0Hzo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1657971.1utElu0Hzo@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/27/2013 09:10 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make acpi_device_set_power() check if the given device is power
> manageable before checking if the given power state is valid for that
> device.  Otherwise it will print that "Device does not support" that
> power state into the kernel log, which may not make sense for some
> power states (D0 and D3cold are supported by all devices by
> definition).

It will not print "Device does not support" that power state if that
power state is D0 or D3cold since we have unconditionally set those two
power state's valid flag.

OTOH, what value should we return for a device node that is not power
manageable in acpi_device_set_power when the target state is D0 or D3
cold? The old behavior is to return 0, meanning success without taking
any actual action.

In acpi_bus_set_power, if the device is not power manageable, we will
return -ENODEV; in acpi_dev_pm_full/low_power, we will return 0 as in
the original acpi_device_set_power. So return -EINVAL here is correct?

-Aaron

> 
> Tested-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/device_pm.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -159,7 +159,8 @@ int acpi_device_set_power(struct acpi_de
>  	int result = 0;
>  	bool cut_power = false;
>  
> -	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
> +	if (!device || !device->flags.power_manageable
> +	    || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
>  		return -EINVAL;
>  
>  	/* Make sure this is a valid target state */
> 

