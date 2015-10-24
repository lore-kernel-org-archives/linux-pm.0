From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] Re: where in sysfs should I put the ability to power
 down a board for a specific time?
Date: Sat, 24 Oct 2015 04:12:11 +0200
Message-ID: <20151024021211.GA8105@piout.net>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
 <20151020212127.GA25882@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48689 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752671AbbJXCMN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2015 22:12:13 -0400
Content-Disposition: inline
In-Reply-To: <20151020212127.GA25882@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com

Hi,

On 20/10/2015 at 23:21:27 +0200, Sebastian Reichel wrote :
> Hi,
> 
> On Tue, Oct 20, 2015 at 08:12:09AM -0700, Tim Harvey wrote:
> > There is a system controller [1] on a set of embedded boards I support
> > that allows disabling the board's primary power supply. It can disable
> > it (until a physical pushbutton event occurs) and/or disable it for a
> > certain number of seconds (up to 2^16 seconds).
> > 
> > I've been in the process of writing a mfd driver to fully support this
> > device and I'm a bit stumped on how to handle the power management
> > capabilities.
> > 
> > What is the correct API for this type of device in sysfs? I'm thinking
> > it needs a power-supply class driver, but after looking over the docs
> > and code I'm not seeing examples of similar devices. Can anyone point
> > me to an example or provide some suggestions?
> 
> Usually this is an RTC feature exposed as wakealarm. See for example
> this article for the description of the userspace interface:
> 
> https://www.linux.com/learn/docs/672849-wake-up-linux-with-an-rtc-alarm-clock

Indeed, if you can set the time, then shutdown in two discreet steps,
then you can probably expose an alarm and a poweroff controller.
If there is only one step involved, then this will not fit well in any
subsystem but I guess it makes more sense to put it in the RTC
subsystem as it has all the utilities to handle dates and times.



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
