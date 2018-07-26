From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/3] thermal: tsens: Rename variable
Date: Thu, 26 Jul 2018 09:16:20 -0700
Message-ID: <20180726161620.GA5450@tuxbook-pro>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
 <5160b58d1d14b87b84ea49adc804afbefb792c34.1532600791.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5160b58d1d14b87b84ea49adc804afbefb792c34.1532600791.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 26 Jul 03:33 PDT 2018, Amit Kucheria wrote:

> We're actually reading the temperature from the status register. Fix the
> variable name to reflect that.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-common.c |  6 +++---
>  drivers/thermal/qcom/tsens-v2.c     | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index c22dc18c7c65..25e7f247b027 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -104,11 +104,11 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> -	unsigned int sensor_addr;
> +	unsigned int status_reg;
>  	int last_temp = 0, ret;
>  
> -	sensor_addr = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	last_temp = code & SN_ST_TEMP_MASK;
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index f40150fd7eae..908e3dcb2d5c 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -16,11 +16,11 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> -	unsigned int sensor_addr;
> +	unsigned int status_reg;
>  	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>  
> -	sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	last_temp = code & LAST_TEMP_MASK;
> @@ -28,7 +28,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  		goto done;
>  
>  	/* Try a second time */
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	if (code & STATUS_VALID_BIT) {
> @@ -39,7 +39,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  	}
>  
>  	/* Try a third/last time */
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	if (code & STATUS_VALID_BIT) {
> -- 
> 2.17.GIT
> 
