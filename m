From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/8] ARM: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:59:53 +0200
Message-ID: <51CAC9A9.5070906@linaro.org>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:61895 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3FZK7n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:59:43 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so7444634eaj.27
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2013 03:59:42 -0700 (PDT)
In-Reply-To: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com

On 06/26/2013 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
>=20
> This patchset moves ARM cpuidle drivers to drivers/cpuidle/ to make
> code match new driver placement rules (per commit a8e39c3 "cpuidle: a=
dd
> maintainer entry").

I second this initiative but as stated in a previous email, a bit of
code cleanup, consolidation and encapsulation should be done before.

Again, from my POV, it is worth to do that but we have to split the pm
code from the driver.

Please review some patches I sent recently to split this code and
comment them. Otherwise, we will collide on this work.

All the patches sent [1] was to unify the code to make the drivers as
unified as possible to converge to the same code pattern and to
facilitate the factoring out.

Thanks
  -- Daniel

[1]
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dlinux-next&qt=3Dauthor&q=3Ddaniel.lezcano%40linaro.org

> [ Please note that movement of Samsung EXYNOS cpuidle driver is handl=
ed
>   in separate patchset since it needs some other changes applied firs=
t. ]
>=20
> Patches are based on linux-next (next-20130624) and are compile teste=
d
> only.  If agreed they all should probably go together through one tre=
e
> (linux-pm or arm-soc) since they all modify drivers/cpuidle/Makefile.
>=20
> PS It seems that majority of cpuidle drivers is not used by default
> (CONFIG_CPU_IDLE is not turned on in corresponding defconfigs). The o=
nly
> exceptions are shmobile (kota2_defconfig) and tegra (tegra_defconfig)=
=2E
> This is probably also something that needs updating.
>=20
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20
>=20
> Bartlomiej Zolnierkiewicz (8):
>   ARM: at91: move cpuidle driver to drivers/cpuidle/
>   ARM: davinci: move cpuidle driver to drivers/cpuidle/
>   ARM: imx: move cpuidle drivers to drivers/cpuidle/
>   ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
>   ARM: S3C64XX: move cpuidle driver to drivers/cpuidle/
>   ARM: shmobile: move cpuidle driver to drivers/cpuidle/
>   ARM: tegra: move cpuidle drivers to drivers/cpuidle/
>   ARM: ux500: move cpuidle drivers to drivers/cpuidle/
>=20
>  arch/arm/mach-at91/Makefile            |   1 -
>  arch/arm/mach-at91/cpuidle.c           |  68 -------
>  arch/arm/mach-davinci/Makefile         |   1 -
>  arch/arm/mach-davinci/cpuidle.c        | 105 ----------
>  arch/arm/mach-imx/Makefile             |   5 -
>  arch/arm/mach-imx/cpuidle-imx5.c       |  37 ----
>  arch/arm/mach-imx/cpuidle-imx6q.c      |  75 -------
>  arch/arm/mach-omap2/Makefile           |   5 -
>  arch/arm/mach-omap2/cpuidle34xx.c      | 344 -----------------------=
----------
>  arch/arm/mach-omap2/cpuidle44xx.c      | 217 ---------------------
>  arch/arm/mach-s3c64xx/Makefile         |   1 -
>  arch/arm/mach-s3c64xx/cpuidle.c        |  63 ------
>  arch/arm/mach-shmobile/Makefile        |   1 -
>  arch/arm/mach-shmobile/cpuidle.c       |  37 ----
>  arch/arm/mach-tegra/Makefile           |   9 -
>  arch/arm/mach-tegra/cpuidle-tegra114.c |  35 ----
>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 217 ---------------------
>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 149 --------------
>  arch/arm/mach-ux500/Makefile           |   1 -
>  arch/arm/mach-ux500/cpuidle.c          | 128 ------------
>  drivers/cpuidle/Makefile               |  42 ++++
>  drivers/cpuidle/cpuidle-at91.c         |  68 +++++++
>  drivers/cpuidle/cpuidle-davinci.c      | 104 ++++++++++
>  drivers/cpuidle/cpuidle-imx5.c         |  37 ++++
>  drivers/cpuidle/cpuidle-imx6q.c        |  74 +++++++
>  drivers/cpuidle/cpuidle-omap34xx.c     | 342 +++++++++++++++++++++++=
+++++++++
>  drivers/cpuidle/cpuidle-omap44xx.c     | 216 +++++++++++++++++++++
>  drivers/cpuidle/cpuidle-s3c64xx.c      |  62 ++++++
>  drivers/cpuidle/cpuidle-shmobile.c     |  37 ++++
>  drivers/cpuidle/cpuidle-tegra114.c     |  35 ++++
>  drivers/cpuidle/cpuidle-tegra20.c      | 217 +++++++++++++++++++++
>  drivers/cpuidle/cpuidle-tegra30.c      | 149 ++++++++++++++
>  drivers/cpuidle/cpuidle-ux500.c        | 128 ++++++++++++
>  33 files changed, 1511 insertions(+), 1499 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/cpuidle.c
>  delete mode 100644 arch/arm/mach-davinci/cpuidle.c
>  delete mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
>  delete mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
>  delete mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
>  delete mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
>  delete mode 100644 arch/arm/mach-s3c64xx/cpuidle.c
>  delete mode 100644 arch/arm/mach-shmobile/cpuidle.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>  delete mode 100644 arch/arm/mach-ux500/cpuidle.c
>  create mode 100644 drivers/cpuidle/cpuidle-at91.c
>  create mode 100644 drivers/cpuidle/cpuidle-davinci.c
>  create mode 100644 drivers/cpuidle/cpuidle-imx5.c
>  create mode 100644 drivers/cpuidle/cpuidle-imx6q.c
>  create mode 100644 drivers/cpuidle/cpuidle-omap34xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-omap44xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-s3c64xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-shmobile.c
>  create mode 100644 drivers/cpuidle/cpuidle-tegra114.c
>  create mode 100644 drivers/cpuidle/cpuidle-tegra20.c
>  create mode 100644 drivers/cpuidle/cpuidle-tegra30.c
>  create mode 100644 drivers/cpuidle/cpuidle-ux500.c
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

