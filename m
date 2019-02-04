From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/7] thermal: mediatek: fix register index error
Date: Mon, 4 Feb 2019 18:24:08 +0100
Message-ID: <6496b13f-57e4-af86-bb59-91a4705d91b0@gmail.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
 <1549006693-11659-2-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549006693-11659-2-git-send-email-michael.kao@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: michael.kao@mediatek.com, =Zhang Rui <rui.zhang@intel.com>, =Eduardo Valentin <edubezval@gmail.com>, =Daniel Lezcano <daniel.lezcano@linaro.org>, =Rob Herring <robh+dt@kernel.org>, =Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-pm@vger.kernel.org



On 01/02/2019 08:38, michael.kao@mediatek.com wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> The index of msr and adcpnp should match the sensor
> which belongs to the selected bank in the for loop.
> 

If I get that right, this fixes
b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")

So please add a fixes tag to the commit.

Thanks,
Matthias

> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 0691f26..f646436 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -431,7 +431,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  	u32 raw;
>  
>  	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -		raw = readl(mt->thermal_base + conf->msr[i]);
> +		raw = readl(mt->thermal_base +
> +			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
>  
>  		temp = raw_to_mcelsius(mt,
>  				       conf->bank_data[bank->id].sensors[i],
> @@ -568,7 +569,8 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  
>  	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
>  		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
> -		       mt->thermal_base + conf->adcpnp[i]);
> +		       mt->thermal_base +
> +		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
>  
>  	writel((1 << conf->bank_data[num].num_sensors) - 1,
>  	       mt->thermal_base + TEMP_MONCTL0);
> 
