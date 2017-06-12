From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: Allow down_threshold to take
 values from 1 to 10
Date: Mon, 12 Jun 2017 09:10:35 +0530
Message-ID: <20170612034035.GB5297@vireshk-i7>
References: <1497169719-13613-1-git-send-email-twilczynski@naver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32776 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbdFLDki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jun 2017 23:40:38 -0400
Received: by mail-pg0-f46.google.com with SMTP id f185so40940472pgc.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2017 20:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1497169719-13613-1-git-send-email-twilczynski@naver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz =?utf-8?Q?Wilczy=C5=84ski?= <twilczynski@naver.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 11-06-17, 17:28, Tomasz Wilczyński wrote:
> Commit 27ed3cd2ebf4cd78b198be9758c538cdede36d8a ("cpufreq: conservative:
> Fix the logic in frequency decrease checking") removed the 10 point
> substraction when comparing the load against down_threshold but did not
> remove the related limit for the down_threshold value. As a result,
> down_threshold lower than 11 is not allowed even though values from
> 1 to 10 do work correctly too. The comment ("cannot be lower than 11
> otherwise freq will not fall") is also not true after removing the
> substraction.
> 
> For this reason, allow down_threshold to take any value from 1 to 99
> and fix the related comment.
> 
> Signed-off-by: Tomasz Wilczyński <twilczynski@naver.com>

Please add Fixes tag and relevant kernel release for stable tag.

> ---
>  drivers/cpufreq/cpufreq_conservative.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 992f7c2..88220ff 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -185,8 +185,8 @@ static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
>  	int ret;
>  	ret = sscanf(buf, "%u", &input);
>  
> -	/* cannot be lower than 11 otherwise freq will not fall */
> -	if (ret != 1 || input < 11 || input > 100 ||
> +	/* cannot be lower than 1 otherwise freq will not fall */
> +	if (ret != 1 || input < 1 || input > 100 ||
>  			input >= dbs_data->up_threshold)
>  		return -EINVAL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
