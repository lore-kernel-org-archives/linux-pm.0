From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: powerpc: add cpufreq transition latency for
 FSL e500mc Socs
Date: Tue, 18 Mar 2014 11:57:23 +0530
Message-ID: <CAKohpomzedcERNQ66Mf5UM3UTJWA3Q3N83eaEbMV2aKx9jARAQ@mail.gmail.com>
References: <1395121285-15383-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:53105 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbaCRG1Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 02:27:24 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so7276669qcy.14
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2014 23:27:23 -0700 (PDT)
In-Reply-To: <1395121285-15383-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Yuantian.Tang@freescale.com

On 18 March 2014 11:11, Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com> wrote:
> According to the data provided by HW Team, at least 12 internal platform
> clock cycles are required to stabilize a DFS clock switch on FSL e500mc Socs.
> This patch replaces the CPUFREQ_ETERNAL with appropriate HW clock transition
> latency to make DFS governors work normally on Freescale e500mc boards.
>
> Signed-off-by: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index 051000f..5977f57 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -21,6 +21,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/smp.h>
> +#include <sysdev/fsl_soc.h>
>
>  /**
>   * struct cpu_data - per CPU data struct
> @@ -205,7 +206,8 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         for_each_cpu(i, per_cpu(cpu_mask, cpu))
>                 per_cpu(cpu_data, i) = data;
>
> -       policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> +       policy->cpuinfo.transition_latency =
> +                               (12 * NSEC_PER_SEC) / fsl_get_sys_freq();
>         of_node_put(np);
>
>         return 0;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
