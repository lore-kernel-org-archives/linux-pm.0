From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 3/7] PM: replace boolean arguments with bitflags
Date: Fri, 24 Sep 2010 00:19:45 +0200
Message-ID: <201009240019.45288.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009231718280.1667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009231718280.1667-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 23, 2010, Alan Stern wrote:
> The "from_wq" argument in __pm_runtime_suspend() and
> __pm_runtime_resume() supposedly indicates whether or not the function
> was called by the PM workqueue thread, but in fact it isn't always
> used this way.  It really indicates whether or not the function should
> return early if the requested operation is already in progress.
> 
> Along with this badly-named boolean argument, later patches in this
> series will add several other boolean arguments to these functions and
> others.  Therefore this patch (as1422) begins the conversion process
> by replacing from_wq with a bitflag argument.  The same bitflags are
> also used in __pm_runtime_get() and __pm_runtime_put(), where they
> indicate whether or not the operation should be asynchronous.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Index: usb-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm_runtime.h
> +++ usb-2.6/include/linux/pm_runtime.h
> @@ -12,6 +12,11 @@
>  #include <linux/device.h>
>  #include <linux/pm.h>
>  
> +/* Runtime PM flag argument bits */
> +#define RPM_ASYNC			0x01	/* Request is asynchronous */
> +#define RPM_RETURN_IF_IN_PROGRESS	0x02	/* Don't wait for concurrent
> +						    state change */

The name of this constant is kind of long. :-)

What about RPM_NOWAIT ?
...
> @@ -782,17 +783,18 @@ EXPORT_SYMBOL_GPL(pm_request_resume);
>  /**
>   * __pm_runtime_get - Reference count a device and wake it up, if necessary.
>   * @dev: Device to handle.
> - * @sync: If set and the device is suspended, resume it synchronously.
> + * @rpmflags: Flag bits.
>   *
>   * Increment the usage count of the device and resume it or submit a resume
> - * request for it, depending on the value of @sync.
> + * request for it, depending on the RPM_ASYNC flag bit.
>   */
> -int __pm_runtime_get(struct device *dev, bool sync)
> +int __pm_runtime_get(struct device *dev, int rpmflags)
>  {
>  	int retval;
>  
>  	atomic_inc(&dev->power.usage_count);
> -	retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> +	retval = (rpmflags & RPM_ASYNC ? pm_runtime_resume(dev)
> +	    : pm_request_resume(dev));

I think you should exchange pm_runtime_resume(dev) and pm_request_resume(dev).
Also, I'd slightly prefer the following coding style:

+	retval = (rpmflags & RPM_ASYNC) ?
+		pm_request_resume(dev) : pm_runtime_resume(dev);

>  	return retval;
>  }
> @@ -801,18 +803,19 @@ EXPORT_SYMBOL_GPL(__pm_runtime_get);
>  /**
>   * __pm_runtime_put - Decrement the device's usage counter and notify its bus.
>   * @dev: Device to handle.
> - * @sync: If the device's bus type is to be notified, do that synchronously.
> + * @rpmflags: Flag bits.
>   *
>   * Decrement the usage count of the device and if it reaches zero, carry out a
>   * synchronous idle notification or submit an idle notification request for it,
> - * depending on the value of @sync.
> + * depending on the RPM_ASYNC flag bit.
>   */
> -int __pm_runtime_put(struct device *dev, bool sync)
> +int __pm_runtime_put(struct device *dev, int rpmflags)
>  {
>  	int retval = 0;
>  
>  	if (atomic_dec_and_test(&dev->power.usage_count))
> -		retval = sync ? pm_runtime_idle(dev) : pm_request_idle(dev);
> +		retval = (rpmflags & RPM_ASYNC ? pm_runtime_idle(dev)
> +		    : pm_request_idle(dev));

And analogously here.

Thanks,
Rafael
