From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/3 v8] thinkpad_acpi: Add support for battery thresholds
Date: Thu, 21 Dec 2017 19:08:11 +0200
Message-ID: <CAHp75VerEvMF+JJH+Vy5wnLyrTWBENEZv1GFZnKZRo+JguRPoQ@mail.gmail.com>
References: <20171221100051.GA30647@thinkpad> <CAHp75Vc2MYDLanvZmqaPkmFVfNbyBQoPwbRDDFmKDtSPAmfj9w@mail.gmail.com>
 <CALgTWSvnyBysDJqGFwCxB43wgzMAAUqYZ2M5r8-L9ZdJ9J4XxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CALgTWSvnyBysDJqGFwCxB43wgzMAAUqYZ2M5r8-L9ZdJ9J4XxQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 21, 2017 at 5:24 PM, Ognjen Gali=C4=87 <smclt30p@gmail.com> wro=
te:
> On 21 Dec 2017 2:53 pm, "Andy Shevchenko" <andy.shevchenko@gmail.com> wro=
te:
> On Thu, Dec 21, 2017 at 12:00 PM, Ognjen Galic <smclt30p@gmail.com> wrote=
:

You need stop using HTML as well.

>> +DEVICE_ATTR(charge_start_threshold, 0644,
>> +               tpacpi_battery_show, tpacpi_battery_store);
>> +DEVICE_ATTR(charge_stop_threshold, 0644,
>> +       tpacpi_battery_show, tpacpi_battery_store);
>
> DEVICE_ATTR_RW().

> I did not use DEVICE_ATTR_RW() because I can't use a common store and sho=
w
> function for both attributes to minimize the code I need. If I used
> DEVICE_ATTR_RW() I would need to define 4 more functions that do the same=
.
> That seems redundant.

_RW() variant still preferable since it makes much more easy to
understand that this attribute doesn't need any *special* permissions.

I think it's not big payment to make it so.

>> +#define to_power_supply(device) container_of(device, struct power_suppl=
y,
>> dev)

>>  This one sounds to me as a separate change.

> At the same time you may convert the current user of it to make sense
> of the change.
> drivers/power/supply/power_supply_core.c:671:
>
> I think I pointed to this out once.

> I wanted to minimize the changes in pm to avoid going through all the rev=
iew
> process hassle for a few simple changes, because I'm modifying a third
> subsystem. But I will do it later tonight.

Thanks!

> This is my first patchset and I did not expect for the review process to =
be
> this agonizingly slow, so I wanted to speed it up by not touching pm.

I see, though you actually made an opposite by that decision :-)

--=20
With Best Regards,
Andy Shevchenko
