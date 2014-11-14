From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 0/4] Add TMU support for Exynos7
Date: Fri, 14 Nov 2014 18:00:35 +0530
Message-ID: <CAM4voannFHau+TSufpN-rsp4TpSFSK0kKx6QtccNtFW9hO5i+Q@mail.gmail.com>
References: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
	<2756804.O2Zby5SkUf@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34259 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965431AbaKNMag (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 07:30:36 -0500
Received: by mail-qc0-f172.google.com with SMTP id i17so12591899qcy.17
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2014 04:30:35 -0800 (PST)
In-Reply-To: <2756804.O2Zby5SkUf@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, amit.daniel@samsung.com, l.majewski@samsung.com

Hi Bartlomiej,

On Fri, Nov 14, 2014 at 5:49 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Friday, November 14, 2014 04:47:58 PM Abhilash Kesavan wrote:
>> The Thermal Management Unit (TMU) in Exynos7 provides software-controlled
>> (thermal throttling) and hardware-controlled (thermal tripping) management
>> schemes.
>> There are several changes in terms of the register and bit offsets in the
>> Exynos7 TMU from that in older SoCs. There are also new bits, more trigger
>> levels and a special clock for TMU that has been introduced in Exynos7.
>> This patchset modifies the thermal driver to handle all these changes.
>>
>> This series is based on linux-next(20141114) and tested on an Exynos7-based
>> espresso board.
>
> Please rebase your patchset on top of:
>
>   http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg38717.html

Sure, will rebase on top of your patchset. Is this patchset going to
be merged into Eduardo's tree soon ?

>
> There is also ongoing work to convert Exynos thermal driver to use device
> tree but Lukasz Majewski (added to Cc:) knows better the current state of
> the work.

Lukasz, are you in the process of making changes to the existing
exynos tmu bindings ?

Regards,
Abhilash
>
>> Abhilash Kesavan (4):
>>   thermal: exynos: add optional sclk support
>>   thermal: exynos: add a triminfo_mask field in exynos_tmu_register
>>     structure
>>   thermal: exynos: modify the prototype for code_to_temp function
>>   thermal: exynos: Add TMU support for Exynos7 SoC
>>
>>  .../devicetree/bindings/thermal/exynos-thermal.txt |    4 +
>>  drivers/thermal/samsung/exynos_tmu.c               |  106 ++++++++++++++----
>>  drivers/thermal/samsung/exynos_tmu.h               |   13 ++-
>>  drivers/thermal/samsung/exynos_tmu_data.c          |  117 ++++++++++++++++++++
>>  drivers/thermal/samsung/exynos_tmu_data.h          |   27 +++++
>>  5 files changed, 247 insertions(+), 20 deletions(-)
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
