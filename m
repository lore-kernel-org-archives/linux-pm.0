From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v8 5/5] clk: samsung: exynos-audss: Add support for
 runtime PM
Date: Thu, 10 Aug 2017 07:51:45 +0200
Message-ID: <20170810055145.GA3268@kozik-book>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170809103515eucas1p19fcbdd113e191cc02f9e5aaa469376d3@eucas1p1.samsung.com>
 <1502274907-11931-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502274907-11931-6-git-send-email-m.szyprowski@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 09, 2017 at 12:35:07PM +0200, Marek Szyprowski wrote:
> This patch adds support for runtime PM to Exynos Audio SubSystem driver to
> enable full support for audio power domain on Exynos5 SoCs. The main change
> is moving register saving and restoring code from system sleep PM ops to
> runtime PM ops and implementing system sleep PM ops with generic
> pm_runtime_force_suspend/resume helpers. Runtime PM of the Exynos AudSS
> device is managed from clock core depending on the preparation status
> of the provided clocks.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../devicetree/bindings/clock/clk-exynos-audss.txt |  6 +++
>  drivers/clk/samsung/clk-exynos-audss.c             | 51 ++++++++++++++--------
>  2 files changed, 40 insertions(+), 17 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

