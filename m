From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Date: Fri, 16 Feb 2018 10:14:53 +0100
Message-ID: <CAJZ5v0gRtkBf7uu4C_k7ivNGo=JM0bB1PAdr_6Nbbs39OPevHw@mail.gmail.com>
References: <20180209161456.18951-1-tony@atomide.com> <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34850 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757693AbeBPJOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Feb 2018 04:14:54 -0500
In-Reply-To: <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Feb 14, 2018 at 12:23 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 9, 2018 at 6:14 PM, Tony Lindgren <tony@atomide.com> wrote:
>> This makes it easy to grep :wakeup /proc/interrupts.
>
> I used to have another patch (not published) to provide this
> information via /sys/kernel/irq.
>
> OK, here we are:
>
>
>> +       namelen = strlen(dev_name(dev)) + strlen(postfix) + 1;
>> +       wirq->name = kzalloc(namelen, GFP_KERNEL);
>
> kasprintf()

It's a bit hard to comment patches sent as attachments, but I'll try anyway. :-)

IMO it is somewhat excessive to put the entire sprintf() under a raw
spinlock and it's not even necessary.

The value can change any time after you've dropped the lock and in
particular before the function returns, so why bother with locking?
desc will not go away from under you at that point anyway.
