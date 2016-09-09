From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 08/10] PM / Domains: Add support for removing PM domains
Date: Fri, 9 Sep 2016 14:54:07 +0100
Message-ID: <c8498eca-6934-1cab-31d9-3d8ce4c74897@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-9-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 08/09/16 12:49, Ulf Hansson wrote:
> On 16 August 2016 at 11:49, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> The genpd framework allows users to add PM domains via the pm_genpd_init()
>> function, however, there is no corresponding function to remove a PM
>> domain. For most devices this may be fine as the PM domains are never
>> removed, however, for devices that wish to populate the PM domains from
>> within a driver, having the ability to remove a PM domain if the probing
>> of the device fails or the driver is unloaded is necessary.
>>
>> Add the function pm_genpd_remove() to remove a PM domain by referencing
>> it's generic_pm_domain structure.
>>
>> PM domains can only be removed if they are not a parent domain to
>> another PM domain and have no devices associated with them.
> 
> I think we should also check if the there's is a provider registered
> for the genpd, as it should also prevent the genpd from being removed.
> Right?

Yes I would agree. I had thought that after patch #4 of this series that
only the provider itself would be able to call this. However, we should
probably still verify that the provider has correctly remove itself.

> I noticed that you are adding the ->provider pointer to the genpd
> struct in patch 9/10. Perhaps re-structure $subject patch and 9/10 a
> bit to deal with this, so we can add the pm_genpd_remove() API in a
> more safe manner.

Yes I can add the >provider member before this patch.

Cheers
Jon

-- 
nvpublic
