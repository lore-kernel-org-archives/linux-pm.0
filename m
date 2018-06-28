From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 4/4] power: ds2760_battery: add device tree glue
Date: Thu, 28 Jun 2018 13:52:46 +0200
Message-ID: <20180628115246.6qqa3nwxwx2qpls6@earth.universe>
References: <20180628075540.1757-1-daniel@zonque.org>
 <20180628075540.1757-5-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uvyaxcjvs7arj2vj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180628075540.1757-5-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr
List-Id: linux-pm@vger.kernel.org


--uvyaxcjvs7arj2vj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 28, 2018 at 09:55:40AM +0200, Daniel Mack wrote:
> The w1 slave device used by this driver now has a of_node in case it
> was matched against a devicetree sub-node of the bus master. This can
> now be passed down to the power supply core which will parse more
> properties from the node, such as 'power-supplies'.
>=20
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---

Thanks for the patch series. Having proper DT support is a nice
addition. But instead of extending the platform device hack, please
merge the w1 driver into ds2760_battery.c as it happened to the
bq27000 driver already. The intermediate platform device is completly
useless and only makes things more complicated.

Basically move all code from w1_ds2760.c into ds2760_battery.c,
drop some EXPORT_SYMBOL and make functions static instead. Then
move content from probe/remove function into add_slave/remove_slave
callbacks and drop all platform device things.

-- Sebastian

--uvyaxcjvs7arj2vj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls0zAsACgkQ2O7X88g7
+pqMqA//UmZfoi5Ks0x0KNtHk7i2gbP+OZCZorgzk2XofSVdayVBpSqwZbKZl7zh
zSOSBnav11j872K3wb+NvsiRq2qxVHzgf7kaHFOQfGrAlmuKoSVjtNItTTS46gT2
OgGaiMs2vePfBlMIbEXqDloxyhmWT49m4038SdtI5S9lKtpEHOJ4/KrBgTX7boi6
NcJ2BBdXn6BeDkKxPVB+X0nX3G48DgEBQN4lqu3LTH+jhLk94AsY5CtA5GFkeYdD
TgrR9s3hMcUbbhobZNnYIG7DVAfiuXEGd4xzGg1EZvomt02oUJX23O6Z6ijDANRS
zFodr1rmJHBXDYhYxV+jIRmeON9SHUopy5xqeINhKX6TuLc1kUon9OS1lkxRGdbj
xGwrJavZ9XDp5xpPgkGzBsT0hqXlSqRCFOiQbWndyCXliHdQO3gaqBMlkbNvl5Z+
BrwIe+A5am76allpuUxb56H90ihGbQGLnoXfS41ouu+ySV91tbFmsB4v1U9WN6xP
h8lSZiqry5fSppHTmXxbAODndBBrW+aTeTu038ovJf5YNmHcJGDZZF9mlSkMWUoR
DKEol2NlcgXm2H/lvKoilaFbWwubuYQIC7rYtYTMOjXOej9kznPWK4i0euHcagDt
rlNO78LJB61ZJxr643acMVa4sWfYoJaJTAD2AQ/PbTGrJ7YLZDI=
=eA3P
-----END PGP SIGNATURE-----

--uvyaxcjvs7arj2vj--
