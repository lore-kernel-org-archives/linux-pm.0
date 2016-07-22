From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] i2c: nomadik: move runtime suspend of hw to _noirq
Date: Fri, 22 Jul 2016 16:20:55 +0200
Message-ID: <CACRpkdbgXrw4zR+Fbm7GMRzaqRqrM7muJ8NbUSkdX4PnB_Ew4w@mail.gmail.com>
References: <1464008356-21162-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFpvwQkqS9TRCj+JCOro-fdbkPKrXr6V7eEeSJLMah61Ng@mail.gmail.com>
 <CACRpkdbFvRKpzY82qWpt6CNLEe8GfgaSOJPaebaanOWbT7mC9Q@mail.gmail.com>
 <20160619171221.GD2933@tetsubishi> <20160714134014.GI4149@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36181 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbcGVOU5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 10:20:57 -0400
Received: by mail-oi0-f47.google.com with SMTP id w18so164659292oiw.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2016 07:20:57 -0700 (PDT)
In-Reply-To: <20160714134014.GI4149@tetsubishi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>

On Thu, Jul 14, 2016 at 3:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Sun, Jun 19, 2016 at 07:12:21PM +0200, Wolfram Sang wrote:
>>
>> > > This is indeed a generic problem, as we don't have a way to describe
>> > > these kind of dependences between devices. In other words, we need to
>> > > control the order of how devices becomes suspended/resumed. If that
>> > > could be done, we could likely avoid runtime resuming devices
>> > > unnecessarily.
>> >
>> > Correct, keep me in the loop and I can test some patches.
>>
>> So, this patch is discarded in favor of a generic solution?
>
> Yes?

I'm reading Ulf's comment here again:

> Moving the suspend operations to the *_noirq callbacks could improve
> the situation, but unfortunate it's comes with a limitation.
> That's because runtime PM has been disabled (by genpd or the PM core)
> before the *_late callbacks is invoked, which means the I2C device
> needs to be runtime resumed in an earlier phase to make it
> operational.

And I mean it means that in the .resume hook, i.e. this:

static int nmk_i2c_resume_noirq(struct device *dev)
{
        return pm_runtime_force_resume(dev);
}

The force call will have no effect in *_noirq() because the runtime
PM callbacks are turned off. The device will not be runtime resumed
by the _force_ call as it should, it will still be runtime suspended
when the device comes back up, and that makes it behave badly
unless it goes through another suspend/resume cycle befor it is
actually used. However we are saved by the fact that the driver
does not use autosuspend, so what happens after the force resume
is that the driver will just be runtime suspended again at late
since there are no users.

It will instead be properly resumed when the next I2C transaction
comes in.

It looks like this if I put prints in the runtime suspend/resume
calls:

[   28.863128] PM: early resume of devices complete after 0.854 msecs
[   28.866302] nmk-i2c 80128000.i2c: nmk_i2c_runtime_resume
[   29.132904] PM: resume of devices complete after 269.744 msecs
[   29.363861] Restarting tasks ...
[   29.373016] nmk-i2c 80128000.i2c: nmk_i2c_runtime_suspend
[   29.384124] done.

Then comes some real traffic (LED heartbeat):
[   29.391113] nmk-i2c 80128000.i2c: nmk_i2c_runtime_resume
[   29.396972] nmk-i2c 80128000.i2c: nmk_i2c_runtime_suspend
(...)

So I think the patch is fine.

Yours,
Linus Walleij
