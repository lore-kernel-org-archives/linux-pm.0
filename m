From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: ab8500: cleanup with list_first_entry_or_null()
Date: Mon, 19 Sep 2016 21:22:47 +0200
Message-ID: <20160919192245.aokjbadp73bzgydw@earth>
References: <1473704601-3217-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbod6ufbzyi5pjvt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbcISTW4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 15:22:56 -0400
Content-Disposition: inline
In-Reply-To: <1473704601-3217-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org


--vbod6ufbzyi5pjvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 13, 2016 at 03:23:21AM +0900, Masahiro Yamada wrote:
> The combo of list_empty() check and return list_first_entry()
> can be replaced with list_first_entry_or_null().
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, queued.

-- Sebastian

--vbod6ufbzyi5pjvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4DsFAAoJENju1/PIO/qaDbQP/0q3DYUoKPj6xriik5MVHN/Y
nqhzycp3y0ymc0qVC/3o7QENPJnpYog/Pes8gJ8v1cO4R/kyfhbTzV01BRMM8uLw
Qw56mMS5RPHp8MVGTHqF69SkOngv1bjmowqTQoYTHtYXu48KoKBFYIY1NWmpQKp7
QNKIUlKUGoWV28LBV/S/JenMEvgKGtLWpoEBSuAfzmwq3Ras84VfzahCOQCPOalc
/QlXn4iiGvhoImfCslFNwQo/Bva5XfndTfsgH14RGS1ncCgbRsBgs0WVywyZlNdK
9ZAdVKiV5O7j536hasOBiVqtBozVLJ6Bpaxc92DECfxHZ83DhbwpmHBsAnj5eoi0
oXMqGPgzkiIyJ94adoe5VvvtIhBFN+wH44ywm3ybJebTPPRKPf4Ukb1ucnbKclGq
t7gE6gt9LYdXf7A0R9mYF70xBjefIyXYfphs8hXNLO2Jlgz56ymtYT+VyK5K+Jy8
Lsp9F23I62PcdDPEwrCibHwII7POLmdX7nd5OtCL4Kx1J6L1u/3KGf7jgTngx9s+
u5J26v++INlsjC66PJfk7BLRaDnbEQvMK7GLkmnEf+OTQ2GPtkpdFIznC2qQLPl5
yLMDZH96S4/fSYU/uFgwzapES484C+kGWoga+Yk23mAZ8s4OLW7Vea+HC80kmODa
4zcAQ0QRwdP9ln3zZfY2
=3ED9
-----END PGP SIGNATURE-----

--vbod6ufbzyi5pjvt--
