From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 3/6] usb: add runtime pm support for usb port device
Date: Wed, 14 Nov 2012 01:08:08 +0100
Message-ID: <5876155.rAsY9PFrXq@vostro.rjw.lan>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <1352793605-4168-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42135 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756040Ab2KNADt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 19:03:49 -0500
In-Reply-To: <1352793605-4168-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, November 13, 2012 04:00:02 PM Lan Tianyu wrote:
> This patch is to add runtime pm callback for usb port device.
> Set/clear PORT_POWER feature in the resume/suspend callbak.
> Add portnum for struct usb_port to record port number.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

This one looks reasonable to me.  From the PM side

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/usb/core/hub.c  |   14 ++++++++++++++
>  drivers/usb/core/port.c |   39 +++++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/usb.h  |    2 ++
>  include/linux/usb.h     |    2 ++
>  4 files changed, 57 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 60746aa..2cb414e 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -765,6 +765,20 @@ static void hub_tt_work(struct work_struct *work)
>  	spin_unlock_irqrestore (&hub->tt.lock, flags);
>  }
>  
> +int usb_hub_set_port_power(struct usb_device *hdev, int port1,
> +		bool set)
> +{
> +	int ret;
> +
> +	if (set)
> +		ret = set_port_feature(hdev, port1,
> +				USB_PORT_FEAT_POWER);
> +	else
> +		ret = clear_port_feature(hdev, port1,
> +				USB_PORT_FEAT_POWER);
> +	return ret;
> +}
> +
>  /**
>   * usb_hub_clear_tt_buffer - clear control/bulk TT state in high speed hub
>   * @urb: an URB associated with the failed or incomplete split transaction
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 6523a03..1cda766 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -53,9 +53,45 @@ static void usb_port_device_release(struct device *dev)
>  	kfree(port_dev);
>  }
>  
> +static int usb_port_runtime_resume(struct device *dev)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +	struct usb_device *hdev =
> +		to_usb_device(dev->parent->parent);
> +
> +	return usb_hub_set_port_power(hdev, port_dev->portnum,
> +			true);
> +}
> +
> +static int usb_port_runtime_suspend(struct device *dev)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +	struct usb_device *hdev =
> +		to_usb_device(dev->parent->parent);
> +
> +	return usb_hub_set_port_power(hdev, port_dev->portnum,
> +			false);
> +}
> +
> +static int usb_port_runtime_idle(struct device *dev)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	return pm_runtime_suspend(&port_dev->dev);
> +}
> +
> +static const struct dev_pm_ops usb_port_pm_ops = {
> +#ifdef CONFIG_USB_SUSPEND
> +.runtime_suspend =	usb_port_runtime_suspend,
> +.runtime_resume =	usb_port_runtime_resume,
> +.runtime_idle =		usb_port_runtime_idle,
> +#endif
> +};
> +
>  struct device_type usb_port_device_type = {
>  	.name =		"usb_port",
>  	.release =	usb_port_device_release,
> +	.pm = &usb_port_pm_ops,
>  };
>  
>  int usb_hub_create_port_device(struct device *intfdev,
> @@ -63,6 +99,7 @@ int usb_hub_create_port_device(struct device *intfdev,
>  {
>  	int retval;
>  
> +	port_dev->portnum = port1;
>  	port_dev->dev.parent = intfdev;
>  	port_dev->dev.groups = port_dev_group;
>  	port_dev->dev.type = &usb_port_device_type;
> @@ -72,6 +109,8 @@ int usb_hub_create_port_device(struct device *intfdev,
>  	if (retval)
>  		goto error_register;
>  
> +	pm_runtime_set_active(&port_dev->dev);
> +	pm_runtime_enable(&port_dev->dev);
>  	usb_acpi_register_power_resources(&port_dev->dev);
>  
>  	return 0;
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index de7434b..47d77d4 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -62,6 +62,8 @@ extern void usb_major_cleanup(void);
>  
>  extern int usb_hub_create_port_device(struct device *intfdev,
>  		int port1, struct usb_port *port_dev);
> +extern int usb_hub_set_port_power(struct usb_device *hdev,
> +		int port1, bool set);
>  
>  #ifdef	CONFIG_PM
>  
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index c1f1346..71510bf 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -578,12 +578,14 @@ struct usb_device {
>   * @dev: generic device interface
>   * @port_owner: port's owner
>   * @connect_type: port's connect type
> + * @portnum: port index num based one
>   */
>  struct usb_port {
>  	struct usb_device *child;
>  	struct device dev;
>  	struct dev_state *port_owner;
>  	enum usb_port_connect_type connect_type;
> +	u8 portnum;
>  };
>  #define to_usb_port(_dev) \
>  	container_of(_dev, struct usb_port, dev)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
