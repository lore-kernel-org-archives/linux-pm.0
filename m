From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 1/2] power: reset: Add generic SYSCON register mapped poweroff.
Date: Wed, 11 Mar 2015 15:00:17 -0700
Message-ID: <CAAtXAHetS9354mN5LAneMBk07U23hq2eZfqOxoXapG384=+EzQ@mail.gmail.com>
References: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
	<1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
	<1426066272.4244.37.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:39483 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbCKWAT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 18:00:19 -0400
Received: by wghn12 with SMTP id n12so12337105wgh.6
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2015 15:00:17 -0700 (PDT)
In-Reply-To: <1426066272.4244.37.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Paul,

thanks for your feedback. While developing this I looked at other drivers in
the tree and many of your comments would apply to them, too?

On Wed, Mar 11, 2015 at 2:31 AM, Paul Bolle <pebolle@tiscali

>> +config POWER_RESET_SYSCON_POWEROFF
>> +     bool "Generic SYSCON regmap poweroff driver"
>
> This adds a bool symbol.

Is that an issue or is it just to substantiate the rest of your comments below?

>> +obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
>
> So this objectfile can never be part of a module.

Same comment would apply for power/reset/qnap-poweroff.c, right?

>> +#include <linux/module.h>
>
> Is that include needed?

Wouldn't that be needed if MODULE_DEVICE_TABLE etc, is used?


>> +MODULE_DEVICE_TABLE(of, syscon_poweroff_of_match);
>
> This will be preprocessed away.

In my experiments it didn't work without this, are you sure it's not needed?
>
>> +module_platform_driver(syscon_poweroff_driver);
>
> I think the built-in equivalent of this would be adding a wrapper that
> only does
>     platform_driver_register(&syscon_poweroff_driver);

I couldn't find other examples in the tree doing this. Any pointers?

>> +MODULE_LICENSE("GPL v2");
>
> You probably meant
>     MODULE_LICENSE("GPL");

Sorry about that. Will fix.
>
>> +MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
>> +MODULE_DESCRIPTION("Generic SYSCON poweroff driver");
>> +MODULE_ALIAS("platform:syscon-poweroff");
>
> But these four macros will all be effectively preprocessed away, anyhow.

I'll remove them.

Thanks,

Moritz
