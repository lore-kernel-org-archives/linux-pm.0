From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v10 2/4] pm: add to_power_supply macro to the API
Date: Sun, 31 Dec 2017 11:37:46 +0200
Message-ID: <CAHp75VewyeTEr7A=HP4nU=DhMvhq9AaHc-VKpz8NzcA2X6BGkg@mail.gmail.com>
References: <20171223105316.GA4352@thinkpad> <CAHp75VcpuQz4n_wRJ+f-OKf4VAVVhXzKAC+FD0EE52cs+Zv22Q@mail.gmail.com>
 <1514591385.9667.0.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1514591385.9667.0.camel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 30, 2017 at 1:49 AM, Ognjen Gali=C4=87 <smclt30p@gmail.com> wro=
te:
> On =C4=8Cet, 2017-12-28 at 10:19 +0200, Andy Shevchenko wrote:
>> On Sat, Dec 23, 2017 at 12:53 PM, Ognjen Galic <smclt30p@gmail.com>
>> wrote:
>> >
>> > This patch adds the to_power_supply macro to upcast
>> > a device to a power_supply struct.
>> >
>> > This is needed because the same piece of code using
>> > container_of is used in various other places, so we
>> > abstract away such low-level operations via a macro.
>> >
>> > ---
>> This is wrong! You have to use *existing* --- line below. Otherwise
>> all mail parsers will cut this out including your SoB tag.
>>
>
> My bad I guess. Want another patch revision with that fixed or
> something?
>

You definitely need to send a new revision with all comments
addressed. So far you didn't responce to them which I recognize as
total agreement that they have to be addressed.


--=20
With Best Regards,
Andy Shevchenko
