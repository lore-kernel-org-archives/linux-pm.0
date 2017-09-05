From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2] thermal: enable broadcom menu for arm64 bcm2835
Date: Tue, 05 Sep 2017 12:40:04 -0700
Message-ID: <87k21dq6i3.fsf@anholt.net>
References: <20170902033639.26774-1-allenwild93@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:53290 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752312AbdIETom (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Sep 2017 15:44:42 -0400
In-Reply-To: <20170902033639.26774-1-allenwild93@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Allen Wild <allenwild93@gmail.com>, linux-pm@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org

--=-=-=
Content-Type: text/plain

Allen Wild <allenwild93@gmail.com> writes:

> Moving the bcm2835 thermal driver to the broadcom directory prevented it
> from getting enabled for arm64 builds, since the broadcom directory is only
> available when 32-bit specific ARCH_BCM is set.
>
> Fix this by enabling the Broadcom menu for ARCH_BCM or ARCH_BCM2835.
>
> Fixes: 6892cf07e733 ("thermal: bcm2835: move to the broadcom subdirectory")
> Cc: linux-rpi-kernel@lists.infradead.org
> Signed-off-by: Allen Wild <allenwild93@gmail.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlmu/ZQACgkQtdYpNtH8
nugvEg/+OzEJoGRcMFb9ZJVAgkS9MEOYBjI0bgUPMfDwSX6HY5yTxg2i3mER7ze1
FUlMzbRGVxpZEpDOgxJDBlKoW0RB9XYCde2l0PvMBUz3zCRxm8Y/jCm6ptsAgMSB
qJAbd4g34dOdeUwfB5OpoOcY11QmlaqkJdruyelomn4W2otMMXMNStoRQt8+EyBH
ZYJ1EsEtTyLB1aeEwdk3rXL/SiBqYmtMNnRRgFWPdQmGUM3uK3Wlx2XIqcvVlt17
Mkj+TAfA7n0zcAkfTVT8g7nc9hXiIiooDF3VI/BYCCHsVIg+V58tCBruoNlMZHA2
1lX15s5ogj97Zz3eY/FlwnSZTD1akfCOv2YO/tdrtEtVyfS5prMT7H5V7YxMzuqz
If46Z3BgKwQxjSMsMRUoc2ihG4A1Zg+trflYJrNHeV4T9k98KoGvt7ygmwqnLTV5
q8BcQ65reve8q4oTl4J4ZXecHQNvN08LkrP0ww50gbW61BtRJw2WUKV+TFcY7brp
D2ewUo1CNMT0kiEBY1/ai7A/H2dAjZy78aHUovEtpbe8VI5jLOCG1971m+Xo2hrV
DAcbmpLD87DDWGAFiq6hekN29JhntRVHSxQ8qcFl50LgsuH0bAGCuvff83YCHob9
ExxpFG8/CLzuwMbWtRlID+o+b4obb7NQpECDoYbr0k6z3B45sKU=
=z4z+
-----END PGP SIGNATURE-----
--=-=-=--
