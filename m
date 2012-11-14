From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH v2 3/6] usb: add runtime pm support for usb port device
Date: Wed, 14 Nov 2012 14:34:37 +0800
Message-ID: <50A33B7D.2000100@intel.com>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <1352793605-4168-4-git-send-email-tianyu.lan@intel.com> <5876155.rAsY9PFrXq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44497 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab2KNGjA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Nov 2012 01:39:00 -0500
In-Reply-To: <5876155.rAsY9PFrXq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 2012=E5=B9=B411=E6=9C=8814=E6=97=A5 08:08, Rafael J. Wysocki wrote:
> On Tuesday, November 13, 2012 04:00:02 PM Lan Tianyu wrote:
>> This patch is to add runtime pm callback for usb port device.
>> Set/clear PORT_POWER feature in the resume/suspend callbak.
>> Add portnum for struct usb_port to record port number.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> This one looks reasonable to me.  From the PM side
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Hi Rafael and Alan:
	This patch has a collaboration problem with pm qos. Since pm core woul=
d
pm_runtime_get_sync/put(port_dev) if pm qos flags was changed and port'=
s
suspend call_back() clear PORT_POWER feature without any check. This
will cause PORT_POWER feather being cleared every time after pm qos
flags being changed.

	I have an idea that add check in the port's runtime idle callback.
Check NO_POWER_OFF flag firstly. If set return. Second, for port withou=
t
device, suspend port directly and for port with device, increase child
device's runtime usage without resume and do barrier to ensure all
suspend process finish, at last check the child runtime status. If it
was suspended, suspend port and if do nothing.

static int usb_port_runtime_idle(struct device *dev)
{
	struct usb_port *port_dev =3D to_usb_port(dev);
	int retval =3D 0;

	if (dev_pm_qos_flags(&port_dev->dev, PM_QOS_FLAG_NO_POWER_OFF)
			=3D=3D PM_QOS_FLAGS_ALL)
		return 0;

	if (!port_dev->child) {
		retval =3D pm_runtime_suspend(&port_dev->dev);
		if (!retval)
			port_dev->power_on =3Dfalse;
	}
	else {
		pm_runtime_get_noresume(&port_dev->child->dev);
		pm_runtime_barrier(&port_dev->child->dev);
		if (port_dev->child->dev.power.runtime_status
				=3D=3D RPM_SUSPENDED) {
			retval =3D pm_runtime_suspend(&port_dev->dev);
			if (!retval)
				port_dev->power_on =3Dfalse;
		}=09
		pm_runtime_put_noidle(&port_dev->child->dev);
	}
=09
	return retval;
}

I'd like to see your opinion :) thanks.

