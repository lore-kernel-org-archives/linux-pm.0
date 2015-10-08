From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Device-mainlining] [PATCH v2 2/3] gadget: Introduce the usb
 charger framework
Date: Thu, 8 Oct 2015 17:50:31 +0200
Message-ID: <20151008155031.GE11776@xo-6d-61-c0.localdomain>
References: <cover.1439519412.git.baolin.wang@linaro.org>
 <0c41e21239f69c4e1aa89aba020c91edfc17c4e8.1439519413.git.baolin.wang@linaro.org>
 <20150814152723.GA17892@kroah.com>
 <CAMz4kuL=6mGjNHcKHA9RYbabYqn3Lgu=rK6s8WkH5YGeV1T2+w@mail.gmail.com>
 <55D1FCDF.6060709@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D1FCDF.6060709@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "sojka@merica.cz" <sojka@merica.cz>, Felipe Balbi <balbi@ti.com>, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Chen <peter.chen@freescale.com>, "sre@kernel.org" <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> On 08/16/2015 08:03 PM, Baolin Wang via device-mainlining wrote:
> > On 14 August 2015 at 23:27, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> On Fri, Aug 14, 2015 at 05:47:45PM +0800, Baolin Wang wrote:
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or modify
> >>> + * it under the terms of the GNU General Public License as published by
> >>> + * the Free Software Foundation; either version 2 of the License, or
> >>> + * (at your option) any later version.
> >>
> >> I have to ask, do you really mean "any later version"?
> >>
> > 
> > I think I did not get your point, could you explain it detailedly?
> 
> The full kernel is licensed under v2 of the GPL only, not "any later version".
> See the second paragraph at the top of the COPYING file in the root directory
> of the kernel source tree. There are differences on individual files, but
> having this file allow "any later version" makes it different from much of
> rest of the kernel.
> 
> Unless you have a specific reason to allow greater-than-V2 GPL licensing on this
> file, you should change the licensing clause.  The following wording appears
> to be pretty popular:
> 
> * This program is free software; you can redistribute it and/or modify
> * it under the terms of the GNU General Public License version 2 as
> * published by the Free Software Foundation.

Please, keep it V2 or later, if you can. It makes sharing code with U-Boot (for
example) easier.

There's long tradition of "V2 or later" code in the kernel.

Best regards,
									Pavel
