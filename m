From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/5] Various fixes to weights in the thermal framework
Date: Mon, 23 Feb 2015 16:30:45 -0400
Message-ID: <20150223203042.GA30100@developer.amazonguestwifi.org>
References: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45852 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbBWVee (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 16:34:34 -0500
Received: by pdjz10 with SMTP id z10so28261763pdj.12
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2015 13:34:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Rui,

On Wed, Feb 18, 2015 at 04:04:20PM +0000, Javi Merino wrote:
> Weights can be specified in the device tree, but the code currently
> ignores the value.  Patch 1 fixes that by putting the weight in the
> thermal_instance.  Patches 2-3 simplify the code in the fair share
> governor by using the weight in the now populated thermal_instance.
> Patch 4 exports the weight to sysfs.  Patch 5 drops the requirement of
> all weights needing to add up to a hundred.
>=20
> Existing thermal zones using this governor should still work, as these
> series shouldn't make any functional change for them.  However,
> thermal zones that previously weren't able to use the fair share
> governor (because they were being register through device tree or
> because they weren't populating thermal_bind_params) now populate the
> weight properly and are able to use the governor.
>=20
> Changes since v2[0]:
>    - Change the default weight to 0.  For the fair share governor, if
>      all weights are 0, cooling devices get the same percentage.
>=20
> Changes since v1[1]:
>    - Fix the call to thermal_zone_bind_cooling_device() in
>      drivers/platform/x86/acerhdf.c and drivers/acpi/thermal.c
>=20
> [0] http://thread.gmane.org/gmane.linux.power-management.general/56269
> [1] http://thread.gmane.org/gmane.linux.power-management.general/55730
>=20
> Javi Merino (4):
>   thermal: fair_share: use the weight from the thermal instance
>   thermal: fair_share: fix typo
>   thermal: export weight to sysfs
>   thermal: fair_share: generalize the weight concept
>=20
> Kapileshwar Singh (1):
>   thermal: of: fix cooling device weights in device tree

Since I have been reviewing these patches and they are dependency of IPA
governor, I will be taking this series in my -linus branch.

Let me know if you have concerns.


BR,

Eduardo Valentin

>=20
>  Documentation/thermal/sysfs-api.txt                | 31 +++++++++--
>  drivers/acpi/thermal.c                             |  9 ++--
>  drivers/platform/x86/acerhdf.c                     |  3 +-
>  drivers/thermal/db8500_thermal.c                   |  2 +-
>  drivers/thermal/fair_share.c                       | 41 +++++++-------
>  drivers/thermal/imx_thermal.c                      |  3 +-
>  drivers/thermal/of-thermal.c                       |  5 +-
>  drivers/thermal/samsung/exynos_thermal_common.c    |  3 +-

Javi, I manually updated your patch 01, because exynos_thermal_common
does not exist as of v4.0-rc1

>  drivers/thermal/thermal_core.c                     | 62 ++++++++++++++++=
+++---
>  drivers/thermal/thermal_core.h                     |  3 ++
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  3 +-
>  include/linux/thermal.h                            | 15 ++++--
>  12 files changed, 137 insertions(+), 43 deletions(-)
>=20
> --=20
> 1.9.1
>=20

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU643qAAoJEMLUO4d9pOJWcRAH/A7lMrBJ8v30WGhcTLYqvP8c
uMmbCoISTOCtCIpSS8Gyx8aS1ROBknWEbunJnEDazMIPh38lqljMlGekqx7n4moS
uDbT06CfkXxYejpRLgVDpCS7nntiVMCoR0qRxz4tRf9yk4Wm1AF9/hwzFasykyuC
CnsWzgEc+r+MTlrxw9m2W4dvd9Tgi+/JSOeD23wToS54cpGNSGK4va93G4fMcfYc
oUzFWrbgRaGXVocRl22KFmTfk5bpinqNKSgOeSqNGsxgde/TQ0a1X0c8q1ykNwzr
wr/PrWB8EtpnYYZDISczxuLftzNUOPz4FF5ISBvJ8iUCDxiLNqRRHCglijEnXXQ=
=el/A
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
