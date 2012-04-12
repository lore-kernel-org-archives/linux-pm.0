From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 23:18:52 +0600
Message-ID: <20120412171852.GD12852@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204121247430.1496-100000@iolanthe.rowland.org>
	<1334250896.23924.340.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3803067891195562592=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334250896.23924.340.camel@gandalf.stny.rr.com>
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
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============3803067891195562592==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 01:14:56PM -0400, Steven Rostedt wrote:
> > Maybe that's the problem here.  Steve and Andrey, does it make any=20
> > difference to the behavior if you do
> >=20
> > 	echo on >/sys/bus/pci/devices/0000:00:1a.0/power/control
> >=20
> > (and likewise for 1d.0) before starting the system suspend?
>=20
> The two files already are set to "on" (without me doing anything)
Here too.

--=20
WBR, wRAR

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhw58AAoJEDNi9wMaSZLhQX4P/0WgXUYGb3pGPr1yBYJ6BvON
s4Q638c6aA+vsQuHXLnRCQ4cvmQiIvzk9aIuhdAOXG3owFVlEiKdJoIztUQDuQyN
R3zYnX9dD6XGK3CBSGovRsFkl5mtUmnm+66vbKhk2Ie/28hV11sIUyPMiK/PYgrN
NDhGt04XVUl0CqT8RdwukbYmCnFFfbdUhOtYC2L2rpWgSNtGX5GFBPmjrw3cydlO
LgyuinPpgs6ehdbtWXSr5luBCQv7M3gxkNM3X7cv9ORNqQ9eM4dwy+MStGY7WGcM
JTs5EVmytbfS+1cXW2AKaaxBYul2du5XPAfiCXb0lqI8+lxludKTIeLbY4wp14Pz
lJaRdbK6H0jY9nzZiSixSye3SomJ7q21RP96FbCDs1cL+BI4qlp1sHMJKZVUuQh1
ytgAtgo1nqrxTxBkHvemKCt4nxQcMYQ6Db9LsKL2oGX27vWuLiTHdws2cxWYR+rO
qHrTpsU9RFjm9kaYnwRZREOMRurbsDe5g/Ym1LWh3y+6gguX/Ld5PcWeRvJZS+JR
SqVZjQ74UVqwPOEkN6QTWlpB/zPdjxYC9j3eaI4Y3X4eekSlIZ1Bet+umCUii5cr
MMSFn6icvolk34OiE5W2i63aX527v57SzHbad5l0wNRvhqRrqLP8pnKYMBDOrRwy
b/SSef4QHd2gud9MNInH
=RnWd
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--

--===============3803067891195562592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3803067891195562592==--
