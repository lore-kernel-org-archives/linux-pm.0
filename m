From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH v2 1/6] usb: Register usb port's acpi power resources
Date: Wed, 14 Nov 2012 10:46:29 +0800
Message-ID: <50A30605.6050703@intel.com>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <50A229E9.4060404@mvista.com> <50A23EBF.1070304@gmail.com> <46669688.k9rXBaWOjk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36319 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489Ab2KNCuq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 21:50:46 -0500
In-Reply-To: <46669688.k9rXBaWOjk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lan Tianyu <lantianyu1986@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 2012=E5=B9=B411=E6=9C=8814=E6=97=A5 07:56, Rafael J. Wysocki wrote:
> On Tuesday, November 13, 2012 08:36:15 PM Lan Tianyu wrote:
>> =E4=BA=8E 2012/11/13 19:07, Sergei Shtylyov =E5=86=99=E9=81=93:
>>> Hello.
>>>
>>> On 13-11-2012 12:00, Lan Tianyu wrote:
>>>
>>>> This patch is to register usb port's acpi power resources. Create
>>>> link between usb port device and its acpi power resource.
>>>
>>>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>>> [...]
>>>
>>>> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-ac=
pi.c
>>>> index cef4252..c58ebc0 100644
>>>> --- a/drivers/usb/core/usb-acpi.c
>>>> +++ b/drivers/usb/core/usb-acpi.c
>>>> @@ -216,6 +216,28 @@ static struct acpi_bus_type usb_acpi_bus =3D =
{
>>>>       .find_device =3D usb_acpi_find_device,
>>>>   };
>>>>
>>>> +int usb_acpi_register_power_resources(struct device *dev)
>>>> +{
>>>> +    acpi_handle port_handle =3D DEVICE_ACPI_HANDLE(dev);
>>>> +
>>>> +    if (!port_handle)
>>>> +        return -ENODEV;
>>>> +
>>>> +    if (acpi_power_resource_register_device(dev, port_handle) < 0=
)
>>>> +        return -ENODEV;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void usb_acpi_unregister_power_resources(struct device *dev)
>>>> +{
>>>> +    acpi_handle port_handle =3D DEVICE_ACPI_HANDLE(dev);
>>>> +
>>>> +    if (!port_handle)
>>>> +        return;
>>>> +
>>>> +    acpi_power_resource_register_device(dev, port_handle);
>>>
>>>     I thinbk you have been askied already, but shouldn't it be
>>> acpi_power_resource_unregister_device()?
>>>
>> Oh. Sorry. Too focus on the other modification. Thanks for your remi=
nder.
>=20
> Besides, it would be a bit more natural to do
>=20
> if (port_handle)
> 	acpi_power_resource_unregister_device(dev, port_handle);
>=20
> instead of doing that return when port_handle is NULL.
>=20
Hi Rafael:
	Great thanks for your review. :)
	I get it and will update it at next version.
> Thanks,
> Rafael
>=20
>=20


--=20
Best regards
Tianyu Lan
