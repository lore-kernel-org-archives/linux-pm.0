From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv6 0/4] thermal: add driver for R-Car Gen3
Date: Fri, 23 Dec 2016 12:02:25 +0100
Message-ID: <20161223110224.GA1440@katana>
References: <20161222103823.8300-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:57962 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754395AbcLWLC2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Dec 2016 06:02:28 -0500
Content-Disposition: inline
In-Reply-To: <20161222103823.8300-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Changes since v5
> - Switch fixpoint scaling from decimal with a factor 100 to binary with=
=20
>   a shift of 7 bits to increase accuracy. In v5 decimal scaling was used=
=20
>   since it closest resembled the v4 implementation of a decimal scaling=
=20
>   with 1000 as a factor. The big change in v5 was to fit all =20
>   calculations inside a int instead of s64.

Pity, I couldn't test it on HW before leaving for christmas. Will
definately do when I come back!

Thanks for this update!


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYXQRAAAoJEBQN5MwUoCm2zNsQAJO8JGNiLxsYoAApDV7/HJu9
QFb0lvmSYt58XNmZVnJgVQKeiMoAh2HOtiSPFA54NABWbQocqy0sdAYNNW0HVYiD
f59K1QAp8wPjLh9kA5ST322SBAIClIRqhb3yqnyxLH2G+DQ/bmuG18M3gW+gebIu
2DB6pull629smPcj6KwlJEaBfQMO3Dpj7kyuwv0/4gRKeh1WRNdTDePatrhcIowk
Vy52mG/uEiPfxf1jCONsXa9akbzWKD2l4m0q/zq4zVr+tbxiiZXBVKCR//Vk1tQl
DHIGvVVpcvoGj9t+UMk64tlum6SiLP03GNvX46ACHxy8L3/2o7U1EyumDSFn+ObM
jDDZMtiyZerRwvpqqEx4t/SNn73Hk+/u2IatDeNA+N1WcSPGpe89sMDXuocUOF4D
qibtA4DX7Vmrl4PhogGFnzNJv/T7MLXmBxszbo4Kvw1to3JvkQWWmt1tsE37+2aS
m3aOlNT32jkveYcs1dIf5znqPDeasjfp5JQEeK874+yYV+H95rg2+dD2MG9iv4l9
JcDEfBFetif8EU+0+PAE3f0si2hEN12oCQSJsOAQUbBiI8cgZW8DE4VGJ4XCg/Ce
+HNsUYYwUIVJtLbP2qqyZidpKLyc+jksN/IbBhj8qQBpU1TzFaa2e3vBYyzOlWpG
N7Yxg1KbxVYvc19xqfuu
=v3wX
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
