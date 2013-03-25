From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 00/15] ARM: cpuidle: code consolidation
Date: Mon, 25 Mar 2013 22:55:23 +0100
Message-ID: <5150C7CB.6080400@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <5150B327.5010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56470 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933353Ab3CYVzX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 17:55:23 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm11so11617099wib.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 14:55:21 -0700 (PDT)
In-Reply-To: <5150B327.5010507@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: rjw@sisk.pl, tglx@linutronix.de, andrew@lunn.ch, linaro-kernel@lists.linaro.org, magnus.damm@gmail.com, ben-linux@fluff.org, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, rob.herring@calxeda.com, linux@arm.linux.org.uk, kevin.hilman@linaro.org, horms@verge.net.au, jason@lakedaemon.net, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 03/25/2013 09:27 PM, Rob Herring wrote:
> On 03/25/2013 12:55 PM, Daniel Lezcano wrote:
>> The flag CPUIDLE_FLAG_TIMER_STOP has been introduced in the commit
>> 89878baa73f0f1c679355006bd8632e5d78f96c2.
>>
>> The flag tells the cpuidle framework the local timer will stop in th=
e
>> idle state.
>>
>> It is now easy to know if the cpuidle driver will use or not the bro=
adcast
>> timer by looking at the different states for this flag and then setu=
p
>> the broadcast timer consequently.
>>
>> When we remove the timer initialization duplicated code in the diffe=
rent
>> drivers, we have most of the drivers with the same init function. Th=
is
>> init function is changed to be generic and moved in the ARM cpuidle =
driver
>> and used from the drivers. That cleanups code and removes a lot of a=
nnoying
>> duplicated code.
>>
>> There is still some modification in OMAP4, tegra2, tegra3 and imx, e=
specially
>> around the coupled idle states, but we are more and more closer to a=
 common
>> squeleton for all the ARM drivers.
>>
>> Daniel Lezcano (15):
>>   timer: move enum definition out of ifdef section
>>   cpuidle: initialize the broadcast timer framework
>>   cpuidle: ux500: remove timer broadcast initialization
>>   cpuidle: OMAP4: remove timer broadcast initialization
>>   cpuidle: imx6: remove timer broadcast initialization
>>   ARM: cpuidle: remove useless declaration
>>   ARM: cpuidle: add init/exit routine
>>   ARM: ux500: cpuidle: use init/exit common routine
>>   ARM: at91: cpuidle: use init/exit common routine
>>   ARM: OMAP3: cpuidle: use init/exit common routine
>>   ARM: s3c64xx: cpuidle: use init/exit common routine
>>   ARM: tegra1: cpuidle: use init/exit common routine
>>   ARM: shmobile: pm: fix init sections
>>   ARM: shmobile: cpuidle: remove useless WFI function
>>   ARM: shmobile: cpuidle: use init/exit common routine
>>
>>  arch/arm/include/asm/cpuidle.h         |   11 +++---
>>  arch/arm/kernel/cpuidle.c              |   57 +++++++++++++++++++++=
++++++++++-
>>  arch/arm/mach-at91/cpuidle.c           |   17 ++--------
>>  arch/arm/mach-imx/cpuidle-imx6q.c      |   15 ---------
>>  arch/arm/mach-omap2/cpuidle34xx.c      |   18 ++--------
>>  arch/arm/mach-omap2/cpuidle44xx.c      |   14 --------
>>  arch/arm/mach-s3c64xx/cpuidle.c        |   15 ++-------
>>  arch/arm/mach-shmobile/cpuidle.c       |   22 ++----------
>>  arch/arm/mach-shmobile/pm-sh7372.c     |    4 +--
>>  arch/arm/mach-tegra/cpuidle-tegra114.c |   27 +--------------
>>  arch/arm/mach-ux500/cpuidle.c          |   50 +--------------------=
-------
>>  drivers/cpuidle/driver.c               |   35 ++++++++++++++++++--
>>  include/linux/clockchips.h             |   22 ++++++------
>>  include/linux/cpuidle.h                |    2 ++
>>  14 files changed, 120 insertions(+), 189 deletions(-)
>=20
> What happened to the Calxeda driver?

On the way...


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

