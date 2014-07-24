From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv3 00/16] cpuidle for Marvell Armada 370 and 38x
Date: Thu, 24 Jul 2014 14:10:46 +0200
Message-ID: <20140724141046.6a0f064b@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140724120349.GT23220@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47839 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751822AbaGXMOB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 08:14:01 -0400
In-Reply-To: <20140724120349.GT23220@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Jason Cooper,

On Thu, 24 Jul 2014 08:03:49 -0400, Jason Cooper wrote:

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
> 
> It'll be in -next tonight.

Great, thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
