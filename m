From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/15] PM QoS: add a global notification
	mechanism for the device constraints
Date: Sun, 14 Aug 2011 23:50:41 +0200
Message-ID: <201108142350.42260.rjw__33071.6601609767$1313358614$gmane$org@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<1313075212-8366-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313075212-8366-8-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,

There is some code duplication in this patch that should better be
avoided (details below).

On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Add a global notification chain that gets called upon changes to the
> aggregated constraint value for any device.
> The notification callbacks are passing the full constraint request data
> in order for the callees to have access to it. The current use is for the
> platform low-level code to access the target device of the constraint.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  drivers/base/power/qos.c |  114 ++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/pm_qos.h   |   11 ++++
>  kernel/power/qos.c       |    2 +-
>  3 files changed, 113 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 465e419..4b0b316 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -8,6 +8,12 @@
>   *
>   * This QoS design is best effort based. Dependents register their QoS needs.
>   * Watchers register to keep track of the current QoS needs of the system.
> + * Watchers can register different types of notification callbacks:
> + *  . a per-device notification callback using the dev_pm_qos_*_notifier API.
> + *    The notification chain data is stored in the per-device constraint
> + *    data struct.
> + *  . a system-wide notification callback using the dev_pm_qos_*_global_notifier
> + *    API. The notification chain data is stored in a static variable.
>   *
>   * Note about the per-device constraint data struct allocation:
>   * . The per-device constraints data struct ptr is tored into the device
> @@ -41,6 +47,7 @@
>  #include <linux/kernel.h>
>  
>  
> +static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
>  static void dev_pm_qos_constraints_allocate(struct device *dev);
>  
>  int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
> @@ -64,6 +71,8 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_request_active);
>  void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
>  			    s32 value)
>  {
> +	int ret, curr_value;
> +
>  	if (!req) /*guard against callers passing in null */
>  		return;
>  
> @@ -82,8 +91,19 @@ void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
>  	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
>  		return;
>  
> -	pm_qos_update_target(dev->power.constraints,
> -			     &req->node, PM_QOS_ADD_REQ, value);

The following code:

> +	/*
> +	 * Update constraints list and call the per-device callbacks if needed
> +	 */
> +	ret = pm_qos_update_target(dev->power.constraints,
> +				   &req->node, PM_QOS_ADD_REQ, value);
> +
> +	if (ret) {
> +		/* Call the global callbacks if needed */
> +		curr_value = pm_qos_read_value(req->dev->power.constraints);
> +		blocking_notifier_call_chain(&dev_pm_notifiers,
> +					     (unsigned long)curr_value,
> +					     req);
> +	}

is used in dev_pm_qos_update_request() and dev_pm_qos_remove_request()
with the only difference being the command given to pm_qos_update_target().
This asks for a common function, eg. dev_pm_qos_update_target(), containing
that code that will be called by all of them (and, apparently, by
dev_pm_qos_constraints_destroy()).

...
> @@ -250,9 +329,18 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  			 * Update constraints list and call the per-device
>  			 * callbacks if needed
>  			 */
> -			pm_qos_update_target(req->dev->power.constraints,
> -					     &req->node, PM_QOS_REMOVE_REQ,
> -					     PM_QOS_DEFAULT_VALUE);
> +			ret |= pm_qos_update_target(req->dev->power.constraints,
> +						    &req->node,
> +						    PM_QOS_REMOVE_REQ,
> +						    PM_QOS_DEFAULT_VALUE);

I'm not sure why you're using the binary or operator here.  Shouldn't that be
a simple assignment?

> +
> +		if (ret) {
> +			/* Call the global callbacks if needed */
> +			curr_value = dev->power.constraints->default_value;
> +			blocking_notifier_call_chain(&dev_pm_notifiers,
> +						     (unsigned long)curr_value,
> +						     req);
> +		}
>  
>  		kfree(dev->power.constraints->notifiers);
>  		kfree(dev->power.constraints);

Thanks,
Rafael
