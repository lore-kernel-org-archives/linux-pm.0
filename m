From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: check for complete cb before device lock in dpm_complete
Date: Fri, 5 Jun 2015 11:04:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1506051055450.2043-100000@iolanthe.rowland.org>
References: <20150604220802.GA20494@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41544 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422712AbbFEPEn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2015 11:04:43 -0400
In-Reply-To: <20150604220802.GA20494@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, todd.e.brandt@intel.com

On Thu, 4 Jun 2015, Todd E Brandt wrote:

> Hi Alan, I actually did that for my initial version of the patch but then
> reconsidered. I was assuming someone would have an issue with reading
> the callback while the device isn't locked. Below is the first version. It
> has the exact same effect as the one in the top of the thread. Is this 
> something that looks ok to you?
> 
> First version of the patch:
> 
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> ---
>  drivers/base/power/main.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3d874ec..b6a0e20 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -897,8 +897,6 @@ static void device_complete(struct device *dev, pm_message_t state)
>  	if (dev->power.syscore)
>  		return;
>  
> -	device_lock(dev);
> -
>  	if (dev->pm_domain) {
>  		info = "completing power domain ";
>  		callback = dev->pm_domain->ops.complete;
> @@ -918,12 +916,15 @@ static void device_complete(struct device *dev, pm_message_t state)
>  		callback = dev->driver->pm->complete;
>  	}
>  
> -	if (callback) {
> -		pm_dev_dbg(dev, state, info);
> -		trace_device_pm_callback_start(dev, info, state.event);
> -		callback(dev);
> -		trace_device_pm_callback_end(dev, 0);
> -	}
> +	if (!callback)
> +		return;
> +
> +	device_lock(dev);
> +
> +	pm_dev_dbg(dev, state, info);
> +	trace_device_pm_callback_start(dev, info, state.event);
> +	callback(dev);
> +	trace_device_pm_callback_end(dev, 0);
>  
>  	device_unlock(dev);

Well, this isn't quite right because we don't want to skip the 
pm_runtime_put(dev) that's just below the bottom of the patch.

More to the point, this does have a race with unregistration.  In
theory you could determine what "callback" is, and then another thread
could unregister the device (including its PM callbacks) before the
lock is acquired.  I don't know if that's liable to come up in
practice, although with asynchronous complete callbacks I suppose it
might.

A safer approach would work as follows: Figure out what "callback" is, 
and if it is NULL then skip the rest.  If it isn't, then lock the 
device, recompute "callback", and continue on like the existing 
routine.  This involves duplicating the computation of "callback", but 
that can be moved into a separate subroutine, so it's not so terrible.

Alan Stern

