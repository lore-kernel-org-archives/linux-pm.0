From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 5/6] usb: expose usb port's pm qos flags to user space
Date: Wed, 14 Nov 2012 01:21:28 +0100
Message-ID: <2120357.Px8lFHHrUZ@vostro.rjw.lan>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <1352793605-4168-6-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42179 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076Ab2KNARJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 19:17:09 -0500
In-Reply-To: <1352793605-4168-6-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, November 13, 2012 04:00:04 PM Lan Tianyu wrote:
> This patch is to expose usb port's pm qos flags(pm_qos_no_power_off,
> pm_qos_remote_wakeup) to user space. User can set pm_qos_no_power_off
> flag to prohibit the port from being power off.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/usb/core/port.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index b7388fd..5a7a833 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -2,6 +2,7 @@
>  #include <linux/errno.h>
>  #include <linux/module.h>
>  #include <linux/usb.h>
> +#include <linux/pm_qos.h>
>  
>  #include "usb.h"
>  
> @@ -48,7 +49,7 @@ static const struct attribute_group *port_dev_group[] = {
>  static void usb_port_device_release(struct device *dev)
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
> -
> +	dev_pm_qos_hide_flags(dev);
>  	usb_acpi_unregister_power_resources(dev);
>  	kfree(port_dev);
>  }
> @@ -110,12 +111,19 @@ int usb_hub_create_port_device(struct device *intfdev,
>  	if (retval)
>  		goto error_register;
>  
> +	retval = dev_pm_qos_expose_flags(&port_dev->dev,
> +			PM_QOS_FLAG_NO_POWER_OFF);
> +	if (retval)
> +		goto error_expose_pm_qos;
> +
>  	pm_runtime_set_active(&port_dev->dev);
>  	pm_runtime_enable(&port_dev->dev);
>  	usb_acpi_register_power_resources(&port_dev->dev);
>  
>  	return 0;
>  
> +error_expose_pm_qos:
> +	device_del(&port_dev->dev);

That seems to be a bit drastic. :-)

Why don't you simply avoid enabling runtime PM in that case?

Rafael


>  error_register:
>  	put_device(&port_dev->dev);
>  	return retval;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
