From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 2/6] PM QoS: Add CPU frequency min/max as PM
 QoS params
Date: Fri, 6 Jan 2012 07:30:27 -0800
Message-ID: <20120106153027.GE12530@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<1325810186-28986-3-git-send-email-amiettinen@nvidia.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325810186-28986-3-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2012 at 02:36:22AM +0200, Antti P Miettinen wrote:
> Add minimum and maximum CPU frequency as PM QoS parameters.
> 
> Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
> ---
>  include/linux/pm_qos.h |    5 +++++
>  kernel/power/qos.c     |   32 +++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 5ac91d8..7b8d08b 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -14,8 +14,11 @@ enum {
>  	PM_QOS_CPU_DMA_LATENCY,
>  	PM_QOS_NETWORK_LATENCY,
>  	PM_QOS_NETWORK_THROUGHPUT,
> +	PM_QOS_CPU_FREQ_MIN,
> +	PM_QOS_CPU_FREQ_MAX,
What is this about?  How sould freq_max make any sense in the context of
constraining power mangement throutling?  this is wrong.

You should only have a cpu throughput qos.  I.e. FREQ_MIN.
FWIW in my patch I named it : PM_QOS_CPU_THROUGHPUT  but, its just a
different name to your PM_QOS_CPU_FREQ_MIN name.


>  
>  	/* insert new class ID */
> +
>  	PM_QOS_NUM_CLASSES,
>  };
>  
> @@ -25,6 +28,8 @@ enum {
>  #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
>  #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
>  #define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
> +#define PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE	0
> +#define PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE	LONG_MAX

PM_QOS_FREQ_MAX must go away.

--mark

>  
>  struct pm_qos_request {
>  	struct plist_node node;
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index d6d6dbd..66ae05e 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -101,11 +101,41 @@ static struct pm_qos_object network_throughput_pm_qos = {
>  };
>  
>  
> +static BLOCKING_NOTIFIER_HEAD(cpu_freq_min_notifier);
> +static struct pm_qos_constraints cpu_freq_min_constraints = {
> +	.list = PLIST_HEAD_INIT(cpu_freq_min_constraints.list),
> +	.target_value = PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE,
> +	.default_value = PM_QOS_CPU_FREQ_MIN_DEFAULT_VALUE,
> +	.type = PM_QOS_MAX,
> +	.notifiers = &cpu_freq_min_notifier,
> +};
> +static struct pm_qos_object cpu_freq_min_pm_qos = {
> +	.constraints = &cpu_freq_min_constraints,
> +	.name = "cpu_freq_min",
> +};
> +
> +
> +static BLOCKING_NOTIFIER_HEAD(cpu_freq_max_notifier);
> +static struct pm_qos_constraints cpu_freq_max_constraints = {
> +	.list = PLIST_HEAD_INIT(cpu_freq_max_constraints.list),
> +	.target_value = PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE,
> +	.default_value = PM_QOS_CPU_FREQ_MAX_DEFAULT_VALUE,
> +	.type = PM_QOS_MIN,
> +	.notifiers = &cpu_freq_max_notifier,
> +};
> +static struct pm_qos_object cpu_freq_max_pm_qos = {
> +	.constraints = &cpu_freq_max_constraints,
> +	.name = "cpu_freq_max",
> +};
> +
> +
>  static struct pm_qos_object *pm_qos_array[] = {
>  	&null_pm_qos,
>  	&cpu_dma_pm_qos,
>  	&network_lat_pm_qos,
> -	&network_throughput_pm_qos
> +	&network_throughput_pm_qos,
> +	&cpu_freq_min_pm_qos,
> +	&cpu_freq_max_pm_qos
>  };
>  
>  static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> -- 
> 1.7.4.1
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
