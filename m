From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/3] regmap: Add 1-Wire bus support
Date: Thu, 8 Jun 2017 14:53:50 +0200
Message-ID: <20170608125350.6glgyrlydqmtshru@earth>
References: <20170602070629.8210-1-minimumlaw@rambler.ru>
 <20170602070629.8210-2-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5sjggg3lgpky75ag"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50163 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdFHMxy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 08:53:54 -0400
Content-Disposition: inline
In-Reply-To: <20170602070629.8210-2-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--5sjggg3lgpky75ag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jun 02, 2017 at 10:06:27AM +0300, Alex A. Mihaylov wrote:
> Add basic support regmap (register map access) API for 1-Wire bus

Thanks :)

> diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
> new file mode 100644
> index 0000000000..5f04e7bf06
> --- /dev/null
> +++ b/drivers/base/regmap/regmap-w1.c
> @@ -0,0 +1,245 @@
> +/*
> + * Register map access API - W1 (1-Wire) support
> + *
> + * Copyright (C) 2017 OAO Radioavionica
> + * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation
> + */
> +
> +#include <linux/regmap.h>
> +#include <linux/module.h>
> +#include "../../w1/w1.h"

This conflicts with the following patch:

https://www.spinics.net/lists/kernel/msg2524566.html

I guess Greg could pull your immutable branch and above
patch can be augumented to also update regmap-w1.

-- Sebastian

--5sjggg3lgpky75ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5SN0ACgkQ2O7X88g7
+ppYig/5AVvP1piEopbH0dWrQ2dt/o54pPpwOnoxeLtzagtxfpLOw/79PQCjXXCS
ud6WdcuRxSqunQwjW62pH4ro/91ib9DkNKaV6jGCgKAxwsLI1nRzpUVCY9Zrnwxw
LF/7Ox4udvcJrEtmjUdd6MqNgJQ0uOehgzLm0RCkN6eXNPKoqW27SlOPSWfuABPW
GffKJn+0WEvYhLY3lS8YSGwklS5DDg/sk7mkpB6SmwTp3+dP/ENZdqXWI6wkjR4L
gb8X0uzFuZpc2WwZTM6aK8kJtVR/3k/0v+sX0hN3Rfympz5SmREnov7mp5tq9yCn
O0O1Va6OIRBXCNuw50iMa1S9FEkDwSWWKnljQiXSWpSLtH0YhoISafGAUpI9E2Em
0Nvq8kyCSbgUnaNi4H8396ZJoRWtzkQioBaApBb/nQtSdN06mfMzM8+plSbmx0wc
DaUt0Om9Nd5AdZB7+NsYt8e+jPwB2mCDbPbGrErkNBSQOS9dlWDa+VuUsSUm4Ecn
oalY0+VGV1/HTEiDPx5NAfZgOhPFUkKs5Iw+xMWObk3JPMVM9jrwEx0ZEkT24SmB
lQmt2LRxecCgpL4IqVhXMgCYegJgMlVPfdCBqH9cRU6hbLXjoFbF7wUL1jspNypM
+6steNJOgF9jQxCG0bcD05VKFfK6rPhDiStdmyRVSwz5bJR3Lbw=
=JA5L
-----END PGP SIGNATURE-----

--5sjggg3lgpky75ag--
