From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 2/6] cpupower: Restore format of frequency-info limit
Date: Thu, 12 Jan 2017 00:20:11 +0900
Message-ID: <20170111152011.GC25986@lianli.shorne-pla.net>
References: <cover.1484146515.git.shorne@gmail.com>
 <aa5a9bd71838802d6410155295796fec9214928d.1484146515.git.shorne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34948 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934672AbdAKPUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 10:20:14 -0500
Content-Disposition: inline
In-Reply-To: <aa5a9bd71838802d6410155295796fec9214928d.1484146515.git.shorne@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah@kernel.org>, Darren Hart <dvhart@linux.intel.com>
Cc: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.com>, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

Hi All,

Please ignore this, its a dup of the patch with the same name.

I had an slight issue with reordering patches and this got send out.

On Thu, Jan 12, 2017 at 12:11:15AM +0900, Stafford Horne wrote:
> The intel_pstate kselftest expects that the output of
> `cpupower frequency-info -l | tail -1 | awk ' { print $1 } '`
> to get frequency limits.  This does not work after the following two
> changes.
> 
>  - 562e5f1a3: rework the "cpupower frequency-info" command
>    (Jacob Tanenbaum) removed parsable limit output
>  - ce512b840: Do not analyse offlined cpus
>    (Thomas Renninger) added newline to break limit parsing more
> 
> This change preserves human readable output if wanted as well as
> parsable output for scripts/tests.
> 
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  tools/power/cpupower/utils/cpufreq-info.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index 590d12a..3e701f0 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -285,20 +285,24 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
>  
>  /* --hwlimits / -l */
>  
> -static int get_hardware_limits(unsigned int cpu)
> +static int get_hardware_limits(unsigned int cpu, unsigned int human)
>  {
>  	unsigned long min, max;
>  
> -	printf(_("  hardware limits: "));
>  	if (cpufreq_get_hardware_limits(cpu, &min, &max)) {
>  		printf(_("Not Available\n"));
>  		return -EINVAL;
>  	}
>  
> -	print_speed(min);
> -	printf(" - ");
> -	print_speed(max);
> -	printf("\n");
> +	if (human) {
> +		printf(_("  hardware limits: "));
> +		print_speed(min);
> +		printf(" - ");
> +		print_speed(max);
> +		printf("\n");
> +	} else {
> +		printf("%lu %lu\n", min, max);
> +	}
>  	return 0;
>  }
>  
> @@ -456,7 +460,7 @@ static void debug_output_one(unsigned int cpu)
>  	get_related_cpus(cpu);
>  	get_affected_cpus(cpu);
>  	get_latency(cpu, 1);
> -	get_hardware_limits(cpu);
> +	get_hardware_limits(cpu, 1);
>  
>  	freqs = cpufreq_get_available_frequencies(cpu);
>  	if (freqs) {
> @@ -622,7 +626,7 @@ int cmd_freq_info(int argc, char **argv)
>  			ret = get_driver(cpu);
>  			break;
>  		case 'l':
> -			ret = get_hardware_limits(cpu);
> +			ret = get_hardware_limits(cpu, human);
>  			break;
>  		case 'w':
>  			ret = get_freq_hardware(cpu, human);
> @@ -639,7 +643,6 @@ int cmd_freq_info(int argc, char **argv)
>  		}
>  		if (ret)
>  			return ret;
> -		printf("\n");
>  	}
>  	return ret;
>  }
> -- 
> 2.9.3
> 
