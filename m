From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] intel_pstate: Remove periodic P state boost
Date: Thu, 23 Jan 2014 08:51:54 -0800
Message-ID: <52E148AA.7030406@intel.com>
References: <1390495707-6297-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33950 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbaAWQv5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2014 11:51:57 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so2077272pab.16
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2014 08:51:57 -0800 (PST)
In-Reply-To: <1390495707-6297-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org

Please ignore. Sorry for the noise I found this in the 3.14 material.

--Dirk
On 01/23/2014 08:48 AM, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
>
> Remove the periodic P state boost.  This code required for some corner
> case benchmark tests.  The calculation of the required P state was
> incorrect/inaccurate and would not allow P state increase.
>
> This was resolved by a combination of commits:
>    2134ed4 cpufreq / intel_pstate: Change to scale off of max P-state
>    d253d2a intel_pstate: Improve accuracy by not truncating until final result
>
> reference:
>    https://bugzilla.kernel.org/show_bug.cgi?id=64271
>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c | 11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index d51f17ed..5a060eb 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -84,8 +84,6 @@ struct cpudata {
>   	struct pstate_data pstate;
>   	struct _pid pid;
>
> -	int min_pstate_count;
> -
>   	u64	prev_aperf;
>   	u64	prev_mperf;
>   	int	sample_ptr;
> @@ -568,15 +566,6 @@ static void intel_pstate_timer_func(unsigned long __data)
>
>   	intel_pstate_sample(cpu);
>   	intel_pstate_adjust_busy_pstate(cpu);
> -
> -	if (cpu->pstate.current_pstate == cpu->pstate.min_pstate) {
> -		cpu->min_pstate_count++;
> -		if (!(cpu->min_pstate_count % 5)) {
> -			intel_pstate_set_pstate(cpu, cpu->pstate.max_pstate);
> -		}
> -	} else
> -		cpu->min_pstate_count = 0;
> -
>   	intel_pstate_set_sample_time(cpu);
>   }
>
>

