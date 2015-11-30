From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: mt8173: add
 CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag
Date: Mon, 30 Nov 2015 10:50:28 +0530
Message-ID: <20151130052028.GI3373@ubuntu>
References: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34256 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbK3FUh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 00:20:37 -0500
Received: by padhx2 with SMTP id hx2so172634769pad.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2015 21:20:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 29-11-15, 16:31, Pi-Cheng Chen wrote:
> Add CPUFREQ_HAVE_GOVERNOR_PER_POLICY to have individual set of tunables
> for each cluster of MT8173.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 83001dc..c438109 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -469,7 +469,8 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>  }
>  
>  static struct cpufreq_driver mt8173_cpufreq_driver = {
> -	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = mtk_cpufreq_set_target,
>  	.get = cpufreq_generic_get,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
