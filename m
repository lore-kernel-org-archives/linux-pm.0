From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND] cpuidle for ARM pull request
Date: Fri, 26 Jul 2013 00:29:08 +0200
Message-ID: <1766778.ZYeDKBOsjV@vostro.rjw.lan>
References: <51E536C5.1020609@linaro.org> <51F1A187.5060408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62734 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756425Ab3GYWTF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2013 18:19:05 -0400
In-Reply-To: <51F1A187.5060408@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>

On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
> On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
> > 
> > Hi,
> > 
> > The first PR was against the linux-pm-next tree including the patch:
> > 
> > "cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"
> > 
> > This patch has been dropped in the meantime.
> > 
> > Here is a new PR where my tree has been rebased against linux-pm-next
> > and adding the patch mentioned above.
> > 
> > As stated by Rafael, I will handle the ARM specific patches from now.
> > 
> > The following changes since commit 48f99d5a97d32d70c0738d6e314d9f4dbefd89bf:
> > 
> >   Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:41:06 +0200)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
> > 
> > for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a990f06:
> > 
> >   ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> > (2013-07-16 13:57:24 +0200)
> 
> ping ?

Sorry, something distracted me.  I'll pull it later today unless there are any
problems (in which case I'll let you know).

Thanks,
Rafael


> > ----------------------------------------------------------------
> > Daniel Lezcano (2):
> >       ARM: davinci: cpuidle: Fix target residency
> >       ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> > 
> > Linus Walleij (2):
> >       ARM: ux500: cpuidle: Instantiate the driver from platform device
> >       ARM: ux500: cpuidle: Remove pointless include
> > 
> > Sahara (1):
> >       cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq
> > 
> >  arch/arm/mach-davinci/cpuidle.c                    |    2 +-
> >  arch/arm/mach-ux500/Makefile                       |    1 -
> >  drivers/cpuidle/Kconfig                            |   20 +++++---------
> >  drivers/cpuidle/Kconfig.arm                        |   29
> > ++++++++++++++++++++
> >  drivers/cpuidle/Makefile                           |    9 ++++--
> >  .../cpuidle.c => drivers/cpuidle/cpuidle-ux500.c   |   19 +++++++------
> >  drivers/mfd/db8500-prcmu.c                         |    4 +++
> >  7 files changed, 58 insertions(+), 26 deletions(-)
> >  create mode 100644 drivers/cpuidle/Kconfig.arm
> >  rename arch/arm/mach-ux500/cpuidle.c => drivers/cpuidle/cpuidle-ux500.c
> > (90%)
> > 
> > 
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
