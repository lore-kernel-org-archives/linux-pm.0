From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 6/6] usb: add usb port's pm qos flags request to change NO_POWER_OFF flag
Date: Wed, 14 Nov 2012 01:23:06 +0100
Message-ID: <2308745.YokGqOdQnN@vostro.rjw.lan>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <1352793605-4168-7-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42192 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab2KNASp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 19:18:45 -0500
In-Reply-To: <1352793605-4168-7-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, November 13, 2012 04:00:05 PM Lan Tianyu wrote:
> Some usb devices can't be resumed correctly after power off. This
> patch is to add pm qos flags request to change NO_POWER_OFF and
> provide usb_device_allow_power_off() for device drivers to allow or
> prohibit usb core to power off the device.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

This looks reasonable to me.  From the PM perspective:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/usb/core/hub.c  |   36 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/port.c |   12 ++++++++++++
>  include/linux/usb.h     |    3 +++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 267e9d7..7aaac720 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -189,6 +189,42 @@ static struct usb_hub *hdev_to_hub(struct usb_device *hdev)
>  	return usb_get_intfdata(hdev->actconfig->interface[0]);
>  }
>  
> +/**
> + * usb_device_allow_power_off - Allow or prohibit power off device.
> + * @udev: target usb device
> + * @set: choice of allow or prohibit
> + *
> + * Clearing or setting usb port's pm qos flag PM_QOS_FLAG_NO_POWER_OFF
> + * to allow or prohibit target usb device to be power off.
> + */
> +int usb_device_allow_power_off(struct usb_device *udev, bool set)
> +{
> +	struct usb_port *port_dev;
> +	struct dev_pm_qos_request *pm_qos;
> +	s32 value;
> +	int ret;
> +
> +	if (!udev->parent)
> +		return -EINVAL;
> +
> +	port_dev =
> +		hdev_to_hub(udev->parent)->ports[udev->portnum - 1];
> +	pm_qos = &port_dev->pm_qos;
> +	value = pm_qos->data.flr.flags;
> +
> +	if (set)
> +		value &= ~PM_QOS_FLAG_NO_POWER_OFF;
> +	else
> +		value |= PM_QOS_FLAG_NO_POWER_OFF;
> +
> +	pm_runtime_get_sync(&port_dev->dev);
> +	ret = dev_pm_qos_update_request(pm_qos, value);
> +	pm_runtime_put(&port_dev->dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_device_allow_power_off);
> +
>  static int usb_device_supports_lpm(struct usb_device *udev)
>  {
>  	/* USB 2.1 (and greater) devices indicate LPM support through
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 5a7a833..077a494 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -49,6 +49,11 @@ static const struct attribute_group *port_dev_group[] = {
>  static void usb_port_device_release(struct device *dev)
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	pm_runtime_get_sync(dev);
> +	dev_pm_qos_remove_request(&port_dev->pm_qos);
> +	pm_runtime_put(dev);
> +
>  	dev_pm_qos_hide_flags(dev);
>  	usb_acpi_unregister_power_resources(dev);
>  	kfree(port_dev);
> @@ -116,12 +121,19 @@ int usb_hub_create_port_device(struct device *intfdev,
>  	if (retval)
>  		goto error_expose_pm_qos;
>  
> +	retval = dev_pm_qos_add_request(&port_dev->dev, &port_dev->pm_qos,
> +			DEV_PM_QOS_FLAGS, 0);
> +	if (retval)
> +		goto error_add_qos_request;
> +
>  	pm_runtime_set_active(&port_dev->dev);
>  	pm_runtime_enable(&port_dev->dev);
>  	usb_acpi_register_power_resources(&port_dev->dev);
>  
>  	return 0;
>  
> +error_add_qos_request:
> +	pm_runtime_put(&port_dev->dev);
>  error_expose_pm_qos:
>  	device_del(&port_dev->dev);
>  error_register:
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 8002640..aa201bd 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -21,6 +21,7 @@
>  #include <linux/sched.h>	/* for current && schedule_timeout */
>  #include <linux/mutex.h>	/* for struct mutex */
>  #include <linux/pm_runtime.h>	/* for runtime PM */
> +#include <linux/pm_qos.h>	/* for PM Qos */
>  
>  struct usb_device;
>  struct usb_driver;
> @@ -577,6 +578,7 @@ struct usb_device {
>   * @child: usb device attatched to the port
>   * @dev: generic device interface
>   * @port_owner: port's owner
> + * @pm_qos: port's pm qos flags request
>   * @connect_type: port's connect type
>   * @portnum: port index num based one
>   * @power_on: port's power state
> @@ -585,6 +587,7 @@ struct usb_port {
>  	struct usb_device *child;
>  	struct device dev;
>  	struct dev_state *port_owner;
> +	struct dev_pm_qos_request pm_qos;
>  	enum usb_port_connect_type connect_type;
>  	u8 portnum;
>  	bool power_on;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
