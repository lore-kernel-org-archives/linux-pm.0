From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 13/14] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Wed, 20 Jun 2018 21:17:20 +0200
Message-ID: <20180620191720.kywnok5ahod3zmmk@kozik-lap>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0@epcas1p4.samsung.com>
 <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 16, 2018 at 12:12:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed samsung thermal properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos4.dtsi                    |  2 +-
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos5410.dtsi                 |  8 ++++----
>  arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 21 ---------------------
>  arch/arm/boot/dts/exynos5420.dtsi                 | 10 +++++-----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5440.dtsi                 |  6 +++---
>  9 files changed, 15 insertions(+), 76 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
>

A lot of changes came in recently so this does not apply anymore. Could
you rebase on my for-next branch?

Best regards,
Krzysztof
