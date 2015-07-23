From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpupower: Do not change the frequency of offline cpu
Date: Thu, 23 Jul 2015 10:42:59 +0530
Message-ID: <20150723051259.GB25364@in.ibm.com>
References: <1437553249-25400-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:45701 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbGWFNy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 01:13:54 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Wed, 22 Jul 2015 23:13:54 -0600
Content-Disposition: inline
In-Reply-To: <1437553249-25400-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rafael.j.wysocki@intel.com, trenn@suse.com, peter.senna@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com

Hi Shilpa,

This looks good. 

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

On Wed, Jul 22, 2015 at 01:50:49PM +0530, Shilpasri G Bhat wrote:
> Check if the cpu is online before changing the frequency/governor of
> the cpu.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  tools/power/cpupower/utils/cpufreq-set.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index f656e58..4e21357 100644
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
> -- 
> 1.9.3
> 

