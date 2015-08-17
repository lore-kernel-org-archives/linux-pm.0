From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Mon, 17 Aug 2015 18:58:16 -0500
Message-ID: <20150817235816.GA5621@saruman.tx.rr.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
 <f3bfd04bc157e97e2d0632b7ed2452f366f66488.1439519413.git.baolin.wang@linaro.org>
 <20150817010707.GC1864@shlinux2>
 <20150817172623.GO10748@sirena.org.uk>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150817172623.GO10748-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 10:26:23AM -0700, Mark Brown wrote:
> On Mon, Aug 17, 2015 at 09:07:08AM +0800, Peter Chen wrote:
> > On Fri, Aug 14, 2015 at 05:47:46PM +0800, Baolin Wang wrote:
>=20
> > > +	1500,
> > > +	1800,
> > > +	550,
> > > +};
>=20
> > Why 550 is the last, but not 1800?
>=20
> You'd have to ask the hardware engineers who designed the chip.  I
> suspect it's because 550 was added at a late stage in the design process
> but I'm basically just guessing there.
>=20
> > >   *******************************************************************=
**/
> > > @@ -606,8 +646,31 @@ static int wm831x_power_probe(struct platform_de=
vice *pdev)
> > >  		}
> > >  	}
>=20
> > > +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {
>=20
> > Where the wm831x_pdata->usb_gadget is initialized?
>=20
> It's platform data, it will be initialised by whatever registers the
> platform data.

passing pointers through pdata ?

--=20
balbi

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0nUYAAoJEIaOsuA1yqREUNgP/iumke66F36gyG04af1/s+VM
lIKszsGlpunYdaWKTJxriGPzpZRXCzn0J43bpcQgYrPvLQYItjeROXlPgrCTh0Th
PUum7E/lNd2vx8vHv4HNLwFxc7bJF945AUpnqXqS0MLQgWppkJ4DNRLMMRK5px2v
Q8MhaZoHOgWCp+OpQZIw5UOCq6QzQv7TZk7iDCQv+JJYwBgJuDWpmNZEQ/LerhMi
2wEWJsaBq2guvAO1eCSN+CSnjz3Uz7+B2BEGdi4L8GuWR/dzHwJJQ+/ZDgHXI1ee
alKVqPCOx2ozxLXcEnsRkcfReKgg6+4Uj+gC873aEMrI/gleCpzlfIWslc2SRW8w
QC/L/XyHNUtWe4FQ6XXgoBuZCaQUvYPH49tsJHoLUGscV17UVjk50inWNJEvdidk
MXObg2+du06Zmtz11IabQmGznDV0nCVX4Jl1RfqjFFYLLll+5i3hKeD9N4TorVim
UTX2uIvhWsnAvOknnakAoX2d8/zHK/qtx8TpUAWQDo2unJDEqBlyjXmCoJA/Nth+
LqrvDD8dH0n+CJvThJhTYHcPoCUK/S6T4abaiyvwgE/IsCeeXa2jn73OJ/sT12/Q
BDSoegtDLMDTV8oASE106FO8W9VcN6ooDa4CCmF1C72ixTysX369zEejlvbuJm1u
mn1VRLAcRslQdMigrN1u
=I1On
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
