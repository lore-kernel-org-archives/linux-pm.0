From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v1 04/10] thermal: tsens: Get rid of dead code
Date: Thu, 9 Aug 2018 12:23:55 -0700
Message-ID: <20180809192355.GL160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <0f945a83190de17df94a1bfcab48e6a86805cc9b.1533815718.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0f945a83190de17df94a1bfcab48e6a86805cc9b.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:36PM +0530, Amit Kucheria wrote:
> hw_id is dynamically allocated but not used anywhere. Get rid of dead
> code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
