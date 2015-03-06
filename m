From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: Re: [RFC/PATCH 0/6] Add CPUIdle support for Renesas SoCs
Date: Fri, 6 Mar 2015 18:38:33 +0900
Message-ID: <54F97599.7050904@renesas.com>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com> <54F89A23.1060008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <54F89A23.1060008@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: horms@verge.net.au, rjw@rjwysocki.net, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Daniel

(2015/03/06 3:02), Daniel Lezcano wrote:

> On 03/04/2015 05:55 AM, Keita Kobayashi wrote:
>> Hello
>>
>> These patches add CPUIdle support for Renesas SoCs.
>> These patches have been tested on Renesas Gen2 series with
>> following cases on renesas-devel-20150301-v4.0-rc1 tag.
>>
>> [Test case]
>>     a. Lager board(CA15 * 4)
>>     b. Lager board(CA7 * 4)
>>     c. Lager board(CA15 * 4 + CA7 *4)
>>     d. Koelsch board(CA15 * 2)
>>
>> These cases work fine.
>>
>> Keita Kobayashi (6):
>>    cpuidle: renesas: Add CPUIdle Driver for Renesas SoCs
>>    ARM: shmobile: Change CPUIdle InterFace
>>    ARM: shmobile: APMU: Add Core-Standby function for CPUIdle
>>    ARM: shmobile: r8a7791: Add Core-Standby CPUIdle support for r8a7791
>>    ARM: shmobile: r8a7790: Add Core-Standby CPUIdle support for r8a7790
>>    ARM: shmobile: Enable Renesas CPUIdle for shmobile_defconfig
>>
>>   arch/arm/configs/shmobile_defconfig           |   2 +
>>   arch/arm/mach-shmobile/common.h               |   8 +-
>>   arch/arm/mach-shmobile/cpuidle.c              |  31 ++++---
>>   arch/arm/mach-shmobile/platsmp-apmu.c         |  20 ++++-
>>   arch/arm/mach-shmobile/pm-r8a7790.c           |  55 ++++++++++++
>>   arch/arm/mach-shmobile/pm-r8a7791.c           |  41 +++++++++
>>   drivers/cpuidle/Kconfig.arm                   |   8 ++
>>   drivers/cpuidle/Makefile                      |   1 +
>>   drivers/cpuidle/cpuidle-renesas.c             | 118 ++++++++++++++++++++++++++
>>   include/linux/platform_data/renesas-cpuidle.h |  24 ++++++
>>   10 files changed, 294 insertions(+), 14 deletions(-)
>>   create mode 100644 drivers/cpuidle/cpuidle-renesas.c
>>   create mode 100644 include/linux/platform_data/renesas-cpuidle.h
> 
> Hi Keita,
> 
> the platform approach to pass private data from the arch specific to the cpuidle driver no longer accepted. Unfortunately, there is no alternate solution upstream.
> 
> But hopefully, there is a patchset [1] submitted for upstreaming which unify arm32/64 into a single generic cpuidle driver and use the DT to define the idle functions to be used.
> 
> I suggest you have a look at this patchset if it can fit your need.
> 
>   -- Daniel
> 
> [1] https://lkml.org/lkml/2015/3/3/271

Thank you for information.
I will take a look at the patch series.

Regards.
Keita Kobayashi

> 
> 

