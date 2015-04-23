From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Register for OCC related opal_message
 notification
Date: Thu, 23 Apr 2015 17:28:54 +0530
Message-ID: <5538DE7E.1020805@linux.vnet.ibm.com>
References: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:58212 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbbDWL7D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Apr 2015 07:59:03 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 23 Apr 2015 07:59:03 -0400
In-Reply-To: <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Hi Shilpa,

On 04/22/2015 10:34 PM, Shilpasri G Bhat wrote:
> OCC is an On-Chip-Controller which takes care of power and thermal
> safety of the chip. During runtime due to power failure or
> overtemperature the OCC may throttle the frequencies of the CPUs to
> remain within the power budget.
> 
> We want the cpufreq driver to be aware of such situations to be able
> to report it to the user. We register to opal_message_notifier to
> receive OCC messages from opal.
> 
> powernv_cpufreq_throttle_check() reports any frequency throttling and
> this patch will report the reason or event that caused throttling. We
> can be throttled if OCC is reset or OCC limits Pmax due to power or
> thermal reasons. We are also notified of unthrottling after an OCC
> reset or if OCC restores Pmax on the chip.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index ebef0d8..5718765 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -32,6 +32,7 @@
>  #include <asm/firmware.h>
>  #include <asm/reg.h>
>  #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
> +#include <asm/opal.h>
> 
>  #define POWERNV_MAX_PSTATES	256
>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
> @@ -40,7 +41,7 @@
>  #define PMSR_LP(x)		((x >> 48) & 0xFF)
> 
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
> -static bool rebooting, throttled;
> +static bool rebooting, throttled, occ_reset;
> 
>  /*
>   * Note: The set of pstates consists of contiguous integers, the
> @@ -395,6 +396,72 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
> 
> +static char throttle_reason[6][50] = {	"No throttling",
> +					"Power Cap",
> +					"Processor Over Temperature",
> +					"Power Supply Failure",
> +					"OverCurrent",
> +					"OCC Reset"
> +				     };
> +
> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
> +		unsigned long msg_type, void *msg)
> +{
> +	struct opal_msg *occ_msg = msg;
> +	uint64_t token;
> +	uint64_t chip_id, reason;
> +
> +	if (msg_type != OPAL_MSG_OCC)
> +		return 0;
> +	token = be64_to_cpu(occ_msg->params[0]);
> +	switch (token) {
> +	case 0:
> +		occ_reset = true;
> +		/*
> +		 * powernv_cpufreq_throttle_check() is called in
> +		 * target() callback which can detect the throttle state
> +		 * for governors like ondemand.
> +		 * But static governors will not call target() often thus
> +		 * report throttling here.
> +		 */
> +		if (!throttled) {
> +			throttled = true;
> +			pr_crit("CPU Frequency is throttled\n");
> +		}
> +		pr_info("OCC in Reset\n");
> +		break;
> +	case 1:
> +		pr_info("OCC is Loaded\n");
> +		break;
> +	case 2:

You may want to replace the numbers with macros. Like
OCC_RESET,OCC_LOAD, OCC_THROTTLE for better readability.

> +		chip_id = be64_to_cpu(occ_msg->params[1]);
> +		reason = be64_to_cpu(occ_msg->params[2]);
> +		if (occ_reset) {
> +			occ_reset = false;
> +			throttled = false;
> +			pr_info("OCC is Active\n");
> +			/* Sanity check for static governors */
> +			powernv_cpufreq_throttle_check(smp_processor_id());
> +		} else if (reason) {
> +			throttled = true;
> +			pr_info("Pmax reduced due to %s on chip %x\n",
> +					throttle_reason[reason], (int)chip_id);
> +		} else {
> +			throttled = false;
> +			pr_info("%s on chip %x\n",
> +					throttle_reason[reason], (int)chip_id);

Don't you need a powernv_cpufreq_throttle_check() here?  Or is it ok to
rely on the OCC notification for unthrottle ?

Regards
Preeti U Murthy

> +		}
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static struct notifier_block powernv_cpufreq_opal_nb = {
> +	.notifier_call	= powernv_cpufreq_occ_msg,
> +	.next		= NULL,
> +	.priority	= 0,
> +};
> +
>  static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  {
>  	struct powernv_smp_call_data freq_data;
> @@ -430,6 +497,7 @@ static int __init powernv_cpufreq_init(void)
>  	}
> 
>  	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
> +	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
>  	return cpufreq_register_driver(&powernv_cpufreq_driver);
>  }
>  module_init(powernv_cpufreq_init);
> 

