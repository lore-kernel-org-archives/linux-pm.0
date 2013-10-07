From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] cpuidle ARM: new material for 3.13
Date: Mon, 07 Oct 2013 21:46:27 +0200
Message-ID: <1526872.QFtHgzSCGz@vostro.rjw.lan>
References: <5252CA58.700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57060 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752270Ab3JGTes (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2013 15:34:48 -0400
In-Reply-To: <5252CA58.700@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Monday, October 07, 2013 04:51:04 PM Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> this pull request based on 3.12-rc4 contains the following changes:
> 
> - Daniel Lezcano converted the zynq cpuidle driver to the platform 
> driver and fixed a section mismatch for ux500
> 
> - Lorenzo Pieralisi fixed the Makefile format for ARM
> 
> 
> Thanks
> -- Daniel
> 
> 
> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
> 
> Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
> 
> are available in the git repository at:
> 
> git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
> 
> for you to fetch changes up to 2c2b24d9c3e96d5cf974be4559a936e7f3b50225:
> 
> ARM: ux500: cpuidle: fix section mismatch (2013-10-07 16:47:07 +0200)
> 
> ----------------------------------------------------------------
> Daniel Lezcano (3):
> ARM: zynq: cpuidle: Remove useless compatibility string
> ARM: zynq: cpuidle: convert to platform driver
> ARM: ux500: cpuidle: fix section mismatch
> 
> Lorenzo Pieralisi (1):
> drivers: cpuidle: rename ARM big.LITTLE driver config and makefile entries
> 
> arch/arm/mach-zynq/common.c | 6 ++++++
> drivers/cpuidle/Kconfig.arm | 22 +++++++++++-----------
> drivers/cpuidle/Makefile | 2 +-
> drivers/cpuidle/cpuidle-ux500.c | 2 +-
> drivers/cpuidle/cpuidle-zynq.c | 17 +++++++++++------
> 5 files changed, 30 insertions(+), 19 deletions(-)

Pulled, thanks Daniel!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
