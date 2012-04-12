From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 00:10:31 +0600
Message-ID: <20120412181031.GE12852@belkar.wrar.name>
References: <1334193773.23924.316.camel@gandalf.stny.rr.com>
	<Pine.LNX.4.44L0.1204121017460.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5594474269830154132=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121017460.1496-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============5594474269830154132==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 10:28:31AM -0400, Alan Stern wrote:
> Here's a diagnostic patch that will give us a little more information. =
=20
> Keep the previous change (so that pci_prepare_to_sleep gets called=20
> whether ehci-hcd is bound or not) and let's see what it says.  Try=20
> doing it both with and without ehci-hcd bound.  Running this with "echo=
=20
> devices >/sys/power/pm_test" ought to be good enough.
If bound: "target 3 wakeup 1 error 0" for both controllers. If not bound,
pci_prepare_to_sleep is not called for ehci_hcd.
>=20
> Alan Stern
>=20
>=20
>=20
> Index: usb-3.4/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/pci/pci.c
> +++ usb-3.4/drivers/pci/pci.c
> @@ -1720,6 +1720,9 @@ int pci_prepare_to_sleep(struct pci_dev
> =20
>  	error =3D pci_set_power_state(dev, target_state);
> =20
> +	dev_info(&dev->dev, "target %d wakeup %d error %d\n",
> +			target_state, device_may_wakeup(&dev->dev), error);
> +
>  	if (error)
>  		pci_enable_wake(dev, target_state, false);
> =20
>=20
>=20

--=20
WBR, wRAR

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhxqWAAoJEDNi9wMaSZLhEBgP/3LHV57uXrsZStNN/r2ASdtB
QfqDxvVJ9SeymKm4FuAsehCk8in/mJy/V/ejKA41TGTC05GBiGDquK1GjY9B536X
523Q+ZtAYzhnjuiPA2ZdeOonAyOGX3H+TaXX2vbqiaNPpAM8Ej9RQAE+EfxbAQy3
ELwM4/B7YDH3ZkJeGB2xyXHZ/t/KV/+58CrSH0hGP+Z2oH/YQ0ST5lnsfuGeVLtS
C22Vd7ZYESeMuW8Qh5T6H8R7vXIN2KZE8dQ3pJkFHINk4XKrr3X0jeMBZ1IQ115a
bXzlc1iVufFnamvdVFzWNjq0gPPeP2CHHrQOYmTEJ1nCjzH6VZMwtFiYrTjp6fBQ
D4IhW0anyQ+i4Ei6dhfnEFwfZ6LEZSy0qz+NsomMqdbxUrfnDOElJOHtkvG9Z7yE
uiaNMFaQ9A7A76oDuQo4kG8cgu7m8tZUop6e48OVyUi1T1G4KUezfspU/Ly5CUMC
3FTwCN34VwrfB3IVG9WRF+UcXTT3XZQtN7QO6OFWEQNXlK7Mku+u619yIypo790f
c7pw56046x+MFyRaQVFB0tukwRaUfXx5ic0jGywhfr+YVjm/5PIl/SVG+LdEbb1V
bJfdmRaAfld9bSyMBPxuPMDEMde+i45CurmbjC15GgPm09ylT+RsUjPQSsFGs9TI
umPA6QGtnTm1XteAqTCS
=gFyc
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--

--===============5594474269830154132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5594474269830154132==--
