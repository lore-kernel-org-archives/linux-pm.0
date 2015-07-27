From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [pm:bleeding-edge 79/80] drivers/acpi/acpica/evgpeinit.c:380:2:
 error: implicit declaration of function 'strtoul'
Date: Mon, 27 Jul 2015 16:43:53 -0700
Message-ID: <55B6C239.2050802@roeck-us.net>
References: <201507280737.vtbTBRH2%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41381 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266AbbG0Xnz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 19:43:55 -0400
In-Reply-To: <201507280737.vtbTBRH2%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On 07/27/2015 04:12 PM, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   020ed5eff1ad8a4fb606c35dafa81151b74e7f3c
> commit: f86187ce938721c4ae1422276ef92248fa99b8f8 [79/80] ACPI / sysfs: Use kstrtoul() instead of strtoul()/simple_strtoul()
> config: x86_64-acpi-redef (attached as .config)
> reproduce:
>    git checkout f86187ce938721c4ae1422276ef92248fa99b8f8
>    # save the attached .config to linux build tree
>    make ARCH=x86_64
>
> All error/warnings (new ones prefixed by >>):
>
>     drivers/acpi/acpica/evgpeinit.c: In function 'acpi_ev_match_gpe_method':
>>> drivers/acpi/acpica/evgpeinit.c:380:2: error: implicit declaration of function 'strtoul' [-Werror=implicit-function-declaration]
>       gpe_number = strtoul(&name[2], NULL, 16);
>       ^
>     cc1: some warnings being treated as errors
>

Looks like my tree missed commit 4fa4616e for some reason.
Sorry for that; I'll send an updated version of my patch.

Guenter

> vim +/strtoul +380 drivers/acpi/acpica/evgpeinit.c
>
> 1d1ea1b7 Chao Guan 2013-06-08  364
> 3fe50208 Bob Moore 2010-04-27  365  		type = ACPI_GPE_EDGE_TRIGGERED;
> 3fe50208 Bob Moore 2010-04-27  366  		break;
> 3fe50208 Bob Moore 2010-04-27  367
> 3fe50208 Bob Moore 2010-04-27  368  	default:
> 1d1ea1b7 Chao Guan 2013-06-08  369
> 3fe50208 Bob Moore 2010-04-27  370  		/* Unknown method type, just ignore it */
> 3fe50208 Bob Moore 2010-04-27  371
> 3fe50208 Bob Moore 2010-04-27  372  		ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
> 3fe50208 Bob Moore 2010-04-27  373  				  "Ignoring unknown GPE method type: %s "
> 3fe50208 Bob Moore 2010-04-27  374  				  "(name not of form _Lxx or _Exx)", name));
> 3fe50208 Bob Moore 2010-04-27  375  		return_ACPI_STATUS(AE_OK);
> 3fe50208 Bob Moore 2010-04-27  376  	}
> 3fe50208 Bob Moore 2010-04-27  377
> 3fe50208 Bob Moore 2010-04-27  378  	/* 4) The last two characters of the name are the hex GPE Number */
> 3fe50208 Bob Moore 2010-04-27  379
> 4fa4616e Bob Moore 2015-07-01 @380  	gpe_number = strtoul(&name[2], NULL, 16);
> 3fe50208 Bob Moore 2010-04-27  381  	if (gpe_number == ACPI_UINT32_MAX) {
> 3fe50208 Bob Moore 2010-04-27  382
> 3fe50208 Bob Moore 2010-04-27  383  		/* Conversion failed; invalid method, just ignore it */
> 3fe50208 Bob Moore 2010-04-27  384
> 3fe50208 Bob Moore 2010-04-27  385  		ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
> 3fe50208 Bob Moore 2010-04-27  386  				  "Could not extract GPE number from name: %s "
> 3fe50208 Bob Moore 2010-04-27  387  				  "(name is not of form _Lxx or _Exx)", name));
> 3fe50208 Bob Moore 2010-04-27  388  		return_ACPI_STATUS(AE_OK);
>
> :::::: The code at line 380 was first introduced by commit
> :::::: 4fa4616e279df89baeb36287bbee83ab272edaed ACPICA: De-macroize calls to standard C library functions
>
> :::::: TO: Bob Moore <robert.moore@intel.com>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

