From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 13/16] power: supply: axp288_fuel_gauge: Rework
 get_status()
Date: Tue, 2 Jan 2018 23:51:08 +0100
Message-ID: <0ebb134a-78a0-e855-e6ba-282b0fc94c21@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
 <20171226125914.10235-13-hdegoede@redhat.com>
 <CAGb2v66=N1Xn4EWQCHw7M08jCZ95u_qdTekp-Oo+vrBSqLrJcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39117 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeABWvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 17:51:11 -0500
Received: by mail-wm0-f46.google.com with SMTP id i11so389811wmf.4
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 14:51:10 -0800 (PST)
In-Reply-To: <CAGb2v66=N1Xn4EWQCHw7M08jCZ95u_qdTekp-Oo+vrBSqLrJcw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Sebastian Reichel <sre@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

Hi,

On 27-12-17 04:15, Chen-Yu Tsai wrote:
> On Tue, Dec 26, 2017 at 8:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Relying on the (dis)charge current reporting for reporting FULL back to
>> userspace does not work really well and often leads to the reported status
>> getting stuck at e.g. 98/99% (the fuelgauge is not perfect) for hours.
>>
>> What happens is that when the battery is full the axp288 keeps charging it
>> with a very low current. Until it is really really full and once really
>> really full, some inaccuracies in the adc lead to it then sometimes
>> reporting a small discharging rate, even though an external pwr source is
>> used. So we end up with a status of "charging" for hours after the battery
>> is actually already full and sometimes this then flip-flops to discharging.
>>
>> This commit fixes this by first checking if a valid Vbus is present and if
>> it is present using the fuel-gauge's reported percentage to check for a
>> full battery.
>>
>> This commit also changes how get_status() determines if the battery is
>> charging or discharging when not reporting it as full. We still use the
>> current direction for this, but instead of reading 4 extra registers for
>> this (2 16 bit regs), simplify things by using the current-direction bit
>> in the power-status register, which already gets read anyways.
>>
>> This also reduces the amount of i2c reads to 1 when on battery and 2
>> when a valid Vbus is present.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This looks better. Thanks.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> I do have one minor question though: What should the status be if there
> was no battery connected?

Good question, I would expect userspace to check the present attribute before
checking the status, but in my experience with a couple of HDMI sticks (so no
battery) sofar they get wired up in such a way that the AXP288 thinks there is
a battery anyways. Which also makes it impossible for get_status() to do anything
here.

Regards,

Hans
