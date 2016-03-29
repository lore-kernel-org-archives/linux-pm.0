From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 29 Mar 2016 10:05:23 +0800
Message-ID: <CAMz4kuJxJbd8LOKNbduoGdQdByB0r0aU_2z9oAbsZB3RPPOjbg@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<20160328071351.GC3302@peterchendt>
	<CAMz4kuK33mfiO9OttbRF9yVbQE1DFeuOtwyUWkCa5iPYbE-H8g@mail.gmail.com>
	<HE1PR04MB145070EE7CAC373C00C539478B870@HE1PR04MB1450.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HE1PR04MB145070EE7CAC373C00C539478B870@HE1PR04MB1450.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29 March 2016 at 08:32, Peter Chen <peter.chen@nxp.com> wrote:
>
>>
>> On 28 March 2016 at 15:13, Peter Chen <hzpeterchen@gmail.com> wrote:
>> > On Mon, Mar 28, 2016 at 02:51:40PM +0800, Baolin Wang wrote:
>> >> On 25 March 2016 at 15:09, Peter Chen <hzpeterchen@gmail.com> wrote:
>> >> > On Thu, Mar 24, 2016 at 08:35:53PM +0800, Baolin Wang wrote:
>> >> >> Currently the Linux kernel does not provide any standard
>> >> >> integration of this feature that integrates the USB subsystem with
>> >> >> the system power regulation provided by PMICs meaning that either
>> >> >> vendors must add this in their kernels or USB gadget devices based
>> >> >> on Linux (such as mobile phones) may not behave as they should. Thus
>> provide a standard framework for doing this in kernel.
>> >> >>
>> >> >> Now introduce one user with wm831x_power to support and test the
>> >> >> usb charger, which is pending testing. Moreover there may be other
>> >> >> potential users will use it in future.
>> >> >>
>> >> >
>> >> > I am afraid I still not find the user (udc driver) for this
>> >> > framework, I would like to see how udc driver block the enumeration
>> >> > until the charger detection has finished, or am I missing something?
>> >>
>> >> It is not for udc driver but for power users who want to negotiate
>> >> with USB subsystem.
>> >>
>> >
>> > Then, where is the code the test user to decide what kinds of USB
>> > charger (SDP, CDP, DCP) is connecting now?
>>
>> Users can choose to implement multiple ways to get the charger type In
>> 'usb_charger_detect_type()' function.
>>
>> >
>
> Then, how you test your code? When we introduce an API, at least, there is one
> user for it.

At first I've tested the API on my board to make sure it can work
well, another hand we introduce one user 'wm831x_power' to support and
test the usb charger.

Yes, The user 'wm831x_power' did not implement any callbacks in
'usb_charger_detect_type()' function, but in
'usb_charger_detect_type()' function it just supplies different
callbacks to get the charger type with simple logic. Anyway we can try
to implement one callback to get the charger type and test the API.
Thanks.

>
> Peter



-- 
Baolin.wang
Best Regards
