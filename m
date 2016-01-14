From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Thu, 14 Jan 2016 09:57:14 +0100
Message-ID: <CAPDyKFrewx5CbS9QKZAxqq0Gu+TywQ3nkDGZFURR=PJLtkDuyQ@mail.gmail.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
	<1449241037-22193-17-git-send-email-jonathanh@nvidia.com>
	<20160113170324.GO2588@ulmo>
	<8579242.omBpg1aLr2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8579242.omBpg1aLr2@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 13 January 2016 at 21:43, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Wednesday 13 January 2016 18:03:24 Thierry Reding wrote:
>> On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
>> > Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
>> > dependent upon a particular power-domain are only probed when that power
>> > domain has been powered up, requires that PM is made mandatory for tegra
>> > 64-bit devices and so select this option for tegra as well.
>> >
>> > Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> > ---
>> >  arch/arm64/Kconfig.platforms | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> > index 9806324fa215..e0b5bd0aff0f 100644
>> > --- a/arch/arm64/Kconfig.platforms
>> > +++ b/arch/arm64/Kconfig.platforms
>> > @@ -93,6 +93,8 @@ config ARCH_TEGRA
>> >       select GENERIC_CLOCKEVENTS
>> >       select HAVE_CLK
>> >       select PINCTRL
>> > +     select PM
>> > +     select PM_GENERIC_DOMAINS
>> >       select RESET_CONTROLLER
>> >       help
>> >         This enables support for the NVIDIA Tegra SoC family.
>>
>> This has potential consequences for multi-platform builds, doesn't it?
>> All of a sudden any combination of builds that includes Tegra won't be
>> possible to build without PM support.
>>
>> Adding linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org for visibility.
>>
>>
>
> Agreed, it would be better to add 'depends on PM_GENERIC_DOMAINS'
> dependencies in the drivers that require it.
>

The problem with that approach is that if those drivers are cross SoC
drivers. In some cases PM isn't needed and it is.

Of course I don't have the in depth knowledge about the drivers being
used in Tegra which may need PM, perhaps it's not that many?

Anyway, to me it seems like ARCH_TEGRA should depend on PM instead.
Would that work?

Kind regards
Uffe
