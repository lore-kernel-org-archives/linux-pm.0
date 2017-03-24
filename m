From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH] powernv-cpuidle: Validate DT property array size
Date: Fri, 24 Mar 2017 14:15:25 +0530
Message-ID: <6d2873de-ee47-e362-ef1a-6ac11ebee121@linux.vnet.ibm.com>
References: <1489565753-2693-1-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44525 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752170AbdCXIph (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 04:45:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2O8iFcl037562
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 04:45:36 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29cu2ge6vg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 04:45:35 -0400
Received: from localhost
        by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Fri, 24 Mar 2017 14:15:31 +0530
In-Reply-To: <1489565753-2693-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Balbir Singh <bsingharora@gmail.com>, Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org



On 03/15/2017 01:45 PM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The various properties associated with powernv idle states such as
> names, flags, residency-ns, latencies-ns, psscr, psscr-mask are
> exposed in the device-tree as property arrays such the pointwise
> entries in each of these arrays correspond to the properties of the
> same idle state.
> 
> This patch validates that the lengths of the property arrays are the
> same. If there is a mismatch, the patch will ensure that we bail out
> and not expose the platform idle states via cpuidle.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> v1: https://lkml.org/lkml/2017/2/23/349
> Changes from v1: Print the full property array name in warning message.

Reviewed-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

> 
>  drivers/cpuidle/cpuidle-powernv.c | 64 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 3705930..a06df51 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -197,11 +197,25 @@ static inline void add_powernv_state(int index, const char *name,
>  	stop_psscr_table[index].mask = psscr_mask;
>  }
> 
> +/*
> + * Returns 0 if prop1_len == prop2_len. Else returns -1
> + */
> +static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
> +					 const char *prop2, int prop2_len)
> +{
> +	if (prop1_len == prop2_len)
> +		return 0;
> +
> +	pr_warn("cpuidle-powernv: array sizes don't match for %s and %s\n",
> +		prop1, prop2);
> +	return -1;
> +}
> +
>  static int powernv_add_idle_states(void)
>  {
>  	struct device_node *power_mgt;
>  	int nr_idle_states = 1; /* Snooze */
> -	int dt_idle_states;
> +	int dt_idle_states, count;
>  	u32 latency_ns[CPUIDLE_STATE_MAX];
>  	u32 residency_ns[CPUIDLE_STATE_MAX];
>  	u32 flags[CPUIDLE_STATE_MAX];
> @@ -226,6 +240,21 @@ static int powernv_add_idle_states(void)
>  		goto out;
>  	}
> 
> +	count = of_property_count_u32_elems(power_mgt,
> +					    "ibm,cpu-idle-state-latencies-ns");
> +
> +	if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags", dt_idle_states,
> +				   "ibm,cpu-idle-state-latencies-ns",
> +				   count) != 0)
> +		goto out;
> +
> +	count = of_property_count_strings(power_mgt,
> +					  "ibm,cpu-idle-state-names");
> +	if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags", dt_idle_states,
> +				   "ibm,cpu-idle-state-names",
> +				   count) != 0)
> +		goto out;
> +
>  	/*
>  	 * Since snooze is used as first idle state, max idle states allowed is
>  	 * CPUIDLE_STATE_MAX -1
> @@ -260,6 +289,22 @@ static int powernv_add_idle_states(void)
>  	has_stop_states = (flags[0] &
>  			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
>  	if (has_stop_states) {
> +		count = of_property_count_u64_elems(power_mgt,
> +						    "ibm,cpu-idle-state-psscr");
> +		if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
> +					   dt_idle_states,
> +					   "ibm,cpu-idle-state-psscr",
> +					   count) != 0)
> +			goto out;
> +
> +		count = of_property_count_u64_elems(power_mgt,
> +						    "ibm,cpu-idle-state-psscr-mask");
> +		if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
> +					   dt_idle_states,
> +					   "ibm,cpu-idle-state-psscr-mask",
> +					   count) != 0)
> +			goto out;
> +
>  		if (of_property_read_u64_array(power_mgt,
>  		    "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states)) {
>  			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
> @@ -274,8 +319,21 @@ static int powernv_add_idle_states(void)
>  		}
>  	}
> 
> -	rc = of_property_read_u32_array(power_mgt,
> -		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
> +	count = of_property_count_u32_elems(power_mgt,
> +					    "ibm,cpu-idle-state-residency-ns");
> +
> +	if (count < 0) {
> +		rc = count;
> +	} else if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
> +					  dt_idle_states,
> +					  "ibm,cpu-idle-state-residency-ns",
> +					  count) != 0) {
> +		goto out;
> +	} else {
> +		rc = of_property_read_u32_array(power_mgt,
> +						"ibm,cpu-idle-state-residency-ns",
> +						residency_ns, dt_idle_states);
> +	}
> 
>  	for (i = 0; i < dt_idle_states; i++) {
>  		unsigned int exit_latency, target_residency;
> 
