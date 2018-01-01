From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v11 3/5] thinkpad_acpi: Add support for battery thresholds
Date: Mon, 1 Jan 2018 13:31:29 +0100
Message-ID: <CAJZ5v0jmYTjhcn_z86tsNNUstbNu=+0OzMgVk85xS-rpvPfKJA@mail.gmail.com>
References: <20171231141727.GA4643@thinkpad> <CAHp75VeYRYRpmqy_GGQ95e1YhvZGfWtsJrGbLiA4JskEmd69zg@mail.gmail.com>
 <20180101114348.GA5589@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20180101114348.GA5589@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 1, 2018 at 12:43 PM, Ognjen Gali=C4=87 <smclt30p@gmail.com> wro=
te:
> On Mon, Jan 01, 2018 at 12:24:39PM +0200, Andy Shevchenko wrote:
>> On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p@gmail.com> wrote=
:
>> > thinkpad_acpi registers two new attributes for each battery:
>> >
>> > 1) Charge start threshold
>> > /sys/class/power_supply/BATN/charge_start_threshold
>> >
>> > Valid values are [0, 99]. A value of 0 turns off the
>> > start threshold wear control.
>> >
>> > 2) Charge stop threshold
>> > /sys/class/power_supply/BATN/charge_stop_threshold
>> >
>> > Valid values are [1, 100]. A value of 100 turns off
>> > the stop threshold wear control. This must be
>> > configured first.
>> >
>>
>> > This patch depends on the following patches:
>> >
>> > "battery: Add the battery hooking API"
>>
>> Since this is series, no need to put above into changelog.
>>
>> AFAICS it's not going to be backported either.
>>
>>
>> > +/**
>> > + * This evaluates a ACPI method call specific to the battery
>> > + * ACPI extension. The specifics are that an error is marked
>> > + * in the 32rd bit of the response, so we just check that here.
>> > + *
>> > + * Returns 0 on success
>> > + */
>> > +static int tpacpi_battery_acpi_eval(char *method, int *ret, int param=
)
>> > +{
>>
>> One problem and one trick you may do.
>>
>> A problem: you return ACPI status as int. We have special type for
>> that. So, be consistent with it.
>> Looking to acpi_evalf() which is private to the module, I think you
>> need to get rid of ACPI return codes here.
>
> What do you mean by "get rid of ACPI return codes"?
> Are you suggesting this?
>
> static void tpacpi_battery_ac....

I think that Andy was talking about returning things like AE_ERROR,
which are of type acpi_status, as int.

You should return either the Linux error codes (in which case int is
the type to use) or ACPI error codes (in which the function should be
defined to return acpi_status).  Do not mix them.

> How would I check if the ACPI call failed if I made the function return
> void?
>
> I use a function return value to check if the ACPI call failed,
> and a return integer pointer to which I write the return data to.
>
>>
>> A trick: since you are using only least significant byte of the
>> response, you can declare it as u8 *value (yeah, ret is not best name
>> here I think).
>
> Neat trick.

Little-endian only though.  Don't do that unless your code is
guaranteed to always (now and in the future) run on little-endian.

Thanks,
Rafael
