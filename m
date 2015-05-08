From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Fri, 08 May 2015 09:09:28 +0200
Message-ID: <554C6128.9060701@collabora.com>
References: <1413881397.30379.7.camel@hadess.net> <26037972.gZDpmonflh@vostro.rjw.lan> <20150507175456.51376473@lxorguk.ukuu.org.uk> <1563819.JLKVYTDD3B@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:38782 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbEHHJd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 03:09:33 -0400
In-Reply-To: <1563819.JLKVYTDD3B@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Chirantan Ekbote <chirantan@chromium.org>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Linux PM list <linux-pm@vger.kernel.org>

On 05/07/2015 11:03 PM, Rafael J. Wysocki wrote:
> On Thursday, May 07, 2015 05:54:56 PM One Thousand Gnomes wrote:
>> On Tue, 05 May 2015 14:31:26 +0200
>>
>>> For example, when you wake up from S3 on ACPI-based systems, the best you
>>> can get is what devices have generated the wakeup events, but there's
>>> no input available from that (like you won't know which key has been
>>> pressed).  You may not get that even.  You may only know what GPEs have
>>> caused the wakeup to happen and they may be shared.
>>>
>>> For PCI wakeup, the wakeup event may be out of band.  You need to walk
>>> the hierarchy and check the PME status bits to identify the wakeup device
>>> and then you need to be careful enough not to reset it while putting into
>>> D0 for the input data associated with the event to be available.  I'm not
>>> sure how many device/driver combinations this actually works for.
>>>
>>> For USB wakeup, you get the wakeup event from the controller which may be
>>> a PCI device.  Getting to the USB device itself from there requires some
>>> work and even then the device may not "remember" what exactly happened.
>>>
>>> Further, if you wake up via the PC keyboard from suspend-to-idle, the
>>> wakeup key code is not available, the only thing you know is that the
>>> interrupts has occured (that may be changed, but it's how the current
>>> code works).
>>
>> It's probably got to change, otherwise once machines get able to sleep
>> between keypresses it's going to suck every time you pause and think for
>> a minute then begin typing. Remember display being off for suspend is
>> purely a limitation of most current display panels.
> 
> Right.
> 
> It is just one example, though.
> 
> Take a PCI device in D3hot for another one.  It may not even have a buffer
> to store input data while in that state.  The only thing it may be able to
> do is to signal a PME from it.

Yeah, I tried to make clear that I don't think that this is generally
achievable. But in the ChromeOS hardware that I have here, the input
event is there for userspace to read when it wakes up.

But if there's traction for adding upstream a more generic mechanism
that works in a broader range of machines, I'm all for it.

Regards,

Tomeu

