From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend to RAM (embedded) ppc?
Date: Mon, 26 Jun 2006 08:13:16 +0200
Message-ID: <1151302397.7608.73.camel@localhost>
References: <Pine.LNX.4.60.0606241957470.22786@poirot.grange>
	<17565.58599.858812.278800@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0606252034260.9893@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1042571202=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0606252034260.9893@poirot.grange>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1042571202==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NSC6ftwpRHRjv53B1CnG"


--=-NSC6ftwpRHRjv53B1CnG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-06-25 at 20:36 +0200, Guennadi Liakhovetski wrote:

> So, there's not a single STR implementation for ppc in the kernel?...

powerbooks and ibooks can suspend but all the code for that goes through
the via-pmu ioctl, not the generic stuff.

johannes

--=-NSC6ftwpRHRjv53B1CnG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJ96+qVg1VMiehFYAQLMdQ//bAdhGxFtckHMT+rcs6zi2xGLw9ynefx7
TGKwo2104n+WM+8Ny0Sz50Z2sXpZWnTEin37zH9N3aao22CXQ1otChpeMh5w/+vF
7ahy/cfOVtATCHbWDnxjhXx3SRXW0mB+/dVYF7Em5yuqgovgbQuk1FrtJMZDesOK
BanEDc0sC8beBK0LIv7iT3GvOft6M/DGldRDv6wJ34Xh1owrvzvIoQUZkAF0yYnI
DvbfiUfsmIk0RLEuVvSYNjKMPIqFITjXHkMWRKFKI9imdqV1oNYul3n1Wdfh2/1G
ySP81CgTXRBxICwBiWWqZqqLXaIbox25Pu6Nhxp5CHk9UAnudPw8Lz7BaIv6+bD+
mghL3JlNWJ0aUMpHVgnLBRwCZ1+MS6kzcPoWqxfqnM90haI8yu61FnrsQy67kPdh
4xWFXnotYHi01/pzoe6Edr0rw3Qhd5a47vLGIW2enOsr6iK6DvnHKqZTP7fR7RJ3
cxpx9s9AD0XV+LOVCuD6+uQo6YXzFnhEwm/CsCqYVJxgZxWU3O+3Xs6kvTWDz7r5
iBAMW2n1d7DhPpooi6fT4V81CvGlgHCvGxvn2qTMJ7fTg4gSegG9L1eBqxcN9GEl
BXVDHuj/7njHH69/q+zbVDSYP4FfX7EPaUe8NQYGTOf4LnkNopLgGU3YgXtfXrcE
c4Hfn5/riKs=
=T2XJ
-----END PGP SIGNATURE-----

--=-NSC6ftwpRHRjv53B1CnG--


--===============1042571202==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1042571202==--
