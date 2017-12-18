From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3 v6] battery: Add the ThinkPad "Not Charging" quirk
Date: Mon, 18 Dec 2017 18:30:57 +0100
Message-ID: <CAJZ5v0jR1ABy-hsGHOMpee9tctUiq6zX6nN44VgxnpdbZ4wiFg@mail.gmail.com>
References: <20171215165750.GA6282@thinkpad> <CAJZ5v0ida0RTUBdtpCK4rAXfdukadpTyxD0Rpp4R=kKcukyjKA@mail.gmail.com>
 <20171216084850.GA19033@thinkpad> <CAJZ5v0gWooR7rtY0qmEyERr=A+BoLWoSAHh5Reh3xE5Gvks9+g@mail.gmail.com>
 <CALgTWSv-4DSnU1MLiapL22rK-qaa45xCz6WuMnM_AeBtKYDidw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CALgTWSv-4DSnU1MLiapL22rK-qaa45xCz6WuMnM_AeBtKYDidw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 18, 2017 at 11:21 AM, Ognjen Gali=C4=87 <smclt30p@gmail.com> wr=
ote:
> On 16/12/2017, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Sat, Dec 16, 2017 at 9:48 AM, Ognjen Galic <smclt30p@gmail.com> wrote=
:
>>> On Sat, Dec 16, 2017 at 01:33:55AM +0100, Rafael J. Wysocki wrote:
>>>> On Fri, Dec 15, 2017 at 5:57 PM, Ognjen Galic <smclt30p@gmail.com>
>>>> wrote:
>>>> > The EC/ACPI firmware on Lenovo ThinkPads used to report a status
>>>> > of "Unknown" when the battery is between the charge start and
>>>> > charge stop thresholds. On Windows, it reports "Not Charging"
>>>> > so the quirk has been added to also report correctly.
>>>> >
>>>> > Now the "status" attribute returns "Not Charging" when the
>>>> > battery on ThinkPads is not physicaly charging.
>>>> >
>>>> > Tested-by: Kevin Locke <kevin@kevinlocke.name>
>>>> > Tested-by: Christoph B=C3=B6hmwalder <christoph@boehmwalder.at>
>>>> > Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
>>>>
>>>> It doesn't look like this is related to the [1/3] and [3/3], so why do
>>>> you make it part of the series?
>>>>
>>>
>>> I made it the same series because it is practically the same feature
>>> set. Without this patch and with 1/3 and 3/3 applied, there is a bug
>>> where the status attribute would show "Unknown" for a battery that is
>>> between the start and stop thresholds while attached to AC.
>>
>> OK, fair enough.
>>
>> I would reorder it as the first patch in the series, then, because the
>> other two are more related to each other.
>>
>> Thanks,
>> Rafael
>>
>
> Do I really need now to re-order and re-send the whole patchset for it
> to get merged?

I'm not sure I will take anything of it at this time.

Thanks,
Rafael
