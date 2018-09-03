From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 05/11] thermal: tsens: Get rid of dead code
Date: Mon, 3 Sep 2018 13:22:39 -0700
Message-ID: <20180903202239.GP3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <c50d9e71fc8cf466b9a7ff32edf7fb9370cca2dd.1535462942.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c50d9e71fc8cf466b9a7ff32edf7fb9370cca2dd.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> hw_id is dynamically allocated but not used anywhere. Get rid of dead
> code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Good catch.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 90bb431cf740..9a8e8f7b4ae1 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -80,11 +80,6 @@ static int tsens_register(struct tsens_device *tmdev)
>  {
>  	int i;
>  	struct thermal_zone_device *tzd;
> -	u32 *hw_id, n = tmdev->num_sensors;
> -
> -	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
> -	if (!hw_id)
> -		return -ENOMEM;
>  
>  	for (i = 0;  i < tmdev->num_sensors; i++) {
>  		tmdev->sensor[i].tmdev = tmdev;
> -- 
> 2.17.1
> 
