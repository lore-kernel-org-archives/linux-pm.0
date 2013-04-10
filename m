From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND PATCH] PM / Runtime: Idle devices asynchronously after probe|release
Date: Wed, 10 Apr 2013 21:05:30 +0200
Message-ID: <2251384.jZjddUxBss@vostro.rjw.lan>
References: <1365606048-27603-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55614 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab3DJS5p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Apr 2013 14:57:45 -0400
In-Reply-To: <1365606048-27603-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wednesday, April 10, 2013 05:00:48 PM Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Putting devices into idle|suspend in a synchronous manner means we are
> waiting for each device to become idle|suspended before the probe|release
> is fully done.
> 
> This patch switch to use the asynchronous runtime PM API:s instead and
> thus improves the parallelism since we can move on and handle the next
> device in queue in an earlier phase.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/dd.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index bb5645e..35fa368 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -380,7 +380,7 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  
>  	pm_runtime_barrier(dev);
>  	ret = really_probe(dev, drv);
> -	pm_runtime_idle(dev);
> +	pm_request_idle(dev);
>  
>  	return ret;
>  }
> @@ -428,7 +428,7 @@ int device_attach(struct device *dev)
>  		}
>  	} else {
>  		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
> -		pm_runtime_idle(dev);
> +		pm_request_idle(dev);
>  	}
>  out_unlock:
>  	device_unlock(dev);
> @@ -499,7 +499,7 @@ static void __device_release_driver(struct device *dev)
>  						     BUS_NOTIFY_UNBIND_DRIVER,
>  						     dev);
>  
> -		pm_runtime_put_sync(dev);
> +		pm_runtime_put(dev);
>  
>  		if (dev->bus && dev->bus->remove)
>  			dev->bus->remove(dev);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
