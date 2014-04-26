From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 0/2] Add generic cpu power control functions for exynos
Date: Sat, 26 Apr 2014 21:37:01 +0530
Message-ID: <CAM4voa=OrMHtB+Rza=5x74w8SuCg0VG8ZA_XLPzmDPU5cfEjyg@mail.gmail.com>
References: <1398331919-28321-1-git-send-email-leela.krishna@linaro.org>
	<5358DF50.9010106@linaro.org>
	<CAM7CM0kCexA=JjGw4XqhRQ+xPEss60SPpqPgSXgxANcnVh7ZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:43821 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaDZQHD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Apr 2014 12:07:03 -0400
In-Reply-To: <CAM7CM0kCexA=JjGw4XqhRQ+xPEss60SPpqPgSXgxANcnVh7ZWA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leela Krishna Amudala <leela.krishna@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "nicolas.pitre" <nicolas.pitre@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Kucheria <amit.kucheria@linaro.org>

Hi Leela,

On Thu, Apr 24, 2014 at 3:56 PM, Leela Krishna Amudala
<leela.krishna@linaro.org> wrote:
> Hi Abhilash,
>
> If you are okay with this patchset you can rebase/merge it with your
> mcpm patches.

I have added these patches as part of my mcpm v3 patchset.

Thanks,
Abhilash
>
> Best Wishes,
> Leela Krishna.
>
> On Thu, Apr 24, 2014 at 3:24 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Hi Abhilash and Leela,
>>
>> FYI I think you are working on similar patches.
>>
>>
>> On 04/24/2014 11:31 AM, Leela Krishna Amudala wrote:
>>> This patchset adds the generic cpu power control functions for
>>>
>>> exynos based SoCs to power up/down and to know the status of the cp=
u.
>>>
>>> Note: This series has been rebased on 3.15-rc1 and tested on
>>> Exynos based Origen(Cortex-A9) and Arndale-octa(Cortex A7,A15) boar=
ds.
>>>
>>> Leela Krishna Amudala (2):
>>>    ARM: EXYNOS: Add generic cpu power control functions for all exy=
nos
>>>      based SoCs
>>>    ARM: EXYNOS: use generic exynos cpu power control functions
>>>
>>>   arch/arm/mach-exynos/common.h   |    3 +++
>>>   arch/arm/mach-exynos/platsmp.c  |    9 +++------
>>>   arch/arm/mach-exynos/pm.c       |   36
>>> ++++++++++++++++++++++++++++++++++++
>>>   arch/arm/mach-exynos/regs-pmu.h |    6 ++++++
>>>   4 files changed, 48 insertions(+), 6 deletions(-)
>>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software =
for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
