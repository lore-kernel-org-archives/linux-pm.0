From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] cpuidle: big.LITTLE: Use of_match_machine
Date: Fri, 8 Aug 2014 11:45:28 +0200
Message-ID: <20140808094525.GB15852@ulmo>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <1407452515-2390-4-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407452515-2390-4-git-send-email-ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2014 at 02:01:55AM +0300, Tuomas Tynkkynen wrote:
> Use the new helper function, also fixing a device_node refcount leak.
>=20
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Compile tested only.
>=20
>  drivers/cpuidle/cpuidle-big_little.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT5Jw1AAoJEN0jrNd/PrOhv58QAJQ+7QEy+lCmrZl/FZxclODm
/SeF3BfFa9bn295JeerkH2mQAHRSpQhkvBvHjl2LNVLXE239mSbJBalB3giBb5N8
yFGiUJgd+h7ykYz1JkpbqC71Ko1IW3rTllM1WcjZM6TdASWIPtb32MIrvE0dMlyU
QB51RWYwnuu0b2CiVORAHiohUi0ay+rFCkcfZGf7mObgDVGuKwDtpVpnY2Y5Bpjy
L++wMbEwimJxoPoWNMeGYcV+v/L+EbjC9kacQORi2/49WpPKijZmBHVWIrwhqdEP
69SVDtUUbNxN0db/zvGZ/KqMwMvnaXmlvvj2qu9HWh98a554lrryhWtaBsKpJ3h2
Wv/nZe1hDBy+Fn+KVgTxN2iCRpjQsUkXlHmTBi7uLoGEemov7WXXWzN0olN0wjOF
MC9cXXZiisFhWBrY+92171LfmphT31XQJSbqseB9Bpia7rF2EMZVrHumz8GoKsMF
fmbY7GZKy7xW6nIozM0+fNoOjYeyOYN6FJFl8WwTb1qUvPuD6/4P328FEwcpYUPA
KpAO9ndYMACfDXr0QKUqZqGRSORKscw4Lr/SVeVOxgBUR0OOjucweBj2Tsmd3VQ6
y0sufdWRKTK4Z8Ah2rKuJDsQtWWIZkwAfYcHScD2w6RO4q3CsX2GS0XzswasV0bl
A8mG1laO1d8PsXbP4/mi
=To51
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
