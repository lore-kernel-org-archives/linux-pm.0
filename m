From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PULL] ARM: cpuidle: changes for 4.7
Date: Tue, 26 Apr 2016 02:34:49 +0200
Message-ID: <1585774.soUmxhQCPX@vostro.rjw.lan>
References: <5719E10D.5020008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57373 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751778AbcDZAbu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 20:31:50 -0400
In-Reply-To: <5719E10D.5020008@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jszhang@marvell.com, lorenzo.pieralisi@arm.com, andy.gross@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday, April 22, 2016 10:30:05 AM Daniel Lezcano wrote:
> Hi Rafael,
> 
> please pull the following changes for 4.7.
> 
>   * Constify the cpuidle_ops structure and the types returned by the 
> functions using it (Jisheng Zhang)
> 
> Thanks !
> 
>    -- Daniel
> 
> The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:
> 
>    Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)
> 
> are available in the git repository at:
> 
>    http://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/4.7
> 
> for you to fetch changes up to 5e7c17df795e462c70a43f1b3b670e08efefe8fd:
> 
>    drivers: firmware: psci: use const and __initconst for 
> psci_cpuidle_ops (2016-04-20 10:44:32 +0200)
> 
> ----------------------------------------------------------------
> Jisheng Zhang (4):
>        ARM: cpuidle: add const qualifier to cpuidle_ops member in structures
>        ARM: cpuidle: constify return value of arm_cpuidle_get_ops()
>        soc: qcom: spm: Use const and __initconst for qcom_cpuidle_ops
>        drivers: firmware: psci: use const and __initconst for 
> psci_cpuidle_ops
> 
>   arch/arm/include/asm/cpuidle.h | 2 +-
>   arch/arm/kernel/cpuidle.c      | 6 +++---
>   drivers/firmware/psci.c        | 2 +-
>   drivers/soc/qcom/spm.c         | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)

Pulled, thanks!

