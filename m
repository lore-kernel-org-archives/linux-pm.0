From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v4 2/3] PM / sleep: Go direct_complete if driver has no
 callbacks
Date: Wed, 15 Jul 2015 14:47:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507151444460.18896-100000@netrider.rowland.org>
References: <1436964008-15151-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:47566 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752329AbbGOSrv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 14:47:51 -0400
In-Reply-To: <1436964008-15151-3-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

On Wed, 15 Jul 2015, Tomeu Vizoso wrote:

> If a suitable prepare callback cannot be found for a given device and
> its driver has no PM callbacks at all, assume that it can go direct to
> complete when the system goes to sleep.
> 
> The reason for this is that there's lots of devices in a system that do
> no PM at all and there's no reason for them to prevent their ancestors
> to do direct_complete if they can support it.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
>  drivers/base/power/main.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 1710c26ba097..edda3f233c7c 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1540,6 +1540,21 @@ int dpm_suspend(pm_message_t state)
>  	return error;
>  }
>  
> +static bool driver_has_no_pm_callbacks(struct device_driver *drv)
> +{
> +	if (!drv->pm)
> +		return true;
> +
> +	return !drv->pm->prepare &&
> +	       !drv->pm->suspend &&
> +	       !drv->pm->suspend_late &&
> +	       !drv->pm->suspend_noirq &&
> +	       !drv->pm->resume_noirq &&
> +	       !drv->pm->resume_early &&
> +	       !drv->pm->resume &&
> +	       !drv->pm->complete;
> +}

This isn't exactly what I meant.  We also need to check the dev_pm_ops 
fields in dev->pm_domain, dev->type, dev->class, and dev->bus.  Only if 
_all_ of these callbacks are missing should we use direct_complete.

Alan Stern

