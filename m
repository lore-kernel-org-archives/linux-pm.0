From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Sat, 28 Apr 2007 07:38:17 +1000
Message-ID: <1177709898.4737.162.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
	<20070427154020.GA11190@kroah.com>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0572663068509646950=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427154020.GA11190@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


--===============0572663068509646950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zeH9Bg7wldaA43U4F3S8"


--=-zeH9Bg7wldaA43U4F3S8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, 2007-04-27 at 08:40 -0700, Greg KH wrote:
> On Fri, Apr 27, 2007 at 03:25:46PM +0300, Pekka J Enberg wrote:
> > From: Nigel Cunningham <nigel@nigel.suspend2.net>
> >=20
> > Add power management related debugging into driver core. Make the
> > kernel complain if a device driver lacks bus and class support for
> > resume or if a PCI or USB driver does not have a driver specific
> > resume function.
> >=20
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> > ---
> >  drivers/base/core.c       |   13 +++++++++++++
> >  drivers/pci/pci-driver.c  |    6 ++++++
> >  drivers/usb/core/driver.c |    6 ++++++
> >  include/linux/device.h    |    1 +
> >  4 files changed, 26 insertions(+)
> >=20
> > Index: 2.6/drivers/base/core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- 2.6.orig/drivers/base/core.c	2007-04-27 14:42:13.000000000 +0300
> > +++ 2.6/drivers/base/core.c	2007-04-27 14:43:14.000000000 +0300
> > @@ -652,6 +652,18 @@ int device_add(struct device *dev)
> >  				class_intf->add_dev(dev, class_intf);
> >  		up(&dev->class->sem);
> >  	}
> > +
> > +#ifdef CONFIG_PM
> > +	if (!((dev->class && dev->class->resume) ||
> > +	      (dev->bus && (dev->bus->resume || dev->bus->resume_early))) &&
> > +	    !dev->pm_safe) {
> > +		printk(KERN_WARNING "Device driver %s lacks bus and class "
> > +				    "support for being resumed.\n",
> > +				    kobject_name(&dev->kobj));
> > +		dump_stack();
> > +	}
> > +#endif
>=20
>=20
> I think you are reporting the wrong thing here, we want to know about
> the busses and classes without suspend support, not the individual
> devices, right?

Yeah, I suppose you're right. I started off seeking to make a message
for each device lacking anything that would save its state. Guess I got
muddled somewhere :)

> And dumping stuff like this to the log for every bus/class isn't the
> nicest :(
>=20
>=20
> > +
> >   Done:
> >   	kfree(class_name);
> >  	put_device(dev);
> > @@ -989,6 +1001,7 @@ struct device *device_create(struct clas
> >  	dev->class =3D class;
> >  	dev->parent =3D parent;
> >  	dev->release =3D device_create_release;
> > +	dev->pm_safe =3D 1;
>=20
> I don't understand the use of this flag, it looks like it is only being
> set, which doesn't really make it very useful.

The use was above (!dev->pm_safe).

Regards,

Nigel


--=-zeH9Bg7wldaA43U4F3S8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMm1JN0y+n1M3mo0RAuC4AJ4y4WyYdbdCPYLGxnAqfmJPhskOegCgtS7u
jtg37K3f6AewYYVZQwqTp+A=
=f649
-----END PGP SIGNATURE-----

--=-zeH9Bg7wldaA43U4F3S8--


--===============0572663068509646950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0572663068509646950==--
