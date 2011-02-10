From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Patch] idle governor: Avoid lock acquisition to
	read pm_qos before entering idle
Date: Fri, 11 Feb 2011 00:17:15 +0100
Message-ID: <201102110017.16066.rjw__8761.8293393918$1297380000$gmane$org@sisk.pl>
References: <1297300864.2645.128.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1297300864.2645.128.camel@schen9-DESK>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Len <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, mark gross <markgross@thegnar.org>, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@suse.de>, David Alan Gilbert <linux@treblig.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 10, 2011, Tim Chen wrote:
> I noticed that before entering idle state, the menu idle governor will
> look up the current pm_qos value according to the list of qos request
> received.  This look up currently needs the acquisition of a lock to go
> down a list of qos requests to find the qos value, slowing down the
> entrance into idle state due to contention by multiple cpus to traverse
> this list.  The contention is severe when there are a lot of cpus waking
> and going into idle.  For example, for a simple workload that has 32
> pair of processes ping ponging messages to each other, where 64 cores
> cores are active in test system, I see the following profile:
> 
> -     37.82%          swapper  [kernel.kallsyms]          [k]
> _raw_spin_lock_irqsave
>    - _raw_spin_lock_irqsave
>       - 95.65% pm_qos_request             
>            menu_select                                             
>            cpuidle_idle_call                      
>          - cpu_idle                                                     
>               99.98% start_secondary
> 
> Perhaps a better approach will be to cache the updated pm_qos value so
> reading it does not require lock acquisition as in the patch below.   
> 
> Tim
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
> index 77cbddb..a7d87f9 100644
> --- a/include/linux/pm_qos_params.h
> +++ b/include/linux/pm_qos_params.h
> @@ -16,6 +16,10 @@
>  #define PM_QOS_NUM_CLASSES 4
>  #define PM_QOS_DEFAULT_VALUE -1
>  
> +#define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> +#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> +#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
> +
>  struct pm_qos_request_list {
>  	struct plist_node list;
>  	int pm_qos_class;
> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> index aeaa7f8..b6310d1 100644
> --- a/kernel/pm_qos_params.c
> +++ b/kernel/pm_qos_params.c
> @@ -58,6 +58,7 @@ struct pm_qos_object {
>  	struct blocking_notifier_head *notifiers;
>  	struct miscdevice pm_qos_power_miscdev;
>  	char *name;
> +	s32 value;
>  	s32 default_value;
>  	enum pm_qos_type type;
>  };
> @@ -70,7 +71,8 @@ static struct pm_qos_object cpu_dma_pm_qos = {
>  	.requests = PLIST_HEAD_INIT(cpu_dma_pm_qos.requests, pm_qos_lock),
>  	.notifiers = &cpu_dma_lat_notifier,
>  	.name = "cpu_dma_latency",
> -	.default_value = 2000 * USEC_PER_SEC,
> +	.value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
> +	.default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>  	.type = PM_QOS_MIN,
>  };
>  
> @@ -79,7 +81,8 @@ static struct pm_qos_object network_lat_pm_qos = {
>  	.requests = PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_qos_lock),
>  	.notifiers = &network_lat_notifier,
>  	.name = "network_latency",
> -	.default_value = 2000 * USEC_PER_SEC,
> +	.value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> +	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
>  	.type = PM_QOS_MIN
>  };
>  
> @@ -89,7 +92,8 @@ static struct pm_qos_object network_throughput_pm_qos = {
>  	.requests = PLIST_HEAD_INIT(network_throughput_pm_qos.requests, pm_qos_lock),
>  	.notifiers = &network_throughput_notifier,
>  	.name = "network_throughput",
> -	.default_value = 0,
> +	.value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> +	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>  	.type = PM_QOS_MAX,
>  };
>  
> @@ -132,6 +136,16 @@ static inline int pm_qos_get_value(struct pm_qos_object *o)
>  	}
>  }
>  
> +static inline s32 pm_qos_read_value(struct pm_qos_object *o)
> +{
> +	return o->value;
> +}
> +
> +static inline int pm_qos_set_value(struct pm_qos_object *o, s32 value)
> +{
> +	o->value = value;
> +}

This requires a fixup, the above function is supposed to return an int.

Also, please add a comment about the requisite 32-bitness as suggested by James.

Thanks,
Rafael
