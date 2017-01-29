From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 11/25] mfd: axp20x: add AC power supply cells for
 AXP22X PMICs
Date: Sun, 29 Jan 2017 17:35:13 +0100
Message-ID: <20170129163513.m7y4vbjgthh2esg4@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-12-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7219781019584084307=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-12-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============7219781019584084307==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h6fucybx25xk66zu"
Content-Disposition: inline


--h6fucybx25xk66zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:44AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
>=20
> This adds the AC power supply driver to the MFD cells of the AXP22X
> PMICs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--h6fucybx25xk66zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOGcEACgkQ2O7X88g7
+pq+KBAAkiHvlTehr7ZGKWmsEU9V3uChOGDwUz2LFmtXJxv2Vl+E0mDH3ADmYNtp
tdn9UW/ywBkLr+CIUVe9jRTccJQ0+9xgLRaxzl2XPnEG1ALfWTFk0eUG4Aa2SSdf
Dgwh9HspOOGFERVVp75uGsftxmPGWL3SCuwm7m4AyPy07i5iO8cjTr9ixsXO9Bk7
764+VFTMaKttsE0EnzeV/iWwS5/RmK5cHZwUiEi9FJbhwxg6NTbwVw8J60+p5ARn
gSMkzjS0sydnCv/UBrkE5hUh745vG2cfeGGEDXDqkeaxmX+CSsgU5CmSGKX/d9ek
beqnT+9hYTuSWYzWmfIHgCuRED/L/F6q7IS2gyWCzccFQAoZjW0kX67bkHYEFMEd
BzM+5j4rF/qrt04taDknkeuBOxgRvQR/2dwJGFyScfF5PQESEQ4st9/lK6THjtWp
tgGJldkW8OH70Gyh1DnQ7njLYCFaX4KHqV1PrC8+J6IzphSf+y9PcDzxWK+nF/yU
mv4Kk3mULcWGye+PF2il0G3qxR7mjbHBHcYbJI+5m2ty78YcnU2hsfe+SEuykkLp
5ISkELjxmNCU9qlgNcjyV8BfdzNveZhnqdQOPFEwnAm5MVdY6KxqCgXa2QG2WEtQ
Xas9UsSeLOhCCxEpWqJ0MN/eQhnLWUS/7n+DlgYcxRZi3I3u85A=
=o1z+
-----END PGP SIGNATURE-----

--h6fucybx25xk66zu--


--===============7219781019584084307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7219781019584084307==--
