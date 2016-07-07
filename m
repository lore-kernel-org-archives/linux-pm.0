From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PULL Request] Devfreq Fixes-2 for next-RC
Date: Thu, 7 Jul 2016 09:43:19 +0900
Message-ID: <CAJ0PZbSww-L6W99Xa1zP-nBW2=GMWP44qFwfBfMf2rRqTJCFNw@mail.gmail.com>
References: <CGME20160706042318epcms1p155db66d1feeea1e45cbcc57f5c004479@epcms1p1>
 <11403313.450560.1467778998317.JavaMail.weblogic@ep2ml104d> <CAJZ5v0gQY=P5=Yq7m5S2ocjykq7YR=AuC-doSA99q80J5+ma4A@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35526 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbcGGAoV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2016 20:44:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id d132so423495oig.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2016 17:43:34 -0700 (PDT)
In-Reply-To: <CAJZ5v0gQY=P5=Yq7m5S2ocjykq7YR=AuC-doSA99q80J5+ma4A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "rafael@kerne.org" <rafael@kerne.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, "peter.chen@nxp.com" <peter.chen@nxp.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>

On Thu, Jul 7, 2016 at 4:55 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jul 6, 2016 at 6:23 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> Dear Rafael,
>>
>> Here goes the second set of devfreq fixes for Linux 4.7 RC-x.
>
> Well, we are in the -rc7 time frame now and the modularity-related
> changes aren't something I'd want to push this late in the cycle.
>
> The other fixes are sort of fine, but it looks to me that they can
> wait for the 4.8 merge window just fine, so what about if I queue up
> all of this material for 4.8?
>
> Thanks,
> Rafael

Sure, this may wait for 4.8.


Cheers,
MyungJoo

>
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> The following changes since commit a99cde438de0c4c0cecc1d1af1a55a75b10bfdef:
>>
>>   Linux 4.7-rc6 (2016-07-03 23:01:00 -0700)
>>
>> are available in the git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git fixes-2
>>
>> for you to fetch changes up to d8150d14e9bc44ba55c707cc67f4fa66d65cfdef:
>>
>>   PM / devfreq: exynos-bus: add missing of_node_put after calling of_parse_phandle (2016-07-06 13:11:24 +0900)
>>
>> - ----------------------------------------------------------------
>> Pull request of second Linux 4.7-rcX devfreq fixes for Linux-PM
>>
>> - ----------------------------------------------------------------
>> Bartlomiej Zolnierkiewicz (2):
>>       PM / devfreq: exynos: fix error path in exynos_bus_probe()
>>       PM / devfreq: exynos-ppmu: fix error path in exynos_ppmu_probe()
>>
>> Paul Gortmaker (5):
>>       PM / devfreq: make devfreq explicitly non-modular
>>       PM / devfreq: make devfreq-event explicitly non-modular
>>       PM / devfreq: make exynos-bus ARM_EXYNOS_BUS_DEVFREQ tristate
>>       PM / devfreq: make event/exynos-nocp DEVFREQ_EVENT_EXYNOS_NOCP tristate
>>       PM / devfreq: make event/exynos-ppmu DEVFREQ_EVENT_EXYNOS_PPMU tristate
>>
>> Peter Chen (2):
>>       PM / devfreq: add missing of_node_put after calling of_parse_phandle
>>       PM / devfreq: exynos-bus: add missing of_node_put after calling of_parse_phandle
>>
>>  drivers/devfreq/Kconfig             |  2 +-
>>  drivers/devfreq/devfreq-event.c     | 12 +-----------
>>  drivers/devfreq/devfreq.c           | 15 +++------------
>>  drivers/devfreq/event/Kconfig       |  4 ++--
>>  drivers/devfreq/event/exynos-ppmu.c |  3 ++-
>>  drivers/devfreq/exynos-bus.c        | 11 +++++++----
>>  6 files changed, 16 insertions(+), 31 deletions(-)
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1
>>
>> iQIcBAEBAgAGBQJXfIZ4AAoJEBOhurvWBoCKowoP/0Iw72IhDI8NFjCFHCcNGKu3
>> TTGJAxC31VhtbrNfB923AWiRGzWqGZ9v1ruV7N0dMnMOwd4SaiQ7l9+qD3WKUgHZ
>> axaIDGg67EJvYqc15p4npfQJAwZZudvbv1xmmthWFiwwDOMYrDZRjy7Z/dJrU+Gn
>> AACATyx6sYGDLxtp0Wi9lRMRHbHgV01JBs/EWhU7u2R9J+GV5V+BVW0Lu4KG/4yv
>> KOzv1oYCfM+EHXiaeOGFs/kzJXFGihofMoX+JEZtwDfABiVj7kuupo7biksnbwpo
>> TWTFJerzFovyFmkygaCSON08ABRX/iy4xoq38HCE7F4SMf6OrYZMqqDfT2HmXyS/
>> iusyrqsiDvdDcMXc7mTbXadC5dAjdiqK5ATzyKCiGJED181FTauBsjp/ZGC0jbwQ
>> eLa1oVsUUYFOKeix5wwCwTzziGrOL2oh9WX8GZds1G50XKcGXk3ej97MawyJSBxv
>> OuVBJt8iZK1uqGHJMWnZYqACI7CQqNDUz/DWNAS8AZJ+A/x6i2DYhVCfUdYDCCpL
>> ayfI+DzE3kAWeTRNEwsdF8mS2cudvtkO+FKcNGjV12eVtSlJ8gzpHtXZNk3W1T3v
>> lQ18+n5pRmjSJFONRvVVx0jldPmIOIEZyyyIcdOXFeEHB/yhljtYvwcQhkHa4Z8L
>> DVFHRkxh+7t5m8CJgjL4
>> =+2T2
>> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
