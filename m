From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v8 2/3] pwm_backlight: use power sequences
Date: Fri, 16 Nov 2012 09:49:58 +0100
Message-ID: <20121116084958.GB20785@avionic-0098.mockup.avionic-design.de>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com>
 <1353047903-14363-3-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353047903-14363-3-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2012 at 03:38:22PM +0900, Alexandre Courbot wrote:
> Make use of the power sequences specified in the device tree or platform
> data to control how the backlight is powered on and off.
>=20
> Signed-off-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

Anton,

I would normally take pwm-backlight patches through the PWM tree, but
since this patch depends on the first in this series, I think it would
be easier if you took it through your tree along with the rest of the
series. If that's okay with you:

Acked-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

Otherwise just let me know and I'm sure we can coordinate to take this
in via the two trees separately.

Thanks,
Thierry

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQpf42AAoJEN0jrNd/PrOhIAQQAIpZRiO0Ir4ZgNr1p9P+MKLJ
Czzca7/YmN4VbqeeNvCAEaN/g1yOb948KdynjRB5RjFqjd+pIGFWlOF+BaZCt0Xn
18DWDar4eWOiy/ZGuOkwL5iKtLzTzSmCLK+rSUHvxGnIGZo/xqO6W96R15/zEJmw
EKMnGmM/vOodjJdxSimbY82Kim+PdbUbecqCNKFSyi5bTXeOd/xYmHml4MysptyB
YLRYeP3wEXflCXMAluPzz+Oo1Rz3BCTmh/VjlE/4879PvpIQjX9jiEmfGnyTaMqG
ZRmS5xwqMaHoQGOkMqQi71P7Fq3P/kUfF05y9A/E9yni2c3230217v5ai7x2JJYd
DalB9WYcPS/836g+JsecH7KMCa6mwjtZjfxoTMILhXG0rOA9QTHguHkFdBb8IGU4
B2dgLACZCvwCLGoTc+AJJJyqWa3Pz7vAjTZ71xCi7e/lmFCAUC4GJv8L/fawSwGv
SFmAXlpBgSgph6hyJolELdnom8R8CzEMQGTWO+chTp2UXEk5iFrWTCfcJ7I77C8D
JevtTjQgiw/C+xot2+cDq/6ghWctupXxNERo2hepW3XRXGKWaAPccgh/YNbI4fGR
I6IVKpVjFVm2+/42R3KknBmz9ghcA0i3hYF0GH5V1sHUVSAqfzfBBWGEHJvhKTC8
O3fkU9G5MYokmDT+i8x0
=ncjv
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
