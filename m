From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: If an OF node is found but no device probed
 yet, defer.
Date: Mon, 16 Mar 2015 09:44:22 +0100
Message-ID: <CAMuHMdX_-U9ZajtWnPsgKR-e3DMS_8oMM3Cq7UgvO-Q2kE7fng@mail.gmail.com>
References: <1426087648-3862-1-git-send-email-eric@anholt.net>
	<6516096.HanqZ05BXy@vostro.rjw.lan>
	<CAMuHMdW0_9HNpqYJhJHpDvFcObYZx0MfKT6hmgqjZmwrtpTSzQ@mail.gmail.com>
	<7hr3sspyj3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7hr3sspyj3.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

On Fri, Mar 13, 2015 at 7:01 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> On Wed, Mar 11, 2015 at 11:08 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> More CCes.
>>>
>>> On Wednesday, March 11, 2015 08:27:28 AM Eric Anholt wrote:
>>>> If we've declared a power domain in the OF, and the OF node is found
>>>> but the requested domain hasn't been registered on it yet, then we
>>>> probably have just tried to probe before the power domain driver has.
>>>> Defer our device's probe until it shows up.
>>>>
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>
>>> Kevin, Ulf, any chance to have a look at this, please?
>>>
>>>> ---
>>>>
>>>> I ran into this when turning my ad-hoc code for BCM2835 (Raspberry Pi)
>>>> USB poweron support in the DWC2 controller to an OF-based power domain
>>>> declaration.
>>
>> I guess you are initializing the PM domains from module_init()?
>>
>> I use core_initcall() in arch/arm/mach-shmobile/pm-rmobile.c to make sure it's
>> initialized earlier, as e.g. the interrupt controller uses postcore_initcall().
>
> Yeah, I think most existing users are initizling PM domains early, but IMO
> we should be working towards supporting PM domains that are created
> later as well (as this patch does.)

Sure. When interrupt controllers are involved (yes, they can be in a PM (Clock)
Domain too), there are definitely some complex issues to resolve in the core OF
probing code first. Cfr. the bug mentioned in
http://marc.info/?l=devicetree&m=142325419327559&w=2

>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>> index ba4abbe..2b93c98 100644
>>>> --- a/drivers/base/power/domain.c
>>>> +++ b/drivers/base/power/domain.c
>>>> @@ -2064,7 +2064,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>>>>  struct generic_pm_domain *of_genpd_get_from_provider(
>>>>                                       struct of_phandle_args *genpdspec)
>>>>  {
>>>> -     struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
>>>> +     struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
>>
>> Currently platform_drv_probe() just continues if dev_pm_domain_attach() returns
>> a different error than -EPROBE_DEFER, which is what you are seeing.
>>
>> Your change does have the side effect that a new DT with PM domains won't
>> work on an older kernel that doesn't have the PM domain driver yet.
>
> Is that a real problem though?  Using newer DTs on older kernels can
> cause many types of problems.

It means we cannot describe everything in (stable) DT before all support code
has been implemented. Ignoring that, it enforces strict merge order.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
