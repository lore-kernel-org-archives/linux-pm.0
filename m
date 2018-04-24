From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 5/6] devfreq: rk3399_dmc: do not print error when get
 supply and clk defer.
Date: Tue, 24 Apr 2018 12:55:05 +0900
Message-ID: <5ADEAA99.1040903@samsung.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104226epcas4p42e5d6a66c909325cedcdc1e24bd9007d@epcas4p4.samsung.com>
        <20180419104019.24406-6-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180419104019.24406-6-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> We just return -EPROBE_DEFER error code to caller and do not
> print error message when try to get center logic regulator
> and DMC clock defer.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/rk3399_dmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 44a379657cd5..5bfca028eaaf 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -308,12 +308,18 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  	data->vdd_center = devm_regulator_get(dev, "center");
>  	if (IS_ERR(data->vdd_center)) {
> +		if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
>  		dev_err(dev, "Cannot get the regulator \"center\"\n");
>  		return PTR_ERR(data->vdd_center);
>  	}
>  
>  	data->dmc_clk = devm_clk_get(dev, "dmc_clk");
>  	if (IS_ERR(data->dmc_clk)) {
> +		if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
>  		dev_err(dev, "Cannot get the clk dmc_clk\n");
>  		return PTR_ERR(data->dmc_clk);
>  	};
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
