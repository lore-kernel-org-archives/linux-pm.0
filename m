From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 13/16] power: supply: axp288_fuel_gauge: Rework get_status()
Date: Wed, 3 Jan 2018 10:37:12 +0800
Message-ID: <CAGb2v64hF8adL_mmNMzsx=oZdv3CJQJWb3dxFeQNY_zKgoXThg@mail.gmail.com>
References: <20171226125914.10235-1-hdegoede@redhat.com> <20171226125914.10235-13-hdegoede@redhat.com>
 <CAGb2v66=N1Xn4EWQCHw7M08jCZ95u_qdTekp-Oo+vrBSqLrJcw@mail.gmail.com> <0ebb134a-78a0-e855-e6ba-282b0fc94c21@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:52334 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeACChj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 21:37:39 -0500
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id E1A0520437
        for <linux-pm@vger.kernel.org>; Wed,  3 Jan 2018 10:37:35 +0800 (CST)
Received: by mail-wr0-f176.google.com with SMTP id o101so255276wrb.6
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 18:37:35 -0800 (PST)
In-Reply-To: <0ebb134a-78a0-e855-e6ba-282b0fc94c21@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On Wed, Jan 3, 2018 at 6:51 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 27-12-17 04:15, Chen-Yu Tsai wrote:
>>
>> On Tue, Dec 26, 2017 at 8:59 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Relying on the (dis)charge current reporting for reporting FULL back to
>>> userspace does not work really well and often leads to the reported
>>> status
>>> getting stuck at e.g. 98/99% (the fuelgauge is not perfect) for hours.
>>>
>>> What happens is that when the battery is full the axp288 keeps charging
>>> it
>>> with a very low current. Until it is really really full and once really
>>> really full, some inaccuracies in the adc lead to it then sometimes
>>> reporting a small discharging rate, even though an external pwr source is
>>> used. So we end up with a status of "charging" for hours after the
>>> battery
>>> is actually already full and sometimes this then flip-flops to
>>> discharging.
>>>
>>> This commit fixes this by first checking if a valid Vbus is present and
>>> if
>>> it is present using the fuel-gauge's reported percentage to check for a
>>> full battery.
>>>
>>> This commit also changes how get_status() determines if the battery is
>>> charging or discharging when not reporting it as full. We still use the
>>> current direction for this, but instead of reading 4 extra registers for
>>> this (2 16 bit regs), simplify things by using the current-direction bit
>>> in the power-status register, which already gets read anyways.
>>>
>>> This also reduces the amount of i2c reads to 1 when on battery and 2
>>> when a valid Vbus is present.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>>
>> This looks better. Thanks.
>>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>>
>> I do have one minor question though: What should the status be if there
>> was no battery connected?
>
>
> Good question, I would expect userspace to check the present attribute
> before
> checking the status, but in my experience with a couple of HDMI sticks (so
> no
> battery) sofar they get wired up in such a way that the AXP288 thinks there
> is
> a battery anyways. Which also makes it impossible for get_status() to do
> anything
> here.

In other words, userspace is responsible for correctly interpreting the
results.

Thanks
ChenYu
