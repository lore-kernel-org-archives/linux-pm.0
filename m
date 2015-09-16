From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 4/9] clk: qcom: create virtual child device for TSENS
Date: Wed, 16 Sep 2015 15:39:25 -0700
Message-ID: <20150916223925.GP23081@codeaurora.org>
References: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
 <1442384603-26053-5-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442384603-26053-5-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

On 09/16, Rajendra Nayak wrote:
> @@ -3520,7 +3522,26 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> -	return qcom_cc_probe(pdev, match->data);
> +	ret = qcom_cc_probe(pdev, match->data);
> +	if (ret)
> +		return ret;
> +
> +	tsens = platform_device_alloc("qcom-tsens", -1);
> +	if (!tsens) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	tsens->dev.parent = &pdev->dev;
> +	ret = platform_device_add(tsens);
> +	if (ret)
> +		goto err_add;

platform_device_register_data() instead of all these lines? We
should probably remove the device when this driver is removed
too.

> +	return 0;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
