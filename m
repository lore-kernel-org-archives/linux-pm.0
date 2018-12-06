From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: stm32: read factory settings properly
Date: Thu, 6 Dec 2018 10:43:30 +0100
Message-ID: <b6e93540-120d-9358-86df-d8b78f37b67a@linaro.org>
References: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pm@vger.kernel.org


Hi David,

On 06/12/2018 10:12, David HERNANDEZ SANCHEZ wrote:
> Call stm_thermal_read_factory_settings once
> internal peripheral is properly clocked.
> 
> To avoid wrong initialization of fmt0
> (stm_thermal_sensor struct) member add
> brackets properly.
> 
> Change-Id: I150d00fd50e382df04bfad12f0653b1ed6a1db1b

Please do a cleanup of the log:
  - line wrap at 72 characters
  - No Change-Id

State the problem and then tell what you do to fix it.

For example, it is unclear what happens if the factory settings are read
before the clock is set.

The bracket change is not directly related to the clock ordering and it
should go in another patch.

In addition each patch is fixing something, in this case it is the
initial import, so each fixes should contain the tag:

Fixes: 1d693155 (thermal: add stm32 thermal driver)


> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 47623da..bbd73c5 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -241,8 +241,8 @@ static int stm_thermal_read_factory_settings(struct stm_thermal_sensor *sensor)
>  		sensor->t0 = TS1_T0_VAL1;
>  
>  	/* Retrieve fmt0 and put it on Hz */
> -	sensor->fmt0 = ADJUST * readl_relaxed(sensor->base + DTS_T0VALR1_OFFSET)
> -					      & TS1_FMT0_MASK;
> +	sensor->fmt0 = ADJUST * (readl_relaxed(sensor->base +
> +				 DTS_T0VALR1_OFFSET) & TS1_FMT0_MASK);
>  
>  	/* Retrieve ramp coefficient */
>  	sensor->ramp_coeff = readl_relaxed(sensor->base + DTS_RAMPVALR_OFFSET) &
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
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
