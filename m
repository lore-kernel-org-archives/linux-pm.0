From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/7] thermal: rcar_gen3_thermal: add support for
 interrupt triggerd trip points
Date: Wed, 29 Mar 2017 22:51:39 +0200
Message-ID: <20170329205139.GB1440@katana>
References: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47710 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933052AbdC2Uvm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 16:51:42 -0400
Content-Disposition: inline
In-Reply-To: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 08:43:49PM +0200, Niklas S=C3=B6derlund wrote:
> Hi,
>=20
> This series adds support for hardware backed trip point windows. It is
> based on top of v4.11-rc1 and is tested on R-Car H3 and M3-W.
>=20
> The series starts out by fixing three issues (1/7, 2/7, 3/7) that should
> have been fixed by me before the initial driver where submitted to
> upstream. Sorry for not spotting the issues sooner.
>=20
> The series then extends the rcar_gen3_thermal driver with hardware
> interrupts for trip point windows by implementing the .set_trips()
> callback of struct thermal_zone_of_device_ops (4/7, 5/7). It then adds
> suspend and resume handlers so that the hardware interrupts are
> preserved across suspend/resume cycles (6/7, 7/7).

Thanks, Niklas! From my PoV, this series is good to go upstream!


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY3B5bAAoJEBQN5MwUoCm2RGIQAKGTKKibMa8+Q0kOu4yZPGlT
4GiuYBlFm89GQsEZ1gDMVw6WcdTLuG8t5nIXkX+Fn64z47gQvc4oftlcjCYpSi0e
psv1TcLH2w3jSHzL23JuGClDn9TQ1GrLsW6xyXQKXm6Ovh16WbGzgHUg5an7gWoW
hfXRgbAmWUtW0Ow7aFeuYLbxeLQQnsE5hKGj+vNOmZ0n6Y7fOB7JnouMu4mFdVRr
+BMnEEL6ZGtDuMlKeFzWbaGNQ2EFlKoq3dFbI6E7M+QZ4SPdJ5TQcQr1CR+9TEXi
/jwut2sg8covGNiAQM8qHOjmZGvHe/8v/ymbJ+3KUPOEIunBFdChBvCSoMXBac/G
pdAYLk5E5dsFraq9aGC/BEf2sSe/qSSFXZUR3Fx4AkaftuuTeHImS8n7/hrispcJ
BKORbopNGimOOqB3bTPTiiMQCeRtPVAgqlaYasI58TTrXvKp1/0qiVTOIYYWUkuv
jB7ety2BMvSJQBLbhrefN/5CWj+CsRz4XwmluK3ctekW9jm0pCcHSAojyIlqSa+4
PTYnBy7JRDKxpxK97LKfO8fJSou0NaZK/NObxdRCPiPxcsC7gwpd3VDtEpe7f+pr
mBqlK/UlgMd/U7u7lYUdX37zZ5LgkbImoakI3WVjlDnhLp4QVd2apRMFD6+ogb7W
1zuQ8AjkWjMzHLDuO5G3
=Rup7
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
