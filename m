From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 10/12] thermal: qoriq: Do not report invalid
 temperature reading
Date: Tue, 16 Apr 2019 19:11:00 +0200
Message-ID: <6c07ec86-297f-01e0-f150-1b03c0a27c62@linaro.org>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-11-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413082748.29990-11-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Before returning measured temperature data to upper layer we need to
> make sure that the reading was marked as "valid" to avoid reporting
> bogus data.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/thermal/qoriq_thermal.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index abbbfe88422e..5c459a9d0db3 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -37,6 +37,7 @@
>  #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
>  					    * Site Register
>  					    */
> +#define TRITSR_V	BIT(31)
>  #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
>  					   * Control Register
>  					   */
> @@ -48,10 +49,25 @@ static int tmu_get_temp(int id, void *p, int *temp)
>  {
>  	struct qoriq_tmu_data *qdata = p;
>  	u32 val;
> +	/*
> +	 * REGS_TRITSR(id) has the following layout:
> +	 *
> +	 * 31  ... 7 6 5 4 3 2 1 0
> +	 *  V          TEMP
> +	 *
> +	 * Where V bit signifies if the measurement is ready and is
> +	 * within sensor range. TEMP is an 8 bit value representing
> +	 * temperature in C.
> +	 */
> +	if (regmap_read_poll_timeout(qdata->regmap,
> +				     REGS_TRITSR(id),
> +				     val,
> +				     val & TRITSR_V,
> +				     USEC_PER_MSEC,
> +				     10 * USEC_PER_MSEC))
> +		return -ENODATA;
>  
> -	regmap_read(qdata->regmap, REGS_TRITSR(id), &val);
>  	*temp = (val & 0xff) * 1000;
> -
>  	return 0;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
