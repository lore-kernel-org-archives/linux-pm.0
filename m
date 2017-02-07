From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / Domains: Keep the pd status during system PM phases
Date: Tue, 7 Feb 2017 09:19:09 +0100
Message-ID: <CAPDyKFojbX1uiS00EsyxxkM5uLUbHkbu3xAN4R5=PKo4iFOcCA@mail.gmail.com>
References: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com>
 <CAPDyKFp0GrSQYftSk1UHUSL=+OR_BGf4OVxJDVht-eXnTX8CtQ@mail.gmail.com>
 <58842848.5090806@rock-chips.com> <CAPDyKFpHttGjKGJi5_TbaD0uepMRC8+NSUqAa5Pmg5j61PT4-Q@mail.gmail.com>
 <5896F1A5.9080405@rock-chips.com> <CAPDyKFpXXL+zpGZCYSEqtJ6_1=tH+FCths7HuuO5OdRcALoRRA@mail.gmail.com>
 <589925B7.4020009@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37391 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbdBGITL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 03:19:11 -0500
Received: by mail-wm0-f54.google.com with SMTP id v77so143447593wmv.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2017 00:19:10 -0800 (PST)
In-Reply-To: <589925B7.4020009@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: Feng Xiao <xf@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, xxx@rock-chips.com, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

[...]

>>
>>
>> Unfortunate, I am still not fully understanding the scenarios. As you
>> indicate, the problem seems related to wakeup settings.
>>
>> Could you please try to answer the below questions, hopefully it helps
>> me to better understand.
>>
>> 1)
>> While starting the system suspend sequence, under what circumstances
>> are you expecting the vdd_gpu and pd_gpu to be powered on?
>>
>
> I don't want to power on the vdd_gpu and pd_gpu during the system suspend
> sequence.
> I hope the pd_gpu and vdd_gpu power on/off just by gpu device.

Let me rephrase my question.

Can the vdd_gpu/pd_gpu ever remain in a powered on state while the
system is suspended?

If yes, when is that the case?

>
>> 2)
>> While starting the system suspend sequence, under what circumstances
>> are you expecting the vdd_gpu and the pd_gpu to be powered off?
>>
>
> I don't want to power off the vdd_gpu and pd_gpu during the system suspend
> sequence.
> Because before the system suspend,the vdd_gpu and pd_gpu has been power off
> by gpu device(pm_ruantime_put).

*Exactly*, how do you guarantee that a pm_runtime_put() for the gpu
device triggers a runtime suspend - before a system suspend sequence
starts?

For example, userspace may via sysfs prevent runtime suspend for any
device with runtime PM enabled.

>
>> 3)
>> What devices are attached to vdd_gpu?
>>
> just pd_gpu
>>
>> 4)
>> What devices are attached to pd_gpu?
>>
> just gpu device(mali driver)
>
> vdd_gpu
> ------- pd_gpu
> ----------------devices/platform/ff9a0000.gpu
>>
>>

Thanks for these details, very useful!

[...]

Kind regards
Uffe
