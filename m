From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 driver
Date: Tue, 13 Dec 2016 09:39:04 +0100
Message-ID: <20161213083903.GA2773@katana>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
 <20161212214514.GA17631@katana>
 <CAMuHMdXPZvHPRNx_VJ5VkowcTZbt_tOtRE1yPPVfv2fMYL8xLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47524 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752910AbcLMIjI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Dec 2016 03:39:08 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdXPZvHPRNx_VJ5VkowcTZbt_tOtRE1yPPVfv2fMYL8xLA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Perhaps the macros should be called e.g. FIXPT_MUL() and FIXPT_DIV()?

Yes, that naming would be more readable to me.


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYT7OnAAoJEBQN5MwUoCm2K1wP+wSVPIor7GsoRCLmh8+40r0I
wALlO+O+F62bE95SumPrUUw3+uGW55qvxryztXqppQCdv1wskyHm1DmA4ltguhGZ
UK0Jkfa4ynwThsy33EUUol7kgcexolK18fo2odp2MRzNIlzHVKHRDWmpbWKVAjrm
dafuVraKF8NyAlmFeK/Pnle51DAwmBKQIauitjPmgnCdlXv0TJueaQVMVy9iqjVR
Ax2E8gl1U5bSrpIDKEHgPc2qFBcAbtABliMs9KC1x04Tr92qGhgcvje2D3EdoNzS
qgThMQoSljG2rmngHuOMZm7QRSreTcaV15ahxyj1xm7R5iTbA8h850DfgTGAeICC
ajHK80u78okxffOdzAuzRQ0aVF2TjbOeJmaSAzDR2k34refc44sty34NfnD1HGM1
PCWjzWadNYnTf3xwCPCpFsNbz05LbaWs7v+oEiAI+CQg+ZMjz61cuQ5hPI0M6UQV
diL5AskhkYxo3w3QhoYL7tk8SLPrvdno9CXpVDmxLFfW//ReQY7PqylbBRXnNoTB
sblCwy2L+alfIgFV1hLqYIb8vcu46WUnMvTqRUU+pkxM2sIFDMA6ixsC6Ocd5fBZ
RK8CgrargULzNXsxiGgGXH6241NzVB0rRJWEVtyy3aylUYQJTQPZJY2pXO8rOzoe
Vty6lR9plxc8XK1uQpnZ
=rM+J
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
