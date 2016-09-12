From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 00/10] PM / Domains: Add support for removing PM domains
Date: Mon, 12 Sep 2016 15:02:13 +0200
Message-ID: <CAPDyKFqd6vH=eCKBSQg0Q5w9x8sd0SiZ42E7yJn6ZDWP1OMuZg@mail.gmail.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473678074-15126-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12 September 2016 at 13:01, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> In order to safely remove PM domains there are a few changes that need to be
> made to ensure that no one is holding an external reference to a PM domain
> after it has been removed. One solution, implemented here, solves this by
> eliminating external references to PM domain.
>
> Changes from V1:
> - Added test when removing a PM domain to ensure the PM domain provider
>   has been removed.
> - Re-organised patches 8-10 so that patch #8 adds the code to verify if
>   the provider is present, patch #9 adds basic support for removing PM
>   domains and patch #10 adds support for removing PM domains by provider.
>
> Changes from initial RFC:
> - Renamed functions made static per Ulf's feedback.
> - Added patch to clean-up provider/xlate APIs per Ulf's feedback
> - Re-worked and simplified the association between PM domains and PM
>   domain providers. Dropped the 'provider_data' variable from the
>   generic_pm_domain structure in favour of using the fwnode_handle.
> - Split patch for removing PM domains into multiple patches per Ulf's
>   feedback.
>
> Jon Hunter (10):
>   PM / Domains: Add new helper functions for device-tree
>   ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
>   staging: board: Remove calls to of_genpd_get_from_provider()
>   PM / Domains: Don't expose generic_pm_domain structure to clients
>   PM / Domains: Don't expose xlate and provider helper functions
>   PM / Domains: Verify the PM domain is present when adding a provider
>   PM / Domains: Prepare for adding support to remove PM domains
>   PM / Domains: Store the provider in the PM domain structure
>   PM / Domains: Add support for removing PM domains
>   PM / Domains: Add support for removing nested PM domains by provider
>
>  drivers/base/power/domain.c      | 353 +++++++++++++++++++++++++++++++++++----
>  drivers/soc/samsung/pm_domains.c |  23 +--
>  drivers/staging/board/board.c    |   9 +-
>  include/linux/pm_domain.h        |  74 ++++----
>  4 files changed, 364 insertions(+), 95 deletions(-)
>
> --
> 2.1.4
>

Jon, thanks for being patient and keep working on this series! I have
now completed the review and I am happy with this version.

Also, I remember Krzysztof requested an immutable branch for this
series, I guess Rafael can arrange that if still needed!?

Kind regards
Uffe
