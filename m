From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Subject: Re: [PATCH 0/3] thermal: samsung: Clean up and add support for Exynos5420
Date: Mon, 18 Nov 2013 08:55:40 +0530
Message-ID: <CAHfPSqCowbDoCdWQ-33S3fQ1p3hDULCaR3X2roETZKZqNU-S_A@mail.gmail.com>
References: <1377668719-8602-1-git-send-email-ch.naveen@samsung.com> <1384238132-24515-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1384238132-24515-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

Hello All,

On 12 November 2013 12:05, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> This patchset does a little clean up of the existing code
> 1.  [v9] thermal: samsung: replace inten_ bit fields with intclr_
> 2.  [v9] thermal: samsung: change base_common to more meaningful base_second
>
> adds support for Exynos5420 in the driver and
> 3.  [v9] thermal: samsung: Add TMU support for Exynos5420 SoCs
> also adds the device tree nodes for the same to exynos5420.dtsi (linux-samsung.git)
> 4.  [v3] ARM: dts: Exynos5420: Add device nodes for TMU blocks
>
> Naveen Krishna Chatradhi (3):
>   thermal: samsung: replace inten_ bit fields with intclr_
>   thermal: samsung: change base_common to more meaningful base_second
>   thermal: samsung: Add TMU support for Exynos5420 SoCs
>   ARM: dts: Exynos5420: Add device nodes for TMU blocks
>
>  .../devicetree/bindings/thermal/exynos-thermal.txt |   49 +++++++-
>  drivers/thermal/samsung/exynos_tmu.c               |   78 +++++++++---
>  drivers/thermal/samsung/exynos_tmu.h               |   22 ++--
>  drivers/thermal/samsung/exynos_tmu_data.c          |  126 ++++++++++++++++++--
>  drivers/thermal/samsung/exynos_tmu_data.h          |   12 +-
>  5 files changed, 249 insertions(+), 38 deletions(-)
>
> --
> 1.7.10.4
Any comments on this patch set please.
>



-- 
Shine bright,
(: Nav :)
