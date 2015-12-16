From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Wed, 16 Dec 2015 11:40:19 +0000
Message-ID: <56714DA3.80707@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-17-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrcuK4iCo7Tg1Q_XjB7Y-+=s-ax1vzK4UEu9FfPnuProw@mail.gmail.com>
 <567131A2.6030303@nvidia.com>
 <CAPDyKFpZoZZapqanFyUzT_jZ6DLBnGXOXEyDHosWpphAjzhy7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpZoZZapqanFyUzT_jZ6DLBnGXOXEyDHosWpphAjzhy7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 16/12/15 09:47, Ulf Hansson wrote:
> On 16 December 2015 at 10:40, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi Ulf,
>>
>> On 15/12/15 19:54, Ulf Hansson wrote:
>>> On 4 December 2015 at 15:57, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>> Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
>>>> dependent upon a particular power-domain are only probed when that power
>>>> domain has been powered up, requires that PM is made mandatory for tegra
>>>> 64-bit devices and so select this option for tegra as well.
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>  arch/arm64/Kconfig.platforms | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>>> index 9806324fa215..e0b5bd0aff0f 100644
>>>> --- a/arch/arm64/Kconfig.platforms
>>>> +++ b/arch/arm64/Kconfig.platforms
>>>> @@ -93,6 +93,8 @@ config ARCH_TEGRA
>>>>         select GENERIC_CLOCKEVENTS
>>>>         select HAVE_CLK
>>>>         select PINCTRL
>>>> +       select PM
>>>> +       select PM_GENERIC_DOMAINS
>>>
>>> If you still want to allow ARCH_TEGRA to run without PM, you should
>>> probably change to:
>>>
>>> select PM_GENERIC_DOMAINS if PM
>>
>> Per the changelog this is deliberate. If we allow !PM, then there is a
>> potential that you could probe a device when the power domain is not
>> powered on. I understand that some SoCs turn on all the power-domains
>> when !PM but this will not work for tegra because we don't register the
>> power domain until later in the boot and so we are relying upon probe
>> deferral to defer the probe of devices that use power-domains.
> 
> So what you are saying is that adding the PM domain support, will fix
> some devices to become successfully probed as they were broken before?

Not exactly. There is a legacy tegra_powergate_sequence_power_up() that
has been used to date to get around this. However, by migrating to GENPD
we really need to make PM mandatory, otherwise you could attempt to
probe a device in a power domain that is not powered. In other words,
you are probing blindly. I know some SoCs do this, but that does not
seem very robust.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
