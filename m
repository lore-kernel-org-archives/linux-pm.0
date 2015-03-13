From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: cpu_cooling: Remove cpu_dev update on
 policy CPU update
Date: Fri, 13 Mar 2015 00:39:22 -0400
Message-ID: <20150313043920.GA29762@developer.hsd1.ca.comcast.net>
References: <1426096417-27522-1-git-send-email-kapileshwar.singh@arm.com>
 <1426096417-27522-2-git-send-email-kapileshwar.singh@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39457 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbCMEjN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 00:39:13 -0400
Received: by pdbft15 with SMTP id ft15so25741562pdb.6
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2015 21:39:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426096417-27522-2-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, Javi.Merino@arm.com, Punit.Agrawal@arm.com

KP,

On Wed, Mar 11, 2015 at 05:53:36PM +0000, Kapileshwar Singh wrote:
> It was initially understood that an update to the cpu_device
> (cached in cpufreq_cooling_device) was required to ascertain the
> correct operating point of the device on a cpufreq policy->cpu update
> or creation or deletion of a cpufreq policy.
> (e.g. when the existing policy CPU goes offline).
> 
> This was added in:
> 
> e0128d8ab423 - thermal: cpu_cooling: implement the power cooling device API


Can you please add a 'fixes' entry here?

> 
> This update is not required and it is possible to ascertain the OPPs
> from the leading CPU in a cpufreq domain even if the CPU is hotplugged out.
> 
> Acked-by: Javi Merino <javi.merino@arm.com>
> Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c |   40 ----------------------------------------

Your patch looks fine to me, but you have to resend it (same applies to
patch 02). The reason is that I've got it with the charset issue and
characters are mangled. Can you please check with Javi or Punit on how
to setup your mailer?

Thanks,

Eduardo Valentin
>  1 file changed, 40 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index c4974144c787..2e15133b4793 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -199,39 +199,6 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
>  
> -static void update_cpu_device(int cpu)
> -{
> -	struct cpufreq_cooling_device *cpufreq_dev;
> -
> -	mutex_lock(&cooling_cpufreq_lock);
> -	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
> -		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
> -			cpufreq_dev->cpu_dev = get_cpu_device(cpu);
> -			if (!cpufreq_dev->cpu_dev) {
> -				dev_warn(&cpufreq_dev->cool_dev->device,
> -					"No cpu device for new policy cpu %d\n",
> -					 cpu);
> -			}
> -			break;
> -		}
> -	}
> -	mutex_unlock(&cooling_cpufreq_lock);
> -}
> -
> -static void remove_cpu_device(int cpu)
> -{
> -	struct cpufreq_cooling_device *cpufreq_dev;
> -
> -	mutex_lock(&cooling_cpufreq_lock);
> -	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
> -		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
> -			cpufreq_dev->cpu_dev = NULL;
> -			break;
> -		}
> -	}
> -	mutex_unlock(&cooling_cpufreq_lock);
> -}
> -
>  /**
>   * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
>   * @nb:	struct notifier_block * with callback info.
> @@ -268,13 +235,6 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  		}
>  		mutex_unlock(&cooling_cpufreq_lock);
>  		break;
> -
> -	case CPUFREQ_CREATE_POLICY:
> -		update_cpu_device(policy->cpu);
> -		break;
> -	case CPUFREQ_REMOVE_POLICY:
> -		remove_cpu_device(policy->cpu);
> -		break;
>  	default:
>  		return NOTIFY_DONE;
>  	}
> -- 
> 1.7.9.5
> 
> 
