From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power_supply: sysfs: ratelimit property read error
 message
Date: Sun, 16 Sep 2018 11:34:18 +0200
Message-ID: <20180916093418.ysblsx6hm2xjndyr@earth.universe>
References: <20180913004830.1265-1-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5twzgmypjd2fkjq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180913004830.1265-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--t5twzgmypjd2fkjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 12, 2018 at 07:48:30PM -0500, David Lechner wrote:
> This adds ratelimiting to the message that is printed when reading a
> power supply property via sysfs returns an error. This will prevent
> userspace applications from unintentionally dDOSing the system by
> continuosuly reading a property that returns an error.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 6170ed8b6854..dce24f596160 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -131,7 +131,8 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  				dev_dbg(dev, "driver has no data for `%s' property\n",
>  					attr->attr.name);
>  			else if (ret !=3D -ENODEV && ret !=3D -EAGAIN)
> -				dev_err(dev, "driver failed to report `%s' property: %zd\n",
> +				dev_err_ratelimited(dev,
> +					"driver failed to report `%s' property: %zd\n",
>  					attr->attr.name, ret);
>  			return ret;
>  		}
> --=20
> 2.17.1
>=20

--t5twzgmypjd2fkjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueI5cACgkQ2O7X88g7
+ppTNA/8DGN3fiWvUrFzSicgIZG4E/fb1jo065u6FHSK5X1qDJxcXyrHAlN7prLr
hqVxJI3x6XhkLQAQrk48MnwtYXKQqZn6TIHAveFJ5evnmcnsD2j/HE5R5PNxTGUP
P9eKSlVfB07YW0LOJW2AYDVonVjG93ZGCLiAcZE92fa+YTs9pkHyCeqpHQSrPIdM
e7rbu94aSqUtCkrIWtTECyn5uV531O5KvRG3CpC/GGGB2Hi8QNTKFrU9J35V7TXT
qwbn4o3BA9JW2jxeQVKa1VmvS2sHMw2O8C2sTG0jCYaBcCRVUQGaX/t6wAlajorp
7jYUuf6nj+zepN02cmNpb2IBkM2NWpXDsihL3e/A8G/S/iUhp1BWkVyKVqO53cyU
aS7hk4r/j3SyFoK2jKo9fnoUV6zIljaCCvLhKG5aGM1GTZ9sJQS2GgQihs8bzdjE
uFQNXMUUKo+1hY4xgNB1nAEtn279JQWBB3ypdMh4fIOwyAH1ziO7BLMmcgkJu5lM
g2edFpeCgMvhE7H4jz16rV5KMK6bxyRhObcI0yZ9UpR2HPRjvmH7K+rK2Ad7hpDo
dtd62QBSSx8j9cra+DEeozycBK4M2fbJYVXVIXondHcqs8FYvOEhPXWO9AeRIErR
aFKjrOdVT+YXShaB/gFZOMk3re6QPuZV1Rmlie7NegtUSfUmmeE=
=bB9D
-----END PGP SIGNATURE-----

--t5twzgmypjd2fkjq--
