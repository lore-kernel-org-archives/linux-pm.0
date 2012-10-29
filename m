From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] cpuidle: add missing header include
Date: Mon, 29 Oct 2012 10:16:13 +0900
Message-ID: <002101cdb572$fcc4d670$f64e8350$%han@samsung.com>
References: <001401cdb332$93ffe450$bbffacf0$%han@samsung.com>
 <508DA864.8020503@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17330 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab2J2BQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Oct 2012 21:16:15 -0400
In-reply-to: <508DA864.8020503@linaro.org>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Daniel Lezcano' <daniel.lezcano@linaro.org>
Cc: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, October 29, 2012 6:49 AM Marek Vasut wrote
>=20
> On 10/26/2012 06:30 AM, Jingoo Han wrote:
> > This patch adds missing device.h header to fix build warnings as be=
low:
> >
> > drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared =
inside parameter list [enabled by
> default]
> > drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this de=
finition or declaration, which is
> probably not what you want
> > [enabled by default]
> > drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared =
inside parameter list [enabled by
> default]
> > In file included from drivers/cpuidle/driver.c:15:0:
> > drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared =
inside parameter list [enabled by
> default]
> > drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this de=
finition or declaration, which is
> probably not what you want
> > [enabled by default]
> > drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared =
inside parameter list [enabled by
> default]
> >
> > This build warning is introduced by commit efeca1b
> > "cpuidle / sysfs: change function parameter".
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
>=20
> Jingoo, could you copy-pastebin your config file. I don't have this
> warning and I would like to understand why.

Hi Daniel Lezcano,

Could you build the code by using GCC 4.6.x?
In my opinion, it would be better.

Also, my config option is as below:
    make exynos4_defconfig + CONFIG_CPU_IDLE

Best regards,
Jingoo Han


>=20
> Thanks
>   -- Daniel
>=20
> >  drivers/cpuidle/cpuidle.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> > index a5bbd1c..2120d9e 100644
> > --- a/drivers/cpuidle/cpuidle.h
> > +++ b/drivers/cpuidle/cpuidle.h
> > @@ -5,6 +5,8 @@
> >  #ifndef __DRIVER_CPUIDLE_H
> >  #define __DRIVER_CPUIDLE_H
> >
> > +#include <linux/device.h>
> > +
> >  /* For internal use only */
> >  extern struct cpuidle_governor *cpuidle_curr_governor;
> >  extern struct list_head cpuidle_governors;
>=20
>=20
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

