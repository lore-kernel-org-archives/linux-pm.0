From: Tim Bird <tim.bird@sonymobile.com>
Subject: Re: [Device-mainlining] [PATCH v2 2/3] gadget: Introduce the usb
 charger framework
Date: Mon, 17 Aug 2015 08:25:19 -0700
Message-ID: <55D1FCDF.6060709@sonymobile.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>	<0c41e21239f69c4e1aa89aba020c91edfc17c4e8.1439519413.git.baolin.wang@linaro.org>	<20150814152723.GA17892@kroah.com> <CAMz4kuL=6mGjNHcKHA9RYbabYqn3Lgu=rK6s8WkH5YGeV1T2+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:4169 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752081AbbHQPZ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 11:25:27 -0400
In-Reply-To: <CAMz4kuL=6mGjNHcKHA9RYbabYqn3Lgu=rK6s8WkH5YGeV1T2+w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "sojka@merica.cz" <sojka@merica.cz>, Felipe Balbi <balbi@ti.com>, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Chen <peter.chen@freescale.com>, "sre@kernel.org" <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>



On 08/16/2015 08:03 PM, Baolin Wang via device-mainlining wrote:
> On 14 August 2015 at 23:27, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Fri, Aug 14, 2015 at 05:47:45PM +0800, Baolin Wang wrote:
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>
>> I have to ask, do you really mean "any later version"?
>>
> 
> I think I did not get your point, could you explain it detailedly?

The full kernel is licensed under v2 of the GPL only, not "any later version".
See the second paragraph at the top of the COPYING file in the root directory
of the kernel source tree. There are differences on individual files, but
having this file allow "any later version" makes it different from much of
rest of the kernel.

Unless you have a specific reason to allow greater-than-V2 GPL licensing on this
file, you should change the licensing clause.  The following wording appears
to be pretty popular:

* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License version 2 as
* published by the Free Software Foundation.

  -- Tim
