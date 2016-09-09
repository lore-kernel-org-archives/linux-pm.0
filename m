From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/10] PM / Domains: Add support for removing nested PM
 domains by provider
Date: Fri, 9 Sep 2016 16:21:45 +0200
Message-ID: <CAPDyKFqSLqHq7XymD2CZzzyAV3ohr5pKS1uTR6DXyBFh+VWCfg@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-11-git-send-email-jonathanh@nvidia.com> <CAPDyKFq3h1-64FtZwXa7XWO1UJj8Od-cfjwa8i4bDwN1VVdL7w@mail.gmail.com>
 <f31e57aa-52aa-d340-ca2b-73dbdf769035@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f31e57aa-52aa-d340-ca2b-73dbdf769035-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>>  /**
>>> + * of_genpd_remove_tail - Remove the last PM domain registered for a provider
>>> + * @provider: Pointer to device structure associated with provider
>>
>> The naming of this function would be okay, if we only have added
>> genpds in the gpd_list by using list_add_tail(), although we don't.
>> Instead we use list_add() and put them first in the list.
>>
>> So, unless we change to use list_add_tail() when adding genpds (I
>> assume we can do that!), I would rather change the name of this
>> function to of_genpd_remove_first().
>>
>> What option do you prefer?
>
> I think that I would prefer either of_genpd_remove_last() or
> of_genpd_remove_one(). Although _first is accurate from the list
> perspective it seems odd from the user perspective. I think that _last
> is more meaningful as we are removing the last that was added regardless
> or how things appear on the list. Alternatively, _one could be a good
> compromise.

I am fine with of_genpd_remove_last().

[...]

Kind regards
Uffe
