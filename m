From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: Dont assume distinct pstate values for
 nominal and pmin
Date: Fri, 12 Jan 2018 14:37:27 +0530
Message-ID: <20180112090727.GN3626@vireshk-i7>
References: <1515741233-1442-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45302 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754430AbeALJHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 04:07:30 -0500
Received: by mail-pg0-f68.google.com with SMTP id c194so4167774pga.12
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2018 01:07:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1515741233-1442-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com

On 12-01-18, 12:43, Shilpasri G Bhat wrote:
> Some OpenPOWER boxes can have same pstate values for nominal and
> pmin pstates. In these boxes the current code will not initialize
> 'powernv_pstate_info.min' variable and result in erroneous CPU
> frequency reporting. This patch fixes this problem.
> 
> Fixes: 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
> Reported-by: Alvin Wang <wangat@tw.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index b6d7c4c..da7fdb4 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -288,9 +288,9 @@ static int init_powernv_pstates(void)
>  
>  		if (id == pstate_max)
>  			powernv_pstate_info.max = i;
> -		else if (id == pstate_nominal)
> +		if (id == pstate_nominal)
>  			powernv_pstate_info.nominal = i;
> -		else if (id == pstate_min)
> +		if (id == pstate_min)
>  			powernv_pstate_info.min = i;
>  
>  		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
