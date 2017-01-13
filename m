From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/4] DMA Engine: switch PL330 driver to non-irq-safe
 runtime PM
Date: Fri, 13 Jan 2017 15:41:48 +0100
Message-ID: <CAPDyKFqHAhsqn+1cQw4Y4GPYZghY8Z=GgYMO=2e6FPGWP0tzsg@mail.gmail.com>
References: <CGME20170113072651eucas1p2b7487d97894de93daab24adb6745087c@eucas1p2.samsung.com>
 <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFqDGs6OkG-NKiY9Xd3hHEJOJB1YJ2O0_3Tojrzv_xR-yw@mail.gmail.com> <60596eee-12a9-58f3-387e-145a5bc28aaa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35083 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdAMOlv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 09:41:51 -0500
Received: by mail-wm0-f47.google.com with SMTP id r126so68008921wmr.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2017 06:41:50 -0800 (PST)
In-Reply-To: <60596eee-12a9-58f3-387e-145a5bc28aaa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>, Arnd Bergmann <arnd@arndb.de>

[...]

>>
>> Marek, this is great work! It's been on my TODO list forever, so I
>> really appreciate your work here.
>>
>> I did only a brief review so far, particularly concentrating on the
>> changes for device links and runtime PM. I like it!
>>
>> Perhaps we can get someone like Arnd/Vinod to comment in general idea
>> from a DT and DMA slave channel point of view. I don't know that stuff
>> good enough to give good opinion.
>
>
> Arnd already said that it looks good:
> http://www.spinics.net/lists/dmaengine/msg12186.html

Great! Clearly, I haven't fully catched up since the holidays. :-)

>
>> A couple of things that crosses my mind so far:
>> 1) I have planned to extend pm_runtime_force_suspend|resume() to cover
>> also device links. Seems like that becomes really useful together with
>> these changes.
>
>
> Is is really needed? I thought that this case is already handled by device
> core. It works perfectly fine for Exynos IOMMU and its client devices for
> suspend/resume too, which rely on pm_runtime_force_suspend|resume().

Only parent devices are being considered in
pm_runtime_force_suspend|resume(). Meaning that the runtime PM usage
count will not be updated for a device's link, even if it should.

I guess what happens is that the pl330 controller will be brought up
to full power during system resume, even if it isn't necessary to do
so. If that's the case, it's not the end of the world, we can optimize
it later on.

Note, this is very theoretical and to be sure, I need to run some
tests and think more about it.

>
>> 2) I think there will be some corner cases during system
>> suspend/resume for pl330. Not sure yet though. However, fixing 1) and
>> converting the driver to use pm_runtime_force_suspend|resume() should
>> probably work anyway.
>
>
> Do you have any particular case in mind? Device links ensures that pl330
> will
> suspended after its slave devices and waken before them. Is there anything
> more needed here?

Likely we can consider them as optimizations. See comment above.

>
>> Allow me to help out looking into 1) and 2). If not for pl330, I am
>> pretty sure it will be useful for other DMA controllers that
>> implements device links and runtime PM.
>
>
> I'm open for suggestions.
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Kind regards
Uffe
