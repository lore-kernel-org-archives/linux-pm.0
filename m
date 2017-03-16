From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/4] acpi: battery: Add acpi_battery_unregister()
 function
Date: Thu, 16 Mar 2017 18:29:53 +0200
Message-ID: <1489681793.19767.21.camel@linux.intel.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
         <20170316161601.32267-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170316161601.32267-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-03-16 at 17:15 +0100, Hans de Goede wrote:
> On some systems we have a native pmic driver which provides battery
> monitoring, while the acpi battery driver is broken on these systems
> due to bad dstds or because of missing vendor specific acpi opregion
> (e.g. BMOP opregion) support, which the acpi battery device in the
> dsdt relies on.
> 
> This leads to there being 2 battery power_supply-s registed like this:
> 
> ~$ acpi
> Battery 0: Charging, 84%, 00:49:39 until charged
> Battery 1: Unknown, 0%, rate information unavailable
> 
> Even if the acpi battery where to function fine (which on systems
> where we have a native pmic driver it often doesn't) we still do not
> want to export the same battery to userspace twice.
> 
> This commit adds an acpi_battery_unregister() function which native
> pmic drivers can call to tell the acpi-battery driver to unregister
> itself so that we do not end up with 2 power_supply-s for the same
> battery device.

acpi -> ACPI
pmic -> PMIC
dsdt -> DSDT (perhaps not here, but just in case)

> @@ -31,6 +31,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
> +#include <linux/mutex.h>

Keep in alphabetical order ?

>  #include <linux/acpi.h>
>  #include <linux/power_supply.h>
> +#include <linux/power/acpi.h>

Ditto. (though I don't remember which is first _ or /)
 
> +	/* Check if acpi_battery_unregister got called before _init()
> */

acpi_battery_unregister -> acpi_battery_unregister() ?

> +	mutex_lock(&init_state_mutex);
> +	if (init_state != BAT_NONE)
> +		goto out_unlock;
> +
>  	async_cookie = async_schedule(acpi_battery_init_async, NULL);
> +	init_state = BAT_INITIALIZED;

+ empty line here...

> +out_unlock:
> +	mutex_unlock(&init_state_mutex);

> +

...instead of this ?

> +++ b/include/linux/power/acpi.h

E.g. for GPIO we keep such things directly in linux/acpi.h. Does it make
sense to have separate one in this case?

Rafael, what is expected approach?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
