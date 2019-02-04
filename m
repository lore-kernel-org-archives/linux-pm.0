From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/7] thermal: mediatek: add calibration item
Date: Mon, 4 Feb 2019 18:31:41 +0100
Message-ID: <dcc04c1e-eb7d-024e-abc8-7b75504947c2@gmail.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
 <1549006693-11659-4-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549006693-11659-4-git-send-email-michael.kao@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: michael.kao@mediatek.com, =Zhang Rui <rui.zhang@intel.com>, =Eduardo Valentin <edubezval@gmail.com>, =Daniel Lezcano <daniel.lezcano@linaro.org>, =Rob Herring <robh+dt@kernel.org>, =Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-pm@vger.kernel.org



On 01/02/2019 08:38, michael.kao@mediatek.com wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add calibration item in thermal_data to support
> the project with different calibration coefficient.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 07f8ad7..45c6587 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -105,6 +105,9 @@
>  /* The number of sensing points per bank */
>  #define MT8173_NUM_SENSORS_PER_ZONE	4
>  
> +/* The calibration coefficient of sensor  */
> +#define MT8173_CALIBRATION	165
> +

Calibration value is the same for all SoCs (including mt8183), we can define it
once and use it in all mtk_thermal structs.

Regards,
Matthias


>  /*
>   * Layout of the fuses providing the calibration data
>   * These macros could be used for MT8173, MT2701, and MT2712.
> @@ -147,6 +150,9 @@ enum {
>  /* The number of sensing points per bank */
>  #define MT2701_NUM_SENSORS_PER_ZONE	3
>  
> +/* The calibration coefficient of sensor  */
> +#define MT2701_CALIBRATION	165
> +
>  /* MT2712 thermal sensors */
>  #define MT2712_TS1	0
>  #define MT2712_TS2	1
> @@ -162,12 +168,18 @@ enum {
>  /* The number of sensing points per bank */
>  #define MT2712_NUM_SENSORS_PER_ZONE	4
>  
> +/* The calibration coefficient of sensor  */
> +#define MT2712_CALIBRATION	165
> +
>  #define MT7622_TEMP_AUXADC_CHANNEL	11
>  #define MT7622_NUM_SENSORS		1
>  #define MT7622_NUM_ZONES		1
>  #define MT7622_NUM_SENSORS_PER_ZONE	1
>  #define MT7622_TS1	0
>  
> +/* The calibration coefficient of sensor  */
> +#define MT7622_CALIBRATION	165
> +
>  struct mtk_thermal;
>  
>  struct thermal_bank_cfg {
> @@ -188,6 +200,7 @@ struct mtk_thermal_data {
>  	const int *sensor_mux_values;
>  	const int *msr;
>  	const int *adcpnp;
> +	const int cali_val;
>  	struct thermal_bank_cfg bank_data[];
>  };
>  
> @@ -295,6 +308,7 @@ struct mtk_thermal {
>  	.num_banks = MT8173_NUM_ZONES,
>  	.num_sensors = MT8173_NUM_SENSORS,
>  	.vts_index = mt8173_vts_index,
> +	.cali_val = MT8173_CALIBRATION,
>  	.bank_data = {
>  		{
>  			.num_sensors = 2,
> @@ -330,6 +344,7 @@ struct mtk_thermal {
>  	.num_banks = 1,
>  	.num_sensors = MT2701_NUM_SENSORS,
>  	.vts_index = mt2701_vts_index,
> +	.cali_val = MT2701_CALIBRATION,
>  	.bank_data = {
>  		{
>  			.num_sensors = 3,
> @@ -356,6 +371,7 @@ struct mtk_thermal {
>  	.num_banks = 1,
>  	.num_sensors = MT2712_NUM_SENSORS,
>  	.vts_index = mt2712_vts_index,
> +	.cali_val = MT2712_CALIBRATION,
>  	.bank_data = {
>  		{
>  			.num_sensors = 4,
> @@ -376,6 +392,7 @@ struct mtk_thermal {
>  	.num_banks = MT7622_NUM_ZONES,
>  	.num_sensors = MT7622_NUM_SENSORS,
>  	.vts_index = mt7622_vts_index,
> +	.cali_val = MT7622_CALIBRATION,
>  	.bank_data = {
>  		{
>  			.num_sensors = 1,
> @@ -402,7 +419,7 @@ static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
>  	raw &= 0xfff;
>  
>  	tmp = 203450520 << 3;
> -	tmp /= 165 + mt->o_slope;
> +	tmp /= mt->conf->cali_val + mt->o_slope;
>  	tmp /= 10000 + mt->adc_ge;
>  	tmp *= raw - mt->vts[sensno] - 3350;
>  	tmp >>= 3;
> 
