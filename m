From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: Runtime PM causes oops on next-20151015
Date: Thu, 15 Oct 2015 15:26:55 +0200
Message-ID: <20151015132655.GA20406@ulmo.nvidia.com>
References: <20151015092213.GA26614@ulmo.nvidia.com>
 <1444903494.8464.5.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444903494.8464.5.camel@ellerman.id.au>
Sender: linux-next-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wonhong Kwon <wonhong.kwon@lge.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-next@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2015 at 09:04:54PM +1100, Michael Ellerman wrote:
> On Thu, 2015-10-15 at 11:22 +0200, Thierry Reding wrote:
> > Hi Rafael, Wonhong,
> >=20
> > Todays linux-next breaks rather spectacularly for drivers using runtime
> > PM. The culprit seems to be this commit:
> >=20
> > 	commit 7d24068e144adc03b805806645d732cf79488717
> > 	Author: Wonhong Kwon <wonhongkwon@gmail.com>
> > 	Date:   Tue Oct 6 10:10:20 2015 +0900
> >=20
> > 	    PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync
> >=20
> > 	    pm_init is being invoked by core_initcall and hibernate_image_size=
_init
> > 	    calculates preferred image size (image_size) based on total pages
> > 	    (totalram_pages). This totalram_pages can be modified during vario=
us
> > 	    initcall-s phase and this can cause miscalculated image_size.
> >=20
> > 	    For example, when CMA is being used, init_cma_reserved_pageblock t=
ries
> > 	    to change the totalram_pages and this job is done during core_init=
call.
> > 	    In order words, the totalram_pages doesn't take CMA reserved pages=
 into
> > 	    account when image_size is calculated and it can be too small.
> >=20
> > 	    Move pm_init and pm_disk_init to late_initcall_sync so that it hap=
pens
> > 	    after all other initcall-s change the totalram_pages.
> >=20
> > 	    Reported-by: Sangseok Lee <sangseok.lee@lge.com>
> > 	    Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
> > 	    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
>=20
> I'm seeing one too on powerpc:
>=20
> Unable to handle kernel paging request for data at address 0x00000030
> Faulting instruction address: 0xc0000000002e4094
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=3D2048 NUMA pSeries
> Modules linked in:
> CPU: 5 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc5-next-20151015-50217-g=
e2be40d-dirty #37
> task: c0000001fefc0000 ti: c0000001fb000000 task.ti: c0000001fb000000
> NIP: c0000000002e4094 LR: c000000000c79dd4 CTR: c000000000c79d90
> REGS: c0000001fb003900 TRAP: 0300   Not tainted  (4.3.0-rc5-next-20151015=
-50217-ge2be40d-dirty)
> MSR: 8000000100009032 <SF,EE,ME,IR,DR,RI>  CR: 28000882  XER: 20000000
> CFAR: c0000000000d117c DAR: 0000000000000030 DSISR: 40000000 SOFTE: 1=20
> GPR00: c00000000000b074 c0000001fb003b80 c000000000e93800 000000000000000=
0=20
> GPR04: c000000000d15c80 0000000000000000 00000001ff150000 000000000000002=
6=20
> GPR08: c000000000d0f748 c000000000f41a10 c000000000d0f8e8 c000000000abc59=
d=20
> GPR12: c000000000b42400 c00000000fdc1680 c00000000000b960 000000000000000=
0=20
> GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
> GPR20: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
> GPR24: 0000000000000000 c000000000de0360 c000000000c45d28 000000000000000=
0=20
> GPR28: c000000000deca80 c000000000d103c0 c0000001fbc905c0 c000000000d103c=
0=20
> NIP [c0000000002e4094] .sysfs_create_file_ns+0x4/0x50
> LR [c000000000c79dd4] .__machine_initcall_pseries_apo_pm_init+0x44/0x60
> Call Trace:
> [c0000001fb003b80] [c0000000004852cc] .kasprintf+0x2c/0x40 (unreliable)
> [c0000001fb003bf0] [c00000000000b074] .do_one_initcall+0xc4/0x250
> [c0000001fb003ce0] [c000000000c64560] .kernel_init_freeable+0x268/0x348
> [c0000001fb003db0] [c00000000000b97c] .kernel_init+0x1c/0x140
> [c0000001fb003e30] [c0000000000095ac] .ret_from_kernel_thread+0x58/0xac
> Instruction dump:
> 419e001c 3ce2ffa8 38e7be60 4bfffea4 3ce2ffa8 38e7bea8 4bfffe9c 3ce2ffa8=
=20
> 38e7bea8 4bfffe8c 60000000 2c230000 <e8630030> 41820028 2fa30000 419e0020=
=20
> ---[ end trace d2a742ce359651dd ]---
>=20
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
>=20
>=20
> Which starts at:
>=20
>   static int __init apo_pm_init(void)
>   {
>   	return (sysfs_create_file(power_kobj, &auto_poweron_attr.attr));
>   }
>   machine_device_initcall(pseries, apo_pm_init);
>=20
> And seems to be caused by power_kobj being NULL:
>=20
>   0:mon> d $power_kobj
>   c000000000f41a10 0000000000000000 0000000000000000  |................|

Yes, power_kobj is one of the other objects created by pm_init() and
which, evidently, needs to be available much earlier than late_initcall.
The patch below works for me, though I don't use hibernate on this
machine, so that part is untested.

Thierry

--- >8 ---
diff --git a/kernel/power/main.c b/kernel/power/main.c
index b2dd4d999900..2f66453e3a9b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -648,8 +648,6 @@ static int __init pm_init(void)
 	int error =3D pm_start_workqueue();
 	if (error)
 		return error;
-	hibernate_image_size_init();
-	hibernate_reserved_size_init();
 	power_kobj =3D kobject_create_and_add("power", NULL);
 	if (!power_kobj)
 		return -ENOMEM;
@@ -661,3 +659,13 @@ static int __init pm_init(void)
 }
=20
 core_initcall(pm_init);
+
+static int __init hibernate_init(void)
+{
+	hibernate_image_size_init();
+	hibernate_reserved_size_init();
+
+	return 0;
+}
+
+late_initcall_sync(hibernate_init);

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWH6mcAAoJEN0jrNd/PrOh0R4QALgxwCDNLtgdNNibI6tG9XKD
u96AmLxXPWUt5CFkwNiYBjs//YQCt5wVo1yHOqOm3TjhdhsG8iEKmZQ1QkBol+Rw
0ygUTzU8hNv2R0UFXJ/EhsiZtEztGQK+U6k/or7Rgw1Z0UXTo+hB8OGH59Oh68f6
bg4eGwFud8xjWkS4qdvuGBjqt0zAtgGXXPRYNO5+EmpdrIHmHRuLBKUOEdMqrCpA
scy1Kge3eIG243WrEgoBugPF1pd5W+y70iT/6UCaq9r/FmdhUfjG7sQ8cGWb4Deq
3A/xihg9syRzRTsOSkXba25CylB1Bl+o/hm0e3RYvLOiEryruSrANYJEzRAIzJKE
U4Kxo65U/bUaa6MFPImpQVdiMfrT9khehvHWXpFuWmArx6lUerdzuLfj3ye6Nr0l
5U8GJOvMa8u/oyPLmscfq1VS3AmxiQETVcSVGqvbiPu34uxBKpYvGBarsMN3LKhy
snda4bAAWkAmOE7We40Wwr+61dtjrmYRivMh09n0tqD9TRCuyMG4eCu9HTXYzdv6
dYJGT1VyYK5jA3LjTElX1CXzf15rg8HlHfn4IuETLuAFZ80Y8/s2VUEmXYDN81ti
woVrt33nb11K3L9sKMttlj77eY4K0nn5t2Km8dO7DbpIcDqV0YE2N7tqYnOSPzMm
cijjUJ5YuKjJDqkkaeo0
=M2E3
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
