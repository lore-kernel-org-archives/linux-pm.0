From: Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/4] cpuidle:powernv: Add helper function to populate
 powernv idle states.
Date: Tue, 13 Dec 2016 22:51:04 +1100
Message-ID: <d50fa1c4-9f48-c463-ddf8-293c23053b8f@gmail.com>
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
 <36f9cd2d944772d8e414a8240f9ec36eaec65ebd.1481288905.git.ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <36f9cd2d944772d8e414a8240f9ec36eaec65ebd.1481288905.git.ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Shreyas B. Prabhu" <shreyasbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shilpasri G Bhat <shilpa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Stewart Smith <stewart-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Oliver O'Halloran <oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 10/12/16 00:32, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> 
> In the current code for powernv_add_idle_states, there is a lot of code
> duplication while initializing an idle state in powernv_states table.
> 
> Add an inline helper function to populate the powernv_states[] table for
> a given idle state. Invoke this for populating the "Nap", "Fastsleep"
> and the stop states in powernv_add_idle_states.
> 
> Signed-off-by: Gautham R. Shenoy <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 85 ++++++++++++++++++++++-----------------
>  include/linux/cpuidle.h           |  1 +
>  2 files changed, 50 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 7fe442c..db18af1 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -167,6 +167,24 @@ static int powernv_cpuidle_driver_init(void)
>  	return 0;
>  }
>  
> +static inline void add_powernv_state(int index, const char *name,
> +				     unsigned int flags,
> +				     int (*idle_fn)(struct cpuidle_device *,
> +						    struct cpuidle_driver *,
> +						    int),
> +				     unsigned int target_residency,
> +				     unsigned int exit_latency,
> +				     u64 psscr_val)
> +{
> +	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> +	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);

Do name and desc ever diverge?

> +	powernv_states[index].flags = flags;
> +	powernv_states[index].target_residency = target_residency;
> +	powernv_states[index].exit_latency = exit_latency;
> +	powernv_states[index].enter = idle_fn;

Why not call it idle_fn instead of enter?

> +	stop_psscr_table[index] = psscr_val;
> +}
> +
>  static int powernv_add_idle_states(void)
>  {
>  	struct device_node *power_mgt;
> @@ -236,6 +254,7 @@ static int powernv_add_idle_states(void)
>  		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
>  
>  	for (i = 0; i < dt_idle_states; i++) {
> +		unsigned int exit_latency, target_residency;
>  		/*
>  		 * If an idle state has exit latency beyond
>  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> @@ -243,28 +262,33 @@ static int powernv_add_idle_states(void)
>  		 */
>  		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)

Ideally this should be called POWERNV_MAX_THRESHOLD_LATENCY_NS then

>  			continue;
> +		/*
> +		 * Firmware passes residency and latency values in ns.
> +		 * cpuidle expects it in us.
> +		 */
> +		exit_latency = ((unsigned int)latency_ns[i]) / 1000;
> +		if (!rc)
> +			target_residency = residency_ns[i] / 1000;
> +		else
> +			target_residency = 0;

Where do we get rc from? what does target_residency = 0 mean?
Balbir Singh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
