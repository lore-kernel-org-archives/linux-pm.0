From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/5] power: domain: add pm_genpd_exit
Date: Mon, 14 Dec 2015 10:49:07 +0100
Message-ID: <CAPDyKFpSu=vik3kDn9zrv7dkg5n+Dqe+xs4FZnB8nhTA=ahaAg@mail.gmail.com>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
	<1449251148-19344-2-git-send-email-eric@anholt.net>
	<5665599A.4060509@nvidia.com>
	<7h8u54lqbv.fsf@deeprootsystems.com>
	<20151209104752.GB1036@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151209104752.GB1036@omega>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

+Russell

[...]

>> >> +void pm_genpd_exit(struct generic_pm_domain *genpd)
>> >> +{
>> >> +  if (IS_ERR_OR_NULL(genpd))
>> >> +          return;
>> >> +
>> >> +  /* check if domain is still in registered inside the pm subsystem */
>> >> +  WARN_ON_ONCE(!list_empty(&genpd->master_links) ||
>> >> +               !list_empty(&genpd->slave_links) ||
>> >> +               !list_empty(&genpd->dev_list));
>> >> +
>> >
>> > Why not return an error here? Seems bad to remove it, if it could still
>> > be referenced by other domains.
>>
>> I had pointed this out as well in an earlier review.
>>
>
> I talked with Ulf Hansson about such handling and there exists currently
> no handling to remove the pm_genpd on error handling (what our use case
> is for RPi domains).
>
> The real solution would be a "pm_genpd_exit_recursive" functionality to
> remove subdomains, etc -> simple everything. Anway I am not a expert into
> power domain functionality and this simple approach was enough to him to
> add "something" which we have actually a lack of support.
>
>

[...]

Just to be clear on my view. I think Russell made a good summary of
how we should implement this API [1].
We should return an error, instead of WARN_ON_ONCE and continue.

Perhaps you can do both a WARN *and* return an error.

Regarding the similar patch from Jon Hunter, I would suggest we focus
on Alexander's $subject patch and try to it queued for 4.5. Please
send a new version.

Also, as other SoC genpd driver isn't using a "pm_genpd_exit()" API,
it shouldn't prevent neither Alexander/Eric or Jon from proceeding
with the RPI/Tegra genpd drivers. Once the new API is in place you can
update these drivers to properly deal with error handling and undo
things from pm_genpd_init().

Kind regards
Uffe

[1]
https://lkml.org/lkml/2015/12/9/308
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
