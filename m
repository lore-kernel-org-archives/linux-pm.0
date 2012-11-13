From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 1/6] usb: Register usb port's acpi power resources
Date: Wed, 14 Nov 2012 00:56:06 +0100
Message-ID: <46669688.k9rXBaWOjk@vostro.rjw.lan>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <50A229E9.4060404@mvista.com> <50A23EBF.1070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42095 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab2KMXvq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 18:51:46 -0500
In-Reply-To: <50A23EBF.1070304@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Lan Tianyu <tianyu.lan@intel.com>, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, November 13, 2012 08:36:15 PM Lan Tianyu wrote:
> =E4=BA=8E 2012/11/13 19:07, Sergei Shtylyov =E5=86=99=E9=81=93:
> > Hello.
> >
> > On 13-11-2012 12:00, Lan Tianyu wrote:
> >
> >> This patch is to register usb port's acpi power resources. Create
> >> link between usb port device and its acpi power resource.
> >
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> > [...]
> >
> >> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-ac=
pi.c
> >> index cef4252..c58ebc0 100644
> >> --- a/drivers/usb/core/usb-acpi.c
> >> +++ b/drivers/usb/core/usb-acpi.c
> >> @@ -216,6 +216,28 @@ static struct acpi_bus_type usb_acpi_bus =3D =
{
> >>       .find_device =3D usb_acpi_find_device,
> >>   };
> >>
> >> +int usb_acpi_register_power_resources(struct device *dev)
> >> +{
> >> +    acpi_handle port_handle =3D DEVICE_ACPI_HANDLE(dev);
> >> +
> >> +    if (!port_handle)
> >> +        return -ENODEV;
> >> +
> >> +    if (acpi_power_resource_register_device(dev, port_handle) < 0=
)
> >> +        return -ENODEV;
> >> +    return 0;
> >> +}
> >> +
> >> +void usb_acpi_unregister_power_resources(struct device *dev)
> >> +{
> >> +    acpi_handle port_handle =3D DEVICE_ACPI_HANDLE(dev);
> >> +
> >> +    if (!port_handle)
> >> +        return;
> >> +
> >> +    acpi_power_resource_register_device(dev, port_handle);
> >
> >     I thinbk you have been askied already, but shouldn't it be
> > acpi_power_resource_unregister_device()?
> >
> Oh. Sorry. Too focus on the other modification. Thanks for your remin=
der.

Besides, it would be a bit more natural to do

if (port_handle)
	acpi_power_resource_unregister_device(dev, port_handle);

instead of doing that return when port_handle is NULL.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
