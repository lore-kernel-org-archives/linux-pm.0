From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Fri, 22 Jun 2018 20:27:07 +0200
Message-ID: <20180622182707.i52l3z4yq2ozmqkw@kozik-lap>
References: <CGME20180621103531eucas1p15ccaf3a2069fe5a188daaeb8e2a29a93@eucas1p1.samsung.com>
 <8551504.8D13YNfR1X@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8551504.8D13YNfR1X@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 21, 2018 at 12:35:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed samsung thermal properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - rebased against current -next kernel
> 
>  arch/arm/boot/dts/exynos3250.dtsi                 |    2 +-
>  arch/arm/boot/dts/exynos4.dtsi                    |    2 +-
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi |   20 --------------------
>  arch/arm/boot/dts/exynos5250.dtsi                 |    2 +-
>  arch/arm/boot/dts/exynos5410.dtsi                 |    8 ++++----
>  arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi |   21 ---------------------
>  arch/arm/boot/dts/exynos5420.dtsi                 |   10 +++++-----
>  7 files changed, 12 insertions(+), 53 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
