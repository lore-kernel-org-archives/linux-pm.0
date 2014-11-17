From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing
 for tegra driver
Date: Mon, 17 Nov 2014 13:01:07 +0100
Message-ID: <20141117120105.GH25699@ulmo>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
 <5465DDC5.6090301@kapsi.fi>
 <20141117114341.GF25699@ulmo>
 <20141117125013.3493a3a1@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141117125013.3493a3a1@amdc2363>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 12:50:13PM +0100, Lukasz Majewski wrote:
> Hi Thierry,
>=20
> > On Fri, Nov 14, 2014 at 12:47:33PM +0200, Mikko Perttunen wrote:
> > > Tested-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
> > >=20
> > > One potential issue I can see is that if the cpufreq driver fails
> > > to probe then you'll never get the thermal driver either. For
> > > example, Tegra124 currently has no cpufreq driver, so if
> > > CONFIG_CPU_THERMAL was enabled, then the soctherm driver would
> > > never be able to probe. But I don't really have a solution for this
> > > either.
> >=20
> > It doesn't seem like there's any code whatsoever to deal with cpufreq
> > within the soctherm driver, so deferring probe based on something
> > we're not using anyway seems rather useless.
>=20
> So, If I understood you correctly - this patch is not needed in the=20
> /tegra_soctherm.c:[tegra_defconfig] driver and can be safely omitted in
> v2 of this driver.

What I'm saying is that I don't think doing this mass conversion
wholesale is useful since none of the drivers register a cooling device
based on cpufreq. In other words: if you're not going to use a feature
there's no use testing for it.

Thierry

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUaeOBAAoJEN0jrNd/PrOhMScQALxuo3xQqZHolHCaayZspSGX
VWHuHVZsB3W/Sd7hT4xQvR+55t2kIviEH8eKRSdcouKlfclFkmrpOvcPA5Pzko+7
0vBwFgD83qlSp+e8oMfOPkT8OKHzY+yciY5Qi5xsDfCSI2dPtgJcEPoujpTdhGRL
+qdPwBSQ5FTwz75FZRCtP1XWhcVdZWKjIQ72FX/6SlOfHVlikgqzr9JdMPe4cnGN
G6Qfl6ssbebW/DJ2xx6Afrk7rHk52wDfWk1SzXjreEU4fgHDQ/CQt8yvfci3C/1f
c0SeU+GWoziA/hbSzMTzvtAFBkH4SnLFsIn6Il9Xaw3HWTOHUGR3D2R+PKMqyYhD
rIh9Aeg+5PaxepHbYOKS3QFeJP5NSSSwCmXfZTI3La1cDK9GxeQRnNshdnFwgxjV
QG1TdlVPw7yoSA4+rG3mOA8oZDLfTg24+bmfgPQOa6l/g5s+6BVZr31wQKK/t6W2
qF1pi00yHt/2uyqVlQ36+V+mLZvrH0EeMWG4os8/qxErN7e/WLgAsdnnCEc6OWCR
TYZBHCQzVx0EAkTrpOh4+ql11/Sw85XQ0lANxwffG3M7lqLQp+VrS7vVMTLKl9/P
kPDC42OqLKgsym+9xs1uyO42y9W1HlOZ/BRhtvIcnKX5vPK4p4WWvwpkgkIpEKXA
VVTRSzBEbNy/nDufAmOc
=osN7
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
