From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / devfreq: Allocate memory using the right data type
Date: Wed, 16 Jul 2014 10:21:13 -0700
Message-ID: <53C6B489.3040001@codeaurora.org>
References: <1405480243-25915-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1405480243-25915-1-git-send-email-skannan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Suman Tatiraju <sumant@codeaurora.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 07/15/14 20:10, Saravana Kannan wrote:
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 65eed38..349e28ea 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -483,9 +483,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  						devfreq->profile->max_state *
>  						devfreq->profile->max_state,
>  						GFP_KERNEL);
> -	devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned int) *
> -						devfreq->profile->max_state,
> -						GFP_KERNEL);
> +	devfreq->time_in_state = devm_kzalloc(dev,
> +					sizeof(*(devfreq->time_in_state)) *
> +					devfreq->profile->max_state,
> +					GFP_KERNEL);

We could use devm_kcalloc() here too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
