From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH] thermal: qcom: tsens-8916: mark PM functions __maybe_unused
Date: Tue, 05 Jul 2016 08:07:24 +0530
Message-ID: <577B1D64.2020509@codeaurora.org>
References: <20160704131318.990672-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50597 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbcGEChb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2016 22:37:31 -0400
In-Reply-To: <20160704131318.990672-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


On 07/04/2016 06:42 PM, Arnd Bergmann wrote:
> The newly added tsens-8916 driver produces warnings when CONFIG_PM
> is disabled:
> 
> drivers/thermal/qcom/tsens.c:53:12: error: 'tsens_resume' defined but not used [-Werror=unused-function]
>  static int tsens_resume(struct device *dev)
>             ^~~~~~~~~~~~
> drivers/thermal/qcom/tsens.c:43:12: error: 'tsens_suspend' defined but not used [-Werror=unused-function]
>  static int tsens_suspend(struct device *dev)
>             ^~~~~~~~~~~~~
> 
> This marks both functions __maybe_unused to let the compiler
> know that they might be used in other configurations, without
> adding ugly #ifdef logic.

Thanks Arnd,
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/thermal/qcom/tsens.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 446f70b5dbb2..e4fca3350d26 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -40,7 +40,7 @@ static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
>  	return -ENOTSUPP;
>  }
>  
> -static int tsens_suspend(struct device *dev)
> +static int  __maybe_unused tsens_suspend(struct device *dev)
>  {
>  	struct tsens_device *tmdev = dev_get_drvdata(dev);
>  
> @@ -50,7 +50,7 @@ static int tsens_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tsens_resume(struct device *dev)
> +static int __maybe_unused  tsens_resume(struct device *dev)
>  {
>  	struct tsens_device *tmdev = dev_get_drvdata(dev);
>  
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
