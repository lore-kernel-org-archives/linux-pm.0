From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 0/3] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 17 Aug 2015 14:02:08 +0800
Message-ID: <CAMz4kuJGR1ZQPbBNpp7EABJn=Rag8jSrb-2ztcefUf4R7pk4AQ@mail.gmail.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
	<20150814085527.GA17920@shlinux2>
	<CAMz4kuK7f=rGOO-YdB0AB8PzpTbnWZtasuQK8gOXLuM9zyn3gw@mail.gmail.com>
	<20150817011541.GA7122@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150817011541.GA7122@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Jun <b47624@freescale.com>
Cc: Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@freescale.com>, sojka@merica.cz, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, sameo@linux.intel.com, Lee Jones <lee.jones@linaro.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17 August 2015 at 09:15, Li Jun <b47624@freescale.com> wrote:
> On Fri, Aug 14, 2015 at 07:04:56PM +0800, Baolin Wang wrote:
>> On 14 August 2015 at 16:55, Li Jun <b47624@freescale.com> wrote:
>> > Hi Baolin,
>> >
>> > On Fri, Aug 14, 2015 at 05:47:43PM +0800, Baolin Wang wrote:
>> >> Currently the Linux kernel does not provide any standard integration of this
>> >> feature that integrates the USB subsystem with the system power regulation
>> >> provided by PMICs meaning that either vendors must add this in their kernels
>> >> or USB gadget devices based on Linux (such as mobile phones) may not behave
>> >> as they should.
>> >>
>> >> Providing a standard framework for doing this in the kernel.
>> >>
>> >
>> > Why not add power supply class support into this?
>> >
>>
>> Hi Jun,
>>
>> We don't need the power supply class support into the usb charger,
> I suppose usb charger is also a power supply for the system, we can use power
> supply class framework for notify mechanism and get/set many attributes(maybe
> also the current limit), I see those usb charger drivers under ./driver/power/
> are designed with power supply supported.
>

I don't think so. The usb charger is rely on the usb gadget, which is
not a complete power supply device and it combines the usb and the
power supply. Thus we make it into usb gadget system. Thanks.

> Li Jun
>> just introduce the notify mechanism for power to set the current limit
>> when notifying some events from usb charger. Maybe I misunderstand
>> your meanings, please describe it detailedly. Thanks for your
>> comments.
>>
>> > Li Jun
>> >
>>
>>
>>
>> --
>> Baolin.wang
>> Best Regards



-- 
Baolin.wang
Best Regards
