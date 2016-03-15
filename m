From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 08/12] of: add notes of critical trips for soctherm
Date: Tue, 15 Mar 2016 12:52:00 -0700
Message-ID: <20160315195159.GC26619@localhost.localdomain>
References: <1457665860-30003-1-git-send-email-wni@nvidia.com>
 <20160314210027.GA4740@localhost.localdomain>
 <56E7BE87.405@nvidia.com>
 <56E7C457.5000301@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56E7C457.5000301-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 04:14:15PM +0800, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 15:49, Wei Ni wrote:
> >=20
> >=20
> > On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 05:00, Eduardo Valentin wrote:
> >> * PGP Signed by an unknown key
> >>
> >> On Fri, Mar 11, 2016 at 11:11:00AM +0800, Wei Ni wrote:
> >>> The "critical" type trip in thermal zone can be
> >>> set to SOC_THERM hardware, it can trigger shut down
> >>> or reset event from hardware.
> >>>
> >>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/thermal/tegra-soctherm.txt | 12 ++=
++++++++++
> >>>  1 file changed, 12 insertions(+)
> >>
> >> I did not see in your patch set an update on the compatible string for
> >> the new chip. Did I miss something?
> >=20
> > As I said in the previous [00/12], the "commit 193c9d23a0f0" already ad=
ded the
> > compatible string. At that time, it just used current tegra_soctherm.c =
driver to
> > support Tegra210, it can work, but can't show temperatures correctly.
>=20
> Oh, sorry, I made a mistake, this "commit 193c9d23a0f0" just added the
> compatible string, did not use current tegra_soctherm driver to support T=
egra210.

Ok. got it. The binding is done, but the driver is being re factored only
now to add the support for this chip version.

>=20
> Wei.
>=20
> >=20
> >>
> >> * Unknown Key
> >> * 0x7DA4E256
> >>

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6GfdAAoJEMLUO4d9pOJW3OQIAJGVACOu7bAGhS+tV8ytGig8
GxLFYPj5fO2HuEhoQk5UKyFGzg0nV/oDPm8O4Tt6frFilgi9CpKPiZ2yGH/8DDsN
QhviotF3iSmXoKagm8oSY97W0e+2hSbyx8OyENU+r5CeT+vp7H6xQEJEqIbZgdkN
x7D+O3t4xDpU5TsBx7aFV7mPFYkKGFbSTOAD+k1kBLbrhv44H0MphS+4AdzMqpds
s3NI6C/rYXjpkpEhv5iG5jNJBqUVARbz0Kp14kqZT1FLYmqEKwkoVgTqYh8+j36i
OOoI0/8x5l/yT/EiJxWx2cVjhEWK1HwiXSFAP3i3OWTi9fHkDSESgGl5/w6SSMU=
=gS21
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
