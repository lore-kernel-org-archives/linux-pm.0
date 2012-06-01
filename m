From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Fri, 1 Jun 2012 22:01:06 +0600
Message-ID: <20120601160106.GD4879@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1206011046460.1610-100000@iolanthe.rowland.org>
	<1338565844.13348.468.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4157941585706230064=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338565844.13348.468.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?iso-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============4157941585706230064==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2012 at 11:50:44AM -0400, Steven Rostedt wrote:
> > > > @@ -1743,6 +1743,11 @@ int pci_prepare_to_sleep(struct pci_dev
> > > >  	if (target_state =3D=3D PCI_POWER_ERROR)
> > > >  		return -EIO;
> > > > =20
> > > > +	/* Some devices mustn't be in D3 during system sleep */
> > > > +	if (target_state =3D=3D PCI_D3hot &&
> > > > +			(dev->dev_flags & PCI_DEV_FLAGS_NO_D3_DURING_SLEEP))
> > > > +		return 0;
> > > > +
> > >=20
> > > Why do you want to skip the wakeup setting in that case?
> >=20
> > Because that's what the 151b61284776 commit did.  Also, the quirk marks=
=20
> > the controller as not wakeup-capable.
> >=20
> > Still, it's worth testing.  Andrey and Steve, here's an updated patch=
=20
> > which should leave wakeup enabled on your EHCI controllers.  If you=20
> > don't have a USB keyboard handy for generating a wakeup signal, you=20
> > can test the wakeup functionality by doing:
> >=20
> > 	echo enabled >/sys/bus/usb/devices/usb1/power/wakeup
> > 	echo enabled >/sys/bus/usb/devices/usb2/power/wakeup
> >=20
> > before suspending.  (In fact you need only one of those two lines, but
> > at the moment I forget which -- probably the usb2 one.)  Then while
> > the system is asleep, either plugging or unplugging a USB device
> > directly into the computer should cause it to wake up.
>=20
> I applied the patch, it suspends and resumes fine, but still no wakeup.
>=20
> I even plugged in a USB keyboard, suspended, and tried to wake it up
> with that. That did not work. I even enabled what you stated above, with
> no effect (with keyboard or usb storage).
The same here, and the keyboard LEDs turn off on suspending.

--=20
WBR, wRAR

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPyOdCAAoJEDNi9wMaSZLhGYIP/icdemzbOVqk+TWtBxo94ugb
4BpZzIhVbIFOr6t2ZhBfFocCEJwikc8Q5nOzN1mkKSgh5mSC4HH9iAJ2mbToxPQ9
M/HD6ycLVFhehgxFg743hd0BIcD8CD5Kh0iJ7LL2FkkXuvXLT/N7ar0cIHHPXeGc
KQAxmV3f9oKOfV16/QboyoULBWqV3rGhAuDTltjCpKG7YZ89FAI+sCLps83IbqTo
og/ZzpUIB18u9d/yZ+T6kHEwc4TZX4k3IDIwoV0tbO8rTSgg4hQWSLkD++2EuZsC
s9XDdnCYtkV71WwnSKTnUGW4MinNy2ifKsHeWanmR7xAj74GFBdRXWxRL+5UYxkN
dVCIRD+H1K44pu0oEBDtWfsnvur1dthWP+XAzhMBoqTXvySV13PgmE2tEarTMUGU
y6Et6EuZknPRzAJ5cm8D3RXXCE3qqjnbv9xrZkKWTSr2YA1Z94aHZ+P/O3SvUkAa
U7eRMkFhPUSmX16rnghk/qOmZeP54hUv+/JJTDDJKUV6nHEEUOxm1nrFfElNKN1b
O5BCGVEo1h95jfqpzrnznT3+4RysFgEE3m5lqbsCf/Qw6xWjrmgF+WuQp0VZ3HFL
DJPC/x9K5ZHYDkNzQUa1TNlogZwN3jmlxGraJXuoRhN4cCDJQtIZOYyF+cXryy+5
I8/FtFi6KQ9BXsOKYCsU
=f9dz
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--

--===============4157941585706230064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4157941585706230064==--
