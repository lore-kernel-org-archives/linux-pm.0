From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 0/6] add cpuidle support for Exynos5420
Date: Wed, 14 May 2014 11:56:24 +0200
Message-ID: <53733DC8.1020608@linaro.org>
References: <ANuQgHGSPJ45tbrVppAVpOqF0OfHacPWfX=S5mOVxTPr66f7vg@mail.gmail.com> <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:39519 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaENJ4Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 05:56:16 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm4so7685450wib.16
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 02:56:14 -0700 (PDT)
In-Reply-To: <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On 05/14/2014 10:03 AM, Chander Kashyap wrote:
> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 co=
res.
>
> This patchset adds cpuidle support for Exynos5420 SoC based on
> generic big.little cpuidle driver.

Hi Chander,

just a side question. I am not succeeding to have both cluster A7/A15=20
with the upstream kernel.

How can I test your driver ?

Did I miss something ?

Thanks
   -- Daniel

> Tested on SMDK5420.
>
> This patch set depends on:
> 	1. [PATCH 0/5] MCPM backend for Exynos5420
> 	   http://www.spinics.net/lists/arm-kernel/msg331100.html
> Changelog is in respective patches.
> Chander Kashyap (5):
>    driver: cpuidle-big-little: add of_device_id structure
>    arm: exynos: add generic function to calculate cpu number
>    cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-littl=
e
>      driver
>    driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
>    exynos: cpuidle: do not allow cpuidle registration for Exynos5420
>    mcpm: exynos: populate suspend and powered_up callbacks
>
>   arch/arm/mach-exynos/cpuidle.c       |    3 +++
>   arch/arm/mach-exynos/mcpm-exynos.c   |   36 +++++++++++++++++++++++=
+++++++++++
>   arch/arm/mach-exynos/regs-pmu.h      |    9 +++++++++
>   drivers/cpuidle/Kconfig.arm          |    2 +-
>   drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
>   5 files changed, 60 insertions(+), 2 deletions(-)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

