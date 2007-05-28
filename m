From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 18:30:26 +1000
Message-ID: <1180341026.14749.12.camel@nigel.suspend2.net>
References: <200705272229.21263.rjw@sisk.pl>
	<200705272231.54535.rjw@sisk.pl> <20070527204955.GA22202@srcf.ucam.org>
	<200705272345.04518.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2026220539276361525=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705272345.04518.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============2026220539276361525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TeYUmiz5EeRIrG0UU77U"


--=-TeYUmiz5EeRIrG0UU77U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sun, 2007-05-27 at 23:45 +0200, Rafael J. Wysocki wrote:
> On Sunday, 27 May 2007 22:49, Matthew Garrett wrote:
> > On Sun, May 27, 2007 at 10:31:53PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >=20
> > > Use a hibernation and suspend notifier to disable the firmware reques=
ting
> > > mechanism before a hibernation/suspend and enable it after the operat=
ion.
> >=20
> > This avoids the problem of .resume methods calling userspace while=20
> > userspace is frozen and a resulting hang, but does it actually result i=
n=20
> > the drivers beginning to work again?
>=20
> Well, this was acutally invented before you've decided to remove the free=
zing
> of tasks from the suspend code path (which I think is a mistake, but that=
's
> only my personal opinion, so it doesn't matter very much ;-)) and I regar=
d it
> as a workaround.

Suspend-to-ram code paths shouldn't assume userspace is unfrozen anyway.
Doesn't [u]swsusp have a code path like Suspend2 where we can suspend to
ram after writing the hibernation image? In that case, it will still be
possible that we seek to enter and leave S3 with processes frozen.

Apologies if anyone has already mentioned this - I'm just starting to
play catchup.

Regards,

Nigel


--=-TeYUmiz5EeRIrG0UU77U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGWpMiN0y+n1M3mo0RAsiAAKDgdGSlgBjRl4Yt5qHxrn6DYslkigCfYVXU
F3kwH+POpwElE+WiSataFXI=
=oI4M
-----END PGP SIGNATURE-----

--=-TeYUmiz5EeRIrG0UU77U--


--===============2026220539276361525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2026220539276361525==--
