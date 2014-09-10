From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of
 cpu_data
Date: Wed, 10 Sep 2014 06:20:22 +0000
Message-ID: <902d3b2adc5c4f7b9c3becd38bf04e23@BY2PR03MB570.namprd03.prod.outlook.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0147.outbound.protection.outlook.com ([157.56.111.147]:24064
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751250AbaIJGee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 02:34:34 -0400
In-Reply-To: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, "LeoLi@freescale.com" <LeoLi@freescale.com>


> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Tuesday, September 02, 2014 11:41 AM
> To: Rafael Wysocki; Tang Yuantian-B29983
> Cc: linaro-kernel@lists.linaro.org; linux-pm@vger.kernel.org; Zhang
> Hongbo-B45939; Li Yang-Leo-R58472; Viresh Kumar
> Subject: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
> 
> 'cpu_data' is updated for policy->cpu first and then for all CPUs in
> policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well
> policy->and so
> the first write to 'cpu_data' for policy->cpu is redundant. Remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Yuantian,
> 
> I was looking into this driver due to issues reported by Hongtao (cc'd) and found
> that we can live without some code. These aren't fixing any bugs and are just
> cleanups.
> 
> I didn't had a compiler for this and so this isn't even compiled. It would be great if
> you can please review/test these patches.
> 
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c
> b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index 3607070..bee5df7 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -199,7 +199,6 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy
> *policy)
>  	}
> 
>  	data->table = table;
> -	per_cpu(cpu_data, cpu) = data;
> 
>  	/* update ->cpus if we have cluster, no harm if not */
>  	cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));
> --
> 2.0.3.693.g996b0fd

Acked-by: Tang Yuantian <Yuantian.Tang@freescale.com>

Regards,
Yuantian
