From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 03:36:05 +0600
Message-ID: <20110616213605.GI7253__266.445233910595$1308261961$gmane$org@belkar.wrar.name>
References: <20110616201228.GG7253@belkar.wrar.name>
	<Pine.LNX.4.44L0.1106161656190.1697-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5571555686406604179=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106161656190.1697-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============5571555686406604179==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2011 at 04:57:59PM -0400, Alan Stern wrote:
> > > > When I try to suspend my ASUS K53E laptop, the process hangs after
> > > > spinning down the disk unless I unload ehci_hcd. This happens on 2.=
6.38,
> > > > 2.6.39 and 3.0-rc3+. Some details are at
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D37632
> > > > What additional info can I provide to help fix this if this is poss=
ible?
> > > Set CONFIG_USB_DEBUG=3Dy and boot with "no_console_suspend" on the=20
> > > command line.  What appears on the console when the system is hung?
> > PM: Entering mem sleep
> > usb usb2: usb auto-resume
> > sd blah-blah syncing cache
> > ehci_hcd 0000:00:1d.0: resume root hub
> > usb 1-1.1: usb suspend
> > sd blah-blah stopping disk
> > hub 1-1:1.0: hub_suspend
> > usb 1-1: unlink qh256-0001/ffff88013b411000 start 1 [1/0 us]
> > usb 1-1: usb suspend
> >=20
> >=20
> > and that's all.
>=20
> Okay, the next step is to try and find out exactly where the ehci=20
> suspend procedure is hanging.  The patch below adds a bunch of=20
> printouts at various spots throughout the procedure.  Let's see what=20
> shows up.
I don't see any of these new messages.

--=20
WBR, wRAR

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+ndFAAoJEDNi9wMaSZLhQpUQAJZahIkGge76dJNeR9ejurgw
eSlClF9tEIJENPtBdH2xYaGY+yodwC7z2SX3zaL4ltakz5SjCE1NzTEN9pBDOtHj
vSrmY0wS8nELviBOIDHRlo815nDvjC9AJaBUZ8YElLHTuw0n8qVyntKQALLA20tq
yMERiRhwD8z1374VosLNwUyZgMXVhCEcgcJWwP64nb4kVjxM1Nv/5yWP7aZEMvyE
3uYeDI4a5zXZrRG71+YoToFEKB7nPKcPiMgol2D1XA5hm3ovLbRA4IK+buDS0312
dbeBgIoygUzpBtu8YX1fBF3Ig4paGXOYrbR+COeohgvN0CQIaaTgXx4qM1gxY3/s
wG/8uVD0IuroFBJu2qtsmKXZdKmcoJEBtW5yEK4UK1oJByQYAlgxnUUwbsoxU2Jj
5k06ucCi0VVMHWwAynrZgF4scmP4lqCvqE6nqdEy+eowXk/BlwciE9UyC9u3S1dJ
Mv4BwLmhSb45JHYGSq1BsT8oDMAwxYI21W+FZ95iC5LKjxww2a1pCFWhL3cdKu25
Qua11C3GCKUXnrk0romS5HoSKCVuFgRvx50lpGHkDALzDcma3zdvXyezizwZ3Rmh
kG9veeC7eJS2ijIBJUQd+ls/NQYQ5t9UTVxISerZIy30js6Z4heZDw/sy3RqRgz4
GHqqu7ytIEliVTSxcrag
=8ya0
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--

--===============5571555686406604179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5571555686406604179==--
