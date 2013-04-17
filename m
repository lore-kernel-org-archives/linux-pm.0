From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 19/19] ARM: imx: cpuidle: use init/exit common routine
Date: Wed, 17 Apr 2013 09:23:02 +0200
Message-ID: <516E4DD6.2090900@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-20-git-send-email-daniel.lezcano@linaro.org> <20130417071511.GB3338@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:54617 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758299Ab3DQHXI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 03:23:08 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so1274342wgh.5
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2013 00:23:06 -0700 (PDT)
In-Reply-To: <20130417071511.GB3338@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/17/2013 09:15 AM, Shawn Guo wrote:
> Thanks for working on this, Daniel.
>=20
> The imx6q change looks good to me.  But I have a comment on imx5 chan=
ges
> below.
>=20
> On Fri, Apr 12, 2013 at 02:36:05PM +0200, Daniel Lezcano wrote:
>> diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cp=
uidle-imx5.c
>> new file mode 100644
>> index 0000000..ba4565f
>> --- /dev/null
>> +++ b/arch/arm/mach-imx/cpuidle-imx5.c
>> @@ -0,0 +1,40 @@
>> +/*
>> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/cpuidle.h>
>> +#include <linux/module.h>
>> +#include <asm/system_misc.h>
>> +#include <asm/proc-fns.h>
>> +
>> +#include "hardware.h"
>> +
>> +static int imx5_cpuidle_enter(struct cpuidle_device *dev,
>> +			      struct cpuidle_driver *drv, int index)
>> +{
>> +	arm_pm_idle();
>=20
> The existing imx5 cpuidle code has an tzic_enable_wake() call before
> going to idle.  I think it's there for some reason.

The idle function for imx5 is untouched, it is called through
arm_pm_idle instead.

The arm_pm_idle is initialized in imx5_pm_common_init:

arm_pm_idle =3D imx5_pm_idle;

The imx5_pm_idle function calls imx5_do_pm_idle which in turns calls
tzic_enable_wake and cpu_do_idle.



[ ... ]

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

