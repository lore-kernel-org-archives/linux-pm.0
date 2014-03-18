From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] cpufreq: Add exit_prepare callback to cpufreq_driver
 interface
Date: Tue, 18 Mar 2014 17:42:27 +0530
Message-ID: <5328382B.7020203@linux.vnet.ibm.com>
References: <1394732168-12638-1-git-send-email-dirk.j.brandewie@intel.com> <1394732168-12638-2-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:56506 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbaCRMMw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 08:12:52 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 18 Mar 2014 22:12:49 +1000
In-Reply-To: <1394732168-12638-2-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, patrick.marlier@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>

On 03/13/2014 11:06 PM, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> This callback allows the driver to do clean up before the CPU is
> completely down and its state cannot be modified.  This is used
> by the intel_pstate driver to reduce the requested P state prior to
> the core going away.  This is required because the requested P state
> of the offline core is used to select the package P state. This
> effectively sets the floor package P state to the requested P state on
> the offline core.
> 
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
>  Documentation/cpu-freq/cpu-drivers.txt | 8 +++++++-
>  drivers/cpufreq/cpufreq.c              | 3 +++
>  include/linux/cpufreq.h                | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
> index 8b1a445..935f274 100644
> --- a/Documentation/cpu-freq/cpu-drivers.txt
> +++ b/Documentation/cpu-freq/cpu-drivers.txt
> @@ -61,7 +61,13 @@ target_index		-	See below on the differences.
> 
>  And optionally
> 
> -cpufreq_driver.exit -		A pointer to a per-CPU cleanup function.
> +cpufreq_driver.exit -		A pointer to a per-CPU cleanup
> +		    		function called during CPU_POST_DEAD
> +		    		phase of cpu hotplug process.
> +
> +cpufreq_driver.exit_prepare -	A pointer to a per-CPU cleanup function 
> +			    	called during CPU_DOWN_PREPARE phase of 
> +				cpu hotplug process.
> 
>  cpufreq_driver.resume -		A pointer to a per-CPU resume function
>  				which is called with interrupts disabled
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index cf485d9..5c9bbfa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1338,6 +1338,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>  		}
>  	}
> 
> +	if (cpufreq_driver->exit_prepare)
> +		cpufreq_driver->exit_prepare(policy);
> +

The placement of this hunk doesn't feel right. IMHO we should place it
right next to the code which stops the governor.

Something like this:

        if (has_target()) {
                ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
                if (ret) {
                        pr_err("%s: Failed to stop governor\n", __func__);
                        return ret; 
                }    
        } else if (cpufreq_driver->setpolicy) {
		if (cpufreq_driver->exit_prepare)
			cpufreq_driver->exit_prepare(policy);
	}

This makes it clear that GOV_STOP is used to stop managing the CPUs
for platforms that have ->target defined, and ->exit_prepare() is used
for similar purposes for platforms that have ->setpolicy() defined.

By the way, I like the name ->stop more than ->exit_prepare, because:
->exit() is done once per policy, which implies that ->exit_prepare
also shares similar semantics. However, what we really want the new
callback to do is to provide a way for the driver to stop managing the
CPU that is going offline, just like GOV_STOP. So naturally, this
new callback should be invoked during every CPU offline, and not just
once per policy. Hence the name "stop" (this CPU) makes perfect sense
for that IMHO. 

[Of course, I understand that GOV_STOP actually stops the entire
policy for all affected cpus and then we use GOV_START in
_remove_dev_finish() to restart the governor for the other online
CPUs in that policy. This is somewhat round-about, but conceptually
this is equivalent to asking the governor to let go control of only
the CPU going offline. The new ->stop callback should have the same
"stop only this CPU" semantics.]

>  	return 0;
>  }
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 4d89e0e..5fa94ad 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -224,6 +224,7 @@ struct cpufreq_driver {
>  	int	(*bios_limit)	(int cpu, unsigned int *limit);
> 
>  	int	(*exit)		(struct cpufreq_policy *policy);
> +	int	(*exit_prepare)	(struct cpufreq_policy *policy);
>  	int	(*suspend)	(struct cpufreq_policy *policy);
>  	int	(*resume)	(struct cpufreq_policy *policy);
>  	struct freq_attr	**attr;
> 

