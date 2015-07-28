From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 10/19] drm/tegra: dc: Prepare for generic PM domains
Date: Tue, 28 Jul 2015 13:20:32 +0200
Message-ID: <20150728112030.GA10949@ulmo.nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-11-git-send-email-jonathanh@nvidia.com>
 <20150717104154.GM3057@ulmo>
 <55B73D8C.103@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B73D8C.103-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2015 at 09:30:04AM +0100, Jon Hunter wrote:
>=20
> On 17/07/15 11:41, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Mon, Jul 13, 2015 at 01:39:48PM +0100, Jon Hunter wrote:
> >> Add support to the tegra dc driver for generic PM domains. However,
> >> to ensure backward compatibility with older device tree blobs ensure
> >> that the driver can work with or without generic PM domains. In order
> >> to migrate to generic PM domain infrastructure the necessary changes
> >> are:
> >>
> >> 1. If the "power-domains" property is present in the DT device node th=
en
> >>    generic PM domains is supported and pm_runtime_enable() should be
> >>    called for the device. Furthermore, the enabling and disabling of t=
he
> >>    power-domain is handled via calling pm_runtime_get/put, respectivel=
y.
> >=20
> > The device could be PM runtime enabled even if no power-domains property
> > is set. Couldn't we check something more direct, like for example if the
> > dev->pm_domain is non-NULL?
>=20
> Yes could do that instead.
>=20
> > Perhaps it'd be worth converting the driver to use runtime PM first, and
> > move all the powergate and clock handling into suspend/resume functions,
> > and then we can conditionalize whether or not we call the legacy API iff
> > dev->pm_domain =3D=3D NULL?
>=20
> May be that would be a cleaner transition than trying to do it all in
> one go.

I have a couple of patches in my tree to do this for DRM as part of an
effort to restore DPMS. It's fairly tricky to get right in DRM and
requires all sorts of changes to the driver.

Thierry

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVt2V8AAoJEN0jrNd/PrOhp7MQAJHgAvjhigg/VOM7XE1Rm4jR
B+aBEzaaI6KOToKsFP48aSe62njCJDMS/5iuFUcf8nRQJY4+sAEn9q82okgOdAfq
lzvYclRKymA6oQjM8QurhmLc7dKT4zMCu4YtM3Pkft7Qcqhryc4g2TqVrDzu2geU
2Aq0IXR5Feud270X5jjVZ67g8+rSfJ4T/RO0aacz+7Qq5jmJeryL8766T2OMHXHN
zE11C9vyqrLqcHIsJ3kMfCEoRSjCj8+B3RLgWJEqZj47kkbeZyO0dW0yJFDwyYjG
uiisT0YezbPbuuEgYxx1YGjmLFwWVkAiBu3+gTMMyF48OB1KCBTNWzXrR4gtCKeR
jd2fGGcKdsj1Nra4uIdHg603i0lgsk1trV/Fvovl31NDc+EoVciT5q6j4c1Lp0p4
nPDigbPexMxKt241Tf12smYgkoM2H++UJsJaMMaYOOhEK8xC437a1Kx0sYnBT2z/
xccK20sfwFuhel1qTKkGwM5XKivqSN03XUCi/icgo/4b+Z9i0tj/Zp1ChJolapwB
38KhhTYLb7QOp37HjCtreKdI5QcHOK9mFlR8QLDBdWEzizy6+fmngHHbeIZxx7zX
rJtfAZB2B8Qo5utzoAQ/7V1i6d05pgow1eUVamafn3OdsV2ZjyUtLS6xrLsDX/Ei
KKd3t9ea4f1FEZjYkMn7
=VKtG
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
