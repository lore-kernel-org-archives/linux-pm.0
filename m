From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 3/6] usb: add runtime pm support for usb port device
Date: Wed, 14 Nov 2012 10:49:16 +0100
Message-ID: <2700525.6XmcYg8quR@vostro.rjw.lan>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <5876155.rAsY9PFrXq@vostro.rjw.lan> <50A33B7D.2000100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:43198 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab2KNJoz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Nov 2012 04:44:55 -0500
In-Reply-To: <50A33B7D.2000100@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, November 14, 2012 02:34:37 PM Lan Tianyu wrote:
> On 2012=E5=B9=B411=E6=9C=8814=E6=97=A5 08:08, Rafael J. Wysocki wrote=
:
> > On Tuesday, November 13, 2012 04:00:02 PM Lan Tianyu wrote:
> >> This patch is to add runtime pm callback for usb port device.
> >> Set/clear PORT_POWER feature in the resume/suspend callbak.
> >> Add portnum for struct usb_port to record port number.
> >>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >=20
> > This one looks reasonable to me.  From the PM side
> >=20
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Hi Rafael and Alan:
> 	This patch has a collaboration problem with pm qos. Since pm core wo=
uld
> pm_runtime_get_sync/put(port_dev) if pm qos flags was changed and por=
t's
> suspend call_back() clear PORT_POWER feature without any check. This
> will cause PORT_POWER feather being cleared every time after pm qos
> flags being changed.
>=20
> 	I have an idea that add check in the port's runtime idle callback.
> Check NO_POWER_OFF flag firstly. If set return. Second, for port with=
out
> device, suspend port directly and for port with device, increase chil=
d
> device's runtime usage without resume and do barrier to ensure all
> suspend process finish, at last check the child runtime status. If it
> was suspended, suspend port and if do nothing.
>=20
> static int usb_port_runtime_idle(struct device *dev)
> {
> 	struct usb_port *port_dev =3D to_usb_port(dev);
> 	int retval =3D 0;
>=20
> 	if (dev_pm_qos_flags(&port_dev->dev, PM_QOS_FLAG_NO_POWER_OFF)
> 			=3D=3D PM_QOS_FLAGS_ALL)
> 		return 0;
>=20
> 	if (!port_dev->child) {
> 		retval =3D pm_runtime_suspend(&port_dev->dev);
> 		if (!retval)
> 			port_dev->power_on =3Dfalse;
> 	}
> 	else {

This usually is written as "} else {" in the kernel code.

> 		pm_runtime_get_noresume(&port_dev->child->dev);
> 		pm_runtime_barrier(&port_dev->child->dev);
> 		if (port_dev->child->dev.power.runtime_status
> 				=3D=3D RPM_SUSPENDED) {
> 			retval =3D pm_runtime_suspend(&port_dev->dev);
> 			if (!retval)
> 				port_dev->power_on =3Dfalse;
> 		}=09
> 		pm_runtime_put_noidle(&port_dev->child->dev);
> 	}

Hmm.  If child->dev is not suspended, then our usage_count should be
at least 1, so pm_runtime_suspend(&port_dev->dev) shouldn't actually
suspend us.  Isn't that the case?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
