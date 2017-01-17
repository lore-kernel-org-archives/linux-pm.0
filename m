From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 11/13] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Tue, 17 Jan 2017 19:48:17 +0200
Message-ID: <20170117174817.ollml6z2qaopvr3u@kozik-lap>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124502eucas1p131b3b424454ee380b0c93899989a51f6@eucas1p1.samsung.com>
 <1484657084-26227-12-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484657084-26227-12-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 17, 2017 at 01:44:42PM +0100, Marek Szyprowski wrote:
> This patch moves pad retention control from PMU driver to Exynos pin
> controller driver. This helps to avoid possible ordering and logical
> dependencies between machine, PMU and pin control code. Till now it
> worked fine only because sys_ops for PMU and pin controller were called
> in registration order.
> This is also a preparation for adding new features to Exynos pin
> controller driver, like runtime power management and suspending
> individual pin controllers, which might be a part of some power domain.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-exynos/suspend.c           |  64 --------------
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 146 +++++++++++++++++++++++++++++++
>  2 files changed, 146 insertions(+), 64 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

