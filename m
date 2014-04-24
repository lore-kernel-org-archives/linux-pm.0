From: Leela Krishna Amudala <leela.krishna@linaro.org>
Subject: Re: [PATCH 0/2] Add generic cpu power control functions for exynos
Date: Thu, 24 Apr 2014 15:56:50 +0530
Message-ID: <CAM7CM0kCexA=JjGw4XqhRQ+xPEss60SPpqPgSXgxANcnVh7ZWA@mail.gmail.com>
References: <1398331919-28321-1-git-send-email-leela.krishna@linaro.org> <5358DF50.9010106@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5358DF50.9010106@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "nicolas.pitre" <nicolas.pitre@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Kucheria <amit.kucheria@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Abhilash,

If you are okay with this patchset you can rebase/merge it with your
mcpm patches.

Best Wishes,
Leela Krishna.

On Thu, Apr 24, 2014 at 3:24 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Abhilash and Leela,
>
> FYI I think you are working on similar patches.
>
>
> On 04/24/2014 11:31 AM, Leela Krishna Amudala wrote:
>> This patchset adds the generic cpu power control functions for
>>
>> exynos based SoCs to power up/down and to know the status of the cpu=
=2E
>>
>> Note: This series has been rebased on 3.15-rc1 and tested on
>> Exynos based Origen(Cortex-A9) and Arndale-octa(Cortex A7,A15) board=
s.
>>
>> Leela Krishna Amudala (2):
>>    ARM: EXYNOS: Add generic cpu power control functions for all exyn=
os
>>      based SoCs
>>    ARM: EXYNOS: use generic exynos cpu power control functions
>>
>>   arch/arm/mach-exynos/common.h   |    3 +++
>>   arch/arm/mach-exynos/platsmp.c  |    9 +++------
>>   arch/arm/mach-exynos/pm.c       |   36
>> ++++++++++++++++++++++++++++++++++++
>>   arch/arm/mach-exynos/regs-pmu.h |    6 ++++++
>>   4 files changed, 48 insertions(+), 6 deletions(-)
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
