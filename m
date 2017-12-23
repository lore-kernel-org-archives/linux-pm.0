From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v10 1/4] battery: Add the battery hooking API
Date: Sat, 23 Dec 2017 12:59:45 +0100
Message-ID: <CAJZ5v0guiuWi=8zHX3cUZarkcxTT-VY9R3ASaCdEPAfjQPDXkA@mail.gmail.com>
References: <20171223105258.GA4334@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171223105258.GA4334@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 23, 2017 at 11:52 AM, Ognjen Galic <smclt30p@gmail.com> wrote:
> This is a patch that implements a generic hooking API for the
> generic ACPI battery driver.
>
> With this new generic API, drivers can expose platform specific
> behaviour via sysfs attributes in /sys/class/power_supply/BATn/
> in a generic way.
>
> A perfect example of the need for this API are Lenovo ThinkPads.
>
> Lenovo ThinkPads have a ACPI extension that allows the setting of
> start and stop charge thresholds in the EC and battery firmware
> via ACPI. The thinkpad_acpi module can use this API to expose
> sysfs attributes that it controls inside the ACPI battery driver
> sysfs tree, under /sys/class/power_supply/BATN/.
>
> The file drivers/acpi/battery.h has been moved to
> include/acpi/battery.h and the includes inside ac.c, sbs.c, and
> battery.c have been adjusted to reflect that.
>
> When drivers hooks into the API, the API calls add_battery() for
> each battery in the system that passes it a acpi_battery
> struct. Then, the drivers can use device_create_file() to create
> new sysfs attributes with that struct and identify the batteries
> for per-battery attributes.
> ---
> v7:
> * Implemented mutual exclusion for hooking methods and battery
> callbacks
> * Fixed a BUG where errors in other modules would occur when the
> modules that depend on battery get unloaded
>
> v8:
> * Use list_for_each_safe instead of list_for_each for the module
> exit function where deletion of nodes occurs
>
> v9:
> * No changes in this patch in v9
>
> v10:
> * Fix compiler warnings in Intel's 0-day CI

You're sending new revisions too fast for me to review them. :-/

Please stop doing this for a while until you get a response from me for the v10.

Thanks,
Rafael
