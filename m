From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/4] power: supply: axp288_charger: Unregister duplicate
 ACPI ac supply
Date: Thu, 16 Mar 2017 18:34:04 +0200
Message-ID: <1489682044.19767.24.camel@linux.intel.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
         <20170316161601.32267-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170316161601.32267-5-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-03-16 at 17:16 +0100, Hans de Goede wrote:
> On some systems with an axp288 PMIC the dsdt exports a non functional
> (*)
> ACPI AC device (ACPI0003 device), which results in a Mains
> power_supply
> which reports itself as being always online.
> 
> This commit calls acpi_ac_unregister() after successfully registering
> the
> axp288_charger power_supply to remove the broken Mains power_supply.
> 
> *) It depends on a vendor specific BMOP ACPI opregion we do not
> implement


> +	# if ACPI_AC=m, this can't be 'y'
> +	depends on ACPI_AC || !ACPI_AC

Same comment as per patch 3

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
