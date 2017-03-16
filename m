From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/4] acpi: ac: Add acpi_ac_unregister() function
Date: Thu, 16 Mar 2017 18:31:09 +0200
Message-ID: <1489681869.19767.22.camel@linux.intel.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
         <20170316161601.32267-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170316161601.32267-3-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-03-16 at 17:15 +0100, Hans de Goede wrote:
> On some systems we have a native pmic driver which provides Mains
> monitoring, while the acpi ac driver is broken on these systems
> due to bad dstds or because of missing vendor specific acpi opregion
> (e.g. BMOP opregion) support, which the acpi ac device in the dsdt
> relies on. This leads for example to a ADP1 power_supply which reports
> itself as always online even if no mains are connected.
> 
> This commit adds an acpi_ac_unregister() function which native pmic
> drivers can call after successfully registering their own power_supply
> to unregister the (potentially broken) acpi-ac power_supply.

Similar comments as per patch 1.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
