From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Sun, 29 Apr 2007 08:55:52 +1000
Message-ID: <1177800952.7652.4.camel@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0704281035530.31211-100000@netrider.rowland.org>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3374570960326216389=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704281035530.31211-100000@netrider.rowland.org>
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


--===============3374570960326216389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-U/YPsBImIs1N4bJH1vj6"


--=-U/YPsBImIs1N4bJH1vj6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2007-04-28 at 10:42 -0400, Alan Stern wrote:
> On Sat, 28 Apr 2007, Nigel Cunningham wrote:
>=20
> > Hi Alan.
>=20
> > Sorry. I thought you were wrong for a minute, but then I looked again a=
t
> > the messages in my dmesg...
> >=20
> > [   33.944214] Device driver usbdev1.1_ep00 lacks bus and class support=
 for being resumed.
> > [   34.051765] Device driver usbdev1.1_ep81 lacks bus and class support=
 for being resumed.
> > [   34.113740] Device driver usbdev2.1_ep00 lacks bus and class support=
 for being resumed.
> > [   34.221541] Device driver usbdev2.1_ep81 lacks bus and class support=
 for being resumed.
> > [   34.251562] Device driver usbdev3.1_ep00 lacks bus and class support=
 for being resumed.
> > [   34.361345] Device driver usbdev3.1_ep81 lacks bus and class support=
 for being resumed.
> >=20
> > They're coming from the other printk, of course.
> >=20
> > > Now perhaps you would prefer to check the USB interface drivers -- th=
ere=20
> > > are many of them, and quite a few don't have suspend or resume method=
s. =20
> > > You would need to modify usb_register_driver() instead of=20
> > > usb_register_device_driver().
> >=20
> > Would they be the ones covered above?
>=20
> No.  As Greg pointed out, these usbdevXX_epYY "devices" are nothing but=20
> placeholders at the moment.  They don't actually do anything and they hav=
e=20
> no need for power management.  (But they do manage to clutter up the=20
> system log with lots of extraneous warnings from the PM core...)

Ok, so they could have the pm_safe flag set to suppress the message.

> > > On the other hand, the drivers' maintainers are probably quite aware =
of=20
> > > the missing PM support, so it's not clear that printing out warning=20
> > > messages will actually help anybody.
> >=20
> > It can help the user, when they're looking for possibilities as to why =
things aren't working.
>=20
> Maybe.  But the warnings will occur when the driver is registered, which=20
> is often long before the problem shows up.  The user may not make the=20
> connection.

True, but if we make them show up earlier, they at least have a chance
to see what might cause problems before the problems occur. If we do it
at the time, they might have zero chance to see messages like this.

> On a completely different topic: Nigel, now's your big chance!  If you=20
> hurry, you can rename Suspend2 to Hibernate -- beating out Pavel, who wil=
l=20
> then be forced to rename swsusp to Hibernate2!  :-)

LOL. I don't care about names, or about beating Pavel at anything. I
just want to get better hibernation support in the kernel. It would be
nice to get rid of that awful swsusp name though! :)

Nigel

--=-U/YPsBImIs1N4bJH1vj6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGM9D4N0y+n1M3mo0RAjJGAJ9P95BRDimz4RXqXJvePOhXWBmERQCeKzmL
jznhs02bOhWNtKNRqagMEvk=
=/y9a
-----END PGP SIGNATURE-----

--=-U/YPsBImIs1N4bJH1vj6--


--===============3374570960326216389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3374570960326216389==--
