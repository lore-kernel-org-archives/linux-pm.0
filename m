From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2: 3/3] thermal: samsung: Add TMU support for Exynos5420
 SoCs
Date: Wed, 28 Aug 2013 12:38:31 +0200
Message-ID: <2432994.TkQmThmFSA@amdc1032>
References: <1375336979-14747-1-git-send-email-ch.naveen@samsung.com>
 <1377681409-18166-1-git-send-email-ch.naveen@samsung.com>
 <1377681409-18166-3-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1377681409-18166-3-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, naveenkrishna.ch@gmail.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Wednesday, August 28, 2013 02:46:49 PM Naveen Krishna Chatradhi wrote:
> This patch adds the neccessary register changes and arch information
> to support Exynos5420 SoCs
> Exynos5420 has 5 TMU channels one for each CPU 0, 1, 2 and 3 and GPU
> 
> Note: The platform data structure will be handled properly once the driver
>  moves to complete device driver solution.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

OK, this is also an acceptable solution (though it seems to be worse
in terms of simplicity and long term maintainance). Anyway please ignore
my comments to v1, just remember to rename this flag (as already pointed
by out by Amit). TMU_SUPPORT_SHARED_MEMORY documentation in exynos_tmu.h
also requires an update.

> ---
> Changes since v1:
> 1. modified the platform data structure in order to pass SHARED flag
>    for channels that need sharing of address space.
> 2. https://lkml.org/lkml/2013/8/1/38 is merged into this patch.
>    As the changes are minimum and can be added here.

Documentation/devicetree/bindings/thermal/exynos-thermal.txt update got
lost and it is quite important now as second address servers multiple
purposes. Please fix it.

>  drivers/thermal/samsung/exynos_tmu.c      |   14 +++-
>  drivers/thermal/samsung/exynos_tmu.h      |    1 +
>  drivers/thermal/samsung/exynos_tmu_data.c |  130 +++++++++++++++++++++++++++++
>  drivers/thermal/samsung/exynos_tmu_data.h |    7 ++
>  4 files changed, 150 insertions(+), 2 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
