From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/8] ARM: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 18:57:19 +0200
Message-ID: <51CB1D6F.8020101@linaro.org>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com> <5859839.2xKkDrLODE@amdc1032> <51CAE713.5070700@linaro.org> <1673802.AM7kgUZk9G@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:59735 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3FZQ5I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 12:57:08 -0400
Received: by mail-ea0-f178.google.com with SMTP id l15so7561182eak.37
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2013 09:57:07 -0700 (PDT)
In-Reply-To: <1673802.AM7kgUZk9G@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com

On 06/26/2013 04:40 PM, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, June 26, 2013 03:05:23 PM Daniel Lezcano wrote:
>> On 06/26/2013 02:22 PM, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On Wednesday, June 26, 2013 12:59:53 PM Daniel Lezcano wrote:
>>>> On 06/26/2013 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
>>>>> Hi,
>>>>>
>>>>> This patchset moves ARM cpuidle drivers to drivers/cpuidle/ to ma=
ke
>>>>> code match new driver placement rules (per commit a8e39c3 "cpuidl=
e: add
>>>>> maintainer entry").
>>>>
>>>> I second this initiative but as stated in a previous email, a bit =
of
>>>> code cleanup, consolidation and encapsulation should be done befor=
e.
>>>>
>>>> Again, from my POV, it is worth to do that but we have to split th=
e pm
>>>> code from the driver.
>>>
>>> OK, I'll look into separating the pm code from the drivers.  Howeve=
r it
>>> seems that patch #2 (for davinci) can be applied as it is.
>>
>> No it can't. It still has #include <mach/...>
>>
>> Please have a look at the thread:
>>
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/146651
>=20
> OK, I see.
>=20
> On davinci:
>=20
> * <mach/cpuidle.h> contains only struct davinci_cpuidle_config
>   declaration (pointer to this structure instance is passed as
>   platform data to davinci cpuidle driver) so it seems that
>   moving it to <linux/platform_data/cpuidle-davinci.h> would be
>   sufficient?
>=20
> * <mach/ddr2.h> contains only few definitions used by davinci
>   cpuidle driver and arch/arm/mach-davinci/sleep.S so wouldn't
>   it be OK to just move the header to <linux/davinci_ddr2.h>?
>=20
> If agreed I'll prepare appropriate patches later.

Let me handle this driver with at91. I am consolidating the code around
the RAM self refresh.

>>>> Please review some patches I sent recently to split this code and
>>>> comment them. Otherwise, we will collide on this work.
>>>>
>>>> All the patches sent [1] was to unify the code to make the drivers=
 as
>>>> unified as possible to converge to the same code pattern and to
>>>> facilitate the factoring out.
>>>
>>> I've looked at the patches ([1] and at91 ones) and they look fine t=
o me.
>>> I don't think that there is currently a risk of colliding on this w=
ork
>>> (except at91 case) as your patches (except at91 ones) are already m=
erged
>>> in upstream or linux-next branch of linux-pm tree (which is include=
d in
>>> linux-next tree which I based my patches on). I'm subscribed to lin=
ux-pm
>>> mailing list now but please cc: me on your future ARM cpuidle chang=
es
>>> (thanks!).
>>
>> We are working on cleaning up the different drivers to have a *commo=
n
>> code pattern* in order to factor it out, split the code into pm code=
 and
>> driver code, move the drivers to the drivers/cpuidle directory and
>> finally create a single arm driver [1][2][3].
>=20
> Interesting, I wasn't aware of the single arm driver goal..
>=20
>> You are sending patches to move the drivers directly to the
>> drivers/cpuidle directory. I did that 1,5 years ago and I was told i=
t is
>> not the way to go [4].
>>
>> As you can see this is a WIP.
>>
>> So I am insisting: that would be better if you sync up with us and c=
heck
>> what is the WIP and, if you are willing to, give us a hand instead o=
f
>> doing your way.
>=20
> OK.
>=20
>> May I suggest you fix up the exynos cpuidle driver first ? :)
>=20
> Sure.
>=20
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20
>> Thanks
>>   -- Daniel
>>
>> [1]
>> https://blueprints.launchpad.net/linaro-power-kernel/+spec/cpuidle-c=
onsolidate-arm-drivers
>>
>> [2]
>> http://summit.linuxplumbersconf.org/lpc-2012/meeting/31/lpc2012-ref-=
cpu-idle-cluster-management/
>>
>> [3] https://e.lca-13.zerista.com/event/member/72362
>>
>> [4] http://comments.gmane.org/gmane.linux.ports.arm.kernel/146651
>>
>>
>>> Best regards,
>>> --
>>> Bartlomiej Zolnierkiewicz
>>> Samsung R&D Institute Poland
>>> Samsung Electronics
>>>
>>>> Thanks
>>>>   -- Daniel
>>>>
>>>> [1]
>>>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/l=
og/?h=3Dlinux-next&qt=3Dauthor&q=3Ddaniel.lezcano%40linaro.org
>>>>
>>>>> [ Please note that movement of Samsung EXYNOS cpuidle driver is h=
andled
>>>>>   in separate patchset since it needs some other changes applied =
first. ]
>>>>>
>>>>> Patches are based on linux-next (next-20130624) and are compile t=
ested
>>>>> only.  If agreed they all should probably go together through one=
 tree
