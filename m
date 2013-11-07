From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Runtime: Update documentation around probe|remove|suspend
Date: Thu, 7 Nov 2013 10:49:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1311071046040.1401-100000@iolanthe.rowland.org>
References: <1383817200-3004-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40422 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752435Ab3KGPty (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2013 10:49:54 -0500
In-Reply-To: <1383817200-3004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kevin Hilman <khilman@linaro.org>

On Thu, 7 Nov 2013, Ulf Hansson wrote:

> PM core and driver core has changed some behavior regarding use of
> runtime PM. Update the documentation accordingly.
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/power/runtime_pm.txt |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 0f54333..0f62cc7 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -547,13 +547,11 @@ helper functions described in Section 4.  In that case, pm_runtime_resume()
>  should be used.  Of course, for this purpose the device's runtime PM has to be
>  enabled earlier by calling pm_runtime_enable().
>  
> -If the device bus type's or driver's ->probe() callback runs
> -pm_runtime_suspend() or pm_runtime_idle() or their asynchronous counterparts,
> -they will fail returning -EAGAIN, because the device's usage counter is
> -incremented by the driver core before executing ->probe().  Still, it may be
> -desirable to suspend the device as soon as ->probe() has finished, so the driver
> -core uses pm_runtime_put_sync() to invoke the subsystem-level idle callback for
> -the device at that time.
> +It may be desirable to suspend the device once ->probe() has finished.
> +Therefore the driver core uses the asyncronous pm_request_idle() to submit a
> +request to execute the subsystem-level idle callback for the device at that
> +time.  A driver which make use of the runtime autosuspend feature, may want to

s/which make/that makes/
s/,//

> +update the last busy mark before it finalilizes it's ->probe().

s/it finalilizes it's/returning from/

>  Moreover, the driver core prevents runtime PM callbacks from racing with the bus
>  notifier callback in __device_release_driver(), which is necessary, because the
> @@ -632,7 +630,10 @@ The PM core always increments the runtime usage counter before calling the
>  Hence disabling runtime PM temporarily like this will not cause any runtime
>  suspend attempts to be permanently lost.  If the usage count goes to zero
>  following the return of the ->resume() callback, the ->runtime_idle() callback
> -will be invoked as usual.
> +will be invoked as usual.  Do note that PM core use the asyncronous
> +pm_runtime_put() when decrementing the usage counter, which means it don't wait
> +for the device to become inactive before it moves on and handles the next
> +device from the list.

I don't think we need to state this.  It shouldn't make any difference 
to drivers whether the runtime-put is synchronous or async.

Alan Stern

