From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 01/17] PM / OPP: get/put regulators from OPP core
Date: Mon, 11 Jan 2016 15:21:18 -0800
Message-ID: <20160111232118.GG22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <8731ff871e0eedfb08b9428af8da21b25d1ad283.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35959 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760869AbcAKXVV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 18:21:21 -0500
Content-Disposition: inline
In-Reply-To: <8731ff871e0eedfb08b9428af8da21b25d1ad283.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
> index 690638ef36ee..c4a03ad34100 100644
> --- a/drivers/base/power/opp/opp.h
> +++ b/drivers/base/power/opp/opp.h
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/limits.h>
> +#include <linux/regulator/consumer.h>

This include doesn't seem necessary. Forward declare struct
regulator instead?

>  #include <linux/pm_opp.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> @@ -132,6 +133,8 @@ struct device_list_opp {
>   * @supported_hw: Array of version number to support.
>   * @supported_hw_count: Number of elements in supported_hw array.
>   * @prop_name: A name to postfix to many DT properties, while parsing them.
> + * @regulator: Supply Regulator

Is there a reason we capitalize regulator?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
