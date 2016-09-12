From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/10] PM / Domains: Add support for removing PM domains
Date: Mon, 12 Sep 2016 09:21:39 +0200
Message-ID: <CAPDyKFp+eDBLge40uv6aDuYOkaKAksgqZekqomLZijPrhDzj6A@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-9-git-send-email-jonathanh@nvidia.com> <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
 <c8498eca-6934-1cab-31d9-3d8ce4c74897@nvidia.com> <63871fe6-cda6-2a95-9c09-e4b3ebfa3419@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <63871fe6-cda6-2a95-9c09-e4b3ebfa3419-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 9 September 2016 at 17:17, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 09/09/16 14:54, Jon Hunter wrote:
>> On 08/09/16 12:49, Ulf Hansson wrote:
>>> On 16 August 2016 at 11:49, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>> The genpd framework allows users to add PM domains via the pm_genpd_init()
>>>> function, however, there is no corresponding function to remove a PM
>>>> domain. For most devices this may be fine as the PM domains are never
>>>> removed, however, for devices that wish to populate the PM domains from
>>>> within a driver, having the ability to remove a PM domain if the probing
>>>> of the device fails or the driver is unloaded is necessary.
>>>>
>>>> Add the function pm_genpd_remove() to remove a PM domain by referencing
>>>> it's generic_pm_domain structure.
>>>>
>>>> PM domains can only be removed if they are not a parent domain to
>>>> another PM domain and have no devices associated with them.
>>>
>>> I think we should also check if the there's is a provider registered
>>> for the genpd, as it should also prevent the genpd from being removed.
>>> Right?
>>
>> Yes I would agree. I had thought that after patch #4 of this series that
>> only the provider itself would be able to call this. However, we should
>> probably still verify that the provider has correctly remove itself.
>
> So now I have the following. I am still not 100% happy. I cannot clear
> the ->provider when calling of_genpd_del_provider() and so I cannot use
> this to verify if the provider is present and so I need to check the
> list of providers and it gets a bit messy. I have been wracking my
> brains to find a better alternative (including a single function to
> remove the provider and domains at once but there are issues with that
> as well).

Instead of using the ->provider pointer to know whether the genpd has
a valid provider, why not just add an additional ->has_provider bool
flag in the genpd struct?

Simply set the flag when adding the provider and reset it when
removing it. Wouldn't that work?

>
> I think that long term it may make sense to reference the providers
> exclusively by the fwnode_handle and make the list of provider non-DT
> specific. I could do it now, but it would increase the series.

Perhaps a good idea. Although I agree, let's not make that change as a
part of this series.

[...]

Kind regards
Uffe
