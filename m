From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower: Do not change the frequency of offline cpu
Date: Wed, 22 Jul 2015 13:44:54 +0200
Message-ID: <5038391.4TLRDc8YB0@skinner>
References: <1437553249-25400-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437553249-25400-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rafael.j.wysocki@intel.com, peter.senna@gmail.com, ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 22, 2015 01:50:49 PM Shilpasri G Bhat wrote:
> Check if the cpu is online before changing the frequency/governor of
> the cpu.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  tools/power/cpupower/utils/cpufreq-set.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c
> b/tools/power/cpupower/utils/cpufreq-set.c index f656e58..4e21357 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -17,6 +17,7 @@
> 
>  #include "cpufreq.h"
>  #include "helpers/helpers.h"
> +#include "helpers/sysfs.h"
> 
>  #define NORM_FREQ_LEN 32
> 
> @@ -318,6 +319,9 @@ int cmd_freq_set(int argc, char **argv)
>  		    cpufreq_cpu_exists(cpu))
>  			continue;
> 
> +		if (sysfs_is_cpu_online(cpu) != 1)
> +			continue;
> +
>  		printf(_("Setting cpu: %d\n"), cpu);
>  		ret = do_one_cpu(cpu, &new_pol, freq, policychange);
>  		if (ret) {

Thanks for catching this one and sending a patch!

Acked-by: Thomas Renninger <trenn@suse.com>
