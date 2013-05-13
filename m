From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] cpufreq / intel_pstate: use vzalloc() instead of vmalloc()/memset(0)
Date: Mon, 13 May 2013 07:44:49 -0700
Message-ID: <5190FC61.8090709@gmail.com>
References: <CAPgLHd9Z99KvdBghVqr++9G5eBx5hKA13LmPUpc=K_X3N+uhiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55026 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3EMOow (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2013 10:44:52 -0400
In-Reply-To: <CAPgLHd9Z99KvdBghVqr++9G5eBx5hKA13LmPUpc=K_X3N+uhiQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, yongjun_wei@trendmicro.com.cn, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, dirk.brandewie@gmail.com

On 05/13/2013 01:03 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Use vzalloc() instead of vmalloc() and memset(0).
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

> ---
>   drivers/cpufreq/intel_pstate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cc3a8e6..f59aecb 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -788,10 +788,9 @@ static int __init intel_pstate_init(void)
>
>   	pr_info("Intel P-state driver initializing.\n");
>
> -	all_cpu_data = vmalloc(sizeof(void *) * num_possible_cpus());
> +	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
>   	if (!all_cpu_data)
>   		return -ENOMEM;
> -	memset(all_cpu_data, 0, sizeof(void *) * num_possible_cpus());
>
>   	rc = cpufreq_register_driver(&intel_pstate_driver);
>   	if (rc)
>
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

