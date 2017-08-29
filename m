From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v4 0/5] BQ24190 devicetree config
Date: Tue, 29 Aug 2017 13:18:13 +0200
Message-ID: <20170829111812.z2grlfs6f5xjrejl@earth>
References: <20170828212349.19037-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y4wwt5tg5tbzvt7m"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56218 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdH2LSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 07:18:17 -0400
Content-Disposition: inline
In-Reply-To: <20170828212349.19037-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>


--y4wwt5tg5tbzvt7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 28, 2017 at 02:23:44PM -0700, Liam Breck wrote:
> Hi Sebastian, here is this series that was waiting on the power_supply_ba=
ttery_info
> patchset. Thanks!

Thanks, queued.

-- Sebastian

> Overview:
> BQ24190 uses power_supply_battery_info fields for precharge & charge-term=
ination=20
> current and a DT property for system min voltage. A new DT binding docume=
nts these.
>=20
> Changes in v4:
> * drop ifdef config_of
>=20
> Changes in v3:
> * clarify gpio-hog use in DT binding doc
> * drop unrelated change from DT table patch
>=20
> Changes in v2:
> * new patch adds bq24192i to DT table
> * dropped patches for power_supply precharge-current; they moved to bq27x=
xx series
> * dropped patches for recently-applied fixes
> * rebased to -next
>=20
> Issues in v1:
> * power_supply_prop_precharge & endcharge are added at end of enum to avo=
id sysfs breakage
> * "Set bq24190-battery device .type=3Dunknown" is a temporary workaround =
to be fixed in v2
>=20
> Liam Breck (5):
>   power: bq24190_charger: Add ti,bq24192i to devicetree table
>   devicetree: power: Add docs for TI BQ24190 battery charger
>   power: bq24190_charger: Enable devicetree config
>   power: bq24190_charger: Add property system-minimum-microvolt
>   power: bq24190_charger: Add power_supply_battery_info support
>=20
>  .../devicetree/bindings/power/supply/bq24190.txt   |  51 +++++++
>  drivers/power/supply/bq24190_charger.c             | 169 +++++++++++++++=
+++---
>  2 files changed, 200 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2419=
0.txt
>=20
> --=20
> 2.13.2
>=20

--y4wwt5tg5tbzvt7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlTXIACgkQ2O7X88g7
+pqpgw/+M3ERwlZYnb3GFBrETp1UJeNLOSPPtsB3FfQdWEezW46RWpoDQk622DH7
4v1VwgzP18O0SdgMETISaTkzc+kUSm2PiyJoGguJXGzhgi6bWjue7W8pywOozvb2
MfpZ3JDTfeR2sk8uQkmYkyzHWfY5C4os1SvPgDlMAKUk+lnskdYi4J6S/FjpwDPJ
G6QAf8neWXniIpx02mmjV4tOO3EMyYZn2YE69yxQtXuzP68znfaeeTTZYuU2nijv
z8xQnZtQdwMZv0HHJZ766YssU/KkAidPi1NmUppfllLvO8bf4tnu1xZnvJ0yB9WI
GS56PSDCVkEcLzyERVtwfRKhlb3vFjL1l5XUKeiIMkGBoQrUpeeolKIVKvSLkgPS
E69VHiWf8Ms15a4LRw6YG0fYNVgblfvOXad4bKGyAoD69O/slPv4oPr5Q79qMlYL
/gI0H65TA6J4L9jHL/MNA1v09fiq2gMDy9iyr6yoB8WT9FB5v0EPF1xTwJU15B/c
wgk8SYheqYebbuhRbpzMxgMkGf/qWZbL8l7HjcNsuP4p97pj8F8KiC75K496gvQN
GPE5rs66JqFjPD0i+M6/pGXJ0Zqc3oP5Bh+fUgk9TZ09VcuIvF2mbrA6Jd4OYKFk
dDFu3hER0epfgfSyB24fk4pRpIDdJkMhBFmTG8sh6+KfnSxoM8k=
=KoC9
-----END PGP SIGNATURE-----

--y4wwt5tg5tbzvt7m--
