From: Thierry Reding <thierry.reding@gmail.com>
Subject: Runtime PM causes oops on next-20151015
Date: Thu, 15 Oct 2015 11:22:13 +0200
Message-ID: <20151015092213.GA26614@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35498 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbJOJWS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 05:22:18 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wonhong Kwon <wonhong.kwon@lge.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-next@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael, Wonhong,

Todays linux-next breaks rather spectacularly for drivers using runtime
PM. The culprit seems to be this commit:

	commit 7d24068e144adc03b805806645d732cf79488717
	Author: Wonhong Kwon <wonhongkwon@gmail.com>
	Date:   Tue Oct 6 10:10:20 2015 +0900

	    PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync

	    pm_init is being invoked by core_initcall and hibernate_image_size_init
	    calculates preferred image size (image_size) based on total pages
	    (totalram_pages). This totalram_pages can be modified during various
	    initcall-s phase and this can cause miscalculated image_size.

	    For example, when CMA is being used, init_cma_reserved_pageblock tries
	    to change the totalram_pages and this job is done during core_initcall.
	    In order words, the totalram_pages doesn't take CMA reserved pages into
	    account when image_size is calculated and it can be too small.

	    Move pm_init and pm_disk_init to late_initcall_sync so that it happens
	    after all other initcall-s change the totalram_pages.

	    Reported-by: Sangseok Lee <sangseok.lee@lge.com>
	    Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
	    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I can't reply to it directly because I don't have it in any of my mail
boxes (it seems to have been sent only to the linux-pm mailing list,
even Google finds only a single match).

Here's an extract of the oops:

	[    1.395928] Unable to handle kernel NULL pointer dereference at virtual=
 address 00000100
	[    1.404013] pgd =3D ffffffc000e0e000
	[    1.407417] [00000100] *pgd=3D000000013c007003, *pud=3D000000013c007003=
, *pmd=3D000000013c008003, *pte=3D0060000050041707
	[    1.417746] Internal error: Oops: 96000005 [#1] PREEMPT SMP
	[    1.423316] Modules linked in:
	[    1.426400] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc5-next-20=
151015+ #1338
	[    1.434138] Hardware name: NVIDIA Tegra210 P2371 (P2180/P2597) referenc=
e board (DT)
	[    1.441789] task: ffffffc0bc0a8000 ti: ffffffc0bc084000 task.ti: ffffff=
c0bc084000
	[    1.449280] PC is at __queue_work+0x2c/0x240
	[    1.453551] LR is at queue_work_on+0x60/0x78
	...
	[    1.836517] Call trace:
	[    1.838968] [<ffffffc0000b4134>] __queue_work+0x2c/0x240
	[    1.844280] [<ffffffc0000b43a4>] queue_work_on+0x5c/0x78
	[    1.849599] [<ffffffc00052e508>] rpm_idle+0xc0/0x140
	[    1.854565] [<ffffffc00052e5dc>] __pm_runtime_idle+0x54/0x98
	[    1.860229] [<ffffffc00052414c>] driver_probe_device+0x164/0x2f8
	[    1.866236] [<ffffffc000524378>] __driver_attach+0x98/0xa0
	[    1.871724] [<ffffffc00052231c>] bus_for_each_dev+0x5c/0xa0
	[    1.877294] [<ffffffc000523ab4>] driver_attach+0x1c/0x28
	[    1.882608] [<ffffffc0005236e4>] bus_add_driver+0x1cc/0x238
	[    1.888180] [<ffffffc000524b1c>] driver_register+0x5c/0xf8
	[    1.893675] [<ffffffc000431800>] mipi_dsi_driver_register_full+0x50/0x60
	[    1.900374] [<ffffffc000ba1570>] panel_simple_init+0x2c/0x44
	[    1.906035] [<ffffffc000082934>] do_one_initcall+0x8c/0x1a0
	[    1.911612] [<ffffffc000b80aa8>] kernel_init_freeable+0x150/0x1f8
	[    1.917711] [<ffffffc0007f78fc>] kernel_init+0xc/0xe0

Instrumenting the code shows that pm_wq (passed to queue_work in the
rpm_idle() function) is NULL at this point. This matches up with the
change done in the above-mentioned commit, since now pm_wq only gets
initialized at late_initcall time, whereas all built-in drivers will
already be probed at device_initcall time. So I suspect that this is
going to cause crashes on a whole lot of systems (essentially every
system that tries to use runtime PM from a built-in driver).

Given the commit message I suspect that the right fix would be to split
pm_init() into two functions, one that initializes the hibernation image
and another with the PM core initialization. The pm_hibernate_init() is
probably going to work fine as late_initcall (I assume this was tested)
but the rest should probably stay at core_initcall.

I can provide a patch for the latter if everyone agrees that it's the
right thing, but in the meantime, can you please drop the above patch
=66rom your tree to unbreak linux-next for all affected users?

Thanks,
Thierry

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWH3BBAAoJEN0jrNd/PrOhHSoP/1ZeTcRYa6Jwd83hDe9CSfr1
7vu69628yAHdpm4X6ZJjjsaSTMA8bPDs9eazyWe9xjWBfUenLHZZKpJLPtufU4VX
HzlzHZOVYcaYqaERtBDCqbLZ7wc5WgffPYbNd3VN4wnehnYmHEjl2giQ6buhaxVH
PYl+4lJ4N6MDdP1Yo4/HUTIrab2uB3o60LW7FSCbgXGGZewXbXDH7LgeViP/EG3B
NjnalvwKXfRcvdqXKaMiZ9lKA9/waDJLgxLsFElgxzwYXJ3ypCyzPdM1E0GozT4q
a/ONE4lR07Dp3EzP2FyjFV6aEZBkVINRIGx4LjaY3pC00SCJldh4CiIZF6UC5KIy
PNujOaZu7rQf/pH6j5HQiZ89jyF+hZcexdwun/WJ9Cdn2zkPn7S0QZlhz3JXLNUe
CdK/jjBbep/v3VxQ+CShHTKqCSkI4/F4gLDwf35n+70OOzth0YvLUI1r7aZ6Ookb
b3deJcopkuvWWBaNbDzCyq5xLdQ4VYIiKmJrOxShKpZUKjtcPlsgcQ/FE9hWkowK
yDol3SYRXIlxcuQehhVluOAy4iPNi81gmTPoh85t30hFsuSCm+mFJhiVMPXfKppb
bOtf0Z6zhiODnjaV9B6Dd/UQFTpzi3KKwvs5aV/CQMtgAjpK7yTbi4eb/xeYeGXL
aqYiyLhqC3/7zfF9mk0O
=jZP2
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
