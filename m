From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27xxx_battery: don't update poll_interval param
 if same
Date: Wed, 19 Oct 2016 05:00:14 +0200
Message-ID: <20161019030013.tskewnz4ycj7adef@earth>
References: <1475297130-18080-1-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="up7szky4abetngnx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475297130-18080-1-git-send-email-matt@ranostay.consulting>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org


--up7szky4abetngnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 30, 2016 at 09:45:30PM -0700, Matt Ranostay wrote:
> To avoid canceling the delayed workqueue needlessly, and scheduling an
> immediate polling. Check if the new poll_interval value is different
> than the previous setting.
>=20
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>

Thanks, queued to for-next.

-- Sebastian

--up7szky4abetngnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBuG9AAoJENju1/PIO/qasjAQAI89fpX+kECorG16BPijtHU3
TdmrKv9EXs4Ndm1lrJSqIYZPuoiTKAeiUkJ4cS7Rpv5fm/prpIyod+c1ZXxwqNuW
pT1u72zuoR4e4FmeX//sZrhS66OhMdk3z3x3tegWI2XN/4rGG0uP/+WxFL3g07pV
v7R8JW5+tQI2QyWsFRjZdhTNKIsVKzuxJkkVLsr58iTXEDzB/j7dr0yxVYX5ahQx
H3IuSSvLND857FYURG3AoMqxSRJcS9P54qSE/IXGihQ0JU7EL4uAAZbs9vs224Ta
h2enWeOHT7dUU0tJwH5mA90Aof1oUZiBmfPUUl4CwMO6czVJShoR9PFvBeEnHXsq
n70M/xod9TxU9auqwm+QMyt1oGNjueMAJ2NTbOi9RcrZUcRvpA9eRlaDLU4Kv+J1
cDvmDJ8i4N5SE5hhFsavuTqz6/Tv5d60Gs+29ama9l2jpKpCLbBlQpSo46BONtq8
mFqfW22cjVIXLOiiU69eq+U5KtsWPqTyok6PAF/WZDIvM2NwpTmcEQFQHG/KleDk
4rDF2LPfLhwqNk0wwd/mdBgoiq0ZvoIaqe3GCZkYVkGFNUuS6KadaexTSt98UgZs
zjWEvRSQK9Ngd0c+KeuFfd27KggnMgrgEMwMQ2bledk2R1L5+SWd1505kjHoGKL2
8AdCeJlfWw0Ohv6Vxeci
=MMu5
-----END PGP SIGNATURE-----

--up7szky4abetngnx--
