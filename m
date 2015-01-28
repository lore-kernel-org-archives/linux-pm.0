From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-exynos: add support for controlling emmc
 reset pin
Date: Wed, 28 Jan 2015 16:40:54 +0100
Message-ID: <CAPDyKFphCPAroG3EEVWHziCRR+t7xEi4UXzWE0LZDRu981xfbw@mail.gmail.com>
References: <1422346289-9348-1-git-send-email-m.szyprowski@samsung.com>
	<1422346289-9348-2-git-send-email-m.szyprowski@samsung.com>
	<54C74C33.5050305@samsung.com>
	<54C8D8E3.9060609@gmx.net>
	<CAPDyKFr9fQ5ny=Foi4x_-wEQA9K0wRqqEfLxmxtBn5tmPwS-Nw@mail.gmail.com>
	<54C8FF06.4000308@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54C8FF06.4000308@gmx.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <liquid.acid@gmx.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 28 January 2015 at 16:23, Tobias Jakobi <liquid.acid@gmx.net> wrote:
> Ulf Hansson wrote:
>> On 28 January 2015 at 13:41, Tobias Jakobi <liquid.acid@gmx.net> wrote:
>>> Hello!
>>>
>>> Jaehoon Chung wrote:
>>>> mmc core supported to hw_reset function.
>>>> So i think we can use it. It's called at only initial time to clear the previous status.
>>>> But i think it can be called at reboot time. (it needs to implement codes.)
>>>> how about?
>>> I don't think that's going the work. The problem here is that depending
>>> on the board configuration, the eMMC might carry the bootloader. If the
>>> eMMC subsystem is not properly reset _during_ reboot, the board won't
>>> even start since no bootloader is found. So we don't even reach the
>>> point where the kernel does anything.
>>
>> I guess it depends on what's being done during the reboot sequence.
>>
>> The most proper thing would be to let the boot loader control the GPIO
>> to trigger the HW reset, but that would mean the boot loader need to
>> know about board specific configurations, such as which GPIO pin. So
>> maybe SOC vendors need to state what GPIO pin to use and don't leave
>> that as a configurable option.
> Not the bootloader, but the iROM code would have to do this, and as far
> as I know the iROM can't be modified. Or am I missing something here?

You are right! The "bootloader" can very likely be stored in ROM code.
That's why I also said the GPIO shouldn't be configurable. :-)

Kind regards
Uffe
