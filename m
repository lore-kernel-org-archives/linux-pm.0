From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 01/13] soc: samsung: pmu: Provide global function to
 get PMU regmap
Date: Fri, 20 Jan 2017 18:39:32 +0200
Message-ID: <20170120163932.4me7fyxxxuiegouf@kozik-lap>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134904eucas1p153a1d5b2ff9826c88293b6a8fe5140bc@eucas1p1.samsung.com>
 <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 19, 2017 at 02:48:41PM +0100, Marek Szyprowski wrote:
> PMU is something like a SoC wide service, so add a helper function to get
> PMU regmap. This will be used by other Exynos device drivers. This way it
> can be avoided to model this dependency in device tree (as phandles to PMU
> node) for almost every device in the SoC.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c       | 11 +++++++++++
>  include/linux/soc/samsung/exynos-pmu.h | 10 ++++++++++
>  2 files changed, 21 insertions(+)
> 

Thanks, applied.

I'll prepare a tag for pinctrl in a sec.

Best regards,
Krzysztof
