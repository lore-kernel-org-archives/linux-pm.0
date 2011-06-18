From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Sun, 19 Jun 2011 01:57:31 +0200
Message-ID: <201106190157.31526.rjw__48952.7610982352$1308441483$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106181123050.29370-100000@netrider.rowland.org>
	<201106182301.04090.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106182301.04090.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, June 18, 2011, Rafael J. Wysocki wrote:
> On Saturday, June 18, 2011, Alan Stern wrote:
> > On Sat, 18 Jun 2011, Rafael J. Wysocki wrote:
...
> 
> Well, assuming that https://patchwork.kernel.org/patch/893722/ is applied,
> which is going to be, I think we can put
> 
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_enable(dev);
> 
> in device_resume() after the dev->power.is_suspended check and
> pm_runtime_put_noidle() under the End label.  That cause them to
> be called under the device lock, but that shouldn't be a big deal.
> 
> Accordingly, we can call pm_runtime_disable(dev) in __device_suspend(),
> right next to the setting of power.is_suspended.
> 
> This is implemented by the patch below.

Well, it hangs suspend on my Toshiba test box, I'm not sure why exactly.

This happens even if the pm_runtime_disable() is replaced with a version
that only increments the disable depth, so it looks like something down
the road relies on disable_depth being zero.  Which is worrisome.

Trying to figure out what the problem is I noticed that, for example,
the generic PM operations use pm_runtime_suspended() to decide whether or
not to execute system suspend callbacks, so the patch below would break it.

Also, after commit e8665002477f0278f84f898145b1f141ba26ee26 the
pm_runtime_suspended() check in __pm_generic_call() doesn't really make
sense.

Thanks,
Rafael


> ---
>  drivers/base/power/main.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -521,6 +521,9 @@ static int device_resume(struct device *
>  	if (!dev->power.is_suspended)
>  		goto Unlock;
>  
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +
>  	if (dev->pwr_domain) {
>  		pm_dev_dbg(dev, state, "power domain ");
>  		error = pm_op(dev, &dev->pwr_domain->ops, state);
> @@ -557,6 +560,7 @@ static int device_resume(struct device *
>  
>   End:
>  	dev->power.is_suspended = false;
> +	pm_runtime_put_noidle(dev);
>  
>   Unlock:
>  	device_unlock(dev);
> @@ -888,7 +892,10 @@ static int __device_suspend(struct devic
>  	}
>  
>   End:
> -	dev->power.is_suspended = !error;
> +	if (!error) {
> +		dev->power.is_suspended = true;
> +		pm_runtime_disable(dev);
> +	}
>  
>   Unlock:
>  	device_unlock(dev);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
