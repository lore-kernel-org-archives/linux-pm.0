From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing
 for tegra driver
Date: Mon, 17 Nov 2014 12:43:42 +0100
Message-ID: <20141117114341.GF25699@ulmo>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
 <5465DDC5.6090301@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5465DDC5.6090301-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Cc: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2014 at 12:47:33PM +0200, Mikko Perttunen wrote:
> Tested-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
>=20
> One potential issue I can see is that if the cpufreq driver fails to probe
> then you'll never get the thermal driver either. For example, Tegra124
> currently has no cpufreq driver, so if CONFIG_CPU_THERMAL was enabled, th=
en
> the soctherm driver would never be able to probe. But I don't really have=
 a
> solution for this either.

It doesn't seem like there's any code whatsoever to deal with cpufreq
within the soctherm driver, so deferring probe based on something we're
not using anyway seems rather useless.

Thierry

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUad9tAAoJEN0jrNd/PrOhLIsP/1G321EqqSncBH2hzi6gCgxG
3soPbr2DILZiCD2PlNuzWohtQe8Z8vuYKc/MmtHxJbx2X1gHMuwq/TFk1LeszZR7
NWYwjkfKzzDEOVoVVLdbi+8Mu36pJws0Q8YU8WGatoJWfnUWblsWB1UyGThLWm3p
Pw8dxgFuTzQELXbdn5aaHLz0YjZvu7NdoxNAwK2wiq5O1/94oDclqIYkcXWf5ddv
hU7FUx5/yvJA3xwtnT5PgchX10ZL6ey6sB3ScTnUz9scZM+4e0BzEN2E8C5L983Y
OjmpMFtQpyGdEhoo/9vc3QpGPOx5oc91IjseaDQZLL9ZCZF18p4WcdrldxxAVEbI
QCFKXlG3tOOIf53wlM6HvlhBBHLMF8AK54oDqVBhDOketFBnSdt6Wlv5GDQDHozg
PgJnjjqx4wjmtJ9fjImlNr2kM/eJxec43T6jgjPXVcYXx0M3yzZmwPtMxvfe/B1f
tWUy9WbPtBHX0nXCfOeZvlPx9IL3NdDhGhZe6+9h1gln0EU7lnmSiZKTe+zKJoEv
57ip63aEwUqxZFxnKsXIn70RyhJX1y8h5yK1XAmYzBMWls66PWQwE4TlQQRMafgy
f9sc5MNXV55NXRd/9gB9PU+Ql1w2eHdt1PoKYwBcw6s6BuLf1q+2rEWQLFaUhTHm
Elt+qT+JqM+KJElClzwQ
=u8ec
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
