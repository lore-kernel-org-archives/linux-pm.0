From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 0/8] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Mon, 23 Mar 2015 16:31:07 +0100
Message-ID: <551031BB.4020200@linaro.org>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org> <20150323152737.GB18904@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:36316 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbbCWPbL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 11:31:11 -0400
Received: by wetk59 with SMTP id k59so140946841wet.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 08:31:09 -0700 (PDT)
In-Reply-To: <20150323152737.GB18904@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On 03/23/2015 04:27 PM, Lorenzo Pieralisi wrote:
> On Fri, Mar 20, 2015 at 11:43:53AM +0000, Daniel Lezcano wrote:
>> There is a big number of cpuidle drivers for the ARM architecture.
>>
>> These drivers have been cleaned up and grouped into the drivers/cpui=
dle
>> directory to keep track of the changes more easily and ensure the co=
de
>> is following the same scheme across the drivers.
>>
>> That had the benefit of simplifying the code and factor out a lot of=
 common
>> parts. Beside that, as the drivers belong to the 'drivers' directory=
, we had
>> to split the arch specific bits and the generic code in order to kee=
p
>> everything self contained. The platform driver paradigm was used for=
 this
>> purpose.
>>
>> Unfortunately, this approach is now no longer accepted and a differe=
nt solution
>> must be provided to reach the same goal: one example is the Qualcomm=
 cpuidle
>> driver upstreaming attempt.
>>
>> In the meantime, ARM64 developed a generic cpuidle driver based on D=
T definition.
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
ther in the
>> cpuidle driver flexibility via the DT.
>
> Tested on arm64 Juno and FVP models.

Thanks Lorenzo for testing the patches.

I applied the series to my tree for 4.1.

   -- Daniel

> Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
>>
>> Changelog:
>>
>>   V3:
>> 	* Fixed unroll loop when failing to register the device
>> 	* Removed the per cpu cpuidle_device
>> 	* Remove goto statement in the registration path
>> 	* Fixed a compilation failure with allyesconfig on arm64
>>
>>   V2:
>> 	* Used smp_operations style for cpuidle_ops
>> 	* Fixed some nits in the comments
>> 	* Added a patch to change the name of the functions
>> 	* Added per cpu device registration patch
>>
>> Daniel Lezcano (8):
>>    ARM: cpuidle: Remove duplicate header inclusion
>>    ARM: cpuidle: Add a cpuidle ops structure to be used for DT
>>    ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 funct=
ion
>>    ARM64: cpuidle: Rename cpu_init_idle to a common function name
>>    ARM64: cpuidle: Remove arm64 reference
>>    ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
>>    ARM: cpuidle: Register per cpuidle device
>>    ARM: cpuidle: Change function name to be consistent with x86
>>
>>   arch/arm/include/asm/cpuidle.h                     | 23 +++++++
>>   arch/arm/kernel/cpuidle.c                          | 74 ++++++++++=
+++++++++-
>>   arch/arm/mach-davinci/cpuidle.c                    |  1 -
>>   arch/arm/mach-imx/cpuidle-imx6q.c                  |  1 -
>>   arch/arm/mach-imx/cpuidle-imx6sl.c                 |  1 -
>>   arch/arm/mach-imx/cpuidle-imx6sx.c                 |  1 -
>>   arch/arm/mach-omap2/cpuidle44xx.c                  |  1 -
>>   arch/arm/mach-s3c64xx/cpuidle.c                    |  2 +-
>>   arch/arm/mach-tegra/cpuidle-tegra20.c              |  1 -
>>   arch/arm/mach-tegra/cpuidle-tegra30.c              |  1 -
>>   arch/arm64/include/asm/cpuidle.h                   |  9 ++-
>>   arch/arm64/kernel/cpuidle.c                        |  2 +-
>>   drivers/cpuidle/Kconfig                            |  7 +-
>>   drivers/cpuidle/Kconfig.arm                        | 12 +++-
>>   drivers/cpuidle/Kconfig.arm64                      | 13 ----
>>   drivers/cpuidle/Makefile                           |  5 +-
>>   drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} | 80 ++++++++=
++++++++------
>>   drivers/cpuidle/cpuidle-at91.c                     |  1 -
>>   drivers/cpuidle/cpuidle-exynos.c                   |  1 -
>>   drivers/cpuidle/cpuidle-kirkwood.c                 |  1 -
>>   drivers/cpuidle/cpuidle-ux500.c                    |  1 -
>>   drivers/cpuidle/cpuidle-zynq.c                     |  1 -
>>   include/asm-generic/vmlinux.lds.h                  |  2 +
>>   23 files changed, 178 insertions(+), 63 deletions(-)
>>   delete mode 100644 drivers/cpuidle/Kconfig.arm64
>>   rename drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} (57%)
>>
>> --
>> 1.9.1
>>
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

