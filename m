From: amit daniel kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RFC v2 08/12] soc: samsung: pm_domain: Add support for
 parent power domain
Date: Tue, 25 Nov 2014 14:27:58 +0530
Message-ID: <CADGdYn4Vi2wV1y3Y0cTbPL0cFR2EEV7jT=82fHNYu+=xwZ7mBA@mail.gmail.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
	<1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
	<1416834256-11225-8-git-send-email-amit.daniel@samsung.com>
	<CAPDyKFoBnViXQF=wDYp0x4gaOO4ht3a8KBeY6=k6_Zkkav28pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoBnViXQF=wDYp0x4gaOO4ht3a8KBeY6=k6_Zkkav28pQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pankaj Dubey <pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 25, 2014 at 1:29 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 24 November 2014 at 14:04, Amit Daniel Kachhap
> <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> This patch adds supports for parent power domain. This will ensure
>> invoking of parent/child power domain on/off in a correct sequence.
>> In exynos7 SOC's, power domain controllers have parent and child
>> hierarchy.
>>
>> Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  .../bindings/arm/exynos/power_domain.txt           |    2 +
>>  drivers/soc/samsung/pm_domains.c                   |   43 +++++++++++++++++++-
>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>> index 00ebda1..0160bdc 100644
>> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>> @@ -24,6 +24,7 @@ Optional Properties:
>>         - pclkN, clkN: Pairs of parent of input clock and input clock to the
>>                 devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
>>                 are supported currently.
>> +- parents: phandle of parent power domains.
>>
>>  Node of a device using power domains must have a samsung,power-domain property
>>  defined with a phandle to respective power domain.
>> @@ -48,6 +49,7 @@ Example:
>>         mfc_pd: power-domain@10044060 {
>>                 compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
>>                 reg = <0x10044060 0x20>;
>> +               parents = <&pd_top>;
>>                 #power-domain-cells = <0>;
>>         };
>
> This seems like a good and generic approach to describe that a PM
> domain could have a parent. I would suggest to rename it, such it
> reflects its a PM domain binding though.
I am not sure if this is generic. I guess PD's represented like below
are more generic.
PD1 {
        PD2 {
                PD3 {
                };
        };
};

>
> So, maybe we can add this as a common DT binding for the generic PM
> domain instead of having it as Exynos specific?
Yes sure.

Regards,
Amit D
>
> Kind regards
> Uffe
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
