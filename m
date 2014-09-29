From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
Date: Mon, 29 Sep 2014 10:29:05 +0200
Message-ID: <20140929082904.GF12506@ulmo>
References: <1411724593-4037-1-git-send-email-cyndis@kapsi.fi>
 <1411724593-4037-5-git-send-email-cyndis@kapsi.fi>
 <20140926114533.GN31106@ulmo>
 <5425CC6F.2020309@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5425CC6F.2020309-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Cc: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, juha-matti.tilli-X3B1VOXEql0@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 11:28:31PM +0300, Mikko Perttunen wrote:
> On 09/26/2014 02:45 PM, Thierry Reding wrote:
[...]
> > I think a more idiomatic way to write this would be:
> >
> > static int
> > calculate_tsensor_calibration(const struct tegra_tsensor *sensor,
> > 			      struct tsensor_shared_calibration shared,
> > 			      u32 *calib)
>=20
> If I do that, it will go over the 80 character limit by quite a few
> characters, which is why I didn't use that style. Personally I'm fine with
> either style.

The above doesn't exceed the 80 character limit. Putting the return
value and the static keyword on a separate line is a pretty common way
to reduce line length.

> >
> >While at it, perhaps make shared a const * instead of passing it in by
> >value?
>=20
> That is possible, but I'm not sure what the difference would be. Is there=
 a
> style rule forbidding by-value compound types? (Also if I change the styl=
e,
> it would go over 80 characters by even more.)

No it doesn't. The below fits within 80 characters per line just fine:

static int
calculate_tsensor_calibration(const struct tegra_tsensor *sensor,
			      const struct tsensor_shared_calibration *shared,
			      u32 *calib)

Thierry

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKRhQAAoJEN0jrNd/PrOhLQ0P/iG7NEpJ0qlOMQD8oZX2hwsK
hvMMFsS8d1ZdPVAKFDMUiur00lDLC3i9b/3WzotWNSWW4qtBWso4VI6wVygvtWIz
KtLfoJPhBEn681p9kRzUnU1J2gG3hh0AYoFbp5mAsguuYVDMWVcOwNihfngrAxie
H2ERRquXgJXngoD38DXhH0LftX6XkCK/irmc464/WKibRz7ZFhj835uSjxvMBhLZ
3W//C41ABuQubyP29xg1qhvZ+g0EyHhAYkLi8JWXSKy7dwY2QoHJP75lYshMoNJt
wzWVO4t8XMLmXKU8+5+w/s2IYb46JKrBHFOORncBM22QqGQ7EgSGkH2Ibq2pNRNc
6twGAnQbFVQEi+KgM9GlZZa38T2EPIRB+7peRrDu7KBnmYIwbw4aunyA5Ilav9zd
2C4eZp4TxK8wIqbKI1KN67crpza3rhlT+8jS9RFKPwURvFI6rL+okhzr1YEKz18D
F3NYC4qhCykka/tZZjHcEwGE9H8XFLBwV6y7MpnAcP9wK0gq0T1axZsxREAWyADn
YGwthpHGgNUa8GMu2fwI6JNybkP4K0mHlJqOya709xSuh3k39AFjB9gvnyQkMqPX
m77qHFjiui31y7A82X30bZbZGGaJMLFYu6roXROd3bICLTBmzjF7telxCXDQQ4aC
p79iiuJu9OkPIeNLu32a
=J8Bb
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
