From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
Date: Tue, 23 Jul 2013 23:20:31 +0200
Message-ID: <9298823.WUCyZreP9q@vostro.rjw.lan>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36346 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757721Ab3GWVKc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jul 2013 17:10:32 -0400
In-Reply-To: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tuesday, July 23, 2013 11:24:37 PM Aaro Koskinen wrote:
> Some functions on switch path use msleep() which is inaccurate, and
> depends on HZ. With HZ=100 msleep(1) takes actually over ten times longer.
> Using usleep_range() we get more accurate sleeps.
> 
> I measured the "pfunc_slewing_done" polling to take 300us at max (on
> 2.3GHz dual-processor Xserve G5), so using 500us sleep there should
> be fine.
> 
> With the patch, g5_switch_freq() duration drops from ~50ms to ~10ms on
> Xserve with HZ=100.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

All looks good in the patchset from 10000 feet (or more), but I need Ben to
speak here.

Thanks,
Rafael


> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index 7ba4234..674807d 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -141,7 +141,7 @@ static void g5_vdnap_switch_volt(int speed_mode)
>  		pmf_call_one(pfunc_vdnap0_complete, &args);
>  		if (done)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1000);
>  	}
>  	if (done == 0)
>  		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
> @@ -240,7 +240,7 @@ static void g5_pfunc_switch_volt(int speed_mode)
>  		if (pfunc_cpu1_volt_low)
>  			pmf_call_one(pfunc_cpu1_volt_low, NULL);
>  	}
> -	msleep(10); /* should be faster , to fix */
> +	usleep_range(10000, 10000); /* should be faster , to fix */
>  }
>  
>  /*
> @@ -285,7 +285,7 @@ static int g5_pfunc_switch_freq(int speed_mode)
>  		pmf_call_one(pfunc_slewing_done, &args);
>  		if (done)
>  			break;
> -		msleep(1);
> +		usleep_range(500, 500);
>  	}
>  	if (done == 0)
>  		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
