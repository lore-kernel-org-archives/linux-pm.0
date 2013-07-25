From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RESEND] cpuidle for ARM pull request
Date: Fri, 26 Jul 2013 00:07:03 +0200
Message-ID: <51F1A187.5060408@linaro.org>
References: <51E536C5.1020609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:56038 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab3GYWHH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2013 18:07:07 -0400
Received: by mail-we0-f169.google.com with SMTP id n5so444846wev.28
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2013 15:07:05 -0700 (PDT)
In-Reply-To: <51E536C5.1020609@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "rjw@sisk.pl" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>

On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
>=20
> Hi,
>=20
> The first PR was against the linux-pm-next tree including the patch:
>=20
> "cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"
>=20
> This patch has been dropped in the meantime.
>=20
> Here is a new PR where my tree has been rebased against linux-pm-next
> and adding the patch mentioned above.
>=20
> As stated by Rafael, I will handle the ARM specific patches from now.
>=20
> The following changes since commit 48f99d5a97d32d70c0738d6e314d9f4dbe=
fd89bf:
>=20
>   Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:41:06=
 +0200)
>=20
> are available in the git repository at:
>=20
>=20
>   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
>=20
> for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a990f=
06:
>=20
>   ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> (2013-07-16 13:57:24 +0200)

ping ?


> ----------------------------------------------------------------
> Daniel Lezcano (2):
>       ARM: davinci: cpuidle: Fix target residency
>       ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuid=
le
>=20
> Linus Walleij (2):
>       ARM: ux500: cpuidle: Instantiate the driver from platform devic=
e
>       ARM: ux500: cpuidle: Remove pointless include
>=20
> Sahara (1):
>       cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq
>=20
>  arch/arm/mach-davinci/cpuidle.c                    |    2 +-
>  arch/arm/mach-ux500/Makefile                       |    1 -
>  drivers/cpuidle/Kconfig                            |   20 +++++-----=
----
>  drivers/cpuidle/Kconfig.arm                        |   29
> ++++++++++++++++++++
>  drivers/cpuidle/Makefile                           |    9 ++++--
>  .../cpuidle.c =3D> drivers/cpuidle/cpuidle-ux500.c   |   19 +++++++-=
-----
>  drivers/mfd/db8500-prcmu.c                         |    4 +++
>  7 files changed, 58 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/cpuidle/Kconfig.arm
>  rename arch/arm/mach-ux500/cpuidle.c =3D> drivers/cpuidle/cpuidle-ux=
500.c
> (90%)
>=20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

