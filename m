From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 2/2] tsens: Get rid of unused fields in structure
Date: Mon, 4 Jun 2018 09:56:53 +0530
Message-ID: <7ccc0acb-b2e0-cb81-31f5-223d78e62966@codeaurora.org>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
 <40aa5b9760b09be0970dbe82997db71756927eb0.1527937396.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40aa5b9760b09be0970dbe82997db71756927eb0.1527937396.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-arm-msm@vger.kernel.org
Cc: bjorn.andersson@linaro.org, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 06/02/2018 04:41 PM, Amit Kucheria wrote:
> status_field and trdy are unused in any of the tsens drivers. Remove them.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Rajendra Nayak <rnayak@codeaurora.org>

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
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
