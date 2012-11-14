From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 4/6] usb: add usb port auto power off mechanism
Date: Wed, 14 Nov 2012 01:16:02 +0100
Message-ID: <2435462.B7xDm7Dlzy@vostro.rjw.lan>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <1352793605-4168-5-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42161 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab2KNALm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 19:11:42 -0500
In-Reply-To: <1352793605-4168-5-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, November 13, 2012 04:00:03 PM Lan Tianyu wrote:
> This patch is to add usb port auto power off mechanism.
> When usb device is suspending, usb core will suspend usb port and
> usb port runtime pm callback will clear PORT_POWER feature to
> power off port if all conditions were met.These conditions are
> remote wakeup disable, pm qos NO_POWER_OFF flag clear and persist
> enable. When device is suspended and power off, usb core
> will ignore port's connect and enable change event to keep the device
> not being disconnected. When it resumes, power on port again.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Again, from the PM side:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

although as far as the USB internals are concerned, I'm far from being an expert. :-)

Thanks,
Rafael


> ---
>  drivers/usb/core/hub.c  |   76 +++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/core/port.c |    1 +
>  include/linux/usb.h     |    2 ++
>  3 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 2cb414e..267e9d7 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/freezer.h>
>  #include <linux/random.h>
> +#include <linux/pm_qos.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
> @@ -159,11 +160,14 @@ MODULE_PARM_DESC(use_both_schemes,
>  DECLARE_RWSEM(ehci_cf_port_reset_rwsem);
>  EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
>  
> +#define HUB_PORT_RECONNECT_TRIES	20
> +
>  #define HUB_DEBOUNCE_TIMEOUT	1500
>  #define HUB_DEBOUNCE_STEP	  25
>  #define HUB_DEBOUNCE_STABLE	 100
>  
>  static int usb_reset_and_verify_device(struct usb_device *udev);
> +static int hub_port_debounce(struct usb_hub *hub, int port1);
>  
>  static inline char *portspeed(struct usb_hub *hub, int portstatus)
>  {
> @@ -855,7 +859,11 @@ static unsigned hub_power_on(struct usb_hub *hub, bool do_delay)
>  		dev_dbg(hub->intfdev, "trying to enable port power on "
>  				"non-switchable hub\n");
>  	for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++)
> -		set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
> +		if (hub->ports[port1 - 1]->power_on)
> +			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
> +		else
> +			clear_port_feature(hub->hdev, port1,
> +						USB_PORT_FEAT_POWER);
>  
>  	/* Wait at least 100 msec for power to become stable */
>  	delay = max(pgood_delay, (unsigned) 100);
> @@ -2852,6 +2860,7 @@ EXPORT_SYMBOL_GPL(usb_enable_ltm);
>  int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  {
>  	struct usb_hub	*hub = hdev_to_hub(udev->parent);
> +	struct usb_port *port_dev = hub->ports[udev->portnum - 1];
>  	int		port1 = udev->portnum;
>  	int		status;
>  
> @@ -2946,6 +2955,19 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  		udev->port_is_suspended = 1;
>  		msleep(10);
>  	}
> +
> +	/*
> +	 * Check whether current status is meeting requirement of
> +	 * usb port power off mechanism
> +	 */
> +	if (!udev->do_remote_wakeup
> +			&& (dev_pm_qos_flags(&port_dev->dev,
> +			PM_QOS_FLAG_NO_POWER_OFF) != PM_QOS_FLAGS_ALL)
> +			&& udev->persist_enabled
> +			&& !status)
> +		if (!pm_runtime_put_sync(&port_dev->dev))
> +			port_dev->power_on = false;
> +
>  	usb_mark_last_busy(hub->hdev);
>  	return status;
>  }
> @@ -3029,6 +3051,25 @@ static int finish_port_resume(struct usb_device *udev)
>  	return status;
>  }
>  
> +static int usb_port_wait_for_connected(struct usb_hub *hub, int port1)
> +{
> +	int status, i;
> +
> +	for (i = 0; i < HUB_PORT_RECONNECT_TRIES; i++) {
> +		status = hub_port_debounce(hub, port1);
> +		if (status & USB_PORT_STAT_CONNECTION) {
> +			/*
> +			 * just clear enable-change feature since debounce
> +			 *  has cleared connect-change feature.
> +			 */
> +			clear_port_feature(hub->hdev, port1,
> +					USB_PORT_FEAT_C_ENABLE);
> +			return 0;
> +		}
> +	}
> +	return -ETIMEDOUT;
> +}
> +
>  /*
>   * usb_port_resume - re-activate a suspended usb device's upstream port
>   * @udev: device to re-activate, not a root hub
> @@ -3066,10 +3107,36 @@ static int finish_port_resume(struct usb_device *udev)
>  int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  {
>  	struct usb_hub	*hub = hdev_to_hub(udev->parent);
> +	struct usb_port *port_dev = hub->ports[udev->portnum  - 1];
>  	int		port1 = udev->portnum;
>  	int		status;
>  	u16		portchange, portstatus;
>  
> +
> +	set_bit(port1, hub->busy_bits);
> +
> +	if (!port_dev->power_on) {
> +		status = pm_runtime_get_sync(&port_dev->dev);
> +		if (status) {
> +			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
> +					status);
> +			return status;
> +		}
> +
> +		port_dev->power_on = true;
> +
> +		/*
> +		 * Wait for usb hub port to be reconnected in order to make
> +		 * the resume procedure successful.
> +		 */
> +		status = usb_port_wait_for_connected(hub, port1);
> +		if (status < 0) {
> +			dev_dbg(&udev->dev, "can't get reconnection after setting port  power on, status %d\n",
> +					status);
> +			return status;
> +		}
> +	}
> +
>  	/* Skip the initial Clear-Suspend step for a remote wakeup */
>  	status = hub_port_status(hub, port1, &portstatus, &portchange);
>  	if (status == 0 && !port_is_suspended(hub, portstatus))
> @@ -3077,8 +3144,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  
>  	// dev_dbg(hub->intfdev, "resume port %d\n", port1);
>  
> -	set_bit(port1, hub->busy_bits);
> -
>  	/* see 7.1.7.7; affects power usage, but not budgeting */
>  	if (hub_is_superspeed(hub->hdev))
>  		status = set_port_feature(hub->hdev,
> @@ -4256,6 +4321,11 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
>  		}
>  	}
>  
> +	if (!hub->ports[port1 - 1]->power_on) {
> +		clear_bit(port1, hub->change_bits);
> +		return;
> +	}
> +
>  	/* Disconnect any existing devices under this port */
>  	if (udev)
>  		usb_disconnect(&hub->ports[port1 - 1]->child);
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 1cda766..b7388fd 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -99,6 +99,7 @@ int usb_hub_create_port_device(struct device *intfdev,
>  {
>  	int retval;
>  
> +	port_dev->power_on = true;
>  	port_dev->portnum = port1;
>  	port_dev->dev.parent = intfdev;
>  	port_dev->dev.groups = port_dev_group;
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 71510bf..8002640 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -579,6 +579,7 @@ struct usb_device {
>   * @port_owner: port's owner
>   * @connect_type: port's connect type
>   * @portnum: port index num based one
> + * @power_on: port's power state
>   */
>  struct usb_port {
>  	struct usb_device *child;
> @@ -586,6 +587,7 @@ struct usb_port {
>  	struct dev_state *port_owner;
>  	enum usb_port_connect_type connect_type;
>  	u8 portnum;
> +	bool power_on;
>  };
>  #define to_usb_port(_dev) \
>  	container_of(_dev, struct usb_port, dev)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
