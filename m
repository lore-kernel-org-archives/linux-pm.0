From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v6 0/6] add cpuidle support for Exynos5420
Date: Wed, 28 May 2014 13:35:19 +0900
Message-ID: <015f01cf7a2e$3b141590$b13c40b0$@samsung.com>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com>
 <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
 <53831795.9070006@gmail.com>
 <CANuQgHH284A9QY7M5zGbSE-mXjm2KDqr54VWmtKVkbma3zZvvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28822 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbaE1EfW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 May 2014 00:35:22 -0400
In-reply-to: <CANuQgHH284A9QY7M5zGbSE-mXjm2KDqr54VWmtKVkbma3zZvvw@mail.gmail.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Chander Kashyap' <chander.kashyap@linaro.org>, 'Tomasz Figa' <tomasz.figa@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

Chander Kashyap wrote:
> 
> On 26 May 2014 15:59, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > Hi Chander,
> >
> > On 16.05.2014 10:03, Chander Kashyap wrote:
> >> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7
> cores.
> >>
> >> This patchset adds cpuidle support for Exynos5420 SoC based on
> >> generic big.little cpuidle driver.
> >>
> >> Tested on SMDK5420.
> >>
> >> This patch set depends on:
> >>       1. [PATCH 0/5] MCPM backend for Exynos5420
> >>          http://www.spinics.net/lists/arm-kernel/msg331100.html
> >> Changelog is in respective patches.
> >> Chander Kashyap (5):
> >>   driver: cpuidle-big-little: add of_device_id structure
> >>   arm: exynos: add generic function to calculate cpu number
> >>   cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-little
> >>     driver
> >>   driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
> >>   exynos: cpuidle: do not allow cpuidle registration for Exynos5420
> >>   mcpm: exynos: populate suspend and powered_up callbacks
> >>
> >>  arch/arm/mach-exynos/exynos.c        |    4 +++-
> >>  arch/arm/mach-exynos/mcpm-exynos.c   |   36
> ++++++++++++++++++++++++++++++++++
> >>  arch/arm/mach-exynos/regs-pmu.h      |    9 +++++++++
> >>  drivers/cpuidle/Kconfig.arm          |    2 +-
> >>  drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
> >>  5 files changed, 60 insertions(+), 3 deletions(-)
> >>
> >
> > For the whole series,
> >
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
> Thanks Tomasz.
> 
> Dear Kukjin,
> Can you take these patches.
> >
When I looked at this series quickly, looks good to me but I need to get ack from cpuidle maintainer Rafael or Daniel.

Thanks,
Kukjin

