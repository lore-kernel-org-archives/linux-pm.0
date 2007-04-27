From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Sat, 28 Apr 2007 07:25:59 +1000
Message-ID: <1177709159.4737.150.camel@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0704271004090.3430-100000@iolanthe.rowland.org>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1421835194844129454=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704271004090.3430-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


--===============1421835194844129454==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xYh/AHwnA7ToC+5Sl145"


--=-xYh/AHwnA7ToC+5Sl145
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Alan.

On Fri, 2007-04-27 at 10:08 -0400, Alan Stern wrote:
> On Fri, 27 Apr 2007, Pekka J Enberg wrote:
>=20
> > From: Nigel Cunningham <nigel@nigel.suspend2.net>
> >=20
> > Add power management related debugging into driver core. Make the
> > kernel complain if a device driver lacks bus and class support for
> > resume or if a PCI or USB driver does not have a driver specific
> > resume function.
>=20
> > Index: 2.6/drivers/usb/core/driver.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- 2.6.orig/drivers/usb/core/driver.c	2007-04-27 14:42:13.000000000 +0=
300
> > +++ 2.6/drivers/usb/core/driver.c	2007-04-27 14:43:14.000000000 +0300
> > @@ -721,6 +721,12 @@ 	int retval =3D 0;
> >  		pr_info("%s: registered new device driver %s\n",
> >  			usbcore_name, new_udriver->name);
> >  		usbfs_update_special();
> > +#ifdef CONFIG_PM
> > +		if (!new_udriver->resume)
> > +			printk(KERN_WARNING "USB driver %s lacks driver "
> > +					    "specific resume support.\n",
> > +					    new_udriver->name);
> > +#endif
> >  	} else {
> >  		printk(KERN_ERR "%s: error %d registering device "
> >  			"	driver %s\n",
>=20
> This part seems unnecessary.  There is only one USB device driver, it is
> built into the USB core, and it does have the appropriate methods. =20
> Checking isn't needed.

Sorry. I thought you were wrong for a minute, but then I looked again at
the messages in my dmesg...

[   33.944214] Device driver usbdev1.1_ep00 lacks bus and class support for=
 being resumed.
[   34.051765] Device driver usbdev1.1_ep81 lacks bus and class support for=
 being resumed.
[   34.113740] Device driver usbdev2.1_ep00 lacks bus and class support for=
 being resumed.
[   34.221541] Device driver usbdev2.1_ep81 lacks bus and class support for=
 being resumed.
[   34.251562] Device driver usbdev3.1_ep00 lacks bus and class support for=
 being resumed.
[   34.361345] Device driver usbdev3.1_ep81 lacks bus and class support for=
 being resumed.

They're coming from the other printk, of course.

> Now perhaps you would prefer to check the USB interface drivers -- there=20
> are many of them, and quite a few don't have suspend or resume methods. =20
> You would need to modify usb_register_driver() instead of=20
> usb_register_device_driver().

Would they be the ones covered above?

> On the other hand, the drivers' maintainers are probably quite aware of=20
> the missing PM support, so it's not clear that printing out warning=20
> messages will actually help anybody.

It can help the user, when they're looking for possibilities as to why thin=
gs aren't working.

Regards,

Nigel

--=-xYh/AHwnA7ToC+5Sl145
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMmpnN0y+n1M3mo0RAm8YAJ954JU+bx8+n6DgVx+2b/olnsuLNACfRI5F
gp09nz1b9xH73fPbGREenkw=
=MnDd
-----END PGP SIGNATURE-----

--=-xYh/AHwnA7ToC+5Sl145--


--===============1421835194844129454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1421835194844129454==--
