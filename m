From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix current freq check on policy update
Date: Mon, 17 Feb 2014 13:53:41 +0530
Message-ID: <CAKohponPbf9hiL7YwNwSrjS1nM3AQ2-PMWhf3ERCBtY_6nOejg@mail.gmail.com>
References: <20140214072623.3dd67851@mjolnir.ossman.eu>
	<52FE01A2.9030905@linux.vnet.ibm.com>
	<20140214153423.340e404e@mjolnir.ossman.eu>
	<5301C379.9020909@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:60606 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaBQIXl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 03:23:41 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp4so16729062obc.30
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2014 00:23:41 -0800 (PST)
In-Reply-To: <5301C379.9020909@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Pierre Ossman <pierre-list@ossman.eu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>

On 17 February 2014 13:38, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Hmm, that would be good. However, I did find something odd while browsing
> through the powernow-k8 code.
>
> It maintains a per-cpu data-structure called powernow_data, but it is
> initialized only for the policy->cpu.

I thought about it earlier, but thought it will be called only with policy->cpu
by core.

> In powernowk8_cpu_init():
>
>         per_cpu(powernow_data, pol->cpu) = data;
>
> Everywhere in the code, this per-cpu data-structure is accessed always with
> pol->cpu as the argument, *except* in powernowk8_get():
>
> 1210 static unsigned int powernowk8_get(unsigned int cpu)
> 1211 {
> 1212         struct powernow_k8_data *data = per_cpu(powernow_data, cpu);
> 1213         unsigned int khz = 0;
> 1214         int err;
> 1215
> 1216         if (!data)
> 1217                 return 0;
> 1218
> 1219         smp_call_function_single(cpu, query_values_on_cpu, &err, true);
> 1220         if (err)
> 1221                 goto out;
> 1222
> 1223         khz = find_khz_freq_from_fid(data->currfid);
> 1224
>
> So, obviously it finds data to be uninitialized if cpu != pol->cpu, and hence
> it would return 0 due to the "if (!data)" check. In other words, the init
> routine initializes the per-cpu memory only for the pol->cpu, whereas the
> ->get() routine tries to access it for some other cpu, and fails.

bingo!!

> So I think the following patch should fix your problem. Basically, this
> initializes the per-cpu data-structures of all the CPUs to the correct memory,
> and not just for the pol->cpu.
>
>
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index e10b646..bd7bc39 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1076,7 +1076,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
>  {
>         struct powernow_k8_data *data;
>         struct init_on_cpu init_on_cpu;
> -       int rc;
> +       int rc, cpu;
>
>         smp_call_function_single(pol->cpu, check_supported_cpu, &rc, 1);
>         if (rc)
> @@ -1140,7 +1140,9 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
>         pr_debug("cpu_init done, current fid 0x%x, vid 0x%x\n",
>                  data->currfid, data->currvid);
>
> -       per_cpu(powernow_data, pol->cpu) = data;
> +       /* Point all the CPUs in this policy to the same data */
> +       for_each_cpu(cpu, pol->cpus)
> +               per_cpu(powernow_data, cpu) = data;

You need to do something similar on: powernowk8_cpu_exit() as well
which sets it to zero.

Please send a patch for it, that is the problem for sure.
