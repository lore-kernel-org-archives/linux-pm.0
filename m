From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling:  pr_err() strings should end with
 newlines
Date: Thu, 26 Oct 2017 09:14:29 +0530
Message-ID: <20171026034429.GB4240@vireshk-i7>
References: <4a3646da88934a58525fc00141f634805ee6eb99.1508829220.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:56362 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdJZDod (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 23:44:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id b85so1517279pfj.13
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2017 20:44:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4a3646da88934a58525fc00141f634805ee6eb99.1508829220.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 24-10-17, 13:20, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 908a801..dc63aba 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -696,7 +696,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
>  	bool first;
>  
>  	if (IS_ERR_OR_NULL(policy)) {
> -		pr_err("%s: cpufreq policy isn't valid: %p", __func__, policy);
> +		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
>  		return ERR_PTR(-EINVAL);
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
