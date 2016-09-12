From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 08/10] PM / Domains: Add support for removing PM domains
Date: Mon, 12 Sep 2016 08:26:37 +0100
Message-ID: <c6e6f1ca-55e9-6157-08ff-bb082cae2840@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-9-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
 <c8498eca-6934-1cab-31d9-3d8ce4c74897@nvidia.com>
 <63871fe6-cda6-2a95-9c09-e4b3ebfa3419@nvidia.com>
 <CAPDyKFp+eDBLge40uv6aDuYOkaKAksgqZekqomLZijPrhDzj6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19828 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbcILH0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 03:26:55 -0400
In-Reply-To: <CAPDyKFp+eDBLge40uv6aDuYOkaKAksgqZekqomLZijPrhDzj6A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>


On 12/09/16 08:21, Ulf Hansson wrote:
> On 9 September 2016 at 17:17, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> On 09/09/16 14:54, Jon Hunter wrote:
>>> On 08/09/16 12:49, Ulf Hansson wrote:
>>>> On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>> The genpd framework allows users to add PM domains via the pm_genpd_init()
>>>>> function, however, there is no corresponding function to remove a PM
>>>>> domain. For most devices this may be fine as the PM domains are never
>>>>> removed, however, for devices that wish to populate the PM domains from
>>>>> within a driver, having the ability to remove a PM domain if the probing
>>>>> of the device fails or the driver is unloaded is necessary.
>>>>>
>>>>> Add the function pm_genpd_remove() to remove a PM domain by referencing
>>>>> it's generic_pm_domain structure.
>>>>>
>>>>> PM domains can only be removed if they are not a parent domain to
>>>>> another PM domain and have no devices associated with them.
>>>>
>>>> I think we should also check if the there's is a provider registered
>>>> for the genpd, as it should also prevent the genpd from being removed.
>>>> Right?
>>>
>>> Yes I would agree. I had thought that after patch #4 of this series that
>>> only the provider itself would be able to call this. However, we should
>>> probably still verify that the provider has correctly remove itself.
>>
>> So now I have the following. I am still not 100% happy. I cannot clear
>> the ->provider when calling of_genpd_del_provider() and so I cannot use
>> this to verify if the provider is present and so I need to check the
>> list of providers and it gets a bit messy. I have been wracking my
>> brains to find a better alternative (including a single function to
>> remove the provider and domains at once but there are issues with that
>> as well).
> 
> Instead of using the ->provider pointer to know whether the genpd has
> a valid provider, why not just add an additional ->has_provider bool
> flag in the genpd struct?
> 
> Simply set the flag when adding the provider and reset it when
> removing it. Wouldn't that work?

Yes. I was trying not to add to much clutter to the struct. However, may
be this is the best option.

Cheers
Jon

-- 
nvpublic
