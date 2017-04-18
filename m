From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 3/5] ACPI: battery: Add a blacklist with PMIC ACPI
 HIDs with a native battery driver
Date: Tue, 18 Apr 2017 16:13:06 +0300
Message-ID: <1492521186.24567.61.camel@linux.intel.com>
References: <20170418115842.16214-1-hdegoede@redhat.com>
         <20170418115842.16214-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16769 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdDRNNK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 09:13:10 -0400
In-Reply-To: <20170418115842.16214-4-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 2017-04-18 at 13:58 +0200, Hans de Goede wrote:
> On some systems we have a native PMIC driver which provides battery
> monitoring, while the ACPI battery driver is broken on these systems
> due to bad DSDTs or because we do not support the proprietary and
> undocumented ACPI opregions these ACPI battery devices rely on
> (e.g. BMOP opregion).
> 
> This leads to there being 2 battery power_supply-s registed like this:
> 
> ~$ acpi
> Battery 0: Charging, 84%, 00:49:39 until charged
> Battery 1: Unknown, 0%, rate information unavailable
> 
> Even if the ACPI battery where to function fine (which on systems
> where we have a native PMIC driver it often doesn't) we still do not
> want to export the same battery to userspace twice.
> 
> This commit adds a blacklist with PMIC ACPI HIDs for which we've a
> native battery driver and makes the ACPI battery driver not register
> itself when a PMIC on this list is present.
> 

Some minor comments, sorry, didn't sent earlier.

Since they are minor, consider to change if some more serious stuff
comes up.


> +/* Lists of PMIC ACPI HIDs with an (often better) native battery
> driver */
> +static const char * const acpi_battery_blacklist[] = {
> +	"INT33F4", /* X-Powers AXP288 PMIC */

> +	NULL

Can we use ARRAY_SIZE() instead?

> +};
> +
>  enum {
>  	ACPI_BATTERY_ALARM_PRESENT,
>  	ACPI_BATTERY_XINFO_PRESENT,
> @@ -1316,7 +1322,15 @@ static struct acpi_driver acpi_battery_driver =
> {
>  
>  static void __init acpi_battery_init_async(void *unused,
> async_cookie_t cookie)
>  {
> -	int result;
> +	int i, result;
> +

> +	for (i = 0; acpi_battery_blacklist[i]; i++)


> +		if (acpi_dev_present(acpi_battery_blacklist[i], "1",
> -1)) {
> +			pr_info("ACPI: %s: found native %s PMIC, not
> loading\n",

pr_info(PREFIX "%s: ...

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
