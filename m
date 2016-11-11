From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: make symbol
 brcm_avs_cpufreq_attr static
Date: Fri, 11 Nov 2016 08:49:41 +0530
Message-ID: <20161111031941.GF11670@vireshk-i7>
References: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35205 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965385AbcKKDTp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 22:19:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so3618812pfk.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 19:19:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10-11-16, 15:19, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c:982:18: warning:
>  symbol 'brcm_avs_cpufreq_attr' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index b761d54..4fda623 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -979,7 +979,7 @@ cpufreq_freq_attr_ro(brcm_avs_pmap);
>  cpufreq_freq_attr_ro(brcm_avs_voltage);
>  cpufreq_freq_attr_ro(brcm_avs_frequency);
>  
> -struct freq_attr *brcm_avs_cpufreq_attr[] = {
> +static struct freq_attr *brcm_avs_cpufreq_attr[] = {
>  	&cpufreq_freq_attr_scaling_available_freqs,
>  	&brcm_avs_pstate,
>  	&brcm_avs_mode,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
