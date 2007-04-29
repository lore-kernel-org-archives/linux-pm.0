From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Sun, 29 Apr 2007 17:47:11 +1000
Message-ID: <1177832831.7652.12.camel@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0704281035530.31211-100000@netrider.rowland.org>
	<1177800952.7652.4.camel@nigel.suspend2.net>
	<20070429065051.GA31628@kroah.com>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7935035733568480538=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070429065051.GA31628@kroah.com>
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
Cc: linux-pm@lists.osdl.org, Pekka J Enberg <penberg@cs.helsinki.fi>, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


--===============7935035733568480538==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SRtflg05GGiFnp/F1K0L"


--=-SRtflg05GGiFnp/F1K0L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2007-04-28 at 23:50 -0700, Greg KH wrote:
> On Sun, Apr 29, 2007 at 08:55:52AM +1000, Nigel Cunningham wrote:
> > Hi.
> >=20
> > On Sat, 2007-04-28 at 10:42 -0400, Alan Stern wrote:
> > > On Sat, 28 Apr 2007, Nigel Cunningham wrote:
> > >=20
> > > > Hi Alan.
> > >=20
> > > > Sorry. I thought you were wrong for a minute, but then I looked aga=
in at
> > > > the messages in my dmesg...
> > > >=20
> > > > [   33.944214] Device driver usbdev1.1_ep00 lacks bus and class sup=
port for being resumed.
> > > > [   34.051765] Device driver usbdev1.1_ep81 lacks bus and class sup=
port for being resumed.
> > > > [   34.113740] Device driver usbdev2.1_ep00 lacks bus and class sup=
port for being resumed.
> > > > [   34.221541] Device driver usbdev2.1_ep81 lacks bus and class sup=
port for being resumed.
> > > > [   34.251562] Device driver usbdev3.1_ep00 lacks bus and class sup=
port for being resumed.
> > > > [   34.361345] Device driver usbdev3.1_ep81 lacks bus and class sup=
port for being resumed.
> > > >=20
> > > > They're coming from the other printk, of course.
> > > >=20
> > > > > Now perhaps you would prefer to check the USB interface drivers -=
- there=20
> > > > > are many of them, and quite a few don't have suspend or resume me=
thods. =20
> > > > > You would need to modify usb_register_driver() instead of=20
> > > > > usb_register_device_driver().
> > > >=20
> > > > Would they be the ones covered above?
> > >=20
> > > No.  As Greg pointed out, these usbdevXX_epYY "devices" are nothing b=
ut=20
> > > placeholders at the moment.  They don't actually do anything and they=
 have=20
> > > no need for power management.  (But they do manage to clutter up the=20
> > > system log with lots of extraneous warnings from the PM core...)
> >=20
> > Ok, so they could have the pm_safe flag set to suppress the message.
>=20
> No, we don't want a flag just to shut up a message, that's the first
> thing a developer will do when they see that message, without realizing
> what exactly they should be doing instead.
>=20
> Trust me, I know the lengths kernel developers go to to try to work
> around "helpful hints" that the kernel can spit out at you :(

Ok, then. So... what would you suggest (if anything)?

Regards,

Nigel

--=-SRtflg05GGiFnp/F1K0L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGNE1/N0y+n1M3mo0RAgx8AJ9qBKTVnod3BdF+evOahBP/xvwUfACg15kz
sYrQ0cS8hMCUMIAFW+/N8SM=
=sbB2
-----END PGP SIGNATURE-----

--=-SRtflg05GGiFnp/F1K0L--


--===============7935035733568480538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7935035733568480538==--
