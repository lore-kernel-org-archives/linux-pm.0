From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] thermal: imx: Add support for reading OCOTP through
 nvmem
Date: Wed, 12 Jul 2017 14:36:31 +0800
Message-ID: <20170712063629.GD3172@dragon>
References: <cover.1499347157.git.leonard.crestez@nxp.com>
 <68b476b35b0c0cbce21da0e87338323bb77e9bc4.1499347157.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <68b476b35b0c0cbce21da0e87338323bb77e9bc4.1499347157.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 06, 2017 at 04:20:42PM +0300, Leonard Crestez wrote:
> On newer imx SOCs accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first. Add support for reading those same values through
> the nvmem API instead.
> 
> The older path is preserved for compatibility with older dts and because it
> works correctly on imx6qdl chips.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/thermal/imx_thermal.c | 131 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 101 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index fb648a4..ffbd579 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  #include <linux/types.h>
> +#include <linux/nvmem-consumer.h>
>  
>  #define REG_SET		0x4
>  #define REG_CLR		0x8
> @@ -92,7 +93,7 @@ struct imx_thermal_data {
>  	struct thermal_cooling_device *cdev;
>  	enum thermal_device_mode mode;
>  	struct regmap *tempmon;
> -	u32 c1, c2; /* See formula in imx_get_sensor_data() */
> +	u32 c1, c2; /* See formula in imx_init_calib() */
>  	int temp_passive;
>  	int temp_critical;
>  	int temp_max;
> @@ -175,7 +176,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>  
>  	n_meas = (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_SHIFT;
>  
> -	/* See imx_get_sensor_data() for formula derivation */
> +	/* See imx_init_calib() for formula derivation */
>  	*temp = data->c2 - n_meas * data->c1;
>  
>  	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
> @@ -344,29 +345,12 @@ static struct thermal_zone_device_ops imx_tz_ops = {
>  	.set_trip_temp = imx_set_trip_temp,
>  };
>  
> -static int imx_get_sensor_data(struct platform_device *pdev)
> +static int imx_init_calib(struct platform_device *pdev, u32 val)
>  {
>  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> -	struct regmap *map;
>  	int t1, n1;
> -	int ret;
> -	u32 val;
>  	u64 temp64;
>  
> -	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> -					      "fsl,tempmon-data");
> -	if (IS_ERR(map)) {
> -		ret = PTR_ERR(map);
> -		dev_err(&pdev->dev, "failed to get sensor regmap: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = regmap_read(map, OCOTP_ANA1, &val);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
> -		return ret;
> -	}
> -
>  	if (val == 0 || val == ~0) {
>  		dev_err(&pdev->dev, "invalid sensor calibration data\n");
>  		return -EINVAL;
> @@ -403,12 +387,12 @@ static int imx_get_sensor_data(struct platform_device *pdev)
>  	data->c1 = temp64;
>  	data->c2 = n1 * data->c1 + 1000 * t1;
>  
> -	/* use OTP for thermal grade */
> -	ret = regmap_read(map, OCOTP_MEM0, &val);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to read temp grade: %d\n", ret);
> -		return ret;
> -	}
> +	return 0;
> +}
> +
> +static void imx_init_temp_grade(struct platform_device *pdev, u32 val)
> +{
> +	struct imx_thermal_data *data = platform_get_drvdata(pdev);
>  
>  	/* The maximum die temp is specified by the Temperature Grade */
>  	switch ((val >> 6) & 0x3) {
> @@ -436,10 +420,87 @@ static int imx_get_sensor_data(struct platform_device *pdev)
>  	 */
>  	data->temp_critical = data->temp_max - (1000 * 5);
>  	data->temp_passive = data->temp_max - (1000 * 10);
> +}
> +
> +static int imx_init_from_tempmon_data(struct platform_device *pdev)
> +{
> +	struct regmap *map;
> +	int ret;
> +	u32 val;
> +
> +	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +					      "fsl,tempmon-data");
> +	if (IS_ERR(map)) {
> +		ret = PTR_ERR(map);
> +		dev_err(&pdev->dev, "failed to get sensor regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(map, OCOTP_ANA1, &val);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
> +		return ret;
> +	}
> +	ret = imx_init_calib(pdev, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(map, OCOTP_MEM0, &val);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
> +		return ret;
> +	}
> +	imx_init_temp_grade(pdev, val);
>  
>  	return 0;
>  }
>  
> +static int nvmem_cell_read_u32(struct device* dev, const char *cell_id, u32 *val)
> +{
> +	struct nvmem_cell *cell;
> +	void *buf;
> +	size_t len;
> +
> +	cell = nvmem_cell_get(dev, cell_id);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	if (IS_ERR(buf)) {
> +		nvmem_cell_put(cell);
> +		return PTR_ERR(buf);
> +	}
> +	if (len != sizeof(*val)) {
> +		kfree(buf);
> +		nvmem_cell_put(cell);
> +		return -EINVAL;
> +	}
> +	memcpy(val, buf, sizeof(*val));
> +
> +	kfree(buf);
> +	nvmem_cell_put(cell);
> +	return 0;
> +}

The function looks nothing IMX specific, and could be a nvmem core
function?

@Srinivas, thoughts?

Shawn

> +
> +static int imx_init_from_nvmem_cells(struct platform_device *pdev)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &val);
> +	if (ret)
> +		return ret;
> +	imx_init_calib(pdev, val);
> +
> +	ret = nvmem_cell_read_u32(&pdev->dev, "temp_grade", &val);
> +	if (ret)
> +		return ret;
> +	imx_init_temp_grade(pdev, val);
> +
> +	return 0;
> +}
> +
> +
>  static irqreturn_t imx_thermal_alarm_irq(int irq, void *dev)
>  {
>  	struct imx_thermal_data *data = dev;
> @@ -512,10 +573,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, data);
>  
> -	ret = imx_get_sensor_data(pdev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to get sensor data\n");
> -		return ret;
> +	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
> +		ret = imx_init_from_nvmem_cells(pdev);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to init from nvmem: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = imx_init_from_tempmon_data(pdev);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to init from from fsl,tempmon-data\n");
> +			return ret;
> +		}
>  	}
>  
>  	/* Make sure sensor is in known good state for measurements */
> -- 
> 2.7.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
