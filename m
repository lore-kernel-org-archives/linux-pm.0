From: "Nayak, Rajendra" <rnayak@codeaurora.org>
Subject: Re: [PATCH 1/1] thermal: qcom: remove declare local symbols as static
Date: Mon, 4 Jul 2016 15:06:30 +0530
Message-ID: <577A2E1E.4070900@codeaurora.org>
References: <1467421431-4581-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36678 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbcGDJhP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2016 05:37:15 -0400
In-Reply-To: <1467421431-4581-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


On 7/2/2016 6:33 AM, Eduardo Valentin wrote:
> Trivial: remove the following:
> drivers/thermal/qcom/tsens-8916.c:103:24: warning: symbol 'ops_8916' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-8996.c:76:24: warning: symbol 'ops_8996' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-8974.c:235:24: warning: symbol 'ops_8974' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-8960.c:279:24: warning: symbol 'ops_8960' was not declared. Should it be static?

Thanks for fixing this,
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>   drivers/thermal/qcom/tsens-8916.c | 2 +-
>   drivers/thermal/qcom/tsens-8960.c | 2 +-
>   drivers/thermal/qcom/tsens-8974.c | 2 +-
>   drivers/thermal/qcom/tsens-8996.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
> index beb3afa..fdf561b 100644
> --- a/drivers/thermal/qcom/tsens-8916.c
> +++ b/drivers/thermal/qcom/tsens-8916.c
> @@ -100,7 +100,7 @@ static int calibrate_8916(struct tsens_device *tmdev)
>   	return 0;
>   }
>
> -const struct tsens_ops ops_8916 = {
> +static const struct tsens_ops ops_8916 = {
>   	.init		= init_common,
>   	.calibrate	= calibrate_8916,
>   	.get_temp	= get_temp_common,
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 1d60916..0451277 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -276,7 +276,7 @@ static int get_temp_8960(struct tsens_device *tmdev, int id, int *temp)
>   	return -ETIMEDOUT;
>   }
>
> -const struct tsens_ops ops_8960 = {
> +static const struct tsens_ops ops_8960 = {
>   	.init		= init_8960,
>   	.calibrate	= calibrate_8960,
>   	.get_temp	= get_temp_8960,
> diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
> index da3ca4c..9baf77e 100644
> --- a/drivers/thermal/qcom/tsens-8974.c
> +++ b/drivers/thermal/qcom/tsens-8974.c
> @@ -232,7 +232,7 @@ static int calibrate_8974(struct tsens_device *tmdev)
>   	return 0;
>   }
>
> -const struct tsens_ops ops_8974 = {
> +static const struct tsens_ops ops_8974 = {
>   	.init		= init_common,
>   	.calibrate	= calibrate_8974,
>   	.get_temp	= get_temp_common,
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> index e2e1274..e1f7781 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-8996.c
> @@ -73,7 +73,7 @@ done:
>   	return 0;
>   }
>
> -const struct tsens_ops ops_8996 = {
> +static const struct tsens_ops ops_8996 = {
>   	.init		= init_common,
>   	.get_temp	= get_temp_8996,
>   };
>
