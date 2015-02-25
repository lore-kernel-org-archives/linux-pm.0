From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFT RESEND 1/4] power_supply: twl4030_madc: Check return value
 of power_supply_register
Date: Wed, 25 Feb 2015 22:22:27 +0100
Message-ID: <20150225212227.GI13695@earth>
References: <1424439145-16895-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424439145-16895-1-git-send-email-k.kozlowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Fri, Feb 20, 2015 at 02:32:22PM +0100, Krzysztof Kozlowski wrote:
> The return value of power_supply_register() call was not checked and
> even on error probe() function returned 0. If registering failed then
> during unbind the driver tried to unregister power supply which was not
> actually registered.
>=20
> This could lead to memory corruption because power_supply_unregister()
> unconditionally cleans up given power supply.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: da0a00ebc239 ("power: Add twl4030_madc battery driver.")
> Cc: <stable@vger.kernel.org>

Thanks, added patches 1-4 to fixes branch.

-- Sebastian

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7j0TAAoJENju1/PIO/qaoG0P/0Gh0QWyS0wmYn6AfjhH4AgB
Z8frNINy4bKr0eThRbt8/P7F50L26tLCYhyKg5s44C+YxEEpQHgwl04sdl3gPpuQ
OM4VhYq44CmsgQV1rMZorpPe7GVH+tm/WcgSM65TcTN3XmFwWHfvc7YjcIqwRiLh
U2AmuRYaV2AvBpRC2hS4L2jldg7ZT+wx+rlLuFHOVzqsdJqe2yqhm/uK3xH7YE1t
kiGVMstfI0h+KGm5/1K3+d4HXwo/uEumnGNJMbHrfbu2E93rMxa+e//Bz10kudUD
l0xo3gObSDoAntVUIlTmAKHeuTnjgZHu/SwPn03a93jngSPZshWUJPW11z8CYf10
KuSyFmf3W2Hpb0OBewTw3DpzvO0XyoA59xXmj3Fz8wV5vNRQuEtdkSel7eDBeMLM
0sPpNMjgGsS7JBX8cYSbR+zoKoTVYXVq0+cQEk3F13ZyzLBrqWuTLRVMqzEvlvyf
iio3U0aaLMGG/qnDqvW1IxLCbA1nEBsXGlpQutORW0rww2WDxP38ohw1i3QsUfMU
qp8zqPQKlGKBrLr/SSHUl6X7ms7HSPGltRbfI4PHgeI+RYX5j7GWHPln8A7Prn1f
wSx+D2B7lPljV3nZ5p9nobZzbBJtNXW4bVsSbxM+EEgZTvqpE2KlFNd+rpQjtebl
EFI/W2vF4vD5mtv5uVFo
=paWw
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
