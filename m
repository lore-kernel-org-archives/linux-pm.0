From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] PM / Runtime: let rpm_resume fail if rpm disabled
 and device suspended.
Date: Sat, 14 Jun 2014 10:32:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1406141020070.3986-100000@netrider.rowland.org>
References: <1402740209-16432-1-git-send-email-alleny@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:47700 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754683AbaFNOcJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Jun 2014 10:32:09 -0400
In-Reply-To: <1402740209-16432-1-git-send-email-alleny@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Allen Yu <alleny@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 14 Jun 2014, Allen Yu wrote:

> dev->power.is_suspended is set after core suspends device during system suspend.
> This flag mostly means device is not operational (all I/O been quiesced, no more
> data read or write acceptible, etc.), hence it's dangerous to access hardware if
> device is suspended even though runtime PM status is RPM_ACTIVE.
> 
> In turn, we should allow device to be accessed in case device is *not* suspended
> and runtime PM status is RPM_ACTIVE, even if runtime PM disabled. This corner case
> can happen to a device in a generic PM domain if the domain is not powered off while
> preparing for a system-wide power transition.

I don't understand.  Even if the PM domain isn't powered off, the
device's is_suspended flag will still be set by __device_suspend().

>  In this case, runtime PM status will
> be set to RPM_ACTIVE and then runtime PM is disabled. After that, device driver may
> call pm_runtime_get_sync() and rpm_resume() should return 1, because the device is
> still active as long as not been suspended.

Isn't that what the existing code does already?  Your patch seems to 
change it so that it _doesn't_ behave the way you want.

> Signed-off-by: Allen Yu <alleny@nvidia.com>
> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 67c7938..39885f1 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -608,7 +608,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>   repeat:
>  	if (dev->power.runtime_error)
>  		retval = -EINVAL;
> -	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> +	else if (dev->power.disable_depth == 1 && !dev->power.is_suspended
>  	    && dev->power.runtime_status == RPM_ACTIVE)
>  		retval = 1;

Alan Stern

