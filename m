From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Wed, 19 Nov 2014 09:54:00 +0100
Message-ID: <CAPDyKFoiEMO5E3nMJDZkFkuio-5sh99m55k-yM=fuqrHUXbhZw@mail.gmail.com>
References: <20141117220238.GE5258@dtor-ws>
	<1787068.2MCH8czsD4@vostro.rjw.lan>
	<CAPDyKFoMftvKs8tyBaYCu1zTK_JYiXeXMiq86OrwAAHZoRO_Pw@mail.gmail.com>
	<3492523.qBADTmdTqo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <3492523.qBADTmdTqo@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>
>> Scenario 5), a platform driver with/without runtime PM callbacks.
>> ->probe()
>> - do some initialization
>> - may fetch handles to runtime PM resources
>> - pm_runtime_enable()
>
> Well, and now how the driver knows if the device is "on" before acces=
sing it?

In this case the driver don't need to access the device during
->probe(). That's postponed until sometime later.

>
>> Note 1)
>> Scenario 1) and 2), both relies on the approach to power on the PM
>> domain by using pm_runtime_get_sync(). That approach didn't work whe=
n
>> CONFIG_PM_RUNTIME was unset, but we recently decided to fixed that b=
y
>> the below patch, so that's good!
>> "[PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when genpd =
enabled"
>>
>> Note 2)
>> Scenario 3) and 4) use the same principles for managing runtime PM.
>> These scenarios needs a way to power on the generic PM domain prior
>> probing the device. The call to pm_runtime_set_active(), prevents an
>> already powered PM domain from power off until after probe, but that=
's
>> not enough.
>>
>> Note 3)
>> The $subject patch, tried to address the issues for scenario 3) and
>> 4). It does so, but will affect scenario 5) which was working nicely
>> before. In scenario 5), the $subject patch will cause the generic PM
>> domain to potentially stay powered after ->probe() even if the devic=
e
>> is runtime PM suspended.
>
> Why would it?  If the device is runtime-suspended, the domain will kn=
ow
> that, because its callbacks will be used for that.  At least, that's
> what I'd expect to happen, so is there a problem here?

Genpd do knows about the device but it doesn=E2=80=99t get a "notificat=
ion" to
power off. There are no issues whatsoever for driver.

This is a somewhat special case. Let's go through an example.

1. The PM domain is initially in powered off state.
2. The bus ->probe() invokes dev_pm_domain_attach() and then the PM
domain gets attached to the device.
3. $subject patch causes the PM domain to power on.
4. A driver ->probe() sequence start, following the Scenario 5).
5. The device is initially in runtime PM suspended state and it will
remain so during ->probe().
6. The pm_request_idle() invoked after really_probe() in driver core,
won't trigger a runtime PM suspend callback to be invoked. In other
words, genpd don't get a "notification" that it may power off.

In this state, genpd will either power off from the late_initcall,
genpd_poweroff_unused() (depending on when the driver was probed) or
wait until some device's runtime PM suspend callback is invoked at any
later point.

>
>> I see three options going forward.
>>
>> Option 1)
>> Convert scenario 3) and 4) into using the pm_runtime_get_sync()
>> approach. There are no theoretical obstacles to do this, but pure
>> practical. There are a lot of drivers that needs to be converted and
>> we also need to teach driver authors future wise to not use
>> pm_runtime_set_active() in this manner.
>
> I'd say we need to do something like this anyway.  That is, standardi=
ze on
> *one* approach.  I'm actually not sure what approach is the most usef=
ul,
> but the pm_runtime_get_sync() one seems to be the most popular to me.
>
>> Option 2)
>> Add some kind of get/put API for PM domains. The buses invokes it to
>> control the power to the PM domain. From what I understand, that's
>> also what Dmitry think is needed!?
>> Anyway, that somehow means to proceed with the approach I took in th=
e
>> below patchset.
>> [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
>> http://marc.info/?t=3D141320907000003&r=3D1&w=3D2
>
> I don't like that.  The API is already quite complicated in my view a=
nd
> adding even more complexity to it is not going to help in the long ru=
n.

I absolutely agree that we shouldn't add unnecessary APIs and keep
APIs as simple as possible.

In that context, I think the effect from proceeding with Option 2)
also means there are no need for the below APIs any more.
pm_genpd_poweron()
pm_genpd_name_poweron() (requires some additional work though)
pm_genpd_poweroff_unused()
pm_genpd_dev_need_restore()

I guess you figured out that I am in favour of Option 2). :-)
Especially since it cover all scenarios and we don't have to go a fix
a vast amount of drivers.

>
>> Option 3)
>> Live we the limitation this $subject patch introduces for scenario 5=
).
>
> I'd say, 3) for now and 1) going forward.

This could work!

The hardest part is to know when we should revert $subject patch, to
fix the regression introduced for scenario 5).

>
>> Is there maybe any additional options, that I didn't think of?
>>
>> Apologize for the long email, I hope I didn't bored you too much.
>
> That's fine, thanks for taking the time to lay out all of the cases, =
that's
> always helpful.
>
> Rafael
>

Kind regards
Uffe
