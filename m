From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 07/13] clk: qcom: gdsc: Add support for ON only state
Date: Wed, 22 Jul 2015 18:11:50 -0700
Message-ID: <55B03F56.8030503@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-8-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48918 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbGWBLx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 21:11:53 -0400
In-Reply-To: <1437549069-29655-8-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 07/22/2015 12:11 AM, Rajendra Nayak wrote:
> @@ -200,6 +224,12 @@ static int gdsc_init(struct gdsc *sc)
>   	if (ret)
>   		return ret;
>   
> +	/* Force gdsc ON if only ON state is supported */
> +	if (sc->pwrsts == PWRSTS_ON)
> +		ret = gdsc_toggle_logic(sc, true);
> +		if (ret)
> +			return ret;

This is missing braces. Please test :)

> +
>   	on = gdsc_is_enabled(sc);
>   	if (on < 0)
>   		return on;
>
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 87c4ace..0d1c4fb 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -17,6 +17,7 @@
>   #include <linux/clk.h>
>   #include <linux/pm_domain.h>
>   #include <linux/regmap.h>
> +#include <linux/reset-controller.h>

Do we need this include either? Just forward declare stuff. Same comment 
goes for the clk include.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

