From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] thermal: samsung: Remove support for Exynos5440
Date: Tue, 1 May 2018 09:45:16 -0500
Message-ID: <20180501144516.GA519@rob-hp-laptop>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-7-krzk@kernel.org>
 <1951102.VLysaozMLK@amdc3058>
 <CGME20180426112113eucas1p1b5bf6f093442154e29f5541b4aba6b00@eucas1p1.samsung.com>
 <2734003.UHSMxVLybj@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2734003.UHSMxVLybj@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 01:21:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Subject: [PATCH] thermal: samsung: Remove support for Exynos5440
> 
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> [b.zolnierkie: ported over driver changes]
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Eduardo, here is a version which applies on top of pending Exynos
> thermal changes (https://lkml.org/lkml/2018/4/16/256).
> 
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt |   14 
>  drivers/thermal/samsung/exynos_tmu.c                         |  161 -----------
>  2 files changed, 4 insertions(+), 171 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
