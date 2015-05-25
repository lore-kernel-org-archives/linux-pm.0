From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq:gx-suspmod - Fix two typos in two comments.
Date: Mon, 25 May 2015 12:51:14 +0530
Message-ID: <20150525072114.GB9992@linux>
References: <1432357609-4102-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34865 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbEYHVR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 03:21:17 -0400
Received: by pacwv17 with SMTP id wv17so65599112pac.2
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 00:21:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432357609-4102-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 23-05-15, 10:36, Shailendra Verma wrote:
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  drivers/cpufreq/gx-suspmod.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
> index 1d723dc..3488c9c 100644
> --- a/drivers/cpufreq/gx-suspmod.c
> +++ b/drivers/cpufreq/gx-suspmod.c
> @@ -144,7 +144,7 @@ module_param(max_duration, int, 0444);
>  
>  
>  /**
> - * we can detect a core multipiler from dir0_lsb
> + * we can detect a core multiplier from dir0_lsb
>   * from GX1 datasheet p.56,
>   *	MULT[3:0]:
>   *	0000 = SYSCLK multiplied by 4 (test only)
> @@ -346,7 +346,7 @@ static int cpufreq_gx_verify(struct cpufreq_policy *policy)
>  
>  	/* it needs to be assured that at least one supported frequency is
>  	 * within policy->min and policy->max. If it is not, policy->max
> -	 * needs to be increased until one freuqency is supported.
> +	 * needs to be increased until one frequency is supported.
>  	 * policy->min may not be decreased, though. This way we guarantee a
>  	 * specific processing capacity.
>  	 */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
