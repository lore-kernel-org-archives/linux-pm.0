From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/8] PM / Domains: Add support for removing PM domains
Date: Mon, 6 Jun 2016 14:19:56 +0100
Message-ID: <5755787C.2050807@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFq3hNARzjSOoP+-NmcgfSWzG6GDmh7qVX6yx6QPgN9Arw@mail.gmail.com>
 <56F925D9.3080703@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56F925D9.3080703-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 28/03/16 13:38, Jon Hunter wrote:
> Hi Uffe,
> 
> On 04/03/16 12:33, Ulf Hansson wrote:
>> On 4 March 2016 at 12:23, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> In order to safely remove PM domains there are a few changes that need to be
>>> made to ensure that no one is holding an external reference to a PM domain
>>> after it has been removed. One solution, implemented here, solves this by
>>> eliminating external references to PM domain. Another alternative would be
>>> to employ some reference counting for the PM domains, however, I did not see
>>> a good reason for allowing external references in the first place (as always
>>> there could be something that I have over-looked!).
>>>
>>> Jon Hunter (8):
>>>   PM / Domains: Add new helper functions for device-tree
>>>   ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
>>>   staging: board: Remove calls to of_genpd_get_from_provider()
>>>   PM / Domains: Don't expose generic_pm_domain structure
>>>   PM / Domains: Verify the PM domain is present when adding a provider
>>>   PM / Domains: Remove a provider by referencing the data pointer
>>>   PM / Domains: Prepare for adding support to remove PM domains
>>>   PM / Domains: Add support for removing PM domains
>>>
>>>  arch/arm/mach-exynos/pm_domains.c |  23 +--
>>>  drivers/base/power/domain.c       | 324 +++++++++++++++++++++++++++++++++++---
>>>  drivers/staging/board/board.c     |   9 +-
>>>  include/linux/pm_domain.h         |  55 ++++---
>>>  4 files changed, 348 insertions(+), 63 deletions(-)
>>>
>>> --
>>> 2.1.4
>>>
>>
>> Jon, thanks for posting this!
>> My initial impressions is the I like the ideas for where you moves this.
>>
>> I will review it in more details as soon as I can (travelling next week).
> 
> Just wanted to see if you have had chance to look at this yet? Not urgent.

Any feedback on this?

FYI, patch #2 does not apply cleanly on the latest -next but the others
should.

Cheers
Jon

-- 
nvpublic
