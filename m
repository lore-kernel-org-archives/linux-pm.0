From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv6 0/4] thermal: add driver for R-Car Gen3
Date: Thu, 19 Jan 2017 13:19:58 +0100
Message-ID: <20170119121958.GA1530@katana>
References: <20161222103823.8300-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47326 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbdASMUC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Jan 2017 07:20:02 -0500
Content-Disposition: inline
In-Reply-To: <20161222103823.8300-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> larger. Therefore I would like to ask Morimoto-san and/or Khiem to
> provide or proxy testing of this less accurate formula and feedback if
> it's OK, let me know if there is anything I can do to help out.

We now got the results of Renesas internal testing via internal
channels. So, for this series:

Tested-by: Hien Dang <hien.dang.eb@renesas.com>

So, from our point of view, this series is ready to go upstream. 4.11
would be most welcome.

Thanks,

   Wolfram


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYgK7tAAoJEBQN5MwUoCm2k0IP/jJRTluPsvPmgHmaYXfTgl5k
wH4sznqz7JL05m8dqEBP+fKZ88R6FSrqIbvkCd4TbuOyGGOtk7VwFolOnX6Gy+Ku
IlYdIZKEm2gdDdPKzuDrtsPBfZK+EctSuFvwHrFvUoeItTOz10W59oc4osXJRWS5
Trb2xjGP+VATukp8pGpsakth+6LxutsuI2Q4nIYJrWK152W0yeIWU1oZhPrOnDTr
9J6+aTnYuHnIWZfYG7Ux9UUtRI9l7q0Wz6CKaIWm0t75bTIF+FBva45TCPN9M06Y
W9CuLUKOTn/WTRJzhyouJKJgLdvMJ+2Hk+EgNlltu5p31ExBpjhghPlKRTkRfat4
fxIZ6ObTSdRIckock5kNm6d31qLrEee6UuaN9OrVV4LHXJ6upT1zm9fOMn6/qmgK
faiIJt4DQeux4un1poxVBzB1HWyRfExu8T6TFi8CENffR9dgZGSWeDaNnHPOGGU/
6niqpMa0mfDiHE5ugJrwJJsq/NIoAXQMx7oZWiKxnXYDbASVPVzQi6CtUojfsFsC
HjfO8c9fnyiyC1Im/lD80SDpDEVZ5W3GhYOIOJbGIZxE76OZoedyKqcl/zeO39PQ
bKpcrbpplKnP10+qmf4MVgBTYKbeYwO8gk8I7c7TfUGRCaW3icA6NLvYRbsYTjAH
BzpsdL8mL13NysvM3s1A
=9Qml
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
