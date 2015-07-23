From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 02/13] clk: qcom: gdsc: Prepare common clk probe to
 register gdscs
Date: Wed, 22 Jul 2015 17:27:58 -0700
Message-ID: <55B0350E.5090904@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-3-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1437549069-29655-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 07/22/2015 12:10 AM, Rajendra Nayak wrote:
> @@ -120,8 +121,20 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>   
>   	ret = reset_controller_register(&reset->rcdev);
>   	if (ret)
> -		of_clk_del_provider(dev->of_node);
> +		goto err_reset;
>   
> +	if (desc->gdscs && desc->num_gdscs) {
> +		ret = gdsc_register(dev, desc->gdscs, desc->num_gdscs, regmap);
> +		if (ret)
> +			goto err_pd;
> +	}
> +
> +	return 0;
> +err_pd:
> +	dev_err(dev, "Failed to register power domains\n");

Let's just stay silent like we've been doing before.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
