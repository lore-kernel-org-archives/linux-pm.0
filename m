From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v1 1/3] thermal: tsens: Rename variable
Date: Wed, 25 Jul 2018 15:44:47 -0700
Message-ID: <20180725224447.GR129942@google.com>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
 <45062f2bcfd0f20e604f663e3627dcedf01f0be5.1531898088.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45062f2bcfd0f20e604f663e3627dcedf01f0be5.1531898088.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2018 at 12:55:01PM +0530, Amit Kucheria wrote:
> We're actually reading the temperature from the status register. Fix the
> variable name to reflect that.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c |  6 +++---
>  drivers/thermal/qcom/tsens-v2.c     | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index c22dc18..25e7f24 100644
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
> index f40150f..908e3dc 100644
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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
