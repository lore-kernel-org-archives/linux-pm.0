From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 2/3] gadget: Introduce the usb charger framework
Date: Tue, 18 Aug 2015 09:44:58 +0800
Message-ID: <CAMz4kuJCDXLtPs5_9C9Zp-oq54-Yt2CGte58vU_ZEGK-naW3Fg@mail.gmail.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
	<0c41e21239f69c4e1aa89aba020c91edfc17c4e8.1439519413.git.baolin.wang@linaro.org>
	<20150814152723.GA17892@kroah.com>
	<CAMz4kuL=6mGjNHcKHA9RYbabYqn3Lgu=rK6s8WkH5YGeV1T2+w@mail.gmail.com>
	<20150817172416.GN10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150817172416.GN10748@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Peter Chen <peter.chen@freescale.com>, sojka@merica.cz, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, sameo@linux.intel.com, Lee Jones <lee.jones@linaro.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 18 August 2015 at 01:24, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 17, 2015 at 11:03:26AM +0800, Baolin Wang wrote:
>> On 14 August 2015 at 23:27, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Fri, Aug 14, 2015 at 05:47:45PM +0800, Baolin Wang wrote:
>
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License as published by
>> >> + * the Free Software Foundation; either version 2 of the License, or
>> >> + * (at your option) any later version.
>
>> > I have to ask, do you really mean "any later version"?
>
>> I think I did not get your point, could you explain it detailedly?
>
> Unlike a lot of userspace projects the kernel is normally just licensed
> under GPLv2 without the option to relicense with a later version so the
> "...or any later version" is a bit unusual.  There is some controversy
> about some of the changes in GPLv3.

Make sense. Thanks a lot.


-- 
Baolin.wang
Best Regards
