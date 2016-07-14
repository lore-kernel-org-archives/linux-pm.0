From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v2 00/10] Exynos IOMMU: proper runtime PM support (use
 device dependencies)
Date: Thu, 14 Jul 2016 17:41:36 +0200
Message-ID: <5787B2B0.9020809@math.uni-bielefeld.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hello Marek,

I've tested the patchset on 4.7-rc7 and noticed that it breaks reboot on
my ODROID-X2.

Going to check where exactly things break.

With best wishes,
Tobias


Marek Szyprowski wrote:
> Hello,
> 
> This patch series finally implements proper runtime PM support in Exynos
> IOMMU driver. This has been achieved by using device links, which lets
> SYSMMU controller's runtime PM to follow master's device runtime PM (the
> device which actually performs DMA transaction). The main idea
> behind this solution is an observation that any DMA activity from master
> device can be done only when master device is active, thus when master
> device is suspended SYSMMU controller device can also be suspended.
> 
> This patchset solves the situation that power domains are always enabled,
> because all SYSMMU controllers (which belongs to those domains) are
> permanently active (because existing driver was simplified and kept
> SYSMMU device active all the time after initialization).
> 
> Patches 1-5 are resend of the "[RFC][PATCH 0/5] Functional dependencies
> between devices" patchset:
> http://thread.gmane.org/gmane.linux.power-management.general/67424/focus=2126379
> I've included them here, because it is hard to find them all on mailing
> list archives.
> 
> Patches 6-8 are fixes to device dependencies/links code, which were
> required to use this solution for Exynos IOMMU driver. I'm not PM/runtime
> PM code expert, so please double check if my changes are really correct.
> 
> This patchset requires my previous changes to Exynos IOMMU driver
> submitted in the "Exynos IOMMU: improve clock management" thread:
> http://www.spinics.net/lists/arm-kernel/msg505695.html
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> 
> Changelog:
> v2:
> - replaced PM notifiers with generic device dependencies/links developped
>   by Rafael J. Wysocki
> 
> v1: http://www.spinics.net/lists/arm-kernel/msg509600.html
> - initial version
> 
> 
> Patch summary:
> 
> Marek Szyprowski (5):
>   driver core: Avoid endless recursion if device has more than one link
>   driver core: Add support for links to already probed drivers
>   PM core: Fix restoring devices with links during system PM transition
>   iommu/exynos: Remove excessive, useless debug
>   iommu/exynos: Add proper runtime pm support
> 
> Rafael J. Wysocki (5):
>   driver core: Add a wrapper around __device_release_driver()
>   driver core: Functional dependencies tracking support
>   PM core: Make async suspend/resume of devices use device links
>   PM core: Make runtime PM of devices use device links
>   PM core: Optimize the use of device links for runtime PM
> 
>  drivers/base/base.h          |  13 ++
>  drivers/base/core.c          | 410 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/dd.c            |  65 +++++--
>  drivers/base/power/main.c    |  68 ++++++-
>  drivers/base/power/runtime.c | 130 +++++++++++++-
>  drivers/iommu/exynos-iommu.c | 221 +++++++++++------------
>  include/linux/device.h       |  41 +++++
>  include/linux/pm.h           |   1 +
>  include/linux/pm_runtime.h   |   6 +
>  9 files changed, 809 insertions(+), 146 deletions(-)
> 
