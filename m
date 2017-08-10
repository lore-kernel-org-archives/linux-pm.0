From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v8 4/5] clk: samsung: exynos-audss: Use local variable
 for controller's device
Date: Thu, 10 Aug 2017 15:27:04 +0900
Message-ID: <598BFCB8.5070401@samsung.com>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
        <CGME20170809103514eucas1p11fb5d1af243e882a5d51a25956d24a19@eucas1p1.samsung.com>
        <1502274907-11931-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1502274907-11931-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2017년 08월 09일 19:35, Marek Szyprowski wrote:
> Store pointer to the controller's device in local variable to avoid
> extracting it from platform device in each call. This will also simplify
> code in the future, when runtime PM support is added.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos-audss.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
> index 1fab56f396d4..6be52fb46ff3 100644
> --- a/drivers/clk/samsung/clk-exynos-audss.c
> +++ b/drivers/clk/samsung/clk-exynos-audss.c
> @@ -135,6 +135,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  	const struct exynos_audss_clk_drvdata *variant;
>  	struct clk_hw **clk_table;
>  	struct resource *res;
> +	struct device *dev = &pdev->dev;
>  	int i, ret = 0;
>  
>  	variant = of_device_get_match_data(&pdev->dev);
> @@ -142,15 +143,15 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	reg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(reg_base)) {
> -		dev_err(&pdev->dev, "failed to map audss registers\n");
> +		dev_err(dev, "failed to map audss registers\n");
>  		return PTR_ERR(reg_base);
>  	}
>  
>  	epll = ERR_PTR(-ENODEV);
>  
> -	clk_data = devm_kzalloc(&pdev->dev,
> +	clk_data = devm_kzalloc(dev,
>  				sizeof(*clk_data) +
>  				sizeof(*clk_data->hws) * EXYNOS_AUDSS_MAX_CLKS,
>  				GFP_KERNEL);
> @@ -160,8 +161,8 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  	clk_data->num = variant->num_clks;
>  	clk_table = clk_data->hws;
>  
> -	pll_ref = devm_clk_get(&pdev->dev, "pll_ref");
> -	pll_in = devm_clk_get(&pdev->dev, "pll_in");
> +	pll_ref = devm_clk_get(dev, "pll_ref");
> +	pll_in = devm_clk_get(dev, "pll_in");
>  	if (!IS_ERR(pll_ref))
>  		mout_audss_p[0] = __clk_get_name(pll_ref);
>  	if (!IS_ERR(pll_in)) {
> @@ -172,7 +173,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  
>  			ret = clk_prepare_enable(epll);
>  			if (ret) {
> -				dev_err(&pdev->dev,
> +				dev_err(dev,
>  					"failed to prepare the epll clock\n");
>  				return ret;
>  			}
> @@ -183,8 +184,8 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  				CLK_SET_RATE_NO_REPARENT,
>  				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
>  
> -	cdclk = devm_clk_get(&pdev->dev, "cdclk");
> -	sclk_audio = devm_clk_get(&pdev->dev, "sclk_audio");
> +	cdclk = devm_clk_get(dev, "cdclk");
> +	sclk_audio = devm_clk_get(dev, "sclk_audio");
>  	if (!IS_ERR(cdclk))
>  		mout_i2s_p[1] = __clk_get_name(cdclk);
>  	if (!IS_ERR(sclk_audio))
> @@ -222,7 +223,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  				 "sclk_pcm", CLK_SET_RATE_PARENT,
>  				reg_base + ASS_CLK_GATE, 4, 0, &lock);
>  
> -	sclk_pcm_in = devm_clk_get(&pdev->dev, "sclk_pcm_in");
> +	sclk_pcm_in = devm_clk_get(dev, "sclk_pcm_in");
>  	if (!IS_ERR(sclk_pcm_in))
>  		sclk_pcm_p = __clk_get_name(sclk_pcm_in);
>  	clk_table[EXYNOS_SCLK_PCM] = clk_hw_register_gate(NULL, "sclk_pcm",
> @@ -237,16 +238,16 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < clk_data->num; i++) {
>  		if (IS_ERR(clk_table[i])) {
> -			dev_err(&pdev->dev, "failed to register clock %d\n", i);
> +			dev_err(dev, "failed to register clock %d\n", i);
>  			ret = PTR_ERR(clk_table[i]);
>  			goto unregister;
>  		}
>  	}
>  
> -	ret = of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_onecell_get,
> +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
>  				     clk_data);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to add clock provider\n");
> +		dev_err(dev, "failed to add clock provider\n");
>  		goto unregister;
>  	}
>  
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
