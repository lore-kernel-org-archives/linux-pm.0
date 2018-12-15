From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Date: Fri, 14 Dec 2018 17:47:34 -0800
Message-ID: <20181215014732.GA24528@localhost.localdomain>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
 <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pm@vger.kernel.org


On Thu, Dec 06, 2018 at 01:23:32PM +0000, David HERNANDEZ SANCHEZ wrote:
> Calling stm_thermal_read_factory_settings before clocking
> internal peripheral causes bad register values and makes
> temperature computation wrong.
> 
> Calling stm_thermal_read_factory_settings inside
> stm_thermal_prepare fixes this problem as internal
> peripheral is well clocked at this stage.
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> Fixes: 1d693155 ("thermal: add stm32 thermal driver")

Please append patch version in the title next time to help tracking it.

> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 47623da..daa1257 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -532,6 +532,10 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  	if (ret)
>  		return ret;
>  
> +	ret = stm_thermal_read_factory_settings(sensor);
> +	if (ret)
> +		goto thermal_unprepare;
> +
>  	ret = stm_thermal_calibration(sensor);
>  	if (ret)
>  		goto thermal_unprepare;
> @@ -636,10 +640,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  	/* Populate sensor */
>  	sensor->base = base;
>  
> -	ret = stm_thermal_read_factory_settings(sensor);
> -	if (ret)
> -		return ret;
> -
>  	sensor->clk = devm_clk_get(&pdev->dev, "pclk");
>  	if (IS_ERR(sensor->clk)) {
>  		dev_err(&pdev->dev, "%s: failed to fetch PCLK clock\n",
> -- 
> 2.7.4
