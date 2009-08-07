From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH update x2] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 13)
Date: Fri, 7 Aug 2009 11:41:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908071130440.3063-100000__42917.5603473142$1249659900$gmane$org@iolanthe.rowland.org>
References: <200908062353.14822.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908062353.14822.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Aug 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> The patch below should address all of your most recent comments.

Only two comments.


> +static int __pm_request_idle(struct device *dev)
> +{
...
> +	if (dev->power.request_pending) {
> +		/* Any requests other then RPM_REQ_IDLE take precedence. */
> +		if (dev->power.request != RPM_REQ_NONE)

Replace != with ==.

> +			dev->power.request = RPM_REQ_IDLE;
> +		else if (dev->power.request != RPM_REQ_IDLE)
> +			retval = -EAGAIN;
> +		return retval;


> --- linux-2.6.orig/drivers/base/dd.c
> +++ linux-2.6/drivers/base/dd.c
...
> @@ -306,6 +317,8 @@ static void __device_release_driver(stru
>  
>  	drv = dev->driver;
>  	if (drv) {
> +		pm_runtime_disable(dev);
> +
>  		driver_sysfs_remove(dev);
>  
>  		if (dev->bus)
> @@ -324,6 +337,8 @@ static void __device_release_driver(stru
>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  						     BUS_NOTIFY_UNBOUND_DRIVER,
>  						     dev);
> +
> +		pm_runtime_enable(dev);
>  	}
>  }

We may need to be more careful here.  The driver's remove method may
want to do some runtime PM stuff to the device before giving up
control.  On the other hand I'm not sure what _should_ be done here, so
I can't suggest anything better.

Alan Stern