>=20
>> ---
>>  drivers/usb/core/hub.c  |   14 ++++++++++++++
>>  drivers/usb/core/port.c |   39 ++++++++++++++++++++++++++++++++++++=
+++
>>  drivers/usb/core/usb.h  |    2 ++
>>  include/linux/usb.h     |    2 ++
>>  4 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 60746aa..2cb414e 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -765,6 +765,20 @@ static void hub_tt_work(struct work_struct *wor=
k)
>>  	spin_unlock_irqrestore (&hub->tt.lock, flags);
>>  }
>> =20
>> +int usb_hub_set_port_power(struct usb_device *hdev, int port1,
>> +		bool set)
>> +{
>> +	int ret;
>> +
>> +	if (set)
>> +		ret =3D set_port_feature(hdev, port1,
>> +				USB_PORT_FEAT_POWER);
>> +	else
>> +		ret =3D clear_port_feature(hdev, port1,
>> +				USB_PORT_FEAT_POWER);
>> +	return ret;
>> +}
>> +
>>  /**
>>   * usb_hub_clear_tt_buffer - clear control/bulk TT state in high sp=
eed hub
>>   * @urb: an URB associated with the failed or incomplete split tran=
saction
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index 6523a03..1cda766 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -53,9 +53,45 @@ static void usb_port_device_release(struct device=
 *dev)
>>  	kfree(port_dev);
>>  }
>> =20
>> +static int usb_port_runtime_resume(struct device *dev)
>> +{
>> +	struct usb_port *port_dev =3D to_usb_port(dev);
>> +	struct usb_device *hdev =3D
>> +		to_usb_device(dev->parent->parent);
>> +
>> +	return usb_hub_set_port_power(hdev, port_dev->portnum,
>> +			true);
>> +}
>> +
>> +static int usb_port_runtime_suspend(struct device *dev)
>> +{
>> +	struct usb_port *port_dev =3D to_usb_port(dev);
>> +	struct usb_device *hdev =3D
>> +		to_usb_device(dev->parent->parent);
>> +
>> +	return usb_hub_set_port_power(hdev, port_dev->portnum,
>> +			false);
>> +}
>> +
>> +static int usb_port_runtime_idle(struct device *dev)
>> +{
>> +	struct usb_port *port_dev =3D to_usb_port(dev);
>> +
>> +	return pm_runtime_suspend(&port_dev->dev);
>> +}
>> +
>> +static const struct dev_pm_ops usb_port_pm_ops =3D {
>> +#ifdef CONFIG_USB_SUSPEND
>> +.runtime_suspend =3D	usb_port_runtime_suspend,
>> +.runtime_resume =3D	usb_port_runtime_resume,
>> +.runtime_idle =3D		usb_port_runtime_idle,
>> +#endif
>> +};
>> +
>>  struct device_type usb_port_device_type =3D {
>>  	.name =3D		"usb_port",
>>  	.release =3D	usb_port_device_release,
>> +	.pm =3D &usb_port_pm_ops,
>>  };
>> =20
>>  int usb_hub_create_port_device(struct device *intfdev,
>> @@ -63,6 +99,7 @@ int usb_hub_create_port_device(struct device *intf=
dev,
>>  {
>>  	int retval;
>> =20
>> +	port_dev->portnum =3D port1;
>>  	port_dev->dev.parent =3D intfdev;
>>  	port_dev->dev.groups =3D port_dev_group;
>>  	port_dev->dev.type =3D &usb_port_device_type;
>> @@ -72,6 +109,8 @@ int usb_hub_create_port_device(struct device *int=
fdev,
>>  	if (retval)
>>  		goto error_register;
>> =20
>> +	pm_runtime_set_active(&port_dev->dev);
>> +	pm_runtime_enable(&port_dev->dev);
>>  	usb_acpi_register_power_resources(&port_dev->dev);
>> =20
>>  	return 0;
>> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
>> index de7434b..47d77d4 100644
>> --- a/drivers/usb/core/usb.h
>> +++ b/drivers/usb/core/usb.h
>> @@ -62,6 +62,8 @@ extern void usb_major_cleanup(void);
>> =20
>>  extern int usb_hub_create_port_device(struct device *intfdev,
>>  		int port1, struct usb_port *port_dev);
>> +extern int usb_hub_set_port_power(struct usb_device *hdev,
>> +		int port1, bool set);
>> =20
>>  #ifdef	CONFIG_PM
>> =20
>> diff --git a/include/linux/usb.h b/include/linux/usb.h
>> index c1f1346..71510bf 100644
>> --- a/include/linux/usb.h
>> +++ b/include/linux/usb.h
>> @@ -578,12 +578,14 @@ struct usb_device {
>>   * @dev: generic device interface
>>   * @port_owner: port's owner
>>   * @connect_type: port's connect type
>> + * @portnum: port index num based one
>>   */
>>  struct usb_port {
>>  	struct usb_device *child;
>>  	struct device dev;
>>  	struct dev_state *port_owner;
>>  	enum usb_port_connect_type connect_type;
>> +	u8 portnum;
>>  };
>>  #define to_usb_port(_dev) \
>>  	container_of(_dev, struct usb_port, dev)
>>


--=20
Best regards
Tianyu Lan
