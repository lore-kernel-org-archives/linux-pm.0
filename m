From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 2/6] usb: Add driver/usb/core/port.c file to fill usb port related code.
Date: Wed, 14 Nov 2012 01:04:03 +0100
Message-ID: <2444119.E7TGPxnJj8@vostro.rjw.lan>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <1352793605-4168-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42119 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983Ab2KMX7o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 18:59:44 -0500
In-Reply-To: <1352793605-4168-3-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, November 13, 2012 04:00:01 PM Lan Tianyu wrote:
> This patch is to create driver/usb/core/port.c and move usb port related
> code into it.

It does seem to make functional changes in addition to that, however.

If I'm not mistaken and that really is the case, can you (briefly)
describe those changes here too?

Rafael


> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/usb/core/Makefile |    1 +
>  drivers/usb/core/hub.c    |  113 +++++++--------------------------------------
>  drivers/usb/core/port.c   |   82 ++++++++++++++++++++++++++++++++
>  drivers/usb/core/usb.h    |    3 ++
>  include/linux/usb.h       |   16 +++++++
>  5 files changed, 118 insertions(+), 97 deletions(-)
>  create mode 100644 drivers/usb/core/port.c
> 
> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
> index 26059b9..5e847ad 100644
> --- a/drivers/usb/core/Makefile
> +++ b/drivers/usb/core/Makefile
> @@ -7,6 +7,7 @@ ccflags-$(CONFIG_USB_DEBUG) := -DDEBUG
>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
> +usbcore-y += port.o
>  
>  usbcore-$(CONFIG_PCI)		+= hcd-pci.o
>  usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3c85fe1c..60746aa 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -42,13 +42,6 @@
>  #define USB_VENDOR_GENESYS_LOGIC		0x05e3
>  #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
>  
> -struct usb_port {
> -	struct usb_device *child;
> -	struct device dev;
> -	struct dev_state *port_owner;
> -	enum usb_port_connect_type connect_type;
> -};
> -
>  struct usb_hub {
>  	struct device		*intfdev;	/* the "interface" device */
>  	struct usb_device	*hdev;
> @@ -170,9 +163,6 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
>  #define HUB_DEBOUNCE_STEP	  25
>  #define HUB_DEBOUNCE_STABLE	 100
>  
> -#define to_usb_port(_dev) \
> -	container_of(_dev, struct usb_port, dev)
> -
>  static int usb_reset_and_verify_device(struct usb_device *udev);
>  
>  static inline char *portspeed(struct usb_hub *hub, int portstatus)
> @@ -1237,57 +1227,12 @@ static int hub_post_reset(struct usb_interface *intf)
>  	return 0;
>  }
>  
> -static void usb_port_device_release(struct device *dev)
> -{
> -	struct usb_port *port_dev = to_usb_port(dev);
> -
> -	usb_acpi_unregister_power_resources(dev);
> -	kfree(port_dev);
> -}
> -
>  static void usb_hub_remove_port_device(struct usb_hub *hub,
>  				       int port1)
>  {
>  	device_unregister(&hub->ports[port1 - 1]->dev);
>  }
>  
> -struct device_type usb_port_device_type = {
> -	.name =		"usb_port",
> -	.release =	usb_port_device_release,
> -};
> -
> -static int usb_hub_create_port_device(struct usb_hub *hub,
> -				      int port1)
> -{
> -	struct usb_port *port_dev = NULL;
> -	int retval;
> -
> -	port_dev = kzalloc(sizeof(*port_dev), GFP_KERNEL);
> -	if (!port_dev) {
> -		retval = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	hub->ports[port1 - 1] = port_dev;
> -	port_dev->dev.parent = hub->intfdev;
> -	port_dev->dev.groups = port_dev_group;
> -	port_dev->dev.type = &usb_port_device_type;
> -	dev_set_name(&port_dev->dev, "port%d", port1);
> -
> -	retval = device_register(&port_dev->dev);
> -	if (retval)
> -		goto error_register;
> -
> -	usb_acpi_register_power_resources(&port_dev->dev);
> -
> -	return 0;
> -
> -error_register:
> -	put_device(&port_dev->dev);
> -exit:
> -	return retval;
> -}
> -
>  static int hub_configure(struct usb_hub *hub,
>  	struct usb_endpoint_descriptor *endpoint)
>  {
> @@ -1548,10 +1493,24 @@ static int hub_configure(struct usb_hub *hub,
>  	if (hub->has_indicators && blinkenlights)
>  		hub->indicator [0] = INDICATOR_CYCLE;
>  
> -	for (i = 0; i < hdev->maxchild; i++)
> -		if (usb_hub_create_port_device(hub, i + 1) < 0)
> +	for (i = 0; i < hdev->maxchild; i++) {
> +		struct usb_port *port_dev = NULL;
> +
> +		port_dev = kzalloc(sizeof(*port_dev), GFP_KERNEL);
> +		if (!port_dev) {
> +			dev_err(hub->intfdev,
> +				"couldn't create port%d device due to lack mem.\n", i + 1);
> +			continue;
> +		}
> +
> +		hub->ports[i] = port_dev;
> +
> +		if (usb_hub_create_port_device(hub->intfdev, i + 1, port_dev) < 0) {
>  			dev_err(hub->intfdev,
>  				"couldn't create port%d device.\n", i + 1);
> +			hub->ports[i] = NULL;
> +		}
> +	}
>  
>  	if (!hub_is_superspeed(hdev)) {
>  		for (i = 1; i <= hdev->maxchild; i++)
> @@ -4765,46 +4724,6 @@ static int hub_thread(void *__unused)
>  	return 0;
>  }
>  
> -static ssize_t show_port_connect_type(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> -{
> -	struct usb_port *port_dev = to_usb_port(dev);
> -	char *result;
> -
> -	switch (port_dev->connect_type) {
> -	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
> -		result = "hotplug";
> -		break;
> -	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
> -		result = "hardwired";
> -		break;
> -	case USB_PORT_NOT_USED:
> -		result = "not used";
> -		break;
> -	default:
> -		result = "unknown";
> -		break;
> -	}
> -
> -	return sprintf(buf, "%s\n", result);
> -}
> -static DEVICE_ATTR(connect_type, S_IRUGO, show_port_connect_type,
> -		NULL);
> -
> -static struct attribute *port_dev_attrs[] = {
> -	&dev_attr_connect_type.attr,
> -	NULL,
> -};
> -
> -static struct attribute_group port_dev_attr_grp = {
> -	.attrs = port_dev_attrs,
> -};
> -
> -static const struct attribute_group *port_dev_group[] = {
> -	&port_dev_attr_grp,
> -	NULL,
> -};
> -
>  static const struct usb_device_id hub_id_table[] = {
>      { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
>  	           | USB_DEVICE_ID_MATCH_INT_CLASS,
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> new file mode 100644
> index 0000000..6523a03
> --- /dev/null
> +++ b/drivers/usb/core/port.c
> @@ -0,0 +1,82 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +
> +#include "usb.h"
> +
> +static ssize_t show_port_connect_type(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +	char *result;
> +
> +	switch (port_dev->connect_type) {
> +	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
> +		result = "hotplug";
> +		break;
> +	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
> +		result = "hardwired";
> +		break;
> +	case USB_PORT_NOT_USED:
> +		result = "not used";
> +		break;
> +	default:
> +		result = "unknown";
> +		break;
> +	}
> +
> +	return sprintf(buf, "%s\n", result);
> +}
> +static DEVICE_ATTR(connect_type, S_IRUGO, show_port_connect_type,
> +		NULL);
> +
> +static struct attribute *port_dev_attrs[] = {
> +	&dev_attr_connect_type.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group port_dev_attr_grp = {
> +	.attrs = port_dev_attrs,
> +};
> +
> +static const struct attribute_group *port_dev_group[] = {
> +	&port_dev_attr_grp,
> +	NULL,
> +};
> +
> +static void usb_port_device_release(struct device *dev)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	usb_acpi_unregister_power_resources(dev);
> +	kfree(port_dev);
> +}
> +
> +struct device_type usb_port_device_type = {
> +	.name =		"usb_port",
> +	.release =	usb_port_device_release,
> +};
> +
> +int usb_hub_create_port_device(struct device *intfdev,
> +		int port1, struct usb_port *port_dev)
> +{
> +	int retval;
> +
> +	port_dev->dev.parent = intfdev;
> +	port_dev->dev.groups = port_dev_group;
> +	port_dev->dev.type = &usb_port_device_type;
> +	dev_set_name(&port_dev->dev, "port%d", port1);
> +
> +	retval = device_register(&port_dev->dev);
> +	if (retval)
> +		goto error_register;
> +
> +	usb_acpi_register_power_resources(&port_dev->dev);
> +
> +	return 0;
> +
> +error_register:
> +	put_device(&port_dev->dev);
> +	return retval;
> +}
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index 38958fb..de7434b 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -60,6 +60,9 @@ extern void usb_hub_cleanup(void);
>  extern int usb_major_init(void);
>  extern void usb_major_cleanup(void);
>  
> +extern int usb_hub_create_port_device(struct device *intfdev,
> +		int port1, struct usb_port *port_dev);
> +
>  #ifdef	CONFIG_PM
>  
>  extern int usb_suspend(struct device *dev, pm_message_t msg);
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index e996bb6..c1f1346 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -572,6 +572,22 @@ struct usb_device {
>  };
>  #define	to_usb_device(d) container_of(d, struct usb_device, dev)
>  
> +/**
> + * struct usb port - kernel's representation of a usb port
> + * @child: usb device attatched to the port
> + * @dev: generic device interface
> + * @port_owner: port's owner
> + * @connect_type: port's connect type
> + */
> +struct usb_port {
> +	struct usb_device *child;
> +	struct device dev;
> +	struct dev_state *port_owner;
> +	enum usb_port_connect_type connect_type;
> +};
> +#define to_usb_port(_dev) \
> +	container_of(_dev, struct usb_port, dev)
> +
>  static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
>  {
>  	return to_usb_device(intf->dev.parent);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