>>>>> (linux-pm or arm-soc) since they all modify drivers/cpuidle/Makef=
ile.
>>>>>
>>>>> PS It seems that majority of cpuidle drivers is not used by defau=
lt
>>>>> (CONFIG_CPU_IDLE is not turned on in corresponding defconfigs). T=
he only
>>>>> exceptions are shmobile (kota2_defconfig) and tegra (tegra_defcon=
fig).
>>>>> This is probably also something that needs updating.
>>>>>
>>>>> Best regards,
>>>>> --
>>>>> Bartlomiej Zolnierkiewicz
>>>>> Samsung R&D Institute Poland
>>>>> Samsung Electronics
>>>>>
>>>>>
>>>>> Bartlomiej Zolnierkiewicz (8):
>>>>>   ARM: at91: move cpuidle driver to drivers/cpuidle/
>>>>>   ARM: davinci: move cpuidle driver to drivers/cpuidle/
>>>>>   ARM: imx: move cpuidle drivers to drivers/cpuidle/
>>>>>   ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
>>>>>   ARM: S3C64XX: move cpuidle driver to drivers/cpuidle/
>>>>>   ARM: shmobile: move cpuidle driver to drivers/cpuidle/
>>>>>   ARM: tegra: move cpuidle drivers to drivers/cpuidle/
>>>>>   ARM: ux500: move cpuidle drivers to drivers/cpuidle/
>>>>>
>>>>>  arch/arm/mach-at91/Makefile            |   1 -
>>>>>  arch/arm/mach-at91/cpuidle.c           |  68 -------
>>>>>  arch/arm/mach-davinci/Makefile         |   1 -
>>>>>  arch/arm/mach-davinci/cpuidle.c        | 105 ----------
>>>>>  arch/arm/mach-imx/Makefile             |   5 -
>>>>>  arch/arm/mach-imx/cpuidle-imx5.c       |  37 ----
>>>>>  arch/arm/mach-imx/cpuidle-imx6q.c      |  75 -------
>>>>>  arch/arm/mach-omap2/Makefile           |   5 -
>>>>>  arch/arm/mach-omap2/cpuidle34xx.c      | 344 -------------------=
--------------
>>>>>  arch/arm/mach-omap2/cpuidle44xx.c      | 217 -------------------=
--
>>>>>  arch/arm/mach-s3c64xx/Makefile         |   1 -
>>>>>  arch/arm/mach-s3c64xx/cpuidle.c        |  63 ------
>>>>>  arch/arm/mach-shmobile/Makefile        |   1 -
>>>>>  arch/arm/mach-shmobile/cpuidle.c       |  37 ----
>>>>>  arch/arm/mach-tegra/Makefile           |   9 -
>>>>>  arch/arm/mach-tegra/cpuidle-tegra114.c |  35 ----
>>>>>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 217 -------------------=
--
>>>>>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 149 --------------
>>>>>  arch/arm/mach-ux500/Makefile           |   1 -
>>>>>  arch/arm/mach-ux500/cpuidle.c          | 128 ------------
>>>>>  drivers/cpuidle/Makefile               |  42 ++++
>>>>>  drivers/cpuidle/cpuidle-at91.c         |  68 +++++++
>>>>>  drivers/cpuidle/cpuidle-davinci.c      | 104 ++++++++++
>>>>>  drivers/cpuidle/cpuidle-imx5.c         |  37 ++++
>>>>>  drivers/cpuidle/cpuidle-imx6q.c        |  74 +++++++
>>>>>  drivers/cpuidle/cpuidle-omap34xx.c     | 342 +++++++++++++++++++=
+++++++++++++
>>>>>  drivers/cpuidle/cpuidle-omap44xx.c     | 216 +++++++++++++++++++=
++
>>>>>  drivers/cpuidle/cpuidle-s3c64xx.c      |  62 ++++++
>>>>>  drivers/cpuidle/cpuidle-shmobile.c     |  37 ++++
>>>>>  drivers/cpuidle/cpuidle-tegra114.c     |  35 ++++
>>>>>  drivers/cpuidle/cpuidle-tegra20.c      | 217 +++++++++++++++++++=
++
>>>>>  drivers/cpuidle/cpuidle-tegra30.c      | 149 ++++++++++++++
>>>>>  drivers/cpuidle/cpuidle-ux500.c        | 128 ++++++++++++
>>>>>  33 files changed, 1511 insertions(+), 1499 deletions(-)
>>>>>  delete mode 100644 arch/arm/mach-at91/cpuidle.c
>>>>>  delete mode 100644 arch/arm/mach-davinci/cpuidle.c
>>>>>  delete mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
>>>>>  delete mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
>>>>>  delete mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
>>>>>  delete mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
>>>>>  delete mode 100644 arch/arm/mach-s3c64xx/cpuidle.c
>>>>>  delete mode 100644 arch/arm/mach-shmobile/cpuidle.c
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>>>>>  delete mode 100644 arch/arm/mach-ux500/cpuidle.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-at91.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-davinci.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-imx5.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-imx6q.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-omap34xx.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-omap44xx.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-s3c64xx.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-shmobile.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-tegra114.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-tegra20.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-tegra30.c
>>>>>  create mode 100644 drivers/cpuidle/cpuidle-ux500.c
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

