From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/3] power: supply: sbs-battery: Add delay when
 changing capacity mode
Date: Tue, 25 Jul 2017 11:32:37 +0200
Message-ID: <20170725093237.ckdo4oipfinjkauj@earth>
References: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="knluhxbgpxkyhfao"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750824AbdGYJck (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jul 2017 05:32:40 -0400
Content-Disposition: inline
In-Reply-To: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: linux-pm@vger.kernel.org, posted@heine.so


--knluhxbgpxkyhfao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 11, 2017 at 05:43:40PM +0800, Phil Reid wrote:
> This is based on Michael Heinemann's patch:
> "sbs-battery: correct capacity mode selection bits"
>=20
> First two are housing keep / cleanup.
> As reported by Michael with his patch he found the mode didn't always cha=
nge.
> I found adding a delay fixed the problem for several Insipered Energy SBS=
=20
> compatible batteries I have on hand.
>=20
> Changes from v2:
> - power: supply: sbs-battery: sort includes
>   - Remove errousnous chunk
> - power: supply: sbs-battery: Don't reset mode in get_battery_capacity
>   - drop patch as it needs more thought
>=20
> Phil Reid (3):
>   power: supply: sbs-battery: Remove FSF mailing address from comments
>   power: supply: sbs-battery: sort includes
>   power: supply: sbs-battery: Add delay when changing capacity mode bit
>=20
>  drivers/power/supply/sbs-battery.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Thanks, whole patchset queued to power-supply's for-next branch.

-- Sebastian

--knluhxbgpxkyhfao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3EC8ACgkQ2O7X88g7
+pomdQ/9HmamKxAIM7zfun5Vpcmw3HAGPquWSapOTuRwsb/6R625goynKXKpn2pc
N94Nsmx0xf8A/eTjIvERo638w3+adcyBDj3t+3QCVjr1aeytB9vDyYR8M9T80tKe
xpkinrRYn9RnjvEZCrd2ySSoXjOxJrqAil4oGscJPKHl7tij+G94ddfK339xGys1
IWwSoxaTP/72Hc2XC+mmib6KDGxA9f+U1IOAKcpgSHNI49hcC2tcQo5VPZgPGCzq
fnuh3MSAC7eRbvaskVzQw/UqECOKle0VyMmwryZn68MpTSYPu00H1N+rhySWOlQq
7P/blVlAYyqIN75AQ4joU9bCTj1TEyUzLDJv9ACZvg10+INL+pnxVoY+Ao4UdcqI
jcbyFtMWWuYVQjB3EqLiSb1C0hwkri9LLCifh8GBU5LqOqRVvlO09E3FRLruk7DP
U93BFqYsMF9wokoylln70sKvKw+uN0T5dfuBSdNzdw2JCYTlFf2ziTf5VUPcpQS8
4d/Cbpi7qJXVeDelJi9htjPAzZ0ZZ/NWHk4VMe9cDGgLo3xlUwi2GkXqfBZUbTA1
CZBdTDstO1ib4jVamF7VDmDvPelFLnvZKSTAppqm5IRMZH8K5AEGR3rS7DAPr0dj
VlaXu6ciG5j5occahX1n4vkbmtFjeInotBwV7jnlB6TrOW3x4Wc=
=KHlk
-----END PGP SIGNATURE-----

--knluhxbgpxkyhfao--
