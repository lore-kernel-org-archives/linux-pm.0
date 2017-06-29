From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Thu, 29 Jun 2017 22:22:50 +0200
Message-ID: <CAJZ5v0hq1YSECBGD9QvqKuzmaFW2+jhWPSzvTb64yTxd6yH06w@mail.gmail.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com> <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 29, 2017 at 4:22 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> +Cc: Hans (he might give some advice regarding to the below)
>
> On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> MSHW0011 replaces the battery firmware by using ACPI operation regions.
>> The values have been obtained by reverse engineering, and are subject to
>> errors. Looks like it works on overall pretty well.
>
> What devices (laptops, tablets) have it?
> Surface 3. What else?
>
>> I couldn't manage to get the IRQ correctly triggered, so I am using a
>> good old polling thread to check for changes.
>
> It might be
>
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=106231
>
>> +config ACPI_SURFACE3_POWER_OPREGION
>> +       tristate "Surface 3 battery platform operation region support"
>
> depends on ACPI ?
>
>> +       help
>> +         Select this option to enable support for ACPI operation
>> +         region of the Surface 3 battery platform driver.
>
>> +/*
>> + * Supports for the power IC on the Surface 3 tablet.
>
> Shouldn't it go to drivers/acpi/pmic folder ?

Surely not directly into drivers/acpi/ in any case.

Thanks,
Rafael
