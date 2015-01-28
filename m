From: Tobias Jakobi <liquid.acid-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-exynos: add support for
 controlling emmc reset pin
Date: Wed, 28 Jan 2015 16:23:50 +0100
Message-ID: <54C8FF06.4000308@gmx.net>
References: <1422346289-9348-1-git-send-email-m.szyprowski@samsung.com>	<1422346289-9348-2-git-send-email-m.szyprowski@samsung.com>	<54C74C33.5050305@samsung.com>	<54C8D8E3.9060609@gmx.net> <CAPDyKFr9fQ5ny=Foi4x_-wEQA9K0wRqqEfLxmxtBn5tmPwS-Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFr9fQ5ny=Foi4x_-wEQA9K0wRqqEfLxmxtBn5tmPwS-Nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Ulf Hansson wrote:
> On 28 January 2015 at 13:41, Tobias Jakobi <liquid.acid-hi6Y0CQ0nG0@public.gmane.org> wrote:
>> Hello!
>>
>> Jaehoon Chung wrote:
>>> mmc core supported to hw_reset function.
>>> So i think we can use it. It's called at only initial time to clear the previous status.
>>> But i think it can be called at reboot time. (it needs to implement codes.)
>>> how about?
>> I don't think that's going the work. The problem here is that depending
>> on the board configuration, the eMMC might carry the bootloader. If the
>> eMMC subsystem is not properly reset _during_ reboot, the board won't
>> even start since no bootloader is found. So we don't even reach the
>> point where the kernel does anything.
> 
> I guess it depends on what's being done during the reboot sequence.
> 
> The most proper thing would be to let the boot loader control the GPIO
> to trigger the HW reset, but that would mean the boot loader need to
> know about board specific configurations, such as which GPIO pin. So
> maybe SOC vendors need to state what GPIO pin to use and don't leave
> that as a configurable option.
Not the bootloader, but the iROM code would have to do this, and as far
as I know the iROM can't be modified. Or am I missing something here?


With best wishes,
Tobias

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
