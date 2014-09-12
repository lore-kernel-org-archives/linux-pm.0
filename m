From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Fri, 12 Sep 2014 12:26:43 +0100
Message-ID: <20140912112643.GA10623@red-moon>
References: <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173740.GJ1824@e102568-lin.cambridge.arm.com>
 <20140904160320.GB22354@arm.com>
 <20140904172909.GA14822@e102568-lin.cambridge.arm.com>
 <20140905092120.GG13515@arm.com>
 <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
 <54115D16.30206@linaro.org>
 <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
 <54116C40.3080700@linaro.org>
 <20140912103257.GB24416@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58355 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbaILL0c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 07:26:32 -0400
In-Reply-To: <20140912103257.GB24416@localhost>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Step

On Fri, Sep 12, 2014 at 11:32:57AM +0100, Catalin Marinas wrote:
> Daniel, Lorenzo,
> 
> On Thu, Sep 11, 2014 at 10:32:48AM +0100, Daniel Lezcano wrote:
> > On 09/11/2014 10:57 AM, Lorenzo Pieralisi wrote:
> > > There is no ARM code in my series. So to sum it up:
> > >
> > > a) I send a pull request to Catalin for arm64 patches on top of the branch
> > >     you are creating with my patches
> >  >
> > > b) You take care of merging the CPUidle related patches through your
> > >     tree
> > >
> > > Is the above what you meant ?
> > 
> > Right, that allows to share a branch across the trees and resolve the 
> > dependencies when a patchset is touching different subsystems.
> > 
> > I realize the dependency is inverted regarding what I proposed 
> > initially, so it is up to Catalin to create the branch and I will share 
> > it with him.
> 
> I created the branch below with the arm64 specific patches for cpuidle.
> I won't rebase it and it should appear in -next tomorrow.
> 
> Lorenzo, please send a pull request to Daniel with the additional
> patches on top of the arm64 branch. Thanks.

Thank you very much, done. Pull request attached for information.

As Daniel knows, last two patches are still pending, waiting for Samsung
acks, and will be dropped if we do not get them in time.

Lorenzo

The following changes since commit 18910ab0d916b1a87016d69efd027714a80521dd:

  arm64: add PSCI CPU_SUSPEND based cpu_suspend support (2014-09-12 10:48:56 +0100)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git for-upstream/arm-generic-cpuidle

for you to fetch changes up to dda773655f9b97570884c4396ad4d63daf177107:

  drivers: cpuidle: initialize Exynos driver through DT (2014-09-12 11:37:43 +0100)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: dts: add CPU nodes for Exynos4 SoCs

Lorenzo Pieralisi (4):
      drivers: cpuidle: implement DT based idle states infrastructure
      drivers: cpuidle: CPU idle ARM64 driver
      drivers: cpuidle: initialize big.LITTLE driver through DT
      drivers: cpuidle: initialize Exynos driver through DT

 arch/arm/boot/dts/exynos4210.dtsi          |  27 ++++
 arch/arm/boot/dts/exynos4212.dtsi          |  17 +++
 arch/arm/boot/dts/exynos4412.dtsi          |  29 ++++
 arch/arm/boot/dts/exynos5250.dtsi          |  11 ++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts |  23 ++++
 drivers/cpuidle/Kconfig                    |   8 ++
 drivers/cpuidle/Kconfig.arm                |   2 +
 drivers/cpuidle/Kconfig.arm64              |  14 ++
 drivers/cpuidle/Makefile                   |   5 +
 drivers/cpuidle/cpuidle-arm64.c            | 133 ++++++++++++++++++
 drivers/cpuidle/cpuidle-big_little.c       |  19 +++
 drivers/cpuidle/cpuidle-exynos.c           |  18 ++-
 drivers/cpuidle/dt_idle_states.c           | 213 +++++++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_states.h           |   7 +
 14 files changed, 525 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c
 create mode 100644 drivers/cpuidle/dt_idle_states.c
 create mode 100644 drivers/cpuidle/dt_idle_states.h

