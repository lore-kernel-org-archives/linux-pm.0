From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: exynos: Propagate error value from tmu_read()
Date: Tue, 27 Feb 2018 16:25:02 +0100
Message-ID: <1635777.KPLQ7M4AcC@amdc3058>
References: <CGME20180227151408eucas1p20dc5f0974dda96b4ebaff7948eda766a@eucas1p2.samsung.com>
        <20180227151405.9618-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20180227151405.9618-1-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 27, 2018 04:14:05 PM Marek Szyprowski wrote:
> tmu_read() in case of Exynos4210 might return error for out of bound
> values. Current code ignores such value, what leads to reporting critical
> temperature value. Add proper error code propagation to exynos_get_temp()
> function.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: stable@vger.kernel.org # v4.6+

Thanks for fixing this.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
> This patch is prepared on top of "thermal: exynos: Reading temperature
> makes sense only when TMU is turned on" patch. Both are required
> to finally fix thermal support on Exynos4210 based boards.
> 
> This patch only applies cleanly together with the mentioned "thermal:
> exynos: Reading temperature makes sense only when TMU is turned on"
> patch on v4.6+ kernels.

You may also add:

Fixes: 3b6a1a805f34 ("thermal: samsung: core: Exynos TMU rework to use device tree for configuration")

to the patch description.

Best regards,
