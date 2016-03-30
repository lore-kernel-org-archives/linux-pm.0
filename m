From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 0/4] Add generic PM domain support for Tegra
Date: Wed, 30 Mar 2016 11:38:43 +0200
Message-ID: <CAPDyKFr2e00bGjK8AE5qPw7wcMFzRr0L3Y7tSVPcCYVqa=9VuQ@mail.gmail.com>
References: <1459329316-27293-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459329316-27293-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 30 March 2016 at 11:15, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Adds generic PM domain support for Tegra SoCs but this series only
> enables support for it on Tegra 64-bit devices. There is no reason why
> this cannot be enable for Tegra 32-bit devices, but to keep the patch
> series to a minimum only 64-bit devices are enabled so far.
>
> This series has been boot tested on Tegra210 as well as various 32-bit
> Tegra platforms.
>
> Summary of changes since V7:
> - Minor update to DT documentation per Rob H's feedback.
>
> Summary of changes since V6:
> - Dropped removal of PM domains, while infrastructure for removing PM
>   domains has been sorted out [4]. Please note that because the PMC driver
>   is never removed, we can simply create the PM domains at the very end
>   of the PMC probe and WARN if any of the PM domains cannot be
>   instantiated.
> - Dropped support for subdomains because there is currently no need to
>   support subdomains for Tegra and this simplifies the code substantially.
> - Updated DT bindings for Tegra powergates based upon feedback from
>   Thierry Reding.
> - Added patch to remove "#power-domain-cells" that in the Tegra210
>   device-tree source that was added incorrectly.
>
> Summary of changes since V5 [2]:
> - Split series into 2 series, separating PMC fixes [3] from genpd changes
> - This series is based upon fixes series (which is now in -next)
> - Added patch to fix removal of genpd subdomain
> - Added patch to get last genpd that was added
> - Fixed locking in function to remove genpd
> - Updated Tegra PMC driver to ensure power-domains cannot be controlled
>   by both legacy Tegra APIs and generic PM domain framework
> - Removed powergate list from Tegra PMC driver and updated removal of
>   power domains to use new genpd APIs.
>
> Summary of changes since V4 [1]:
> - Re-worked fix to handle base address on probe failure
> - Added patch to lock around simultaneuous accesses to PMC registers
> - Added patch to change powergate and rail IDs to unsigned type
> - Added patch to fix testing of powergate state
> - Updated patch to check for valid powergates to use a bitmap
> - Updated Tegra DT PMC bindings per Rob H's feedback
> - Updated Tegra power domains binding per Thierry's feedback
> - Updated Tegra generic power domain support per Thierry's feedback
>
> Summary of changes since V3 [0]:
> - Dropped tegra124 support for now
> - Removed MC flush support per feedback from Thierry
> - Cleaned up the PMC changes per feedback from Thierry
> - Added support for tegra210
>
> [0] http://comments.gmane.org/gmane.linux.ports.tegra/22944
> [1] http://marc.info/?l=linux-tegra&m=144924153600529&w=2
> [2] http://marc.info/?l=linux-tegra&m=145399885003830&w=2
> [3] http://marc.info/?l=linux-tegra&m=145521381331144&w=2
> [4] http://marc.info/?l=linux-pm&m=145709064407085&w=2
>
> Jon Hunter (4):
>   ARM64: tegra: Remove unused #power-domain-cells property
>   Documentation: DT: bindings: Add power domain info for NVIDIA PMC
>   soc: tegra: pmc: Add generic PM domain support
>   ARM64: tegra: select PM_GENERIC_DOMAINS
>
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  80 ++++
>  arch/arm64/Kconfig.platforms                       |   2 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   2 -
>  drivers/soc/tegra/pmc.c                            | 485 ++++++++++++++++++---
>  include/soc/tegra/pmc.h                            |   1 +
>  5 files changed, 507 insertions(+), 63 deletions(-)
>
> --
> 2.1.4
>

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe
