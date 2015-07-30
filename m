From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: remove dangling 'weight_attr' device file
Date: Wed, 29 Jul 2015 23:30:14 -0700
Message-ID: <20150730063012.GA6157@localhost.localdomain>
References: <874682c7b1ab8b0fcc2abc905c71bc2bc041aaeb.1437642037.git.viresh.kumar@linaro.org>
 <20150730061438.GA31351@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34634 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbG3GaS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 02:30:18 -0400
Content-Disposition: inline
In-Reply-To: <20150730061438.GA31351@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, javi.merino@arm.com, open list <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 11:44:38AM +0530, Viresh Kumar wrote:
> On 23-07-15, 14:32, Viresh Kumar wrote:
> > This file isn't getting removed while we unbind a device from thermal
> > zone. And this causes following messages when the device is registered
> > again:
> >=20
> > WARNING: CPU: 0 PID: 2228 at /home/viresh/linux/fs/sysfs/dir.c:31 sysfs=
_warn_dup+0x60/0x70()
> > sysfs: cannot create duplicate filename '/devices/virtual/thermal/therm=
al_zone0/cdev0_weight'
> > Modules linked in: cpufreq_dt(+) [last unloaded: cpufreq_dt]
> > CPU: 0 PID: 2228 Comm: insmod Not tainted 4.2.0-rc3-00059-g44fffd9473eb=
 #272
> > Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > [<c00153e8>] (unwind_backtrace) from [<c0012368>] (show_stack+0x10/0x14)
> > [<c0012368>] (show_stack) from [<c053a684>] (dump_stack+0x84/0xc4)
> > [<c053a684>] (dump_stack) from [<c002284c>] (warn_slowpath_common+0x80/=
0xb0)
> > [<c002284c>] (warn_slowpath_common) from [<c00228ac>] (warn_slowpath_fm=
t+0x30/0x40)
> > [<c00228ac>] (warn_slowpath_fmt) from [<c012d524>] (sysfs_warn_dup+0x60=
/0x70)
> > [<c012d524>] (sysfs_warn_dup) from [<c012d244>] (sysfs_add_file_mode_ns=
+0x13c/0x190)
> > [<c012d244>] (sysfs_add_file_mode_ns) from [<c012d2d4>] (sysfs_create_f=
ile_ns+0x3c/0x48)
> > [<c012d2d4>] (sysfs_create_file_ns) from [<c03c04a8>] (thermal_zone_bin=
d_cooling_device+0x260/0x358)
> > [<c03c04a8>] (thermal_zone_bind_cooling_device) from [<c03c2e70>] (of_t=
hermal_bind+0x88/0xb4)
> > [<c03c2e70>] (of_thermal_bind) from [<c03c10d0>] (__thermal_cooling_dev=
ice_register+0x17c/0x2e0)
> > [<c03c10d0>] (__thermal_cooling_device_register) from [<c03c3f50>] (__c=
pufreq_cooling_register+0x3a0/0x51c)
> > [<c03c3f50>] (__cpufreq_cooling_register) from [<bf00505c>] (cpufreq_re=
ady+0x44/0x88 [cpufreq_dt])
> > [<bf00505c>] (cpufreq_ready [cpufreq_dt]) from [<c03d6c30>] (cpufreq_ad=
d_dev+0x4a0/0x7dc)
> > [<c03d6c30>] (cpufreq_add_dev) from [<c02cd3ec>] (subsys_interface_regi=
ster+0x94/0xd8)
> > [<c02cd3ec>] (subsys_interface_register) from [<c03d785c>] (cpufreq_reg=
ister_driver+0x10c/0x1f0)
> > [<c03d785c>] (cpufreq_register_driver) from [<bf0057d4>] (dt_cpufreq_pr=
obe+0x60/0x8c [cpufreq_dt])
> > [<bf0057d4>] (dt_cpufreq_probe [cpufreq_dt]) from [<c02d03e4>] (platfor=
m_drv_probe+0x44/0xa4)
> > [<c02d03e4>] (platform_drv_probe) from [<c02cead8>] (driver_probe_devic=
e+0x174/0x2b4)
> > [<c02cead8>] (driver_probe_device) from [<c02ceca4>] (__driver_attach+0=
x8c/0x90)
> > [<c02ceca4>] (__driver_attach) from [<c02cd078>] (bus_for_each_dev+0x68=
/0x9c)
> > [<c02cd078>] (bus_for_each_dev) from [<c02ce2f0>] (bus_add_driver+0x19c=
/0x214)
> > [<c02ce2f0>] (bus_add_driver) from [<c02cf490>] (driver_register+0x78/0=
xf8)
> > [<c02cf490>] (driver_register) from [<c0009710>] (do_one_initcall+0x8c/=
0x1d4)
> > [<c0009710>] (do_one_initcall) from [<c05396b0>] (do_init_module+0x5c/0=
x1b8)
> > [<c05396b0>] (do_init_module) from [<c0086490>] (load_module+0xd34/0xed=
8)
> > [<c0086490>] (load_module) from [<c0086704>] (SyS_init_module+0xd0/0x12=
0)
> > [<c0086704>] (SyS_init_module) from [<c000f480>] (ret_fast_syscall+0x0/=
0x3c)
> > ---[ end trace 3be0e7b7dc6e3c4f ]---
> >=20
> > Fixes: db91651311c8 ("thermal: export weight to sysfs")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/thermal/thermal_core.c | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Hi Eduardo,
>=20
> Not sure if you are on leaves right now, but this is an rc fix. Can

sort of.. but now I am back. Apologize for the inconvenience.

> you please apply that ?

looking into it. doing local checks. but it should be on its way.

Thanks for the fix.

BR,

Eduardo Valentin

>=20
> --=20
> viresh

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVucRtAAoJEMLUO4d9pOJWgCcH/R/dh4cGIlQ7ko+z6Tpc09WB
Nq0IhXadHX3cdL8TPBGewBf88Ly0l/Y8rwjvWugumW7M3L00PQx20dSHRKMOlVLX
Ca2TYIRHHf7Kwilj1CjliWn4PlsoG3zK92k4BKgJzU5hmf8W/t0tuW3nmea+wxOq
DyQDQtMKh4p/UmzMr2qu6BRGzCSo65JF2t84Imje95nnqxrJzixQ+UxPlhhrHpSf
/ntWOLY6g1nsMHdr7OeLWyJQoZPHg7ANuLzxpruDmskDO9xDzZ42dyp4kK2sPf7u
zlRJb0Ub75ZizLLZNgShrBF8yzcqBQE3b5ABIpJRoDDGY7U4cU4bAHl/kCWS9Kk=
=HM6G
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
