From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 14/14] arm64: dts: exynos: remove no longer needed
 samsung thermal properties
Date: Wed, 20 Jun 2018 21:19:45 +0200
Message-ID: <20180620191945.lesqbvweltupnvf3@kozik-lap>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101428epcas1p1d9646bf1b56f0512a3fa3a6301b793c6@epcas1p1.samsung.com>
 <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 16, 2018 at 12:12:05PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed samsung thermal properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
>  .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 10 +++++-----
>  .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
>  arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
>  5 files changed, 6 insertions(+), 66 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
> 

Thanks, applied.

Best regards,
Krzysztof
