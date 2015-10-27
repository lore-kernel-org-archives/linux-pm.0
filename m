From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] Re: where in sysfs should I put the ability to power
 down a board for a specific time?
Date: Tue, 27 Oct 2015 16:29:58 +0100
Message-ID: <20151027152958.GE22331@piout.net>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
 <20151020212127.GA25882@earth>
 <20151024021211.GA8105@piout.net>
 <CAJ+vNU1vH2kr5snXiO2dCLcw=DViNLBtwxqsiAM4-xpMhu9w0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39527 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932274AbbJ0PaB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 11:30:01 -0400
Content-Disposition: inline
In-Reply-To: <CAJ+vNU1vH2kr5snXiO2dCLcw=DViNLBtwxqsiAM4-xpMhu9w0w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com

Hi,

On 27/10/2015 at 07:55:28 -0700, Tim Harvey wrote :
> The power-off process is a discrete step from setting the wakeup time.
> By 'poweroff controller' I'm assuming you mean implement a
> pm_power_off hook which makes sense.
> 
> While I'm at it it seems like implementing arm_pm_restart makes a lot
> of sense as well as the device can toggle board power which should be
> preferred over a chip-level reset.
> 

Sure, then you can probably make an MFD which is the proper way of
register one device in multiple susbsytems. I just happened to give a
talk on that topic:

http://free-electrons.com/pub/conferences/2015/elce/belloni-mfd-regmap-syscon/belloni-mfd-regmap-syscon.pdf

> I was looking for a standard userspace sysfs API in (ie
> /sys/class/power?) that will call kernel_restart or kernel_power_off
> but the only thing I've found is either the reboot syscall or sysrq (o
> or b). Have I missed something or are these the expected userspace
> API's for power-off/reset?

Yeah, I'm guessing this is the correct API, people usually use
halt/poweroff/shutdown/reboot which should all end up calling the reboot
system call.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
