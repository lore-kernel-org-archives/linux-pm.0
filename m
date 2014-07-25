From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 00/16] cpuidle for Marvell Armada 370 and 38x
Date: Thu, 24 Jul 2014 20:05:54 -0400
Message-ID: <20140725000554.GA23220@titan.lakedaemon.net>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140724120349.GT23220@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934813AbaGYAGH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 20:06:07 -0400
Content-Disposition: inline
In-Reply-To: <20140724120349.GT23220@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thu, Jul 24, 2014 at 08:03:49AM -0400, Jason Cooper wrote:
> Thomas, all,
> 
> On Wed, Jul 23, 2014 at 03:00:37PM +0200, Thomas Petazzoni wrote:
> > Hello,
> > 
> > Here comes the third version of the cpuidle support for Armada 370 and
> > Armada 38x.
> > 
> > We are hoping to see this patch series merged for 3.17.
> > 
> > Most patches are touching only arch/arm/mach-mvebu/ code so they
> > should be handled by the mvebu maintainers. However, patches 11-13 are
> > touching the mvebu cpuidle driver, with a possible issue on patch 11,
> > which touches both the cpuidle driver and the mach-mvebu code in order
> > to rename the driver without breaking functionality (if needed, we can
> > decide to split the commits, it would break functionality temporarly,
> > but not buildability).
> > 
> > Changes since v2
> > ================
> > 
> >  * According to the discussion with Daniel Lezcano (cpuidle
> >    maintainer) and Arnd Bergmann, changed the cpuidle-mvebu-v7 driver
> >    to actually register three separate cpuidle platform driver, one
> >    per-SoC. This way, we don't need special platform data to convey
> >    the SoC type being used, as this information is already available
> >    by looking at the driver name.
> > 
> >    This change impacts the patches "cpuidle: mvebu: rename the driver
> >    from armada-370-xp to mvebu-v7", "cpuidle: mvebu: add Armada 370
> >    support", "cpuidle: mvebu: add Armada 38x support", "ARM: mvebu:
> >    add cpuidle support for Armada 370" and "ARM: mvebu: add cpuidle
> >    support for Armada 38x". Other patches are unchanged. The patch
> >    "cpuidle: mvebu: make the cpuidle driver capable of handling
> >    multiple SoCs" was no longer needed, so it has been removed.
> > 
> ...
> > Gregory CLEMENT (14):
> >   ARM: mvebu: split again armada_370_xp_pmsu_idle_enter() in PMSU code
> >   ARM: mvebu: sort the #include of pmsu.c in alphabetic order
> >   ARM: mvebu: add a common function for the boot address work around
> >   ARM: mvebu: use the common function for Armada 375 SMP workaround
> >   ARM: mvebu: rename the armada_370_xp symbols to mvebu_v7 in pmsu.c
> >   ARM: mvebu: make the cpuidle initialization more generic
> >   ARM: mvebu: use a local variable to store the resume address
> >   ARM: mvebu: make the snoop disabling optional in
> >     mvebu_v7_pmsu_idle_prepare()
> >   ARM: mvebu: export the SCU address
> >   ARM: mvebu: add CA9 MPcore SoC Controller node
> >   cpuidle: mvebu: rename the driver from armada-370-xp to mvebu-v7
> >   ARM: mvebu: add cpuidle support for Armada 370
> >   ARM: mvebu: add cpuidle support for Armada 38x
> >   ARM: mvebu: defconfig: enable cpuidle support in mvebu_v7_defconfig
> > 
> > Thomas Petazzoni (2):
> >   cpuidle: mvebu: add Armada 370 support
> >   cpuidle: mvebu: add Armada 38x support
> > 
> >  .../bindings/arm/armada-380-mpcore-soc-ctrl.txt    |  14 ++
> >  arch/arm/boot/dts/armada-38x.dtsi                  |   5 +
> >  arch/arm/configs/mvebu_v7_defconfig                |   2 +
> >  arch/arm/mach-mvebu/armada-370-xp.h                |   1 -
> >  arch/arm/mach-mvebu/board-v7.c                     |   9 +-
> >  arch/arm/mach-mvebu/common.h                       |   2 +
> >  arch/arm/mach-mvebu/headsmp-a9.S                   |  15 --
> >  arch/arm/mach-mvebu/platsmp-a9.c                   |  42 +---
> >  arch/arm/mach-mvebu/platsmp.c                      |   2 +-
> >  arch/arm/mach-mvebu/pmsu.c                         | 273 ++++++++++++++++++---
> >  arch/arm/mach-mvebu/pmsu.h                         |   5 +
> >  arch/arm/mach-mvebu/pmsu_ll.S                      |  36 +++
> >  arch/arm/mach-mvebu/system-controller.c            |  31 +++
> >  drivers/cpuidle/Kconfig.arm                        |  12 +-
> >  drivers/cpuidle/Makefile                           |   2 +-
> >  drivers/cpuidle/cpuidle-armada-370-xp.c            |  93 -------
> >  drivers/cpuidle/cpuidle-mvebu-v7.c                 | 150 +++++++++++
> >  17 files changed, 500 insertions(+), 194 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
> >  delete mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
> >  create mode 100644 drivers/cpuidle/cpuidle-mvebu-v7.c
> 
> Whole series, except 10 (went to mvebu/dt), and 16 (went to
> mvebu/defconfig) applied to mvebu/soc-cpuidle.  Patches 11 to 13 applied
> with Daniel's Ack.

Now merged into mvebu/soc.

It's getting really close.  I'll try to send out the pull request
tomorrow am.  

thx,

Jason.
