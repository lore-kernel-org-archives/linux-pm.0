From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v6 0/6] add cpuidle support for Exynos5420
Date: Mon, 26 May 2014 12:29:41 +0200
Message-ID: <53831795.9070006@gmail.com>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com> <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58157 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaEZK3r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 06:29:47 -0400
In-Reply-To: <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com

Hi Chander,

On 16.05.2014 10:03, Chander Kashyap wrote:
> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.
> 
> This patchset adds cpuidle support for Exynos5420 SoC based on
> generic big.little cpuidle driver.
> 
> Tested on SMDK5420.
> 
> This patch set depends on:
> 	1. [PATCH 0/5] MCPM backend for Exynos5420
> 	   http://www.spinics.net/lists/arm-kernel/msg331100.html
> Changelog is in respective patches.
> Chander Kashyap (5):
>   driver: cpuidle-big-little: add of_device_id structure
>   arm: exynos: add generic function to calculate cpu number
>   cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-little
>     driver
>   driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
>   exynos: cpuidle: do not allow cpuidle registration for Exynos5420
>   mcpm: exynos: populate suspend and powered_up callbacks
> 
>  arch/arm/mach-exynos/exynos.c        |    4 +++-
>  arch/arm/mach-exynos/mcpm-exynos.c   |   36 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h      |    9 +++++++++
>  drivers/cpuidle/Kconfig.arm          |    2 +-
>  drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
>  5 files changed, 60 insertions(+), 3 deletions(-)
> 

For the whole series,

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
