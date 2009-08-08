From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/05] PM: Runtime PM v13 - add debug
	printouts
Date: Sat, 8 Aug 2009 15:28:45 +0200
Message-ID: <200908081528.45184.rjw@sisk.pl>
References: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
	<20090807073342.22479.85640.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090807073342.22479.85640.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

On Friday 07 August 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds dev_dbg() printouts to the Runtime PM
> code. Just add a #define DEBUG at the top of the file
> to get suspend and resume printouts. Also add a missing
> newline to the pm_runtime_enable() printout while at it.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Can this patch be rolled into the main Runtime PM patch?

Yes, I've just folded it into the runtime PM patch, with some minor modifications.

Thanks,
Rafael


>  Changes for v11->v13:
>  - solved conflicts introduced by v11->v13 update
> 
>  drivers/base/power/runtime.c |   32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> --- 0009/drivers/base/power/runtime.c
> +++ work/drivers/base/power/runtime.c	2009-08-07 13:55:20.000000000 +0900
> @@ -125,13 +125,19 @@ int __pm_runtime_suspend(struct device *
>  	bool notify = false;
>  	int retval = 0;
>  
> +	dev_dbg(dev, "__pm_runtime_suspend() %d!\n", from_wq);
>   repeat:
> -	if (dev->power.runtime_error)
> -		return -EINVAL;
> +	if (dev->power.runtime_error) {
> +		retval = -EINVAL;
> +		goto out;
> +	}
>  
>  	/* Pending resume requests take precedence over us. */
> -	if (dev->power.request_pending && dev->power.request == RPM_REQ_RESUME)
> -			return -EAGAIN;
> +	if (dev->power.request_pending
> +	    && dev->power.request == RPM_REQ_RESUME) {
> +		retval = -EAGAIN;
> +		goto out;
> +	}
>  
>  	/* Other scheduled or pending requests need to be canceled. */
>  	pm_runtime_cancel_pending(dev);
> @@ -145,13 +151,15 @@ int __pm_runtime_suspend(struct device *
>  	else if (!pm_children_suspended(dev))
>  		retval = -EBUSY;
>  	if (retval)
> -		return retval;
> +		goto out;
>  
>  	if (dev->power.runtime_status == RPM_SUSPENDING) {
>  		DEFINE_WAIT(wait);
>  
> -		if (from_wq)
> -			return -EINPROGRESS;
> +		if (from_wq) {
> +			retval = -EINPROGRESS;
> +			goto out;
> +		}
>  
>  		/* Wait for the other suspend running in parallel with us. */
>  		for (;;) {
> @@ -200,7 +208,8 @@ int __pm_runtime_suspend(struct device *
>  	if (dev->power.deferred_resume) {
>  		dev->power.deferred_resume = false;
>  		__pm_runtime_resume(dev, false);
> -		return -EAGAIN;
> +		retval = -EAGAIN;
> +		goto out;
>  	}
>  
>  	if (notify)
> @@ -213,6 +222,8 @@ int __pm_runtime_suspend(struct device *
>  
>  		spin_lock_irq(&dev->power.lock);
>  	}
> + out:
> +	dev_dbg(dev, "__pm_runtime_suspend() returns %d!\n", retval);
>  
>  	return retval;
>  }
> @@ -252,6 +263,7 @@ int __pm_runtime_resume(struct device *d
>  	struct device *parent = NULL;
>  	int retval = 0;
>  
> +	dev_dbg(dev, "__pm_runtime_resume() %d!\n", from_wq);
>   repeat:
>  	if (dev->power.runtime_error) {
>  		retval = -EINVAL;
> @@ -358,6 +370,8 @@ int __pm_runtime_resume(struct device *d
>  		spin_lock_irq(&dev->power.lock);
>  	}
>  
> +	dev_dbg(dev, "__pm_runtime_resume() returns %d!\n", retval);
> +
>  	return retval;
>  }
>  
> @@ -795,7 +809,7 @@ void pm_runtime_enable(struct device *de
>  	if (dev->power.disable_depth > 0)
>  		dev->power.disable_depth--;
>  	else
> -		dev_warn(dev, "Unbalanced %s!", __func__);
> +		dev_warn(dev, "Unbalanced %s!\n", __func__);
>  
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
>  }
> 
