From: Ognjen Galic <smclt30p@gmail.com>
Subject: Re: [PATCH 1/3 v7] battery: Add the battery hooking API (fwd)
Date: Sat, 23 Dec 2017 20:28:20 +0100
Message-ID: <20171223192820.GA27806@thinkpad>
References: <alpine.DEB.2.20.1712232023480.2138@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1712232023480.2138@hadrien>
Sender: linux-acpi-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 23, 2017 at 08:24:41PM +0100, Julia Lawall wrote:
> Please check on the indentation of line 1534.

Fixed in v10:
https://marc.info/?l=linux-acpi&m=151403063102416&w=2

> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Sat, 23 Dec 2017 20:15:26 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [PATCH 1/3 v7] battery: Add the battery hooking API
> 
> Hi Ognjen,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on platform-drivers-x86/for-next]
> [also build test WARNING on v4.15-rc4 next-20171222]
> [cannot apply to pm/linux-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ognjen-Galic/battery-Add-the-battery-hooking-API/20171223-144855
> base:   git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git for-next
> :::::: branch date: 5 hours ago
> :::::: commit date: 5 hours ago
> 
> >> drivers/acpi/battery.c:1533:2-51: code aligned with following code on line 1534
> --
> >> drivers/acpi/battery.c:707:3-9: preceding lock on line 684
> 
> # https://github.com/0day-ci/linux/commit/19380b8e214c2ac505bb3b21bbb73f51ecc716de
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 19380b8e214c2ac505bb3b21bbb73f51ecc716de
> vim +1533 drivers/acpi/battery.c
> 
> ^1da177e Linus Torvalds 2005-04-16  1528
> 4be44fcd Len Brown      2005-08-05  1529  static void __exit acpi_battery_exit(void)
> ^1da177e Linus Torvalds 2005-04-16  1530  {
> 5dfa0c73 Chris Wilson   2016-05-19  1531  	async_synchronize_cookie(async_cookie + 1);
> bc39fbcf Hans de Goede  2017-04-19  1532  	if (battery_driver_registered)
> ^1da177e Linus Torvalds 2005-04-16 @1533  		acpi_bus_unregister_driver(&acpi_battery_driver);
> 19380b8e Ognjen Galic   2017-12-20 @1534  		battery_hook_exit();
> 3a670cc7 Lan Tianyu     2014-05-04  1535  #ifdef CONFIG_ACPI_PROCFS_POWER
> bc39fbcf Hans de Goede  2017-04-19  1536  	if (acpi_battery_dir)
> 3a670cc7 Lan Tianyu     2014-05-04  1537  		acpi_unlock_battery_dir(acpi_battery_dir);
> 3a670cc7 Lan Tianyu     2014-05-04  1538  #endif
> ^1da177e Linus Torvalds 2005-04-16  1539  }
> ^1da177e Linus Torvalds 2005-04-16  1540
> 
> :::::: The code at line 1533 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
