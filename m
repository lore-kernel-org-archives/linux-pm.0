From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 0/6] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Fri, 13 Mar 2015 15:51:38 -0500
Message-ID: <CAL_Jsq+HSE997h4CtM-hM29t5Yhrkc0ikkfJDOUhHf3JTH-g4w@mail.gmail.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org> <5501A1DE.9020804@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33158 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbbCMUwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 16:52:01 -0400
In-Reply-To: <5501A1DE.9020804@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lina.iyer@linaro.org

On Thu, Mar 12, 2015 at 9:25 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Catalin, Rob,
>
> do you agree with this patchset ?

There's very little to do with DT, but looks fine to me.

Rob

>
> Thanks
>   -- Daniel
>
>
> On 03/03/2015 01:29 PM, Daniel Lezcano wrote:
>>
>> There is a big number of cpuidle drivers for the ARM architecture.
>>
>> These drivers have been cleaned up and grouped into the drivers/cpui=
dle
>> directory to keep track of the changes more easily and ensure the co=
de
>> is following the same scheme across the drivers.
>>
>> That had the benefit of simplifying the code and factor out a lot of
>> common
>> parts. Beside that, as the drivers belong to the 'drivers' directory=
, we
>> had
>> to split the arch specific bits and the generic code in order to kee=
p
>> everything self contained. The platform driver paradigm was used for=
 this
>> purpose.
>>
>> Unfortunately, this approach is now no longer accepted and a differe=
nt
>> solution
>> must be provided to reach the same goal: one example is the Qualcomm
>> cpuidle
>> driver upstreaming attempt [1].
>>
>> In the meantime, ARM64 developed a generic cpuidle driver based on D=
T
>> definition.
>>
>> The DT definition provides an 'enable-method' to specify one of the =
cpu
>> operations (PSCI, ...).
>>
>> This patchset unify this driver with ARM32, using the same DT defini=
tion.
>>
>> Thanks with this patchset we can use the 'enable-method' to specify =
a cpu
>> operations, hence get rid of the platform driver approach and go fur=
ther
>> in the
>> cpuidle driver flexibility via the DT.
>>
>> Daniel Lezcano (6):
>>    ARM: cpuidle: Remove duplicate header inclusion
>>    ARM: cpuidle: Add a cpuidle ops structure to be used for DT
>>    ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 funct=
ion
>>    ARM64: cpuidle: Rename cpu_init_idle to a common function name
>>    ARM64: cpuidle: Remove arm64 reference
>>    ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
>>
>>   arch/arm/include/asm/cpuidle.h                     | 12 +++
>>   arch/arm/include/asm/cpuidle_ops.h                 |  3 +
>>   arch/arm/kernel/cpuidle.c                          | 87
>> +++++++++++++++++++++-
>>   arch/arm/mach-davinci/cpuidle.c                    |  1 -
>>   arch/arm/mach-imx/cpuidle-imx6q.c                  |  1 -
>>   arch/arm/mach-imx/cpuidle-imx6sl.c                 |  1 -
>>   arch/arm/mach-imx/cpuidle-imx6sx.c                 |  1 -
>>   arch/arm/mach-omap2/cpuidle44xx.c                  |  1 -
>>   arch/arm/mach-tegra/cpuidle-tegra20.c              |  1 -
>>   arch/arm/mach-tegra/cpuidle-tegra30.c              |  1 -
>>   arch/arm64/include/asm/cpuidle.h                   |  9 ++-
>>   arch/arm64/kernel/cpuidle.c                        |  2 +-
>>   drivers/cpuidle/Kconfig                            |  7 +-
>>   drivers/cpuidle/Kconfig.arm                        | 10 +++
>>   drivers/cpuidle/Kconfig.arm64                      | 13 ----
>>   drivers/cpuidle/Makefile                           |  5 +-
>>   drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} | 38 +++++---=
--
>>   drivers/cpuidle/cpuidle-at91.c                     |  1 -
>>   drivers/cpuidle/cpuidle-exynos.c                   |  1 -
>>   drivers/cpuidle/cpuidle-kirkwood.c                 |  1 -
>>   drivers/cpuidle/cpuidle-ux500.c                    |  1 -
>>   drivers/cpuidle/cpuidle-zynq.c                     |  1 -
>>   22 files changed, 139 insertions(+), 59 deletions(-)
>>   create mode 100644 arch/arm/include/asm/cpuidle_ops.h
>>   delete mode 100644 drivers/cpuidle/Kconfig.arm64
>>   rename drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} (72%)
>>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
