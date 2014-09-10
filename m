From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Wed, 10 Sep 2014 10:02:33 +0530
Message-ID: <CAKohpo=bz7H1CUUNGq_u33oKLnzzgPcqxyMOvC-S_dT8UE0S9A@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:62886 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbaIJEce (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 00:32:34 -0400
Received: by mail-oi0-f48.google.com with SMTP id a141so11658448oig.35
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 21:32:33 -0700 (PDT)
In-Reply-To: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Yuantian Tang <yuantian.tang@freescale.com>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, Li Yang <leoli@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 2 September 2014 09:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 'cpu_data' is updated for policy->cpu first and then for all CPUs in
> policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well and so
> the first write to 'cpu_data' for policy->cpu is redundant. Remove it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Yuantian,
>
> I was looking into this driver due to issues reported by Hongtao (cc'd) and
> found that we can live without some code. These aren't fixing any bugs and are
> just cleanups.
>
> I didn't had a compiler for this and so this isn't even compiled. It would be
> great if you can please review/test these patches.
>
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index 3607070..bee5df7 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -199,7 +199,6 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         }
>
>         data->table = table;
> -       per_cpu(cpu_data, cpu) = data;
>
>         /* update ->cpus if we have cluster, no harm if not */
>         cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));

Hi Yuantian,

Can we get your Ack for this patch atleast so that Rafael can apply it ?
