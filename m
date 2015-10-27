From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [rtc-linux] Re: where in sysfs should I put the ability to power
 down a board for a specific time?
Date: Tue, 27 Oct 2015 07:55:28 -0700
Message-ID: <CAJ+vNU1vH2kr5snXiO2dCLcw=DViNLBtwxqsiAM4-xpMhu9w0w@mail.gmail.com>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
	<20151020212127.GA25882@earth>
	<20151024021211.GA8105@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35628 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932557AbbJ0Oz3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 10:55:29 -0400
Received: by obctp1 with SMTP id tp1so144919141obc.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 07:55:28 -0700 (PDT)
In-Reply-To: <20151024021211.GA8105@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pm@vger.kernel.org, rtc-linux@googlegroups.com

On Fri, Oct 23, 2015 at 7:12 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 20/10/2015 at 23:21:27 +0200, Sebastian Reichel wrote :
>> Hi,
>>
>> On Tue, Oct 20, 2015 at 08:12:09AM -0700, Tim Harvey wrote:
>> > There is a system controller [1] on a set of embedded boards I support
>> > that allows disabling the board's primary power supply. It can disable
>> > it (until a physical pushbutton event occurs) and/or disable it for a
>> > certain number of seconds (up to 2^16 seconds).
>> >
>> > I've been in the process of writing a mfd driver to fully support this
>> > device and I'm a bit stumped on how to handle the power management
>> > capabilities.
>> >
>> > What is the correct API for this type of device in sysfs? I'm thinking
>> > it needs a power-supply class driver, but after looking over the docs
>> > and code I'm not seeing examples of similar devices. Can anyone point
>> > me to an example or provide some suggestions?
>>
>> Usually this is an RTC feature exposed as wakealarm. See for example
>> this article for the description of the userspace interface:
>>
>> https://www.linux.com/learn/docs/672849-wake-up-linux-with-an-rtc-alarm-clock

Sebastian,

Thanks for the pointer - this device does have an RTC so the wakealarm
makes complete sense here.

>
> Indeed, if you can set the time, then shutdown in two discreet steps,
> then you can probably expose an alarm and a poweroff controller.
> If there is only one step involved, then this will not fit well in any
> subsystem but I guess it makes more sense to put it in the RTC
> subsystem as it has all the utilities to handle dates and times.
>
>

Alexandre,

The power-off process is a discrete step from setting the wakeup time.
By 'poweroff controller' I'm assuming you mean implement a
pm_power_off hook which makes sense.

While I'm at it it seems like implementing arm_pm_restart makes a lot
of sense as well as the device can toggle board power which should be
preferred over a chip-level reset.

I was looking for a standard userspace sysfs API in (ie
/sys/class/power?) that will call kernel_restart or kernel_power_off
but the only thing I've found is either the reboot syscall or sysrq (o
or b). Have I missed something or are these the expected userspace
API's for power-off/reset?

Thanks!

Tim
