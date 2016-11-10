From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: make symbol
 brcm_avs_cpufreq_attr static
Date: Thu, 10 Nov 2016 14:06:16 -0800
Message-ID: <CAGt4E5sQvRXdS+wh2jqa9jF4jxS9TxnULXwg1vJm1fwU-Gja4g@mail.gmail.com>
References: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32827 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbcKJWGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 17:06:19 -0500
Received: by mail-vk0-f44.google.com with SMTP id 137so168258870vkl.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 14:06:19 -0800 (PST)
In-Reply-To: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>

On 10 November 2016 at 07:19, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fixes the following sparse warning:
>
> drivers/cpufreq/brcmstb-avs-cpufreq.c:982:18: warning:
>  symbol 'brcm_avs_cpufreq_attr' was not declared. Should it be static?

Yes, thanks for the fix.

Acked-by: Markus Mayer <mmayer@broadcom.com>

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
>         &cpufreq_freq_attr_scaling_available_freqs,
>         &brcm_avs_pstate,
>         &brcm_avs_mode,
>
