From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
Date: Tue, 28 Mar 2017 17:47:54 +0100
Message-ID: <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
 <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
 <1490704781.3546.57.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq5wqvcw3yjjd6ix"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490704781.3546.57.camel-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--wq5wqvcw3yjjd6ix
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 03:39:41PM +0300, Leonard Crestez wrote:
> On Fri, 2017-03-24 at 12:52 +0000, Mark Brown wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > to the supply.=A0=A0Usually bypass is used for low power retention modes
> > with different settings to those used in normal operation that wouldn't
> > be desired in normal operation, if we were going to have constraints for
> > this I'd expect a separate set used during bypass.

> In this particular case it's not possible to set constraints on the parent
> regulator so that both ldo-enable and ldo-bypass modes work. The maximum =
allowed
> voltage for ldo-bypass is lower than the minimum required to support the =
chip at
> max frequency wit ldo-enable.

If things are really so sensitive that you can't bypass without lowering
the voltage then it's hard to see how you can safely transition into and
out of bypass mode. =20

> I'm not sure I understand why you are against applying constraints to the=
 parent
> when in bypass mode, it seems like the obvious thing to do if you want to
> support flexible configuration. The check I introduced is probably not en=
ough to
> cover all cases, for example it would still be possible to explicitly cha=
nge
> parent voltage afterwards.

To repeat what I said previously the whole point of bypassing is to not
do regulation and generally the constraints in the unregulated idle case
are substantially more relaxed.  This would break use cases relying on
the existing behaviour which wouldn't expect to affect the parent
voltage at all, either stopping things working or making them less
efficient by needlessly regulating the voltage down which defeats the
main point of bypassing.

--wq5wqvcw3yjjd6ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljak7kACgkQJNaLcl1U
h9CqTwf/TSRcy61GFRGr0tnkhFhjr7ToIDfLW7vP3slRHtakPK63C0vsNK5sxcOW
VO/aOQOvzWSFd6oW33hAvUv3DmHYOvUu9X0U2DXMhH0rwXhhjh2Ph2CkcdAkbZ13
5J+Q5X3vUxOEdFnh05hMRA0nGQ+9aNHhvgI4GfZBtJmjG1tB00Bma4OeKvYnam6X
JCSeRp8KquTbsOVt0qj41nABpPetd39VZYFnaHbPNFHSDt2KPhVGct4oOkcl74oX
oB0T1XO2V2dGnUEauh2QW77Vk2ShrivTmnBfl7Oo4LEmkpFkB6PEZ+dfDlnDYqd3
TiarJ7x4WoDdKuHjW7DXwe4AGZL5EQ==
=E/La
-----END PGP SIGNATURE-----

--wq5wqvcw3yjjd6ix--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
