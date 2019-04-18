From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 00/10] Add support for XO 1.75 to OLPC battery driver
Date: Thu, 18 Apr 2019 22:20:00 +0200
Message-ID: <20190418202000.hcojhcf2f47te44u@earth.universe>
References: <20190418144655.18758-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jx6vzhc64gitrwmn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418144655.18758-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--jx6vzhc64gitrwmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 18, 2019 at 04:46:45PM +0200, Lubomir Rintel wrote:
> This patch set modifies the OLPC battery driver so that it could eventual=
ly
> be used on an Arm-based OLPC XO 1.75 machine.
>=20
> Compared to the previous version, it addresses review comments for the
> x86 platform parts from Thomas Gleixner. Details in individual patches'
> change logs.
>=20
> I've failed to version the previous iteration of the set that should've
> been "v6" for the change logs to make sense. Sorry for that.
>=20
> Thank you,
> Lubo

I queued up the complete patchset via an immutable branch based on
v5.1-rc1. X86 maintainers can pull this signed immutable branch as
required. Thanks for the patches,

-- Sebastian

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/psy-olpc-1.75-battery-signed

for you to fetch changes up to 31e220877981d0005d0c4a76f68027a73131212b:

  power: supply: olpc_battery: Have the framework register sysfs files for =
us (2019-04-18 21:55:04 +0200)

----------------------------------------------------------------
Immutable branch between x86 and power-supply for OLPC

This immutable branch contains the changes required for OLPC
1.75 battery, which touches x86 and power-supply and is based
on v5.1-rc1.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Lubomir Rintel (10):
      dt-bindings: olpc_battery: Add XO-1.5 battery
      x86/platform/olpc: Don't split string literals when fixing up the DT
      x86/platform/olpc: Trivial code move in DT fixup
      x86/platform/olpc: Use a correct version when making up a battery node
      power: supply: olpc_battery: Use DT to get battery version
      power: supply: olpc_battery: Move priv data to a struct
      power: supply: olpc_battery: Use devm_power_supply_register()
      power: supply: olpc_battery: Avoid using platform_info
      power: supply: olpc_battery: Add OLPC XO 1.75 support
      power: supply: olpc_battery: Have the framework register sysfs files =
for us

 .../bindings/power/supply/olpc_battery.txt         |   2 +-
 arch/x86/platform/olpc/olpc_dt.c                   | 101 ++++++++----
 drivers/power/supply/olpc_battery.c                | 169 +++++++++++++----=
----
 3 files changed, 177 insertions(+), 95 deletions(-)

--jx6vzhc64gitrwmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly42+wACgkQ2O7X88g7
+pqEIw/+IH19WGdKSJX8Ybr2LDUp56np4dT3S5GM0EFoxiC8hmpFtMKIBw5kdI2l
KoBQhsDJTwDnrycuDsFs4eNYZXw+qoNktW4bHNJe6Hdr0C3k77ITT86Y1QwZGH60
HD/E9brMn5HBBRi1/0YUCkRJa3Iy2nzr+hk8RE/gynHOXywqqmbRA+QCtG4P52Xf
0azBVaPT163+ioWB4K0P1JeVoGVz583+C9ZfWP683CfuZhLZ2zoLPWCl4hwTpgcJ
mWoX4jrALIvu8DJZslpg2vKFVqomWg1IMD/OXkDBKo7y/9/LKdb+qCRfFmwNPJQ/
D0xrhaCeCZeO/t5yMoI/pWRQMPU0TBreXYhydlL59L0mKgH8f1n99lqzDDn9+Vgv
vEVSIy9RrSmQ4tPcN3JnWw+MlzCqn8lB1xGWbXH2qlRP+hOZWAX5RQNh5t8KeBEk
vH1FzOSiMxBDgnHG4vHhjcwOf3UmD5ZlUuaIadN5KUIpC1ie126vqsutuQ7IzkmG
47oxKGsZxtK3ilJe1Pu/MKwQAQD1uTXkEMPeZ6D2ONJebgGbmSnvdZ05puusLwFH
PYhHFwf2cY+gydMZ5ONM1Rs3FNDsYOt/tOyHXYq/aZqh+d/DXMv5USm6XrLYKyKp
np8bpoUNdiyeoKQ0RQ1dyAw3qC2Z9s8Sz25IPpls7iNtayjJQB4=
=sV9a
-----END PGP SIGNATURE-----

--jx6vzhc64gitrwmn--
