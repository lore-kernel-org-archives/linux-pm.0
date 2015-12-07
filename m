From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mt8173: migrate to use operating-points-v2
 bindings
Date: Mon, 7 Dec 2015 15:34:27 +0530
Message-ID: <20151207100427.GG3294@ubuntu>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
 <1449305584-414-2-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35458 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144AbbLGKEb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 05:04:31 -0500
Received: by pfu207 with SMTP id 207so62682041pfu.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 02:04:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449305584-414-2-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 05-12-15, 16:53, Pi-Cheng Chen wrote:
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 257bcb9..17e9cad 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -344,6 +344,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  	unsigned long rate;
>  	int ret;
>  
> +	/* Mark the first owner of this CPU DVFS domain information */
> +	cpumask_set_cpu(cpu, &info->cpus);
> +

This is bad, sorry about that. Please update
dev_pm_opp_of_get_sharing_cpus() to update this as well.

-- 
viresh
