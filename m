From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 4/5] ACPI: ac: Add a blacklist with PMIC ACPI HIDs
 with a native charger driver
Date: Tue, 18 Apr 2017 16:15:44 +0300
Message-ID: <1492521344.24567.63.camel@linux.intel.com>
References: <20170418115842.16214-1-hdegoede@redhat.com>
         <20170418115842.16214-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53079 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752608AbdDRNSt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 09:18:49 -0400
In-Reply-To: <20170418115842.16214-5-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 2017-04-18 at 13:58 +0200, Hans de Goede wrote:
> On some systems we have a native PMIC driver which provides Mains
> monitoring, while the ACPI ac driver is broken on these systems
> due to bad DSTDs or because we do not support the proprietary and
> undocumented ACPI opregions these ACPI battery devices rely on
> (e.g. BMOP opregion).
> 
> This leads for example to a ADP1 power_supply which reports
> itself as always online even if no mains are connected.
> 
> This commit adds a blacklist with PMIC ACPI HIDs for which we've a
> native charger or extcon driver and makes the ACPI ac driver not
> register itself when a PMIC on this list is present.

Same remark, change those minors if something else comes up.

>  static int __init acpi_ac_init(void)
>  {
> -	int result;
> +	int i, result;

I would go with

unsigned int i;

(Same for previous patch considering ARRAY_SIZE() in use)

>  
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> +	for (i = 0; i < ARRAY_SIZE(acpi_ac_blacklist); i++)
> +		if (acpi_dev_present(acpi_ac_blacklist[i].hid, "1",
> +				     acpi_ac_blacklist[i].hrv)) {

> +			pr_info("ACPI: AC: found native %s PMIC, not
> loading\n",

Do we have PREFIX defined in this module as well?

> +				acpi_ac_blacklist[i].hid);
> +			return -ENODEV;
> +		}
> +

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
