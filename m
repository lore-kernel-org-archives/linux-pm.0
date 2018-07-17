From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on
 many-CPU systems
Date: Tue, 17 Jul 2018 22:13:23 +0200
Message-ID: <20180717201323.6rwb4yklq46cmtom@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <306375154.NhdH6AhdAd@aspire.rjw.lan>
 <5423012.ZZnfdYddaT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5423012.ZZnfdYddaT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 06:14:58PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The firmware interface used by the pcc-cpufreq driver is
> fundamentally not scalable and using it for dynamic CPU performance
> scaling on systems with many CPUs leads to degraded performance.
> 
> For this reason, disable dynamic CPU performance scaling on systems
> with pcc-cpufreq where the number of CPUs present at the driver init
> time is greater than 4.  Also make the driver print corresponding
> complaints to the kernel log.
> 
> Reported-by: Andreas Herrmann <aherrmann@suse.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Rework the messages printed in the problematic case.

I've tested this patch. Effect is as expected: driver loads but use of
ondemand governor is not allowed. Sample output:

[   40.757519] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz
[   40.831705] pcc_cpufreq_init: Too many CPUs, dynamic performance scaling disabled
[   40.898353] pcc_cpufreq_init: Try to enable a different scaling driver through BIOS settings
[   40.972327] pcc_cpufreq_init: and complain to the system vendor
[   41.025620] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor
...
[   41.187928] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor

Last message is shown for each online CPU in the system  (ie. 120x).

Looks good to me.


Andreas

> ---
>  drivers/cpufreq/pcc-cpufreq.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/pcc-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/pcc-cpufreq.c
> +++ linux-pm/drivers/cpufreq/pcc-cpufreq.c
> @@ -589,6 +589,15 @@ static int __init pcc_cpufreq_init(void)
>  		return ret;
>  	}
>  
> +	if (num_present_cpus() > 4) {
> +		pcc_cpufreq_driver.flags |= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING;
> +		pr_err("%s: Too many CPUs, dynamic performance scaling disabled\n",
> +		       __func__);
> +		pr_err("%s: Try to enable a different scaling driver through BIOS settings\n",
> +		       __func__);
> +		pr_err("%s: and complain to the system vendor\n", __func__);
> +	}
> +
>  	ret = cpufreq_register_driver(&pcc_cpufreq_driver);
>  
>  	return ret;
> 
> 
