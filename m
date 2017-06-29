From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH fixes v3] pinctrl: Really force states during suspend/resume
Date: Thu, 29 Jun 2017 11:17:46 +0200
Message-ID: <CACRpkdbGza+vYTSqBRPbUGGnUsuNQS-6oKkweSch5Pwpku=CEg@mail.gmail.com>
References: <20170301183257.6554-1-f.fainelli@gmail.com> <CAHp75VdWVq3E3qrgtvvJK=A4yxK+yM_q3ZJd1hNnFBTj-H4Mxw@mail.gmail.com>
 <304fb86d-0862-992b-4563-61151b37d060@gmail.com> <CACRpkdb-_oTuRyGWtH9Rb2g2w_J9VM=m3mXK94OYbCXy+E0XLw@mail.gmail.com>
 <18ca4418-8b62-a1c9-1282-0c468f2aefb2@gmail.com> <CACRpkdZBrYT=vXhR77W+v_hN=t6zYACVPm5HR==kC7nmDYJLQA@mail.gmail.com>
 <5e61618b-cfb0-ddff-3d87-bf512521e669@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5e61618b-cfb0-ddff-3d87-bf512521e669@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, Al Cooper <alcooperx@gmail.com>, "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Sorry for slowness...

On Wed, Jun 21, 2017 at 11:23 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 03/16/2017 07:08 AM, Linus Walleij wrote:

>> I guess then it is better to assume we will loose the state, or
>> push for more granular handling of S2/3 etc states in the
>> PM core (I guess these states comes from ACPI or similar).
>
> I expected to see pm_message_t reflect which state we were entering into
> (PM_SUSPEND_STANDBY vs. PM_SUSPEND_MEM), but that is not the case.

Can we fix it?

>> Alternatively develop the PM core. Is it really impossible for
>> PM hooks to know which state it went into/came from?
>
> I don't think I liked Rafael's suggestion of putting that kind of detail
> into the platform_suspend_ops routine as he seems to suggest here:
>
> https://www.spinics.net/lists/arm-kernel/msg587311.html

He is suggesting:

> The cleanest way would be to run that code from one of the platform
> suspend hooks that receive information on what sleep state is to be
> entered.

But what I suggest is more the inverse: that it receive information
on what state it is coming from, rather than which state it is
going to.

But I guess it would be logical that suspend() get to know what state
it is going to and resume() get to know which state it is coming from.

So Rafael seem to be aligned with that idea.

> and here is my response:
>
> https://www.spinics.net/lists/arm-kernel/msg589844.html

So if it is not desireable to have every driver know which exact
state it came from like S3 this or S2 that and on this laptop
we have S2' which is slightly different and such mess (that you
predict IIUC) what we really need to know is pretty simple:
did the hardware loose its state or not?

That is the information we want the PM core to provide to
the resume() callback, somehow. A simple bool is fine.

Any platform specifics or simplifications pertaining to certain
states and whether S5 or S7 looses the context should not
be the concern of a driver, what it wants to know is simply
whether its device has been powered off and lost its hardware
context.

Yours,
Linus Walleij
