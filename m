From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/6] usb: Add driver/usb/core/port.c file to fill
 usb port related code.
Date: Wed, 14 Nov 2012 11:17:38 +0800
Message-ID: <50A30D52.2090308@intel.com>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <1352793605-4168-3-git-send-email-tianyu.lan@intel.com> <2444119.E7TGPxnJj8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2444119.E7TGPxnJj8-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 2012=E5=B9=B411=E6=9C=8814=E6=97=A5 08:04, Rafael J. Wysocki wrote:
> On Tuesday, November 13, 2012 04:00:01 PM Lan Tianyu wrote:
>> This patch is to create driver/usb/core/port.c and move usb port rel=
ated
>> code into it.
>=20
> It does seem to make functional changes in addition to that, however.
>=20
No functional change. But change the usb_hub_create_port_device() param=
=2E
which original used struct usb_hub as param. Because struct usb_hub is
private struct in the hub.c and now move usb_hub_create_port_device() t=
o
port.c. Will add changelog about this next version.
> If I'm not mistaken and that really is the case, can you (briefly)
> describe those changes here too?
>=20
> Rafael
>=20
>=20
>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/usb/core/Makefile |    1 +
>>  drivers/usb/core/hub.c    |  113 +++++++---------------------------=
-----------
>>  drivers/usb/core/port.c   |   82 ++++++++++++++++++++++++++++++++
>>  drivers/usb/core/usb.h    |    3 ++
>>  include/linux/usb.h       |   16 +++++++
>>  5 files changed, 118 insertions(+), 97 deletions(-)
>>  create mode 100644 drivers/usb/core/port.c
>>
>> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
>> index 26059b9..5e847ad 100644
>> --- a/drivers/usb/core/Makefile
>> +++ b/drivers/usb/core/Makefile
>> @@ -7,6 +7,7 @@ ccflags-$(CONFIG_USB_DEBUG) :=3D -DDEBUG
>>  usbcore-y :=3D usb.o hub.o hcd.o urb.o message.o driver.o
>>  usbcore-y +=3D config.o file.o buffer.o sysfs.o endpoint.o
>>  usbcore-y +=3D devio.o notify.o generic.o quirks.o devices.o
>> +usbcore-y +=3D port.o
>> =20
>>  usbcore-$(CONFIG_PCI)		+=3D hcd-pci.o
>>  usbcore-$(CONFIG_ACPI)		+=3D usb-acpi.o
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 3c85fe1c..60746aa 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -42,13 +42,6 @@
>>  #define USB_VENDOR_GENESYS_LOGIC		0x05e3
>>  #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
>> =20
>> -struct usb_port {
>> -	struct usb_device *child;
>> -	struct device dev;
>> -	struct dev_state *port_owner;
>> -	enum usb_port_connect_type connect_type;
>> -};
>> -
>>  struct usb_hub {
>>  	struct device		*intfdev;	/* the "interface" device */
>>  	struct usb_device	*hdev;
>> @@ -170,9 +163,6 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
>>  #define HUB_DEBOUNCE_STEP	  25
>>  #define HUB_DEBOUNCE_STABLE	 100
>> =20
>> -#define to_usb_port(_dev) \
>> -	container_of(_dev, struct usb_port, dev)
>> -
>>  static int usb_reset_and_verify_device(struct usb_device *udev);
>> =20
>>  static inline char *portspeed(struct usb_hub *hub, int portstatus)
>> @@ -1237,57 +1227,12 @@ static int hub_post_reset(struct usb_interfa=
ce *intf)
>>  	return 0;
>>  }
>> =20
>> -static void usb_port_device_release(struct device *dev)
>> -{
>> -	struct usb_port *port_dev =3D to_usb_port(dev);
>> -
>> -	usb_acpi_unregister_power_resources(dev);
>> -	kfree(port_dev);
>> -}
>> -
>>  static void usb_hub_remove_port_device(struct usb_hub *hub,
>>  				       int port1)
>>  {
>>  	device_unregister(&hub->ports[port1 - 1]->dev);
>>  }
>> =20
>> -struct device_type usb_port_device_type =3D {
>> -	.name =3D		"usb_port",
>> -	.release =3D	usb_port_device_release,
>> -};
>> -
>> -static int usb_hub_create_port_device(struct usb_hub *hub,
>> -				      int port1)
>> -{
>> -	struct usb_port *port_dev =3D NULL;
>> -	int retval;
>> -
>> -	port_dev =3D kzalloc(sizeof(*port_dev), GFP_KERNEL);
>> -	if (!port_dev) {
>> -		retval =3D -ENOMEM;
>> -		goto exit;
>> -	}
>> -
>> -	hub->ports[port1 - 1] =3D port_dev;
>> -	port_dev->dev.parent =3D hub->intfdev;
>> -	port_dev->dev.groups =3D port_dev_group;
>> -	port_dev->dev.type =3D &usb_port_device_type;
>> -	dev_set_name(&port_dev->dev, "port%d", port1);
>> -
>> -	retval =3D device_register(&port_dev->dev);
>> -	if (retval)
>> -		goto error_register;
>> -
>> -	usb_acpi_register_power_resources(&port_dev->dev);
>> -
>> -	return 0;
>> -
>> -error_register:
>> -	put_device(&port_dev->dev);
>> -exit:
>> -	return retval;
>> -}
>> -
>>  static int hub_configure(struct usb_hub *hub,
>>  	struct usb_endpoint_descriptor *endpoint)
>>  {
>> @@ -1548,10 +1493,24 @@ static int hub_configure(struct usb_hub *hub=
,
>>  	if (hub->has_indicators && blinkenlights)
>>  		hub->indicator [0] =3D INDICATOR_CYCLE;
>> =20
>> -	for (i =3D 0; i < hdev->maxchild; i++)
>> -		if (usb_hub_create_port_device(hub, i + 1) < 0)
>> +	for (i =3D 0; i < hdev->maxchild; i++) {
>> +		struct usb_port *port_dev =3D NULL;
>> +
>> +		port_dev =3D kzalloc(sizeof(*port_dev), GFP_KERNEL);
>> +		if (!port_dev) {
>> +			dev_err(hub->intfdev,
>> +				"couldn't create port%d device due to lack mem.\n", i + 1);
>> +			continue;
>> +		}
>> +
>> +		hub->ports[i] =3D port_dev;
>> +
>> +		if (usb_hub_create_port_device(hub->intfdev, i + 1, port_dev) < 0=
) {
>>  			dev_err(hub->intfdev,
>>  				"couldn't create port%d device.\n", i + 1);
>> +			hub->ports[i] =3D NULL;
>> +		}
>> +	}
>> =20
>>  	if (!hub_is_superspeed(hdev)) {
>>  		for (i =3D 1; i <=3D hdev->maxchild; i++)
>> @@ -4765,46 +4724,6 @@ static int hub_thread(void *__unused)
>>  	return 0;
>>  }
>> =20
>> -static ssize_t show_port_connect_type(struct device *dev,
>> -	struct device_attribute *attr, char *buf)
>> -{
>> -	struct usb_port *port_dev =3D to_usb_port(dev);
>> -	char *result;
>> -
>> -	switch (port_dev->connect_type) {
>> -	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
>> -		result =3D "hotplug";
>> -		break;
>> -	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
>> -		result =3D "hardwired";
>> -		break;
>> -	case USB_PORT_NOT_USED:
>> -		result =3D "not used";
>> -		break;
>> -	default:
>> -		result =3D "unknown";
>> -		break;
>> -	}
>> -
>> -	return sprintf(buf, "%s\n", result);
>> -}
>> -static DEVICE_ATTR(connect_type, S_IRUGO, show_port_connect_type,
>> -		NULL);
>> -
>> -static struct attribute *port_dev_attrs[] =3D {
>> -	&dev_attr_connect_type.attr,
>> -	NULL,
>> -};
>> -
>> -static struct attribute_group port_dev_attr_grp =3D {
>> -	.attrs =3D port_dev_attrs,
>> -};
>> -
>> -static const struct attribute_group *port_dev_group[] =3D {
>> -	&port_dev_attr_grp,
>> -	NULL,
>> -};
>> -
>>  static const struct usb_device_id hub_id_table[] =3D {
>>      { .match_flags =3D USB_DEVICE_ID_MATCH_VENDOR
>>  	           | USB_DEVICE_ID_MATCH_INT_CLASS,
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> new file mode 100644
>> index 0000000..6523a03
>> --- /dev/null
>> +++ b/drivers/usb/core/port.c
>> @@ -0,0 +1,82 @@
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/module.h>
>> +#include <linux/usb.h>
>> +
>> +#include "usb.h"
>> +
>> +static ssize_t show_port_connect_type(struct device *dev,
>> +	struct device_attribute *attr, char *buf)
>> +{
>> +	struct usb_port *port_dev =3D to_usb_port(dev);
>> +	char *result;
>> +
>> +	switch (port_dev->connect_type) {
>> +	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
>> +		result =3D "hotplug";
>> +		break;
>> +	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
>> +		result =3D "hardwired";
>> +		break;
>> +	case USB_PORT_NOT_USED:
>> +		result =3D "not used";
>> +		break;
>> +	default:
>> +		result =3D "unknown";
>> +		break;
>> +	}
>> +
>> +	return sprintf(buf, "%s\n", result);
>> +}
>> +static DEVICE_ATTR(connect_type, S_IRUGO, show_port_connect_type,
>> +		NULL);
>> +
>> +static struct attribute *port_dev_attrs[] =3D {
>> +	&dev_attr_connect_type.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group port_dev_attr_grp =3D {
>> +	.attrs =3D port_dev_attrs,
>> +};
>> +
>> +static const struct attribute_group *port_dev_group[] =3D {
>> +	&port_dev_attr_grp,
>> +	NULL,
>> +};
>> +
>> +static void usb_port_device_release(struct device *dev)
>> +{
>> +	struct usb_port *port_dev =3D to_usb_port(dev);
>> +
>> +	usb_acpi_unregister_power_resources(dev);
>> +	kfree(port_dev);
>> +}
>> +
>> +struct device_type usb_port_device_type =3D {
>> +	.name =3D		"usb_port",
>> +	.release =3D	usb_port_device_release,
>> +};
>> +
>> +int usb_hub_create_port_device(struct device *intfdev,
>> +		int port1, struct usb_port *port_dev)
>> +{
>> +	int retval;
>> +
>> +	port_dev->dev.parent =3D intfdev;
>> +	port_dev->dev.groups =3D port_dev_group;
>> +	port_dev->dev.type =3D &usb_port_device_type;
>> +	dev_set_name(&port_dev->dev, "port%d", port1);
>> +
>> +	retval =3D device_register(&port_dev->dev);
>> +	if (retval)
>> +		goto error_register;
>> +
>> +	usb_acpi_register_power_resources(&port_dev->dev);
>> +
>> +	return 0;
>> +
>> +error_register:
>> +	put_device(&port_dev->dev);
>> +	return retval;
>> +}
>> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
>> index 38958fb..de7434b 100644
>> --- a/drivers/usb/core/usb.h
>> +++ b/drivers/usb/core/usb.h
>> @@ -60,6 +60,9 @@ extern void usb_hub_cleanup(void);
>>  extern int usb_major_init(void);
>>  extern void usb_major_cleanup(void);
>> =20
>> +extern int usb_hub_create_port_device(struct device *intfdev,
>> +		int port1, struct usb_port *port_dev);
>> +
>>  #ifdef	CONFIG_PM
>> =20
>>  extern int usb_suspend(struct device *dev, pm_message_t msg);
>> diff --git a/include/linux/usb.h b/include/linux/usb.h
>> index e996bb6..c1f1346 100644
>> --- a/include/linux/usb.h
>> +++ b/include/linux/usb.h
>> @@ -572,6 +572,22 @@ struct usb_device {
>>  };
>>  #define	to_usb_device(d) container_of(d, struct usb_device, dev)
>> =20
>> +/**
>> + * struct usb port - kernel's representation of a usb port
>> + * @child: usb device attatched to the port
>> + * @dev: generic device interface
>> + * @port_owner: port's owner
>> + * @connect_type: port's connect type
>> + */
>> +struct usb_port {
>> +	struct usb_device *child;
>> +	struct device dev;
>> +	struct dev_state *port_owner;
>> +	enum usb_port_connect_type connect_type;
>> +};
>> +#define to_usb_port(_dev) \
>> +	container_of(_dev, struct usb_port, dev)
>> +
>>  static inline struct usb_device *interface_to_usbdev(struct usb_int=
erface *intf)
>>  {
>>  	return to_usb_device(intf->dev.parent);
>>


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
