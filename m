From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v14 00/11] devicetree simple-battery and client in
 bq27xxx_battery
Date: Thu, 8 Jun 2017 18:42:31 +0200
Message-ID: <20170608164231.gzqdrcnrt22655se@earth>
References: <20170607183759.20261-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dcd3mrafd7neomzn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50669 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdFHQmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 12:42:40 -0400
Content-Disposition: inline
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>


--dcd3mrafd7neomzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 07, 2017 at 11:37:48AM -0700, Liam Breck wrote:
> Hi Sebastian, I think this is finally ready to go. I'll make a final
> test pass while awaiting any further comments. There's a lot here, so
> I'd appreciate it if you could look closely, as it's been a while since
> you had any feedback. Also note comment about Rob's ack in v13 change lis=
t.

Ok, I had some hours for reviewing stuff today and finished
and queued everything up to patch 8, which looked fine to me.
I will have a look at the remaining 3 sometime this week.

> Enric, Paul, Quentin, and I all have patchsets waiting on this one.
> Thanks!

I also queued some of those, so that stuff can be
properly tested in linux-next. Thanks for your work.

Also: If any issues come up for the patches I want
follow-up patches instead of replacing them.

-- Sebastian

> Overview:
> * new devicetree battery node specifies static battery data
> * fuel gauge and charger nodes shall use monitored-battery=3D<&battery_no=
de>
> * new power_supply_get_battery_info() reads battery data from devicetree
> * new struct power_supply_battery_info provides battery data to drivers
> * drivers surface battery data in sysfs via related power_supply_prop_* f=
ields
> * bq27xxx driver calls the above and writes battery data to RAM/NVM for p=
arams
>   essential to correct operation: energy-full-design-microwatt-hours,
>   charge-full-design-microamp-hours, voltage-min-design-microvolt
>=20
> Changes in v14:
>   Doc...bindings/power/supply/ & power_supply_core
> *   add constant-charge-{current,voltage}-max-* for Enric's patchset
>   bq27xxx_battery:
> *   separate set_cfgupdate() and soft_reset() functions
> *   module param dt_monitored_battery_updates_nvm visible even when disab=
led
> *   real_chip & chip IDs combined in i2c_id_table[]
> *   hide untested chip params behind ifdef DEBUG
>=20
> Changes in v13:
>   Doc...bindings/power/supply/*
> *   add fields in battery.txt, see below
> *   caution about changing battery type in battery.txt
> *   note: Rob acked v11 battery.txt containing URL to Linux header
> *   more detail in bq27xxx.txt
>   power_supply_core:
> *   add battery_info fields precharge-current-microamp & charge-term-curr=
ent-microamp
> *   new patch for power_supply_prop_precharge_current
>   bq27xxx_battery:
> *   add copyright notice
> *   for flash/NVM chips, emit warning instead of doing update
> *   config_battery_bq27xxx_dt_updates_nvm enables update of flash/NVM
> *   module param dt_monitored_battery_updates_nvm lets user disallow upda=
te
> *   new patch to flag dupes in bq27xxx_regs[]
> *   drop patch to clean up error reporting
> *   polishing from Andrew's feedback
> *   resolve checkpatch errors
> *   refactor patchset
> *   fix missing static keyword flagged by Colin
>=20
> Changes in v12: (several partial series posts; see above)
>=20
> Changes in v11:
>   power_supply_core:
> *   switch to compatible =3D "simple-battery"
> *   add docs to power_supply_class.txt
>   Documentation/devicetree/.../battery.txt:
> *   add description, drop refs to Linux, "simple-battery"
>   bq27xxx_battery:
> *   reset flash chips after DM update
> *   add bq27xxx_write/xfer()
> *   polishing from Andrew's feedback
> *   new patch to clean up error reporting
> *   new patch to consolidate duplicate register/property arrays
>=20
> Changes in v10:
>   bq27xxx_battery:
> *   pass actual chip ID into _setup()
> *   add di->unseal_key & di->dm_regs; drop static arrays
> *   support bq27425, 441, 621
>=20
> Changes in v9:
>   bq27xxx_battery:
> *   fix set_cfgupdate()
> *   support bq27500, 545, 421; defer others
> *   drop print_dm_blocks() patch
> *   minor polishing
>   Documentation/devicetree/.../battery.txt:
> *   describe rationale for enum power_supply_property names
>=20
> Changes in v8:
>   bq27xxx_battery:
> *   wait on flag after set_cfgupdate & soft_reset
> *   drop print_config(), report status in update_dm_block()
> *   clarify error messages
> *   cleanup from Andrew's feedback; minor polishing
>=20
> Changes in v7:
>   bq27xxx_battery:
> *   support chips where terminate_voltage & design_* live in separate blo=
cks
> *   draft support for 421, 441, 621 chips
> *   new patch to log chip memory fields
> *   report bus I/O errors; return error code in bq27xxx_battery_i2c
> *   verify checksum in read_dm_block()
> *   use set_cfgupdate only if chip provides it, soft_reset on I/O error
> *   block_data_control=3D0 only in write_dm_block()
> *   note toxic code from TI bqtool in write_dm_block()
> *   lots of functionally neutral polishing
>   Documentation/devicetree/.../battery.txt:
> *   mention power_supply_get_battery_info()
>=20
> Changes in v6:
> * Documentation/devictree/... fixes
> * bq27xxx_battery: clarify names
> * bq27xxx_battery: verify that selected registers are supported
> * bq27xxx_battery: allocate NVM buffer on stack
> * bq27xxx_battery_i2c: fix return code of bulk_read
>=20
> Changes in v5:
> * incorporate feedback into Documentation/devicetree/.../battery.txt
> * use power_supply_prop_* names in devicetree and power_supply_battery_in=
fo
> * default fields to -EINVAL in power_supply_battery_info
> * power_supply_get_battery_info() always looks for "monitored-battery"
> * power_supply_get_battery_info() emits a warning if !psy->of_node
> * squash patches for power_supply_battery_info
> * bq27xxx_battery: check power_supply_battery_info values
> * bq27xxx_battery: note missing power_supply_prop_* features
> * bq27xxx_battery: new patch for access methods
>=20
> Changes in v4:
> * add "fixed-battery" compatible field to be be more consistant with devi=
cetree
>=20
> Changes in v3:
> * split i2c changes into respective patches
> * add documentation for battery information for fuel gauge
> * rebased documentation patches on change on the list
> * abstracted the battery configuration for the state machine
>   to an generic struct and platform data access function
>=20
> Changes in v2:
> * add documentation for uWh and uAh property units
> * change devicetree entries to match new property units
>=20
>=20
> Liam Breck (9):
>   dt-bindings: power: supply: Add battery.txt with simple-battery binding
>   power: supply: core: Add power_supply_battery_info and API
>   power: supply: core: Add power_supply_prop_precharge
>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
>   power: supply: bq27xxx: Add chip data memory read/write support
>   power: supply: bq27xxx: Add power_supply_battery_info support
>   power: supply: bq27xxx: Enable data memory update for certain chips
>   power: supply: bq27xxx: Flag identical register maps when in debug mode
>   power: supply: bq27xxx: Remove duplicate register arrays
>=20
> Matt Ranostay (2):
>   devicetree: property-units: Add uWh and uAh units
>   power: supply: bq27xxx: Add bulk transfer bus methods
>=20
>  .../devicetree/bindings/power/supply/battery.txt   |  57 ++
>  .../devicetree/bindings/power/supply/bq27xxx.txt   |  31 +-
>  .../devicetree/bindings/property-units.txt         |   2 +
>  Documentation/power/power_supply_class.txt         |  31 +-
>  drivers/power/supply/Kconfig                       |  11 +
>  drivers/power/supply/bq27xxx_battery.c             | 752 +++++++++++++++=
++----
>  drivers/power/supply/bq27xxx_battery_i2c.c         | 134 +++-
>  drivers/power/supply/power_supply_core.c           |  57 ++
>  drivers/power/supply/power_supply_sysfs.c          |   1 +
>  include/linux/power/bq27xxx_battery.h              |  30 +-
>  include/linux/power_supply.h                       |  25 +
>  11 files changed, 955 insertions(+), 176 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.txt
>=20
> --=20
> 2.13.0
>=20

--dcd3mrafd7neomzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5fncACgkQ2O7X88g7
+ppZ3xAAn3yijEbF7w3ZfjksHb1QcAlvpS7po/zQbJ6M4+aPetS4i91ZqHloaE5h
rmw+1IcCK7/LEYhxnpfrBbM492DFF3sWuhSDbi7NZ542GSgatxeDRJYZkbc0LsbX
PqcXOnM6A864D7QdvfJAo1XYP6OUMNYi+PO3KEv9Ts4cJPpDr5BDPAcs258A9ecT
YF0B/dFmHqY3FQxLSZi5VzvBATFWIm0DK+i6vDFblmsPNRh9YJSBxH2kFdicuf4k
wVWq7dQo1mSHJJhV5I9l0ypgP/AGAROKNPZnAZfIaB7WrK9eGqs+QxD6JJQeENeq
qyjyU9+X3MZBuYJKUYt6L5YT2Lcqob3biPskxJsryg/HYhEUWQZj65gPJRH/CHjX
GvEfWh/F5rPm22H7A0qv2lNkYgG4bhL/E8RiN74oIaD9vFrAbPL0c8KZHSnjb2nw
NPWUPL4KgIZTH0n3gUHrHZI8FKUbuISkWXkXFXgcWP/yKNcMQc9yvBw/o/rxkpmH
qesWDmWWy3/pWacT/VLbp/Ix64HvMQf+GpHlSqwTXmHzD1takzIfxDb3okX7eL50
LXp1XXWOctUwPWCT5nIva5NRd9sFaAHYF5GFgDtay3cqQhsJWct+kc0cgnY8d1ub
8UP+h8ASUbL02tBtZZdVmzn1quFT/pN8m25DJn8/x/Iabq5zQWw=
=c9Fh
-----END PGP SIGNATURE-----

--dcd3mrafd7neomzn--
