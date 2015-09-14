From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq : powernv: Report Pmax throttling if capped
 below nominal frequency
Date: Mon, 14 Sep 2015 12:36:13 +0530
Message-ID: <20150914070613.GA32551@linux>
References: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33962 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbINHGS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 03:06:18 -0400
Received: by padhy16 with SMTP id hy16so135579857pad.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2015 00:06:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 14-09-15, 10:47, Shilpasri G Bhat wrote:
> Log a 'critical' message if the max frequency is reduced below nominal
> frequency. We already log 'info' message if the max frequency is
> capped below turbo frequency. CPU should guarantee atleast nominal
> frequency, but not turbo frequency in all system configurations and
> environments. So report the pmax throttling with severity when Pmax is
> dipped below nominal frequency.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 64994e1..2d9ed42 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -327,8 +327,13 @@ static void powernv_cpufreq_throttle_check(void *data)
>  		if (chips[i].throttled)
>  			goto next;
>  		chips[i].throttled = true;
> -		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
> -			chips[i].id, pmsr_pmax);
> +		if (pmsr_pmax < powernv_pstate_info.nominal)
> +			pr_crit("CPU %d on Chip %u has Pmax reduced to %d\n",
> +				cpu, chips[i].id, pmsr_pmax);
> +		else
> +			pr_info("CPU %d on Chip %u has Pmax reduced to %d\n",
> +				cpu, chips[i].id, pmsr_pmax);

I think the messages here can be improved a bit here to something
like:

			pr_warn("CPU %d on Chip %u has Pmax reduced below nominal freq (%d < %d)\n",
                                 cpu, chips[i].id, pmsr_pmax, powernv_pstate_info.nominal);

And similarly for the pr_info case as well.

-- 
viresh
