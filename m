From: Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH] thermal: cpu_cooling:  pr_err() strings should end with
 newlines
Date: Wed, 25 Oct 2017 17:20:15 +0200
Message-ID: <20171025152015.s34bcrgg7a3okouv@tesla>
References: <4a3646da88934a58525fc00141f634805ee6eb99.1508829220.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:55612 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbdJYPUT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 11:20:19 -0400
Content-Disposition: inline
In-Reply-To: <4a3646da88934a58525fc00141f634805ee6eb99.1508829220.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: amit.kachhap@gmail.com, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Oct 24, 2017 at 01:20:39PM +0530, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

FWIW,

Acked-by: Javi Merino <javi.merino@kernel.org>

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
>  
> -- 
> 1.9.1
> 
