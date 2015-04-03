From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 7/7] USB / PM: Allow USB devices to remain
 runtime-suspended when sleeping
Date: Fri, 3 Apr 2015 13:44:36 -0700
Message-ID: <20150403204436.GB19867@dtor-ws>
References: <1428065887-16017-1-git-send-email-tomeu.vizoso@collabora.com>
 <1428065887-16017-8-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36962 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbDCUol (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 16:44:41 -0400
Content-Disposition: inline
In-Reply-To: <1428065887-16017-8-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scot Doyle <lkml14@scotdoyle.com>, Alan Stern <stern@rowland.harvard.edu>, Dan Williams <dan.j.williams@intel.com>, Julius Werner <jwerner@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Pratyush Anand <pratyush.anand@st.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Tomeu,

On Fri, Apr 03, 2015 at 02:57:56PM +0200, Tomeu Vizoso wrote:
> Have dev_pm_ops.prepare return 1 for USB devices, interfaces, endpoints
> and ports so that USB devices can remain runtime-suspended when the
> system goes to a sleep state, if their wakeup state is correct.
> 
> Also enable runtime PM for endpoints, which is another requirement for
> the above to work.

After patching I think the 4th unrelated subsystem with stubs for
prepare() I think it is pretty clear that this approach is not the right
one.

If your driver does not care about any children hanging off it there is
dev->ignore_children flag that either already does what you want, or
maybe needs adjusted to support your use case.

Thanks.

> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/usb/core/endpoint.c | 17 +++++++++++++++++
>  drivers/usb/core/message.c  | 16 ++++++++++++++++
>  drivers/usb/core/port.c     |  6 ++++++
>  drivers/usb/core/usb.c      |  8 +++++++-
>  4 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
> index 39a2402..7c82bb7 100644
> --- a/drivers/usb/core/endpoint.c
> +++ b/drivers/usb/core/endpoint.c
> @@ -160,6 +160,19 @@ static const struct attribute_group *ep_dev_groups[] = {
>  	NULL
>  };
>  
> +#ifdef	CONFIG_PM
> +
> +static int usb_ep_device_prepare(struct device *dev)
> +{
> +	return 1;
> +}
> +
> +static const struct dev_pm_ops usb_ep_device_pm_ops = {
> +	.prepare =	usb_ep_device_prepare,
> +};
> +
> +#endif	/* CONFIG_PM */
> +
>  static void ep_device_release(struct device *dev)
>  {
>  	struct ep_device *ep_dev = to_ep_device(dev);
> @@ -170,6 +183,9 @@ static void ep_device_release(struct device *dev)
>  struct device_type usb_ep_device_type = {
>  	.name =		"usb_endpoint",
>  	.release = ep_device_release,
> +#ifdef CONFIG_PM
> +	.pm =		&usb_ep_device_pm_ops,
> +#endif
>  };
>  
>  int usb_create_ep_devs(struct device *parent,
> @@ -197,6 +213,7 @@ int usb_create_ep_devs(struct device *parent,
>  		goto error_register;
>  
>  	device_enable_async_suspend(&ep_dev->dev);
> +	pm_runtime_enable(&ep_dev->dev);
>  	endpoint->ep_dev = ep_dev;
>  	return retval;
>  
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index f368d20..9041aee 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1589,10 +1589,26 @@ static int usb_if_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +#ifdef	CONFIG_PM
> +
> +static int usb_if_prepare(struct device *dev)
> +{
> +	return 1;
> +}
> +
> +static const struct dev_pm_ops usb_if_pm_ops = {
> +	.prepare =	usb_if_prepare,
> +};
> +
> +#endif	/* CONFIG_PM */
> +
>  struct device_type usb_if_device_type = {
>  	.name =		"usb_interface",
>  	.release =	usb_release_interface,
>  	.uevent =	usb_if_uevent,
> +#ifdef CONFIG_PM
> +	.pm =		&usb_if_pm_ops,
> +#endif
>  };
>  
>  static struct usb_interface_assoc_descriptor *find_iad(struct usb_device *dev,
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 2106183..f49707d 100644
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
> index 8d5b2f4..3a55c91 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -316,7 +316,13 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
>  
>  static int usb_dev_prepare(struct device *dev)
>  {
> -	return 0;		/* Implement eventually? */
> +	struct usb_device *udev = to_usb_device(dev);
> +
> +	/* Return 0 if the current wakeup setting is wrong, otherwise 1 */
> +	if (udev->do_remote_wakeup != device_may_wakeup(dev))
> +		return 0;
> +
> +	return 1;
>  }
>  
>  static void usb_dev_complete(struct device *dev)
> -- 
> 2.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
