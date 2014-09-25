From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
Date: Thu, 25 Sep 2014 07:59:55 +0200
Message-ID: <20140925055953.GA12423@ulmo>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
 <1408616242-21009-5-git-send-email-mperttunen@nvidia.com>
 <20140924191829.GA16529@developer>
 <54231C3D.6040900@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54231C3D.6040900-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, juha-matti.tilli-X3B1VOXEql0@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2014 at 10:32:13PM +0300, Mikko Perttunen wrote:
> On 09/24/2014 10:18 PM, Eduardo Valentin wrote:
> >
> >Mikko,
> >
> >On Thu, Aug 21, 2014 at 01:17:22PM +0300, Mikko Perttunen wrote:
> >>...
> >>+
> >>+static int enable_tsensor(struct tegra_soctherm *tegra,
> >>+			  const struct tegra_tsensor *sensor,
> >>+			  struct tsensor_shared_calibration shared)
> >>+{
> >>+	void * __iomem base =3D tegra->regs + sensor->base;
> >
> >I get sparse complaining about this declaration. For the sake of keeping
> >a clean static checks, can you please:
> >-       void * __iomem base =3D tegra->regs + sensor->base;
> >+       void __iomem * base =3D tegra->regs + sensor->base;
> >
>=20
> Sure.
>=20
> >Can you also please check the remaining sparse errors?
> >   CHECK   drivers/thermal/tegra_soctherm.c
> >   drivers/thermal/tegra_soctherm.c:260:43: warning: incorrect type in
> >   initializer (different address spaces)
> >   drivers/thermal/tegra_soctherm.c:260:43:    expected void *[noderef]
> >   <asn:2>base
> >   drivers/thermal/tegra_soctherm.c:260:43:    got void [noderef]
> >   <asn:2>*
> >   drivers/thermal/tegra_soctherm.c:271:9: warning: incorrect type in
> >   argument 2 (different address spaces)
> >   drivers/thermal/tegra_soctherm.c:271:9:    expected void volatile
> >   [noderef] <asn:2>*addr
> >   drivers/thermal/tegra_soctherm.c:271:9:    got void *
> >   drivers/thermal/tegra_soctherm.c:279:9: warning: incorrect type in
> >   argument 2 (different address spaces)
> >   drivers/thermal/tegra_soctherm.c:279:9:    expected void volatile
> >   [noderef] <asn:2>*addr
> >   drivers/thermal/tegra_soctherm.c:279:9:    got void *
> >   drivers/thermal/tegra_soctherm.c:281:9: warning: incorrect type in
> >   argument 2 (different address spaces)
> >   drivers/thermal/tegra_soctherm.c:281:9:    expected void volatile
> >   [noderef] <asn:2>*addr
> >   drivers/thermal/tegra_soctherm.c:281:9:    got void *
> >   drivers/thermal/tegra_soctherm.c:347:25: warning: incorrect type in
> >   argument 1 (different address spaces)
> >   drivers/thermal/tegra_soctherm.c:347:25:    expected void const *ptr
> >   drivers/thermal/tegra_soctherm.c:347:25:    got void [noderef]
> >   <asn:2>*regs
> >   drivers/thermal/tegra_soctherm.c:349:37: warning: incorrect type in
> >   argument 1 (different address spaces)
> >   drivers/thermal/tegra_soctherm.c:349:37:    expected void const *ptr
> >   drivers/thermal/tegra_soctherm.c:349:37:    got void [noderef]
> >   <asn:2>*regs
> >   drivers/thermal/tegra_soctherm.c:271:9: warning: dereference of
> >   noderef expression
> >   drivers/thermal/tegra_soctherm.c:279:9: warning: dereference of
> >   noderef expression
> >   drivers/thermal/tegra_soctherm.c:281:9: warning: dereference of
> >   noderef expression
> >
>=20
> Most of these seem to be caused by the above-mentioned swapping of __iomem
> and *. The ones on lines 347 and 349 are more peculiar, though. Apparently
> sparse doesn't like using IS_ERR and PTR_ERR on the void __iomem * pointer
> returned by devm_ioremap_resource. Looks like this has been discussed bef=
ore
> (https://lkml.org/lkml/2013/6/17/216) and sparse should have been patched=
 to
> ignore this situation, so I'm not sure why it's complaining about it.
> Anyway, there shouldn't be any issue here.

If I apply the change suggested by Eduardo above then all of the above
warnings go away for me. That's with sparse 0.5.0. According to the
email thread above a patch for this was applied in 0.4.5.

Thierry

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI69ZAAoJEN0jrNd/PrOhxN4P/iNBVWAAxC39mr9zEliC9aXY
XszUMWP2PUyfXCCzfKQJeD9Nj8cdZ2RJw3vIO2MwXCLDwtntjoSptGVGzseIBCxc
9zn3XcI25QRe+/0mYNa2fPyEP0JzcqmIAxxB/OEp2sYXWz+/bC+EyUy7pKJGA3Oi
m82L2IFFFS3dPfsM75cxz94hNOGY9LpQqwIu03NBy60hw+aNhIqnSQbqNbJZFVq8
s88jVhblclPR5RFscXIQLoZp7cNnAsJ9EEq5/iVbe+PSkq+rfltg2Fa2ae+qUz+X
BXC1eoDcV+eiua29yrUExI9XYpmQm08fT91ixpx+IuQNmyLtAWHkNyGHjwqLuI99
SrNqrAmL/2o/LgtwhdsRULc/I21r5+prSsrn8eeb/5ARkET+Zp/FQPb8EC6x+qze
DEdkpZt3QUPN9i6SJvNli+SHV+P6Eql0qs+DXXMF84WoEb0NfSDA9btxfJomT4Dd
En1s0wtHI6KivyjSmRZwvpmRvCUFksZAcTOY2t8dr/AtSssIqzZqzeL1n7tVRLhC
VapenNFowk1ATLbtGwefiRFnzlg6DmbIxapG69/WVKXuJXCn5Cg6A6abyc8pjbkt
rMptF7O2CB2vTM2y6WXn8OZxwN8EbF75oI0RMIvzXA31x52+nwg8mxvd6QBz+54X
8Y7PXr0re0m2GovBwlGC
=Ckmc
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
