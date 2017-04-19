From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 0/5] ACPI: new acpi_dev_present helper + ac and battery
 blacklist patches
Date: Wed, 19 Apr 2017 21:37:50 +0200
Message-ID: <CAJZ5v0i1oFMaqRF85TzvEM_ZHAe+rUUXqRruy7aHY_PwGcCw0w@mail.gmail.com>
References: <20170419120212.24949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170419120212.24949-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 19, 2017 at 2:02 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Rafael,
>
> This is a new version of my acpi_dev_present helper + ac and battery
> blacklist patches, new compared to the v5 resend of the latest
> version of all these patches are some changes to the first,
> third and fourth patch as requested by Andy Shevchenko.
>
> This set also includes a power-supply patch, which depends on the
> new acpi_dev_present helper and has an Ack from Sebastian Reichel
> (the power-supply maintainer) for being merged through the ACPI
> tree because of that dependency.
>
> These patches obsolete:
> -earlier versions of patches with the same title
> -"ACPI: battery: Add acpi_battery_unregister() function"
> -"ACPI: ac: Add acpi_ac_unregister() function"
> -"power: supply: axp288_fuel_gauge: Unregister duplicate ACPI battery supply"
> -"power: supply: axp288_charger: Unregister duplicate ACPI ac supply"

Andy, Mika, any concerns about anything this series?

Thanks,
Rafael
