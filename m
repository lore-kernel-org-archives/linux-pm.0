From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] tsens: Get rid of unused fields in structure
Date: Mon, 4 Jun 2018 08:05:49 -0700
Message-ID: <20180604150549.GD510@tuxbook-pro>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
 <40aa5b9760b09be0970dbe82997db71756927eb0.1527937396.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40aa5b9760b09be0970dbe82997db71756927eb0.1527937396.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat 02 Jun 04:11 PDT 2018, Amit Kucheria wrote:

> status_field and trdy are unused in any of the tsens drivers. Remove them.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index f15660d..77ed8dc 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -77,9 +77,7 @@ struct tsens_device {
>  	struct device			*dev;
>  	u32				num_sensors;
>  	struct regmap			*map;
> -	struct regmap_field		*status_field;
>  	struct tsens_context		ctx;
> -	bool				trdy;
>  	const struct tsens_ops		*ops;
>  	struct tsens_sensor		sensor[0];
>  };
> -- 
> 2.7.4
> 
