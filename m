From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Sun, 13 Dec 2009 23:37:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912132331420.9109-100000@netrider.rowland.org>
References: <200912140103.23415.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912140103.23415.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Dec 2009, Rafael J. Wysocki wrote:

> There you go (untested for now).
> 
> ->runtime_idle() is still only called for the device's bus type, because
> otherwise it will be hard to determine the right ordering of the bus type,
> device type and device class callbacks.

Shouldn't it be the same as runtime_suspend and runtime_resume?

>  drivers/base/power/runtime.c       |  110 ++++++++++++++++---
>  2 files changed, 201 insertions(+), 113 deletions(-)
> 
> Index: linux-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/runtime.c
> +++ linux-2.6/drivers/base/power/runtime.c
> @@ -111,6 +111,45 @@ int pm_runtime_idle(struct device *dev)
>  EXPORT_SYMBOL_GPL(pm_runtime_idle);
>  
>  /**
> + * device_runtime_suspend - Execute "runtime suspend" callbacks for a device.
> + * @dev: Device to handle.
> + * @error_ptr: Place to store error values returned by the callbacks.
> + */
> +static int device_runtime_suspend(struct device *dev, int *error_ptr)
> +{
> +	int error = -ENOSYS;
> +
> +	down(&dev->sem);
> +
> +	if (dev->class && dev->class->pm && dev->class->pm->runtime_suspend) {
> +		error = dev->class->pm->runtime_suspend(dev);
> +		suspend_report_result(dev->class->pm->runtime_suspend, error);
> +		*error_ptr = error;
> +		if (error)
> +			goto out;
> +	}
> +
> +	if (dev->type && dev->type->pm && dev->type->pm->runtime_suspend) {
> +		error = dev->type->pm->runtime_suspend(dev);
> +		suspend_report_result(dev->type->pm->runtime_suspend, error);
> +		*error_ptr = error;
> +		if (error)
> +			goto out;
> +	}
> +
> +	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
> +		error = dev->bus->pm->runtime_suspend(dev);
> +		suspend_report_result(dev->bus->pm->runtime_suspend, error);
> +		*error_ptr = error;
> +	}
> +
> + out:
> +	up(&dev->sem);
> +
> +	return error;
> +}

What's the reason for error_ptr here?  Its value will always be the
same as the return value except in the case where none of the callbacks
are defined.  Why not just use -ENOSYS in that case and eliminate
error_ptr?

Alan Stern
