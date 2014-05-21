From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Remove unused member name of cpudata
Date: Wed, 21 May 2014 10:15:50 -0700
Message-ID: <537CDF46.3000007@gmail.com>
References: <537B9B0B.1020404@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:42404 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbaEURPy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 13:15:54 -0400
In-Reply-To: <537B9B0B.1020404@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: dirk.brandewie@gmail.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org >> LKML" <linux-kernel@vger.kernel.org>

On 05/20/2014 11:12 AM, Stratos Karafotis wrote:
> Although, a value is assigned to member name of struct cpudata,
> it is never used.
>
> We can safely remove it.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>

Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 24a534a..a6d5afa 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -88,8 +88,6 @@ struct _pid {
>   struct cpudata {
>   	int cpu;
>
> -	char name[64];
> -
>   	struct timer_list timer;
>
>   	struct pstate_data pstate;
> @@ -544,8 +542,6 @@ static inline void intel_pstate_pstate_decrease(struct cpudata *cpu, int steps)
>
>   static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>   {
> -	sprintf(cpu->name, "Intel 2nd generation core");
> -
>   	cpu->pstate.min_pstate = pstate_funcs.get_min();
>   	cpu->pstate.max_pstate = pstate_funcs.get_max();
>   	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>

