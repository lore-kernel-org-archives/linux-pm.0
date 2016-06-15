From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/8] PM / Domains: Add support for removing PM domains
Date: Wed, 15 Jun 2016 16:46:38 +0200
Message-ID: <CAPDyKFoUxknMzF-TReS+3LkRLvw-X1SeBCw83_y_bsXVGJVnXA@mail.gmail.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 4 March 2016 at 12:23, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> In order to safely remove PM domains there are a few changes that need to be
> made to ensure that no one is holding an external reference to a PM domain
> after it has been removed. One solution, implemented here, solves this by
> eliminating external references to PM domain. Another alternative would be
> to employ some reference counting for the PM domains, however, I did not see
> a good reason for allowing external references in the first place (as always
> there could be something that I have over-looked!).
>
> Jon Hunter (8):
>   PM / Domains: Add new helper functions for device-tree
>   ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
>   staging: board: Remove calls to of_genpd_get_from_provider()
>   PM / Domains: Don't expose generic_pm_domain structure
>   PM / Domains: Verify the PM domain is present when adding a provider
>   PM / Domains: Remove a provider by referencing the data pointer
>   PM / Domains: Prepare for adding support to remove PM domains
>   PM / Domains: Add support for removing PM domains
>
>  arch/arm/mach-exynos/pm_domains.c |  23 +--
>  drivers/base/power/domain.c       | 324 +++++++++++++++++++++++++++++++++++---
>  drivers/staging/board/board.c     |   9 +-
>  include/linux/pm_domain.h         |  55 ++++---
>  4 files changed, 348 insertions(+), 63 deletions(-)
>
> --
> 2.1.4
>

Apologize for the long delay!

I have looked through this now and I really like this!

There were a few comments, but those should be easily taken care of.
So please go ahead and re-spin a new version!

There are a few outstanding genpd patches which I have posted a while
ago but which isn't yet queued for 4.8.
I don't know whether those will conflict with this series (if they get
merged prior to this), but I guess it's better if you anyway base you
series on Rafael's latest changes instead of on top of mine...

Kind regards
Uffe
