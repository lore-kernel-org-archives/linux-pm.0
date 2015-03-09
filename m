From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC/PATCH 0/6] Add CPUIdle support for Renesas SoCs
Date: Mon, 9 Mar 2015 09:21:55 -0600
Message-ID: <20150309152155.GC456@linaro.org>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
 <54F89A23.1060008@linaro.org>
 <54F97599.7050904@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34439 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbbCIPV6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 11:21:58 -0400
Received: by pdno5 with SMTP id o5so21520764pdn.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2015 08:21:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54F97599.7050904@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: keita kobayashi <keita.kobayashi.ym@renesas.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, horms@verge.net.au, rjw@rjwysocki.net, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com

On Fri, Mar 06 2015 at 02:38 -0700, keita kobayashi wrote:
>Hi Daniel
>
>(2015/03/06 3:02), Daniel Lezcano wrote:
>
>> On 03/04/2015 05:55 AM, Keita Kobayashi wrote:
>>> Hello
>>>
>>> These patches add CPUIdle support for Renesas SoCs.
>>> These patches have been tested on Renesas Gen2 series with
>>> following cases on renesas-devel-20150301-v4.0-rc1 tag.
>>>
>>> [Test case]
>>>     a. Lager board(CA15 * 4)
>>>     b. Lager board(CA7 * 4)
>>>     c. Lager board(CA15 * 4 + CA7 *4)
>>>     d. Koelsch board(CA15 * 2)
>>>
>>> These cases work fine.
>>>
>>> Keita Kobayashi (6):
>>>    cpuidle: renesas: Add CPUIdle Driver for Renesas SoCs
>>>    ARM: shmobile: Change CPUIdle InterFace
>>>    ARM: shmobile: APMU: Add Core-Standby function for CPUIdle
>>>    ARM: shmobile: r8a7791: Add Core-Standby CPUIdle support for r8a7791
>>>    ARM: shmobile: r8a7790: Add Core-Standby CPUIdle support for r8a7790
>>>    ARM: shmobile: Enable Renesas CPUIdle for shmobile_defconfig
>>>
>>>   arch/arm/configs/shmobile_defconfig           |   2 +
>>>   arch/arm/mach-shmobile/common.h               |   8 +-
>>>   arch/arm/mach-shmobile/cpuidle.c              |  31 ++++---
>>>   arch/arm/mach-shmobile/platsmp-apmu.c         |  20 ++++-
>>>   arch/arm/mach-shmobile/pm-r8a7790.c           |  55 ++++++++++++
>>>   arch/arm/mach-shmobile/pm-r8a7791.c           |  41 +++++++++
>>>   drivers/cpuidle/Kconfig.arm                   |   8 ++
>>>   drivers/cpuidle/Makefile                      |   1 +
>>>   drivers/cpuidle/cpuidle-renesas.c             | 118 ++++++++++++++++++++++++++
>>>   include/linux/platform_data/renesas-cpuidle.h |  24 ++++++
>>>   10 files changed, 294 insertions(+), 14 deletions(-)
>>>   create mode 100644 drivers/cpuidle/cpuidle-renesas.c
>>>   create mode 100644 include/linux/platform_data/renesas-cpuidle.h
>>
>> Hi Keita,
>>
>> the platform approach to pass private data from the arch specific to the cpuidle driver no longer accepted. Unfortunately, there is no alternate solution upstream.
>>
>> But hopefully, there is a patchset [1] submitted for upstreaming which unify arm32/64 into a single generic cpuidle driver and use the DT to define the idle functions to be used.
>>
>> I suggest you have a look at this patchset if it can fit your need.
>>
>>   -- Daniel
>>
>> [1] https://lkml.org/lkml/2015/3/3/271
>
>Thank you for information.
>I will take a look at the patch series.

Hi Kieta,

Please also have a look at the v15 of the cpuidle support for QCOM SoC.
Sent just now.  It is based on [1].

Thanks,
Lina
