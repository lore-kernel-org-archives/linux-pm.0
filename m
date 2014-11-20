From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Thu, 20 Nov 2014 14:01:53 +0100
Message-ID: <CAPDyKFrssg8wTr7e+EDrrgvHCndq8hcoNJb8TQGc_tt4ePpdEw@mail.gmail.com>
References: <20141117220238.GE5258@dtor-ws>
	<1787068.2MCH8czsD4@vostro.rjw.lan>
	<CAPDyKFoMftvKs8tyBaYCu1zTK_JYiXeXMiq86OrwAAHZoRO_Pw@mail.gmail.com>
	<3492523.qBADTmdTqo@vostro.rjw.lan>
	<CAPDyKFoiEMO5E3nMJDZkFkuio-5sh99m55k-yM=fuqrHUXbhZw@mail.gmail.com>
	<546DDBCF.205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <546DDBCF.205@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 20 November 2014 13:17, Grygorii Strashko <grygorii.strashko@ti.com>=
 wrote:
> On 11/19/2014 10:54 AM, Ulf Hansson wrote:
>> [...]
>>
>>>>
>>>> Scenario 5), a platform driver with/without runtime PM callbacks.
>>>> ->probe()
>>>> - do some initialization
>>>> - may fetch handles to runtime PM resources
>>>> - pm_runtime_enable()
>>>
>>> Well, and now how the driver knows if the device is "on" before acc=
essing it?
>>
>> In this case the driver don't need to access the device during
>> ->probe(). That's postponed until sometime later.
>>
>>>
>>>> Note 1)
>>>> Scenario 1) and 2), both relies on the approach to power on the PM
>>>> domain by using pm_runtime_get_sync(). That approach didn't work w=
hen
>>>> CONFIG_PM_RUNTIME was unset, but we recently decided to fixed that=
 by
>>>> the below patch, so that's good!
>>>> "[PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when genp=
d enabled"
>>>>
>>>> Note 2)
>>>> Scenario 3) and 4) use the same principles for managing runtime PM=
=2E
>>>> These scenarios needs a way to power on the generic PM domain prio=
r
>>>> probing the device. The call to pm_runtime_set_active(), prevents =
an
>>>> already powered PM domain from power off until after probe, but th=
at's
>>>> not enough.
>>>>
>>>> Note 3)
>>>> The $subject patch, tried to address the issues for scenario 3) an=
d
>>>> 4). It does so, but will affect scenario 5) which was working nice=
ly
>>>> before. In scenario 5), the $subject patch will cause the generic =
PM
>>>> domain to potentially stay powered after ->probe() even if the dev=
ice
>>>> is runtime PM suspended.
>>>
>>> Why would it?  If the device is runtime-suspended, the domain will =
know
>>> that, because its callbacks will be used for that.  At least, that'=
s
>>> what I'd expect to happen, so is there a problem here?
>>
>> Genpd do knows about the device but it doesn=E2=80=99t get a "notifi=
cation" to
>> power off. There are no issues whatsoever for driver.
>>
>> This is a somewhat special case. Let's go through an example.
>>
>> 1. The PM domain is initially in powered off state.
>> 2. The bus ->probe() invokes dev_pm_domain_attach() and then the PM
>> domain gets attached to the device.
>> 3. $subject patch causes the PM domain to power on.
>> 4. A driver ->probe() sequence start, following the Scenario 5).
>> 5. The device is initially in runtime PM suspended state and it will
>> remain so during ->probe().
>> 6. The pm_request_idle() invoked after really_probe() in driver core=
,
>> won't trigger a runtime PM suspend callback to be invoked. In other
>> words, genpd don't get a "notification" that it may power off.
>>
>> In this state, genpd will either power off from the late_initcall,
>> genpd_poweroff_unused() (depending on when the driver was probed) or
>> wait until some device's runtime PM suspend callback is invoked at a=
ny
>> later point.
>
> if I understand things right (thanks to Russell), the Power domain ma=
y not
>  be powered off not only in above case, but also in some cases when
> driver is unloaded.
>
> AMBA bus for example:
> static int amba_remove(struct device *dev)
> {
>         pm_runtime_get_sync(dev); <---------- GPD=3Don, dev is active=
, usage_count >=3D 1
>         ret =3D drv->remove(pcdev); <----------- GPD=3Don, should do =
balancing put() to compensate all get() made by driver, usage_count =3D=
=3D 1
>                                   <----------- GPD=3Don, should do ba=
lancing get() to compensate put() in probe, usage_count =3D=3D 2
>         pm_runtime_put_noidle(dev); <---------- GPD=3Don, dev is acti=
ve, usage_count =3D=3D 1
>
>         /* Undo the runtime PM settings in amba_probe() */
>         pm_runtime_disable(dev);  <---------- GPD=3Don, dev is active=
, usage_count =3D=3D 1
>         pm_runtime_set_suspended(dev); <---------- GPD=3Don, dev is s=
uspended, usage_count =3D=3D 1
>         pm_runtime_put_noidle(dev); <---------- GPD=3Don, dev is susp=
ended, usage_count =3D=3D 0
>
>         amba_put_disable_pclk(pcdev);
>         dev_pm_domain_detach(dev, true); <---------- GPD=3Don, dev is=
 suspended, usage_count =3D=3D 0

=46or the generic OF-based PM domain look-up case:
->dev_pm_domain_detach()
    ->genpd_dev_pm_detach() - to remove the device from the PM domain.
       ->genpd_queue_power_off_work() - to power off unused PM domains.

That does the trick, right!?

Kind regards
Uffe
