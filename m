From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/2] Enabling PSCI based idle on ARM 32-bit platforms
Date: Tue, 13 Oct 2015 13:17:57 +0200
Message-ID: <561CE865.2000509@linaro.org>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
 <561CC185.60001@linaro.org> <20151013104424.GA13899@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33694 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbbJMLSB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 07:18:01 -0400
Received: by wicge5 with SMTP id ge5so52818452wic.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 04:18:00 -0700 (PDT)
In-Reply-To: <20151013104424.GA13899@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>, Lina Iyer <lina.iyer@linaro.org>

On 10/13/2015 12:44 PM, Lorenzo Pieralisi wrote:
> Hi Daniel,
>
> On Tue, Oct 13, 2015 at 10:32:05AM +0200, Daniel Lezcano wrote:
>>
>> Hi Lorenzo,
>>
>> I would like to take this patch through my tree but it does not appl=
y.
>
> That's because as I mentioned in the cover letter the series is built
> on top of:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git ta=
gs/firmware/psci-1.0
>
> Hopefully this tag will soon get pulled in arm-soc, I will respin a v=
3
> anyway to add tags and fold psci_cpuops.c in psci.c, how do you want =
to
> merge this then ?

May be you can create a branch with your modifications to be shared wit=
h=20
arm-soc and me ?


>> Mind to refresh it against linux-pm or v4.3-rc5 ?
>>
>>    -- Daniel
>>
>>
>> On 10/12/2015 01:17 PM, Lorenzo Pieralisi wrote:
>>> This patch series is v2 of a previous posting:
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/=
373756.html
>>>
>>> v1->v2:
>>>
>>> - Refactored patch 1 to remove cpu parameter from cpuidle_ops
>>>    suspend hook
>>> - Refactored psci_cpu_init_idle to stub out dt parsing function and
>>>    make it usable on both ARM/ARM64 with no additional changes
>>> - Updated ARM cpuidle_ops to new interfaces
>>> - Fixed PSCI enable method string in ARM cpuidle_ops struct
>>>
>>> PSCI firmware provides a kernel API that, through a standard interf=
ace,
>>> allows to manage power states transitions in a seamless manner for
>>> ARM and ARM64 systems.
>>>
>>> Current PSCI code that initializes CPUidle states on PSCI based
>>> systems lives in arch/arm64 directory but it is not ARM64 specific
>>> and can be shared with ARM 32-bit systems so that the generic
>>> ARM CPUidle driver can leverage the common PSCI interface.
>>>
>>> This patch series moves PSCI CPUidle management code to
>>> drivers/firmware directory so that ARM and ARM64 architecture
>>> can actually share the code.
>>>
>>> It is made up of two patches:
>>>
>>> Patch 1 refactors ARM 32-bit generic idle implementation to remove
>>> the cpu parameter from the cpuidle_ops suspend hook, in preparation
>>> for a common PSCI implementation for ARM/ARM64 PSCI idle.
>>>
>>> Patch 2 moves ARM64 PSCI CPUidle functions implementation to
>>> drivers/firmware so that it can be shared with ARM 32-bit platforms
>>> code. This patch also adds a PSCI entry section on ARM 32-bit syste=
ms
>>> so that the PSCI CPUidle back-end can be enabled when the enable-me=
thod
>>> corresponds to PSCI.
>>>
>>> Patches apply on top of current patch stack to enable PSCI 1.0:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git =
tags/firmware/psci-1.0
>>>
>>> Tested on Juno board (ARM64), compile tested only on ARM 32-bit sys=
tems.
>>>
>>> Lorenzo Pieralisi (2):
>>>    ARM: cpuidle: remove cpu parameter from the cpuidle_ops suspend =
hook
>>>    ARM64: kernel: PSCI: move PSCI idle management code to
>>>      drivers/firmware
>>>
>>>   arch/arm/include/asm/cpuidle.h |   2 +-
>>>   arch/arm/kernel/cpuidle.c      |   2 +-
>>>   arch/arm64/kernel/psci.c       |  99 +---------------------------=
--
>>>   drivers/firmware/Makefile      |   2 +-
>>>   drivers/firmware/psci_cpuops.c | 133 ++++++++++++++++++++++++++++=
+++++++++++++
>>>   drivers/soc/qcom/spm.c         |  10 ++--
>>>   include/linux/psci.h           |   3 +
>>>   7 files changed, 146 insertions(+), 105 deletions(-)
>>>   create mode 100644 drivers/firmware/psci_cpuops.c
>>>
>>
>>
>> --
>>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software=
 for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

