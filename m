From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Date: Fri, 16 Feb 2018 11:54:07 +0100
Message-ID: <CAJZ5v0gowD179tVaAc_8Wy-pV=mAwsO1egs0DfCnA-eEWayJdw@mail.gmail.com>
References: <20180209161456.18951-1-tony@atomide.com> <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
 <CAJZ5v0gRtkBf7uu4C_k7ivNGo=JM0bB1PAdr_6Nbbs39OPevHw@mail.gmail.com> <CAHp75VcVNDV9FmPFTBHsJRoiHtOviwC68Wk+aCqhqteZw41ZzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcVNDV9FmPFTBHsJRoiHtOviwC68Wk+aCqhqteZw41ZzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 16, 2018 at 11:39 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 16, 2018 at 11:14 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Feb 14, 2018 at 12:23 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Fri, Feb 9, 2018 at 6:14 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>> This makes it easy to grep :wakeup /proc/interrupts.
>>>
>>> I used to have another patch (not published) to provide this
>>> information via /sys/kernel/irq.
>>>
>>> OK, here we are:
>
>> It's a bit hard to comment patches sent as attachments, but I'll try anyway. :-)
>
> Sorry, I was thinking that Tony may test it first to see if it does
> what he wants.
> Of course I would send normally in case it's an expected approach.
>
>> IMO it is somewhat excessive to put the entire sprintf() under a raw
>> spinlock and it's not even necessary.
>
> It's a copy'n'paste of from the rest of functions there.

Fair enough. :-)

>> The value can change any time after you've dropped the lock and in
>> particular before the function returns, so why bother with locking?
>> desc will not go away from under you at that point anyway.
>
> IIRC descriptor's content might be changed, or descriptor itself might
> be gone (potential crash).

No, desc cannot go away at this point AFAICS due to the kernfs
refcounting.  And the lock is *inside* of the desc object anyway, so
it doesn't help really against that.

The contents may change, but so what?

Effectively, you read an int and reading an int is atomic.  It may
change after that, but the lock doesn't prevent it from changing.  It
only prevents the change from being applied to it before you drop the
lock, but why do you care?
