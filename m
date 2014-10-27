From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 03/10] regulator: act8865: Use
 of_is_system_power_controller helper function
Date: Mon, 27 Oct 2014 11:40:22 -0500
Message-ID: <20141027164022.GC14253@saruman>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-3-git-send-email-romain.perier@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414427215-14380-3-git-send-email-romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2014 at 04:26:48PM +0000, Romain Perier wrote:
> Signed-off-by: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/regulator/act8865-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/ac=
t8865-regulator.c
> index 76301ed..435aba1 100644
> --- a/drivers/regulator/act8865-regulator.c
> +++ b/drivers/regulator/act8865-regulator.c
> @@ -365,7 +365,7 @@ static int act8865_pmic_probe(struct i2c_client *clie=
nt,
>  		return ret;
>  	}
> =20
> -	if (of_system_has_poweroff_source(dev->of_node)) {
> +	if (of_is_system_power_controller(dev->of_node)) {

so building this driver is broken until this patch ? not very good
either.

Looks to me you should add of_is_system_power_controller without remove
of_system_has_poweroff_source() until all users of that have been
converted over.

--=20
balbi

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTnV2AAoJEIaOsuA1yqRE1dIQAI73rs9tLjyf0P8i5zcdoT2T
FQEYzL6cJFekHJZGFr9HIBTgN+spy9Gop7DaIOeCZ8yFjW0/Kww69EYLuGYn/wsW
NZCRhBsZAfhajPt/S0jIE0yP8z2wF5iNVVDvOb0xOKWqxYPI4rLCX4uQSdtBboXY
73uj/6n5g/QDPIlHjOqWm0uEOZ1xNhEdmfr6WhpK5olUdGyc+vQCJetOxlSBeYrt
z7nBYUx1KiBChVcb5sYZAl5z800BqUkKfw/y58cela07YuH75ILviCfoXlOR7S83
XCzriZzrxzyYgbBF6YU9spD2z9cEVxL+4zivBw95gm49ZflhvWovbRU8jjM9YrWD
Jnyqh8X9Dn1R5rt2epAwBALqom3qyNdgCO3jEpfHtM6hBZYUJZV1wyAeUugAwMlM
ez8PFOTLyTmRqYzcA9Lh9HpEWf+5ERfFdEJbYLX9RdPqJqkS8zF+nvI4Hf94E2Ud
MiuRpYOwPm5LyP8PRfeLhZYrNmYZxEo3HyRa3Z4B6AvCHpNqXoe4dgjjWXOWMQEG
9XSvHN30ApRugMzuBXnYRPXpGIkRMnVCJz8DzE4g2n2hQc8c/P4gvmOSgUi4QuyC
6RqhkDPQShEzDzKY7WN0S6aFdDzJ36vlKKDtdOX81Z/azLGe1Vogj0bOg50THeCB
WEs4knb7t/xqA3jYV2KN
=OfHJ
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
