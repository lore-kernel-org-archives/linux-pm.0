From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 06/11] thermal: tsens: Rename map field in order to
 add a second address map
Date: Mon, 3 Sep 2018 13:23:17 -0700
Message-ID: <20180903202317.GQ3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <9dd785eb1292e80e3ac4b52e1e4da431774c2211.1535462942.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9dd785eb1292e80e3ac4b52e1e4da431774c2211.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> The TSENS driver currently only uses a limited set of registers from the TM
> address space. So it was ok to map just that set of registers and call it
> "map".
> 
> We'd now like to map a second set: SROT registers to introduce new
> functionality. Rename the "map" field to a more appropriate "tm_map".
> 
> The 8960 doesn't have a clear split between TM and SROT registers. To avoid
> complicating the data structure, it will switchover to using tm_map for its
> maps.
> 
> There is no functional change with this patch.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-8960.c   | 30 ++++++++++++++---------------
>  drivers/thermal/qcom/tsens-common.c | 17 ++++++++--------
>  drivers/thermal/qcom/tsens-v2.c     |  6 +++---
>  drivers/thermal/qcom/tsens.h        |  2 +-
>  4 files changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 4af76de7dc2e..0f0adb302a7b 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -60,7 +60,7 @@ static int suspend_8960(struct tsens_device *tmdev)
>  {
>  	int ret;
>  	unsigned int mask;
> -	struct regmap *map = tmdev->map;
> +	struct regmap *map = tmdev->tm_map;
>  
>  	ret = regmap_read(map, THRESHOLD_ADDR, &tmdev->ctx.threshold);
>  	if (ret)
> @@ -85,7 +85,7 @@ static int suspend_8960(struct tsens_device *tmdev)
>  static int resume_8960(struct tsens_device *tmdev)
>  {
>  	int ret;
> -	struct regmap *map = tmdev->map;
> +	struct regmap *map = tmdev->tm_map;
>  
>  	ret = regmap_update_bits(map, CNTL_ADDR, SW_RST, SW_RST);
>  	if (ret)
> @@ -117,12 +117,12 @@ static int enable_8960(struct tsens_device *tmdev, int id)
>  	int ret;
>  	u32 reg, mask;
>  
> -	ret = regmap_read(tmdev->map, CNTL_ADDR, &reg);
> +	ret = regmap_read(tmdev->tm_map, CNTL_ADDR, &reg);
>  	if (ret)
>  		return ret;
>  
>  	mask = BIT(id + SENSOR0_SHIFT);
> -	ret = regmap_write(tmdev->map, CNTL_ADDR, reg | SW_RST);
> +	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg | SW_RST);
>  	if (ret)
>  		return ret;
>  
> @@ -131,7 +131,7 @@ static int enable_8960(struct tsens_device *tmdev, int id)
>  	else
>  		reg |= mask | SLP_CLK_ENA_8660 | EN;
>  
> -	ret = regmap_write(tmdev->map, CNTL_ADDR, reg);
> +	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg);
>  	if (ret)
>  		return ret;
>  
> @@ -148,7 +148,7 @@ static void disable_8960(struct tsens_device *tmdev)
>  	mask <<= SENSOR0_SHIFT;
>  	mask |= EN;
>  
> -	ret = regmap_read(tmdev->map, CNTL_ADDR, &reg_cntl);
> +	ret = regmap_read(tmdev->tm_map, CNTL_ADDR, &reg_cntl);
>  	if (ret)
>  		return;
>  
> @@ -159,7 +159,7 @@ static void disable_8960(struct tsens_device *tmdev)
>  	else
>  		reg_cntl &= ~SLP_CLK_ENA_8660;
>  
> -	regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
> +	regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
>  }
>  
>  static int init_8960(struct tsens_device *tmdev)
> @@ -167,8 +167,8 @@ static int init_8960(struct tsens_device *tmdev)
>  	int ret, i;
>  	u32 reg_cntl;
>  
> -	tmdev->map = dev_get_regmap(tmdev->dev, NULL);
> -	if (!tmdev->map)
> +	tmdev->tm_map = dev_get_regmap(tmdev->dev, NULL);
> +	if (!tmdev->tm_map)
>  		return -ENODEV;
>  
>  	/*
> @@ -184,14 +184,14 @@ static int init_8960(struct tsens_device *tmdev)
>  	}
>  
>  	reg_cntl = SW_RST;
> -	ret = regmap_update_bits(tmdev->map, CNTL_ADDR, SW_RST, reg_cntl);
> +	ret = regmap_update_bits(tmdev->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
>  	if (ret)
>  		return ret;
>  
>  	if (tmdev->num_sensors > 1) {
>  		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
>  		reg_cntl &= ~SW_RST;
> -		ret = regmap_update_bits(tmdev->map, CONFIG_ADDR,
> +		ret = regmap_update_bits(tmdev->tm_map, CONFIG_ADDR,
>  					 CONFIG_MASK, CONFIG);
>  	} else {
>  		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
> @@ -200,12 +200,12 @@ static int init_8960(struct tsens_device *tmdev)
>  	}
>  
>  	reg_cntl |= GENMASK(tmdev->num_sensors - 1, 0) << SENSOR0_SHIFT;
> -	ret = regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
> +	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
>  	if (ret)
>  		return ret;
>  
>  	reg_cntl |= EN;
> -	ret = regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
> +	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
>  	if (ret)
>  		return ret;
>  
> @@ -252,12 +252,12 @@ static int get_temp_8960(struct tsens_device *tmdev, int id, int *temp)
>  
>  	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
>  	do {
> -		ret = regmap_read(tmdev->map, INT_STATUS_ADDR, &trdy);
> +		ret = regmap_read(tmdev->tm_map, INT_STATUS_ADDR, &trdy);
>  		if (ret)
>  			return ret;
>  		if (!(trdy & TRDY_MASK))
>  			continue;
> -		ret = regmap_read(tmdev->map, s->status, &code);
> +		ret = regmap_read(tmdev->tm_map, s->status, &code);
>  		if (ret)
>  			return ret;
>  		*temp = code_to_mdegC(code, s);
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 303e3fdaca98..0585084630b3 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -99,8 +99,7 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  	int last_temp = 0, ret;
>  
>  	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
> -	ret = regmap_read(tmdev->map, status_reg, &code);
> -
> +	ret = regmap_read(tmdev->tm_map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	last_temp = code & SN_ST_TEMP_MASK;
> @@ -118,7 +117,7 @@ static const struct regmap_config tsens_config = {
>  
>  int __init init_common(struct tsens_device *tmdev)
>  {
> -	void __iomem *base;
> +	void __iomem *tm_base;
>  	struct resource *res;
>  	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
> @@ -134,13 +133,13 @@ int __init init_common(struct tsens_device *tmdev)
>  	}
>  
>  	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&op->dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	tm_base = devm_ioremap_resource(&op->dev, res);
> +	if (IS_ERR(tm_base))
> +		return PTR_ERR(tm_base);
>  
> -	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
> -	if (IS_ERR(tmdev->map))
> -		return PTR_ERR(tmdev->map);
> +	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base, &tsens_config);
> +	if (IS_ERR(tmdev->tm_map))
> +		return PTR_ERR(tmdev->tm_map);
>  
>  	return 0;
>  }
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 44da02f594ac..1bdef92e4521 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -21,7 +21,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  	int ret;
>  
>  	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> -	ret = regmap_read(tmdev->map, status_reg, &code);
> +	ret = regmap_read(tmdev->tm_map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	last_temp = code & LAST_TEMP_MASK;
> @@ -29,7 +29,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  		goto done;
>  
>  	/* Try a second time */
> -	ret = regmap_read(tmdev->map, status_reg, &code);
> +	ret = regmap_read(tmdev->tm_map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	if (code & STATUS_VALID_BIT) {
> @@ -40,7 +40,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  	}
>  
>  	/* Try a third/last time */
> -	ret = regmap_read(tmdev->map, status_reg, &code);
> +	ret = regmap_read(tmdev->tm_map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	if (code & STATUS_VALID_BIT) {
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 8207610f326a..58e98c4d3a8b 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -69,7 +69,7 @@ struct tsens_context {
>  struct tsens_device {
>  	struct device			*dev;
>  	u32				num_sensors;
> -	struct regmap			*map;
> +	struct regmap			*tm_map;
>  	u32				tm_offset;
>  	struct tsens_context		ctx;
>  	const struct tsens_ops		*ops;
> -- 
> 2.17.1
> 
