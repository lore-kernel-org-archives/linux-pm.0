From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
Date: Thu, 6 Dec 2018 14:30:04 +0100
Message-ID: <ecfc241e-7453-36dd-70ba-34b0f2e69dc8@linaro.org>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pm@vger.kernel.org

On 06/12/2018 14:23, David HERNANDEZ SANCHEZ wrote:
> Adding brackets allows to multiply the register value,
> masked by TS1_RAMP_COEFF_MASK, by an ADJUST value
> properly and not to multiply ADJUST by register value and
> then mask the whole.
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> Fixes: 1d693155 ("thermal: add stm32 thermal driver")

Usually 'Fixes' comes first in the list.

Other than that:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index daa1257..bbd73c5 100644
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
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
