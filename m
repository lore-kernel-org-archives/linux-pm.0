From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 4/4] USB / PM: Allow USB devices to remain
 runtime-suspended when sleeping
Date: Fri, 16 Oct 2015 23:38:24 -0700
Message-ID: <20151017063824.GB13889@kroah.com>
References: <1444056332-30246-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444056332-30246-5-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:32861 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbJQGiY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2015 02:38:24 -0400
Content-Disposition: inline
In-Reply-To: <1444056332-30246-5-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 05, 2015 at 04:45:32PM +0200, Tomeu Vizoso wrote:
> Have dev_pm_ops.prepare return 1 for USB devices and ports so that USB
> devices can remain runtime-suspended when the system goes to a sleep
> state, if their wakeup state is correct and they have runtime PM enabled.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> 
>  drivers/usb/core/port.c |  6 ++++++
>  drivers/usb/core/usb.c  | 11 ++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 210618319f10..f49707d73b5a 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -168,12 +168,18 @@ static int usb_port_runtime_suspend(struct device *dev)
>  
>  	return retval;
>  }
> +
> +static int usb_port_prepare(struct device *dev)
> +{
> +	return 1;
> +}
>  #endif
>  
>  static const struct dev_pm_ops usb_port_pm_ops = {
>  #ifdef CONFIG_PM
>  	.runtime_suspend =	usb_port_runtime_suspend,
>  	.runtime_resume =	usb_port_runtime_resume,
> +	.prepare =		usb_port_prepare,
>  #endif
>  };
>  
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 8d5b2f4113cd..cf4dde11db1c 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -316,7 +316,16 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
>  
>  static int usb_dev_prepare(struct device *dev)
>  {
> -	return 0;		/* Implement eventually? */
> +	struct usb_device *udev = to_usb_device(dev);
> +
> +	if (!pm_runtime_enabled(dev))
> +		return 0;
> +
> +	/* Return 0 if the current wakeup setting is wrong, otherwise 1 */
> +	if (udev->do_remote_wakeup != device_may_wakeup(dev))
> +		return 0;
> +
> +	return 1;
>  }
>  
>  static void usb_dev_complete(struct device *dev)

I'll defer to Alan if this is correct or not.

Alan?
