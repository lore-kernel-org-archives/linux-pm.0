From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 2/4] clk: samsung: Add support for runtime PM
Date: Tue, 8 Aug 2017 17:44:04 +0200
Message-ID: <20170808154404.GB2646@kozik-book>
References: <1501839294-478-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170804093515eucas1p1cc2273ba02d86767c5b2533430577698@eucas1p1.samsung.com>
 <1501839294-478-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501839294-478-3-git-send-email-m.szyprowski@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 04, 2017 at 11:34:52AM +0200, Marek Szyprowski wrote:
> This patch adds struct device pointer to samsung_clk_provider and forwarding it
> to clk_register_* functions, so drivers can register clocks, which use runtime
> pm feature.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/clk/samsung/clk-pll.c |  2 +-
>  drivers/clk/samsung/clk.c     | 12 ++++++------
>  drivers/clk/samsung/clk.h     |  1 +
>  3 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

