From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: allow for usage_count > 0 in
 pm_runtime_get()
Date: Thu, 3 Dec 2009 12:47:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912031235560.4795-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0912021110310.11361-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912021110310.11361-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Dec 2009, Alan Stern wrote:

> This patch (as1308b) fixes __pm_runtime_get().  Currently the routine
> will resume a device if the prior usage count was 0.  But this isn't
> right; thanks to pm_runtime_get_noresume() the usage count can be
> positive even while the device is suspended.
> 
> Now the routine always tries to carry out a resume when called
> synchronously.  When called asynchronously, it avoids the overhead of
> an unnecessary spinlock acquisition by doing the resume only if the
> device's state was SUSPENDING or SUSPENDED.  Since the access to the
> state is unprotected, be careful to read the value only once.

...

>  int __pm_runtime_get(struct device *dev, bool sync)
>  {
> -	int retval = 1;
> +	int retval = 0;
>  
> -	if (atomic_add_return(1, &dev->power.usage_count) == 1)
> -		retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> +	atomic_inc(&dev->power.usage_count);
> +	if (sync) {
> +		retval = pm_runtime_resume(dev);
> +	} else {
> +		enum rpm_status s = ACCESS_ONCE(dev->power.runtime_status);
>  
> +		if (s == RPM_SUSPENDING || s == RPM_SUSPENDED)
> +			retval = pm_request_resume(dev);
> +	}
>  	return retval;
>  }

I wonder whether this is really a good thing to do.  It changes the
semantics in the async case where the device is already active.  The
old code would cancel a pending or scheduled suspend request, whereas
the new code will leave it alone.

My feeling was that an atomic routine would most likely do its work and
then schedule a new suspend request before the old one expired, so it
wouldn't matter if the old request wasn't cancelled.  Still, some
drivers might have their own preferences.

Of course, this is just a convenient utility routine.  Anybody can 
simply do

	pm_runtime_get_noresume(dev);
	switch (ACCESS_ONCE(dev->power.runtime_status)) {
	case RPM_SUSPENDING:
	case RPM_SUSPENDED:
		pm_request_resume(dev);
	default:
	}

and obtain the same effect.  So I don't know...  Should
pm_runtime_get() call pm_request_resume() always, or only when the
state is SUSPENDING or SUSPENDED?  Should we offer two routines and let
people choose which they want?

Alan Stern
