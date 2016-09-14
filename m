From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 00/10] PM / Domains: Add support for removing PM domains
Date: Wed, 14 Sep 2016 02:58:34 +0200
Message-ID: <14914984.irHbtjz3da@vostro.rjw.lan>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61939 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752289AbcINAw0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 20:52:26 -0400
In-Reply-To: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org

On Monday, September 12, 2016 12:01:04 PM Jon Hunter wrote:
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

All applied.

I'll expose a branch containing them after they've spent a couple of days in
linux-next.

Thanks,
Rafael

