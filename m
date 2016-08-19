From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] thermal: rockchip: enhance the tsadc's bandgap
 feature for rk3399
Date: Fri, 19 Aug 2016 21:09:24 +0800
Message-ID: <1471612164.2691.73.camel@intel.com>
References: <1469628643-29661-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26113 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754047AbcHSNJb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 09:09:31 -0400
In-Reply-To: <1469628643-29661-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: smbarber@chromium.org, dianders@chromium.org, briannorris@chromium.org, Rocky Hao <rocky.hao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

On 三, 2016-07-27 at 22:10 +0800, Caesar Wang wrote:
> From: Rocky Hao <rocky.hao@rock-chips.com>
> 
> Due to the voltage ripple, the sensing data of the tsadc is not
> accurate.
> And in this patch, the bandgap feature is enhanced to remove the
> voltage
> ripple, and then the tsadc can sense the temperature more precisely.
> 
> Obsolete codes are removed as well.
> 
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-pm@vger.kernel.org

Both patches applied and queued for 4.9.

thanks,
rui
> ---
> 
>  drivers/thermal/rockchip_thermal.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c
> index db5ecc5..a90423d 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -222,10 +222,10 @@ struct rockchip_thermal_data {
>  #define GRF_TSADC_TESTBIT_L			0x0e648
>  #define GRF_TSADC_TESTBIT_H			0x0e64c
>  
> -#define GRF_TSADC_TSEN_PD_ON			(0x30003 << 0)
> -#define GRF_TSADC_TSEN_PD_OFF			(0x30000 << 0)
>  #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
>  #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
> +#define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
> +#define GRF_TSADC_VCM_EN_H			(0x10001 << 7)
>  
>  /**
>   * struct tsadc_table - code to temperature conversion table
> @@ -567,9 +567,10 @@ static void rk_tsadcv3_initialize(struct regmap
> *grf, void __iomem *regs,
>  			       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
>  
>  	} else {
> -		regmap_write(grf, GRF_TSADC_TESTBIT_L,
> GRF_TSADC_TSEN_PD_ON);
> -		mdelay(10);
> -		regmap_write(grf, GRF_TSADC_TESTBIT_L,
> GRF_TSADC_TSEN_PD_OFF);
> +		/* Enable the voltage common mode feature */
> +		regmap_write(grf, GRF_TSADC_TESTBIT_L,
> GRF_TSADC_VCM_EN_L);
> +		regmap_write(grf, GRF_TSADC_TESTBIT_H,
> GRF_TSADC_VCM_EN_H);
> +
>  		usleep_range(15, 100); /* The spec note says at
> least 15 us */
>  		regmap_write(grf, GRF_SARADC_TESTBIT,
> GRF_SARADC_TESTBIT_ON);
>  		regmap_write(grf, GRF_TSADC_TESTBIT_H,
> GRF_TSADC_TESTBIT_H_ON);
