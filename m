From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix possible integer overflow
Date: Mon, 21 Oct 2013 08:56:22 -0700
Message-ID: <52654EA6.6020805@gmail.com>
References: <1382239876-12688-1-git-send-email-geyslan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42862 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3JUP4Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 11:56:25 -0400
In-Reply-To: <1382239876-12688-1-git-send-email-geyslan@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Geyslan G. Bem" <geyslan@gmail.com>, kernel-br@googlegroups.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:CPU FREQUENCY DRI..." <cpufreq@vger.kernel.org>, "open list:CPU FREQUENCY DRI..." <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 10/19/2013 08:31 PM, Geyslan G. Bem wrote:
> The expression 'pstate << 8' is evaluated using 32-bit arithmetic while
> 'val' expects an expression of type u64.
>
> Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index badf620..43446b5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -395,7 +395,7 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
>   	trace_cpu_frequency(pstate * 100000, cpu->cpu);
>
>   	cpu->pstate.current_pstate = pstate;
> -	val = pstate << 8;
> +	val = (u64)pstate << 8;
>   	if (limits.no_turbo)
>   		val |= (u64)1 << 32;
>
>

