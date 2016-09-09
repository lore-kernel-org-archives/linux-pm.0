From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/10] PM / Domains: Store the provider in the PM domain structure
Date: Fri, 9 Sep 2016 16:25:44 +0200
Message-ID: <CAPDyKFr7uLgqzMpEfMDZHnnFXTxhvSsaeaUSfM4-6rbahp1PEg@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-10-git-send-email-jonathanh@nvidia.com> <CAPDyKFp+93=CrmgLNx1ritm1Dm=eWFJn=vbuzAUb9VmWc4j1fg@mail.gmail.com>
 <73870e28-3600-8a84-7659-55d4a8320a1d@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <73870e28-3600-8a84-7659-55d4a8320a1d-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>
>> I also think you should extend this change, to also make the
>> of_genpd_del_provider() API to reset the genpd->provider = NULL.
>> Otherwise you can't track when a provider is removed.
>
> Unfortunately that is not going to work. The function
> of_genpd_remove_tail() (patch #10) uses the ->provider member to remove
> the last domain for the given provider and of_genpd_del_provider() must
> be called before hand.

Yes, of course - you are right!

Kind regards
Uffe
