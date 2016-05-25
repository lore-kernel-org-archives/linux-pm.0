From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] i2c: nomadik: move runtime suspend of hw to _noirq
Date: Wed, 25 May 2016 14:53:51 +0200
Message-ID: <CACRpkdbFvRKpzY82qWpt6CNLEe8GfgaSOJPaebaanOWbT7mC9Q@mail.gmail.com>
References: <1464008356-21162-1-git-send-email-linus.walleij@linaro.org>
	<CAPDyKFpvwQkqS9TRCj+JCOro-fdbkPKrXr6V7eEeSJLMah61Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33022 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcEYMxw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 08:53:52 -0400
Received: by mail-oi0-f46.google.com with SMTP id k23so76374882oih.0
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2016 05:53:52 -0700 (PDT)
In-Reply-To: <CAPDyKFpvwQkqS9TRCj+JCOro-fdbkPKrXr6V7eEeSJLMah61Ng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>

On Wed, May 25, 2016 at 12:09 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 May 2016 at 14:59, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The runtime suspend of the hardware (declocking and pin control
>> resting) needs to happen in the *_noirq callbacks after all
>> hardware interrupts are disabled and we know there will be no
>> more I2C traffic in the system.
>
> As you need this change, it means some other device requires the I2C
> device to be runtime resumed, while a *_late callback tries to suspend
> the other device. Right!?

Yep.

> Can you tell which these devices are?

Those I have seen colliding in suspend/resume cycles:
drivers/leds/leds-lp5521.c
drivers/iio/light/bh1780.c
(note that I have fixes pending for the bh1780 driver)

> Moving the suspend operations to the *_noirq callbacks could improve
> the situation, but unfortunate it's comes with a limitation.
> That's because runtime PM has been disabled (by genpd or the PM core)
> before the *_late callbacks is invoked, which means the I2C device
> needs to be runtime resumed in an earlier phase to make it
> operational.

Hm uncertain what you mean here, but happy to test.
The macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS makes
you think the hooks should be paired up and has this nice
symmetry, do you mean I should not do this but keep
the resume hook where SET_LATE_SYSTEM_SLEEP_PM_OPS()
puts it?

> This is indeed a generic problem, as we don't have a way to describe
> these kind of dependences between devices. In other words, we need to
> control the order of how devices becomes suspended/resumed. If that
> could be done, we could likely avoid runtime resuming devices
> unnecessarily.

Correct, keep me in the loop and I can test some patches.

Yours,
Linus Walleij
