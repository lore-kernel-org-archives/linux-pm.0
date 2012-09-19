From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM QoS: Use spinlock in the per-device PM
	QoS constraints code
Date: Wed, 19 Sep 2012 14:31:50 +0200
Message-ID: <201209191431.50670.rjw@sisk.pl>
References: <1348046283-2495-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1348046283-2495-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-pm@lists.linux-foundation.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 19, 2012, Jean Pihet wrote:
> The per-device PM QoS locking requires a spinlock to be used. The reasons
> are:
> - an alignement with the PM QoS core code, which is used by the per-device
>   PM QoS code for the constraints lists management. The PM QoS core code
>   uses spinlocks to protect the constraints lists,
> - some drivers need to use the per-device PM QoS functionality from
>   interrupt context or spinlock protected context.
>   An example of such a driver is the OMAP HSI (high-speed synchronous serial
>   interface) driver which needs to control the IP block idle state
>   depending on the FIFO empty state, from interrupt context.
> 
> Reported-by: Djamil Elaidi <d-elaidi@ti.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Applied to the linux-next branch of the linux-pm.git tree as v3.7 material.

Next time please send CCs to linux-pm@vger.kernel.org instead of the
Linux Foundation list (of the same name), which has been abandoned.

Thanks,
Rafael


> ---
>  drivers/base/power/qos.c |   67 ++++++++++++++++++++++++++++------------------
>  1 files changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 74a67e0..968a771 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -24,26 +24,32 @@
>   *  . a system-wide notification callback using the dev_pm_qos_*_global_notifier
>   *    API. The notification chain data is stored in a static variable.
>   *
> - * Note about the per-device constraint data struct allocation:
> - * . The per-device constraints data struct ptr is tored into the device
> + * Notes about the per-device constraint data struct allocation:
> + * . The per-device constraints data struct ptr is stored into the device
>   *    dev_pm_info.
>   * . To minimize the data usage by the per-device constraints, the data struct
> - *   is only allocated at the first call to dev_pm_qos_add_request.
> + *    is only allocated at the first call to dev_pm_qos_add_request.
>   * . The data is later free'd when the device is removed from the system.
> - *  . A global mutex protects the constraints users from the data being
> - *     allocated and free'd.
> + *
> + * Notes about locking:
> + * . The dev->power.lock lock protects the constraints list
> + *    (dev->power.constraints) allocation and free, as triggered by the
> + *   driver core code at device insertion and removal,
> + * . A global lock dev_pm_qos_lock protects the constraints list entries
> + *    from any modification and the notifiers registration and unregistration.
> + * . For both locks a spinlock is needed since this code can be called from
> + *    interrupt context or spinlock protected context.
>   */
>  
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
> -#include <linux/mutex.h>
>  #include <linux/export.h>
>  
>  #include "power.h"
>  
> -static DEFINE_MUTEX(dev_pm_qos_mtx);
> +static DEFINE_SPINLOCK(dev_pm_qos_lock);
>  
>  static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
>  
> @@ -110,18 +116,19 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>   * @dev: device to allocate data for
>   *
>   * Called at the first call to add_request, for constraint data allocation
> - * Must be called with the dev_pm_qos_mtx mutex held
> + * Must be called with the dev_pm_qos_lock lock held
>   */
>  static int dev_pm_qos_constraints_allocate(struct device *dev)
>  {
>  	struct pm_qos_constraints *c;
>  	struct blocking_notifier_head *n;
> +	unsigned long flags;
>  
> -	c = kzalloc(sizeof(*c), GFP_KERNEL);
> +	c = kzalloc(sizeof(*c), GFP_ATOMIC);
>  	if (!c)
>  		return -ENOMEM;
>  
> -	n = kzalloc(sizeof(*n), GFP_KERNEL);
> +	n = kzalloc(sizeof(*n), GFP_ATOMIC);
>  	if (!n) {
>  		kfree(c);
>  		return -ENOMEM;
> @@ -134,9 +141,9 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>  	c->type = PM_QOS_MIN;
>  	c->notifiers = n;
>  
> -	spin_lock_irq(&dev->power.lock);
> +	spin_lock_irqsave(&dev->power.lock, flags);
>  	dev->power.constraints = c;
> -	spin_unlock_irq(&dev->power.lock);
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
>  
>  	return 0;
>  }
> @@ -150,10 +157,12 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>   */
>  void dev_pm_qos_constraints_init(struct device *dev)
>  {
> -	mutex_lock(&dev_pm_qos_mtx);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev_pm_qos_lock, flags);
>  	dev->power.constraints = NULL;
>  	dev->power.power_state = PMSG_ON;
> -	mutex_unlock(&dev_pm_qos_mtx);
> +	spin_unlock_irqrestore(&dev_pm_qos_lock, flags);
>  }
>  
>  /**
> @@ -166,6 +175,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  {
>  	struct dev_pm_qos_request *req, *tmp;
>  	struct pm_qos_constraints *c;
> +	unsigned long flags;
>  
>  	/*
>  	 * If the device's PM QoS resume latency limit has been exposed to user
> @@ -173,7 +183,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  	 */
>  	dev_pm_qos_hide_latency_limit(dev);
>  
> -	mutex_lock(&dev_pm_qos_mtx);
> +	spin_lock_irqsave(&dev_pm_qos_lock, flags);
>  
>  	dev->power.power_state = PMSG_INVALID;
>  	c = dev->power.constraints;
> @@ -198,7 +208,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  	kfree(c);
>  
>   out:
> -	mutex_unlock(&dev_pm_qos_mtx);
> +	spin_unlock_irqrestore(&dev_pm_qos_lock, flags);
>  }
>  
>  /**
> @@ -223,6 +233,7 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
>  			   s32 value)
>  {
>  	int ret = 0;
> +	unsigned long flags;
>  
>  	if (!dev || !req) /*guard against callers passing in null */
>  		return -EINVAL;
> @@ -233,7 +244,7 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
>  
>  	req->dev = dev;
>  
> -	mutex_lock(&dev_pm_qos_mtx);
> +	spin_lock_irqsave(&dev_pm_qos_lock, flags);
>  
>  	if (!dev->power.constraints) {
>  		if (dev->power.power_state.event == PM_EVENT_INVALID) {
> @@ -255,7 +266,7 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
>  		ret = apply_constraint(req, PM_QOS_ADD_REQ, value);
>  
>   out:
> -	mutex_unlock(&dev_pm_qos_mtx);
> +	spin_unlock_irqrestore(&dev_pm_qos_lock, flags);
>  
>  	return ret;
>  }
> @@ -280,6 +291,7 @@ int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>  			      s32 new_value)
>  {
>  	int ret = 0;
> +	unsigned long flags;
>  
>  	if (!req) /*guard against callers passing in null */
>  		return -EINVAL;
> @@ -288,7 +300,7 @@ int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>  		 "%s() called for unknown object\n", __func__))
>  		return -EINVAL;
>  
> -	mutex_lock(&dev_pm_qos_mtx);
> +	spin_lock_irqsave(&dev_pm_qos_lock, flags);
>  
>  	if (req->dev->power.constraints) {
>  		if (new_value != req->node.prio)
> @@ -299,7 +311,7 @@ int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>  		ret = -ENODEV;
>  	}
>  
> -	mutex_unlock(&dev_pm_qos_mtx);
> +	spin_unlock_irqrestore(&dev_pm_qos_lock, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_update_request);
> @@ -319,6 +331,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_update_request);
>  int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
>  {
>  	int ret = 0;
> +	unsigned long flags;
>  
>  	if (!req) /*guard against callers passing in null */
>  		return -EINVAL;
> @@ -327,7 +340,7 @@ int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
>  		 "%s() called for unknown object\n", __func__))
>  		return -EINVAL;
>  
> -	mutex_lock(&dev_pm_qos_mtx);
> +	spin_lock_irqsave(&dev_pm_qos_lock, flags);
>  
>  	if (req->dev->power.constraints) {
>  		ret = apply_constraint(req, PM_QOS_REMOVE_REQ,
> @@ -338,7 +351,7 @@ int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
>  		ret = -ENODEV;
>  	}
>  
> -	mutex_unlock(&dev_pm_qos_mtx);
> +	spin_unlock_irqrestore(&dev_pm_qos_lock, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
> @@ -359,8 +372,9 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
>  int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
>  {
>  	int ret = 0;
> +	unsigned long flags;
>  
> -	mutex_lock(&dev_pm_qos_mtx);
> +	spin_lock_irqsave(&dev_pm_qos_lock, flags);
>  
>  	if (!dev->power.constraints)
>  		ret = dev->power.power_state.event != PM_EVENT_INVALID ?
> @@ -370,7 +384,7 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
>  		ret = blocking_notifier_chain_register(
>  				dev->power.constraints->notifiers, notifier);
>  
> -	mutex_unlock(&dev_pm_qos_mtx);
> +	spin_unlock_irqrestore(&dev_pm_qos_lock, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
> @@ -389,8 +403,9 @@ int dev_pm_qos_remove_notifier(struct device *dev,
>  			       struct notifier_block *notifier)
>  {
>  	int retval = 0;
> +	unsigned long flags;
>  
> -	mutex_lock(&dev_pm_qos_mtx);
> +	spin_lock_irqsave(&dev_pm_qos_lock, flags);
>  
>  	/* Silently return if the constraints object is not present. */
>  	if (dev->power.constraints)
> @@ -398,7 +413,7 @@ int dev_pm_qos_remove_notifier(struct device *dev,
>  				dev->power.constraints->notifiers,
>  				notifier);
>  
> -	mutex_unlock(&dev_pm_qos_mtx);
> +	spin_unlock_irqrestore(&dev_pm_qos_lock, flags);
>  	return retval;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
> 
