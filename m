From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/3] power: supply: bq24735-charger: allow chargers to
 share the ac-detect gpio
Date: Fri, 30 Dec 2016 08:49:31 +0100
Message-ID: <CACRpkda+7XLBMo11vB_V030or3b+-LRufrziVVgct4Gr_2E+KQ@mail.gmail.com>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
 <1481673405-4547-4-git-send-email-peda@axentia.se> <20161214165921.jsatcznbljd7anqi@earth>
 <20161214170114.ckozfple475kqajh@earth> <e1667d9d-17bf-2fe5-8a65-af73b6507cbd@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:32949 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbcL3Htc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 02:49:32 -0500
Received: by mail-qt0-f180.google.com with SMTP id p16so386928818qta.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2016 23:49:32 -0800 (PST)
In-Reply-To: <e1667d9d-17bf-2fe5-8a65-af73b6507cbd@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Sebastian Reichel <sre@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Wed, Dec 14, 2016 at 6:41 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2016-12-14 18:01, Sebastian Reichel wrote:
>> [of course I forgot to actually add gpio people, let's try again]
>>
>> On Wed, Dec 14, 2016 at 05:59:21PM +0100, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> On Wed, Dec 14, 2016 at 12:56:45AM +0100, Peter Rosin wrote:
>>>> If several parallel bq24735 chargers have their ac-detect gpios wired
>>>> together (or if only one of the parallel bq24735 chargers have its
>>>> ac-detect pin wired to a gpio, and the others are assumed to react the
>>>> same), then all driver instances need to check the same gpio. But the
>>>> gpio subsystem does not allow sharing gpios, so handle that locally.
>>>
>>> Adding GPIO subsystem people to see if they can come up with
>>> something in the gpiod API for this usecase.
>
> Right, I don't like how my new code steps away from gpio descriptors.

The issue of shared gpiods have come up over and over again.
For example the messy regulator code needs this too.

It is better if we implement something like gpiod_get_shared()
in the gpiolib of these cases.

Just put a refcount in struct gpio_desc in drivers/gpio/gpiolib.h
for this case I guess?

Yours,
Linus Walleij
