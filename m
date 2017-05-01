From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 3/3] drivers:power:twl4030-charger: remove nonstandard
 max_current sysfs attribute
Date: Mon, 1 May 2017 13:26:01 +0200
Message-ID: <20170501112601.lfh42un6dgohofbu@earth>
References: <cover.1492194356.git.hns@goldelico.com>
 <38afc4e7faaeabb32f153a0956899fa8e97c1b3a.1492194356.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ovpxv7sr34nmh6v5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754680AbdEAL0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:26:06 -0400
Content-Disposition: inline
In-Reply-To: <38afc4e7faaeabb32f153a0956899fa8e97c1b3a.1492194356.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org


--ovpxv7sr34nmh6v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Apr 14, 2017 at 08:25:57PM +0200, H. Nikolaus Schaller wrote:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

I'm not queuing this. Please change the following things for the
v4 of this patch:

 - Kernel patches should always have a long description
 - Patch needs to update Documentation/ABI/testing/sysfs-class-power-twl4030
 - Make sure to use recent MAINTAINERS file for getting patch
   destination (Dmitry and David are no longer listed).
 - And for this case: please also Cc NeilBrown <neil@brown.name>. If
   the ABI is in use we cannot simply remove it. If its unlikely,
   that its used I will queue the patch and revert if any problems
   are reported.

-- Sebastian

--ovpxv7sr34nmh6v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHG0YACgkQ2O7X88g7
+pqJqg/+Mf8zFoe7ty6oNxhC4hNONSEUenF+vFtifpB/8flFevKQuJeYU6JWhDv1
WUmUg+3SiecXJNwIrWy591ndMDOmxMjATAiplhhh68JXccIjAFW69feC9qn1WgML
L++D0/JH7kc7Ri0IU7Ovs1o2FtDgt/R4xVbWbvLScidSH3ANshn0xPCWvxnWTd1c
QR5wEhiEXYv0mYv+GEDbkHco0Y81bM7K/knL1NJDI97/f/gC20VoBzCuctyMWdVX
qfECj9YRvFxfn4axAwQPF4reAmHUQ57Hr86hTNRNmk8bcHmWLCxCPsA6HiQ0mPzr
/JuJjaxDRec7kGJDYgK7raPUsTpMvyra9K63TMtlihV5RqwbSVEgEb1HU2V6H0Cg
fDPAWWR5hXgjEciIp6DuFZ0RaPZdU6s+07GMXRG8XM5WVnojPT7RWI8XHI9wuWuC
0+LCEtroPE3iSd6V0VwXVd9oQn10AS8TaDza2a6ZRrvgbgFjCGM92ORt45cpJ9hd
h7wIIBXy8lma7nIxFQIGcJ9p0H62QECE/kecKjsjh+kty4JdMls+h2+VZYP5ebyp
stWMS6pnOqCqrSO59OjciniL/ogeHpJYx54CviA9KEmyLL+Nfw7bgWflcXW3x5op
u99yj13JaK5qX6hzrcAsXA8ESKFd45DNM71j8GP/QsmOrmbgS60=
=2rrb
-----END PGP SIGNATURE-----

--ovpxv7sr34nmh6v5--
