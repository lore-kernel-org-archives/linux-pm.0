From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Check memory allocation of
 power_table
Date: Wed, 25 Mar 2015 11:47:05 +0000
Message-ID: <20150325114705.GB3125@e104805>
References: <1426875613-31612-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:31782 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752147AbbCYLyG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Mar 2015 07:54:06 -0400
In-Reply-To: <1426875613-31612-1-git-send-email-javi.merino@arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Fri, Mar 20, 2015 at 06:20:13PM +0000, Javi Merino wrote:
> We allocate the power_table in memory but we don't test whether the
> allocation succeeded.  Return -ENOMEM if kcalloc() fails.
> 
> Fixes: e0128d8ab423 ("thermal: cpu_cooling: implement the power cooling device API")
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
> This applies on top of the linus branch in Eduardo's repository
> 
>  drivers/thermal/cpu_cooling.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index c4974144c787..3a01dfd5b29c 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -329,6 +329,10 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
>  	}
>  
>  	power_table = kcalloc(num_opps, sizeof(*power_table), GFP_KERNEL);
> +	if (!power_table) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
>  
>  	for (freq = 0, i = 0;
>  	     opp = dev_pm_opp_find_freq_ceil(dev, &freq), !IS_ERR(opp);
> -- 
> 1.9.1

Gentle reminder.  Cheers,
Javi

