From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
Date: Thu, 7 Feb 2019 17:25:44 +0100
Message-ID: <1d292090-414a-e500-f2e3-db3b0891812d@gmail.com>
References: <20190109055724.184692-1-pihsun@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190109055724.184692-1-pihsun@chromium.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Pi-Hsun Shih <pihsun@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 09/01/2019 06:57, Pi-Hsun Shih wrote:
> The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
> but the allocation only allocates sizeof(struct mtk_thermal) bytes,
> which cause out of bound access with the ->banks[] member. Change it to
> a fixed size array instead.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

For the next time, please don't forget to provide a fixes tag so that it can get
into stable trees automatically.

For the records, it fixes commit (v4.9):
b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")


> ---
>  drivers/thermal/mtk_thermal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 0691f260f6eabe..ea11edb3fcced6 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -159,6 +159,9 @@
>  #define MT7622_NUM_SENSORS_PER_ZONE	1
>  #define MT7622_TS1	0
>  
> +/* The maximum number of banks */
> +#define MAX_NUM_ZONES		8
> +
>  struct mtk_thermal;
>  
>  struct thermal_bank_cfg {
> @@ -178,7 +181,7 @@ struct mtk_thermal_data {
>  	const int *sensor_mux_values;
>  	const int *msr;
>  	const int *adcpnp;
> -	struct thermal_bank_cfg bank_data[];
> +	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>  };
>  
>  struct mtk_thermal {
> @@ -197,7 +200,7 @@ struct mtk_thermal {
>  	s32 vts[MT8173_NUM_SENSORS];
>  
>  	const struct mtk_thermal_data *conf;
> -	struct mtk_thermal_bank banks[];
> +	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>  };
>  
>  /* MT8173 thermal sensor data */
> 
