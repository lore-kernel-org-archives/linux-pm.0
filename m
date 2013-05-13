From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 0/2] CPU Package temperarure thermal driver
Date: Mon, 13 May 2013 15:08:55 -0400
Message-ID: <51913A47.9080206@ti.com>
References: <1367953065-2729-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2MTEHUWIJPQODSCPIFJUL"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50682 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab3EMTJN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 15:09:13 -0400
In-Reply-To: <1367953065-2729-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, tony.luck@intel.com, linux-edac@vger.kernel.org, eduardo.valentin@ti.com

------enig2MTEHUWIJPQODSCPIFJUL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07-05-2013 14:57, Srinivas Pandruvada wrote:
> This driver register CPU digital temperature package level sensor as a
> thermal zone with two user mode configurable trip points. Once
> the trip point is violated, user mode can receive notification via ther=
mal
> notification mechanism and can take any action to control temperature.


So, you have an IRQ that will be translated into a thermal event to
userland. Userland takes care of cooling the device. Is that correct?

>=20
> Background:
> This set of changes were done to coretemp driver and posted to lm_senso=
rs
> mailing list on 04/04/2013. This was reviewed by Guenter Roeck from lm-=
sensors
> and Zhang Rui (thermal maintainer). They were in agreement not to add n=
otification
> mechanism to coretemp driver but use thermal sysfs.
> Guenter Roeck suggested to use approach like "db8500_thermal driver in =
drivers/thermal".
> So resubmitting the driver as a thermal zone driver.
> Previous discussion link:
> http://comments.gmane.org/gmane.linux.drivers.sensors/32182
> "=20
> This is clear that there is reluctance in adding thresholds in coretemp=
 sysfs,
> during previous attempts. Probably because of lake of use cases.
> But this time use case may be more compelling.
>=20
> We have many small form factor devices like ultrabooks, slate PCs in th=
e market.
> Unfortunately these devices reach maximum temperature with relatively l=
ess
> workloads, causing BIOS to do thermal throttling. There are real perfor=
mance
> issues due to aggressive BIOS action to control thermals and also therm=
al breakdown
> in some cases.
>=20
> Even the most expensive laptops, don't have correct ACPI thermal config=
uration,
> so that kernel thermal driver can act. In some case even the trip point=
 is higher
> than critical temperature setting.
>=20

So, this driver is meant for ACPI capable systems, but with incorrect
ACPI thermal configuration. Is my understanding correct? Does it apply
to other types of systems?



> Intel has developed several drivers, which can be used to cool the syst=
em very efficiently.
> They include RAPL based cooling driver, Powerclamp driver and P state d=
river.
> To utilize these cooling device a closed loop user mode program is requ=
ired, which
> will utilize these method and dynamically compensate for high CPU tempe=
ratures,
> without relying on any configuration data.
> One such solution is developed is "Linux thermal daemon". More details =
can be
> obtained from=20
> "https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Intr=
oduction.pdf".
> This daemon polls for cpu temperature and apply compensation once the C=
PU reach target
> temperature.=20
>=20
> This polling can be mostly avoided, by getting notification for the tem=
perature, where
> it needs to wake up and get ready for apply compensation. In most of th=
e normal use=20
> cases, there may not be any threshold events. So very minimal number of=
 user space
> notification for thermal thresholds.
> "
>=20

IMO, interrupt based TDM can be extended to non ACPI systems in most
cases. This is based on the fact that most temperature sensors for
embedded systems provide int high/low thresholds for triggering IRQs.
Not only Bandgaps but also I2C devices. Thus, avoiding polling is a
common target.

If the design can be generalized enough to cope with improving the
framework, I believe is a better way to go.

>=20
> Srinivas Pandruvada (2):
>   x86, mcheck, therm_throt: Process package thresholds
>   Thermal: CPU Package temperature thermal
>=20
>  arch/x86/include/asm/mce.h               |   7 +
>  arch/x86/kernel/cpu/mcheck/therm_throt.c |  63 ++-
>  drivers/thermal/Kconfig                  |  12 +
>  drivers/thermal/Makefile                 |   2 +-
>  drivers/thermal/x86_pkg_temp_thermal.c   | 633 +++++++++++++++++++++++=
++++++++
>  5 files changed, 712 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/thermal/x86_pkg_temp_thermal.c
>=20



------enig2MTEHUWIJPQODSCPIFJUL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGROkcACgkQCXcVR3XQvP0qMgEAmQw0KqeFu6VI7haaOtdy8M8Q
6aD8ZaK1/et8c+c5P0AA/2/2x/1s+bH+AFl92FZ7LRxsBHR5ZMXW7bPKcWr0QlBE
=7Hb4
-----END PGP SIGNATURE-----

------enig2MTEHUWIJPQODSCPIFJUL--
