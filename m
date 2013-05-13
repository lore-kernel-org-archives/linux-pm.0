From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 0/2] CPU Package temperarure thermal driver
Date: Mon, 13 May 2013 15:16:40 -0400
Message-ID: <51913C18.4070008@ti.com>
References: <1367953065-2729-1-git-send-email-srinivas.pandruvada@linux.intel.com> <51913A47.9080206@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2PSRGIJXATJRKVSQHUPPR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45454 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab3EMTRK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 15:17:10 -0400
In-Reply-To: <51913A47.9080206@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, rui.zhang@intel.com, tony.luck@intel.com, linux-edac@vger.kernel.org

------enig2PSRGIJXATJRKVSQHUPPR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13-05-2013 15:08, Eduardo Valentin wrote:
> On 07-05-2013 14:57, Srinivas Pandruvada wrote:
>> This driver register CPU digital temperature package level sensor as a=

>> thermal zone with two user mode configurable trip points. Once
>> the trip point is violated, user mode can receive notification via the=
rmal
>> notification mechanism and can take any action to control temperature.=

>=20
>=20
> So, you have an IRQ that will be translated into a thermal event to
> userland. Userland takes care of cooling the device. Is that correct?
>=20
>>
>> Background:
>> This set of changes were done to coretemp driver and posted to lm_sens=
ors
>> mailing list on 04/04/2013. This was reviewed by Guenter Roeck from lm=
-sensors
>> and Zhang Rui (thermal maintainer). They were in agreement not to add =
notification
>> mechanism to coretemp driver but use thermal sysfs.
>> Guenter Roeck suggested to use approach like "db8500_thermal driver in=
 drivers/thermal".
>> So resubmitting the driver as a thermal zone driver.
>> Previous discussion link:
>> http://comments.gmane.org/gmane.linux.drivers.sensors/32182
>> "=20
>> This is clear that there is reluctance in adding thresholds in coretem=
p sysfs,
>> during previous attempts. Probably because of lake of use cases.
>> But this time use case may be more compelling.
>>
>> We have many small form factor devices like ultrabooks, slate PCs in t=
he market.
>> Unfortunately these devices reach maximum temperature with relatively =
less
>> workloads, causing BIOS to do thermal throttling. There are real perfo=
rmance
>> issues due to aggressive BIOS action to control thermals and also ther=
mal breakdown
>> in some cases.
>>
>> Even the most expensive laptops, don't have correct ACPI thermal confi=
guration,
>> so that kernel thermal driver can act. In some case even the trip poin=
t is higher
>> than critical temperature setting.
>>
>=20
> So, this driver is meant for ACPI capable systems, but with incorrect
> ACPI thermal configuration. Is my understanding correct? Does it apply
> to other types of systems?
>=20
>=20
>=20
>> Intel has developed several drivers, which can be used to cool the sys=
tem very efficiently.
>> They include RAPL based cooling driver, Powerclamp driver and P state =
driver.
>> To utilize these cooling device a closed loop user mode program is req=
uired, which
>> will utilize these method and dynamically compensate for high CPU temp=
eratures,
>> without relying on any configuration data.
>> One such solution is developed is "Linux thermal daemon". More details=
 can be
>> obtained from=20
>> "https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Int=
roduction.pdf".
>> This daemon polls for cpu temperature and apply compensation once the =
CPU reach target
>> temperature.=20
>>
>> This polling can be mostly avoided, by getting notification for the te=
mperature, where
>> it needs to wake up and get ready for apply compensation. In most of t=
he normal use=20
>> cases, there may not be any threshold events. So very minimal number o=
f user space
>> notification for thermal thresholds.
>> "
>>
>=20
> IMO, interrupt based TDM can be extended to non ACPI systems in most
> cases. This is based on the fact that most temperature sensors for
> embedded systems provide int high/low thresholds for triggering IRQs.
> Not only Bandgaps but also I2C devices. Thus, avoiding polling is a
> common target.
>=20
> If the design can be generalized enough to cope with improving the
> framework, I believe is a better way to go.
>=20
>>
>> Srinivas Pandruvada (2):
>>   x86, mcheck, therm_throt: Process package thresholds
>>   Thermal: CPU Package temperature thermal
>>
>>  arch/x86/include/asm/mce.h               |   7 +
>>  arch/x86/kernel/cpu/mcheck/therm_throt.c |  63 ++-
>>  drivers/thermal/Kconfig                  |  12 +
>>  drivers/thermal/Makefile                 |   2 +-
>>  drivers/thermal/x86_pkg_temp_thermal.c   | 633 ++++++++++++++++++++++=
+++++++++
>>  5 files changed, 712 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/thermal/x86_pkg_temp_thermal.c
>>

I d recommend including documentation on your series, explaining where
this driver is applicable and how it is supposed to work.
>=20
>=20



------enig2PSRGIJXATJRKVSQHUPPR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGRPBgACgkQCXcVR3XQvP0o6AEA4B9p8Bl4Wz10mMqS9AtPbd1v
9A84YHAjcsg8KzAjpp0BANC5qbB0hL4dL4Vv1Ryrp2g90171js9t3QB6vUnnna54
=rgDu
-----END PGP SIGNATURE-----

------enig2PSRGIJXATJRKVSQHUPPR--
