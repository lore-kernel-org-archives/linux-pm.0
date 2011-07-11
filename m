From: Kevin Hilman <khilman@ti.com>
Subject: Re: [Update][PATCH 6/10] PM / Domains: System-wide
	transitions support for generic domains (v5)
Date: Mon, 11 Jul 2011 08:37:19 -0700
Message-ID: <87oc10zv4g.fsf__40420.9435605027$1310398836$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1107081033000.2208-100000@iolanthe.rowland.org>
	<201107082006.49660.rjw@sisk.pl> <201107082124.24921.rjw@sisk.pl>
	<201107091615.38915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107091615.38915.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 9 Jul 2011 16:15:38 +0200")
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[...]

>
> There's one more case to consider, namely devices that are runtime
> suspended, set up to wake up the system from sleep states
> (ie. device_may_wakeup(dev) returns "true") and such that
> genpd->active_wakeup(dev) returns "true" for them, because they need
> to be resumed at this point too (arguably, it makes a little sense to
> runtime suspend such devices, but that's possible in principle).
>
> So, IMO, the patch should look like this:
>
> ---
>  drivers/base/power/domain.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
>> Index: linux-2.6/drivers/base/power/domain.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/domain.c
> +++ linux-2.6/drivers/base/power/domain.c
> @@ -486,6 +486,22 @@ static void pm_genpd_sync_poweroff(struc
>  }
>  
>  /**
> + * resume_needed - Check whether to resume a device before system suspend.
> + * @dev: Device to handle.
> + * @genpd: PM domain the device belongs to.
> + */
> +static bool resume_needed(struct device *dev, struct generic_pm_domain *genpd)
> +{
> +	bool active_wakeup;
> +
> +	if (!device_can_wakeup(dev))
> +		return false;
> +
> +	active_wakeup = genpd->active_wakeup && genpd->active_wakeup(dev);
> +	return device_may_wakeup(dev) ? active_wakeup : !active_wakeup;

This also returns true and causes a resume if active_wakeup = false and
device_may_wakeup() = false.  That doesn't seem right.

> +}
> +
> +/**
>   * pm_genpd_prepare - Start power transition of a device in a PM domain.
>   * @dev: Device to start the transition of.
>   *
> @@ -519,6 +535,9 @@ static int pm_genpd_prepare(struct devic
>  		return -EBUSY;
>  	}
>  
> +	if (resume_needed(dev, genpd))
> +		pm_runtime_resume(dev);
> +
>  	genpd_acquire_lock(genpd);
>  
>  	if (genpd->prepared_count++ == 0)

IIUC, if a device is runtime suspended when a system suspend happens,
the device will be runtime resumed, but never re-suspended.

Should resumes by the PM core be done with a get (and a corresponding
put in .complete())?

Kevin
