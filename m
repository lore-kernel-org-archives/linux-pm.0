From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/5] power: supply: tps65217: Remove IRQ data from driver
 data
Date: Tue, 22 Nov 2016 17:58:29 +0100
Message-ID: <20161122165829.kvpxzi6iddmr347b@earth>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
 <20161115131855.4175-3-woogyom.kim@gmail.com>
 <20161122165107.nk2lm36nhz6wwlyp@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3uu27mt5jeport7m"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752746AbcKVQ6f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 11:58:35 -0500
Content-Disposition: inline
In-Reply-To: <20161122165107.nk2lm36nhz6wwlyp@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--3uu27mt5jeport7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[it's me again after reading Patch 3]

On Tue, Nov 22, 2016 at 05:51:07PM +0100, Sebastian Reichel wrote:
> On Tue, Nov 15, 2016 at 10:18:52PM +0900, Milo Kim wrote:
> > IRQ number is only used on requesting the interrupt, so no need to keep
> > it inside the driver data.

Please move simple cleanup patches like this one to the
begin of the patch series.

> > In case of polling, poll_task is valid only when polling thread is
> > activated.

And merge this change into the patch were you introduced the
problem...

-- Sebastian

--3uu27mt5jeport7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg0eTUACgkQ2O7X88g7
+poW2hAAhapLLMY+8CPWYBq6Dp5jTudtL+vfv3EYEkMYz/KaS2TZwvtvGDA5JKes
ONXaPQuQfXYDusyF/KsRqxdM3cPplSIG//pd5MqX6KoIJbFaw57gPc9vF5z2mTUG
EA1E/2F69RYwV5IykQZ20V33rbBIJH8m+/QTqRXy93ICvj5kR+k6tZVdtVXMHQqg
Xo1HaxBO/Q4iE9A67sBW/QmU6JL8aS8H1/W8d3F3N3wICB0QUI0s4Az0MwAM/5Tx
FrXeFSDWuH9zqN8OWtoaBRoKjsW/99J6TlX2ABeLdN9kqNz5ZqEX64kh1rx0FuUQ
dGieaM6dsw1jUUxKMtfCKRWjQBbPEHRVwUITbtits5AnhiGR1B611DWliPNy6tqi
+GxgOyb7zJAbAM93YutspQ6S818bYG5ouBurQ+SMkj4iQjBLVLjmzFVhsaG9MeI+
xAiKN3gqZWt81c6T3eqjk0pvHF51RInuGMdmhmD88q+oKjUlAJJYvDjTH4uyQZ4G
0HPVGrcimGvwLSTHvbbPijvnfO+vcYjW/06jlwdIfs5O0HcIHZejspdcqoOCcZ6v
d64u0Pxw1LTioyQI/moRodQd/EtfDm4ksVmn7A98QP6x9+8w677Hv3p6o39RZJhT
vjlp9c+JV1vev7Wa2i5wsD7MVnoiB9YQJKahy8yyqrO5jE0L8SM=
=h/tV
-----END PGP SIGNATURE-----

--3uu27mt5jeport7m--
