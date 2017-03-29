From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister duplicate ACPI battery supply
Date: Wed, 29 Mar 2017 22:31:47 +0200
Message-ID: <6382698.NuYXpb6L7h@aspire.rjw.lan>
References: <20170316161601.32267-1-hdegoede@redhat.com> <20170316161601.32267-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63128 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753441AbdC2Uhb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 16:37:31 -0400
In-Reply-To: <20170316161601.32267-4-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday, March 16, 2017 05:16:00 PM Hans de Goede wrote:
> On some systems with axp288 PMIC the dsdt also exports an ACPI battery
> device (PNP0C0A device). This leads to there being 2 battery
> power_supply-s registed like this:
> 
> ~$ acpi
> Battery 0: Charging, 84%, 00:49:39 until charged
> Battery 1: Unknown, 0%, rate information unavailable
> 
> Note that the ACPI battery device does not work properly this is due
> to Linux missing support for the vendor specific BMOP ACPI opregion.
> But even if the ACPI battery where to function fine we still do not
> want to export the same battery to userspace twice.
> 
> Therefor this commit calls acpi_battery_unregister() after successfully
> registering the axp288-fuel-gauge power_supply to remove the duplicate
> (and often broken) ACPI battery power_supply.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=194811
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Sergei Trusov <t.rus76@ya.ru>
> ---
>  drivers/power/supply/Kconfig             | 2 ++
>  drivers/power/supply/axp288_fuel_gauge.c | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index d0453ca..e504644 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -242,6 +242,8 @@ config AXP288_CHARGER
>  config AXP288_FUEL_GAUGE
>  	tristate "X-Powers AXP288 Fuel Gauge"
>  	depends on MFD_AXP20X && IIO
> +	# if ACPI_BATTERY=m, this can't be 'y'
> +	depends on ACPI_BATTERY || !ACPI_BATTERY
>  	help
>  	  Say yes here to have support for X-Power power management IC (PMIC)
>  	  Fuel Gauge. The device provides battery statistics and status
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index a8dcabc..15f10ce 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -26,6 +26,7 @@
>  #include <linux/mfd/axp20x.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <linux/power/acpi.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> @@ -754,6 +755,8 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	acpi_battery_unregister();
> +

What if the ACPI battery driver is loaded after this has been called already?

>  	fuel_gauge_create_debugfs(info);
>  	fuel_gauge_init_irq(info);
>  	schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFIES);
> 

Thanks,
Rafael
