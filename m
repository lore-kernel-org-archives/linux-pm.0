From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Tue, 11 Aug 2015 15:49:02 -0700
Message-ID: <20150811224902.GO2839@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
 <1436348838-22671-6-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436348838-22671-6-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

On 07/08, Rajendra Nayak wrote:
> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
> index eb6a4f9..2c80d03 100644
> --- a/drivers/clk/qcom/gcc-msm8960.c
> +++ b/drivers/clk/qcom/gcc-msm8960.c
> @@ -15,6 +15,7 @@
>  #include <linux/bitops.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -3520,7 +3521,8 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> -	return qcom_cc_probe(pdev, match->data);
> +	qcom_cc_probe(pdev, match->data);
> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);

We just lost the error code from qcom_cc_probe()...

Also, I don't like having a subnode in DT. Why can't we use the
same node as the GCC node and create a virtual child device here
for tsens? We can assign the same of_node that this platform
device has so that DT keeps working correctly.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
