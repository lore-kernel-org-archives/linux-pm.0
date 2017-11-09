From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] PM / core: Invent a WAKEUP_POWERED driver flag
Date: Thu, 9 Nov 2017 09:28:00 +0100
Message-ID: <CAPDyKFqeEZT631g=x_LTU+Dba=WAhM9YOHYfdsSYo+kJz7HtkQ@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org> <CAMuHMdUu6=zuCRBaON4K9ivG8bdV1xBuf4dCvPUr2JCL-=xC=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUu6=zuCRBaON4K9ivG8bdV1xBuf4dCvPUr2JCL-=xC=w@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 8 November 2017 at 16:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Wed, Nov 8, 2017 at 4:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The generic problem this series is trying to solve, is that for some bus types
>> and PM domains, it's not sufficient to only check the return value from
>> device_may_wakeup(), to fully understand how to treat the device during system
>> suspend.
>>
>> One particular case that suffers from this, is the generic PM domain (aka genpd)
>> and that is taken care of in the final change in this series.
>>
>> The special case this series address, is to enable drivers to instruct bus types
>> and PM domains, that the device need to stay powered in case wakeup signals
>> is enabled for it.
>
> Thanks for your patches!
> They look good to me, hence my Reviewed-by.

Hi Geert,

Thanks for reviewing, much appreciated!

>
>> Geert Uytterhoeven, has been working on some related problems for some Renesas
>> SoCs [1], to be able to properly configure WakeOnLAN, for some ethernet
>> devices/drivers, which are used together with genpd. My intent is that this
>> series enables a solution for those problems.
>>
>> [1]
>> https://www.spinics.net/lists/linux-renesas-soc/msg19319.html
>
> While your new WAKEUP_POWERED definitely serves a purpose, I don't think
> it's the right solution for the Renesas SoCs.  I can just set the recently
> added flag GENPD_FLAG_ACTIVE_WAKEUP in all Renesas clock/power domain
> drivers to fix the issue for all Renesas drivers.  After all, all devices in
> the clock/power domain must be kept enabled if they're a wakeup source, or
> part of the wakeup path.

Right, that would work! However, to me, I don't think it's fine grained enough.

Let's take the Ethernet device/driver using WoL as an example, similar
to your cases.

First, let's assume device_may_wakeup() returns true, meaning that the
Ethernet device is wakeup capable and that userspace has requested
wakeup to be enabled.

Then we have three scenarios to consider when the Ethernet driver
becomes suspended (typically when its ->suspend() callback gets
invoked).
1) The Ethernet interface is down.
2) The Ethernet interface is up, but no connection established.
3) The Ethernet interface is up, connection established.

By following your approach, using GENPD_FLAG_ACTIVE_WAKEUP, would mean
that we can't distinguish between any of the the scenarios above, but
instead always keep the Ethernet device powered on and thus the PM
domain also.

In the more fine grained solution, we can change the Ethernet driver
to consider under what scenario it's being suspended. For 1) and 2),
there is no need to keep the Ethernet device being powered, but
instead only enable WoL in 3) - via also using the WAKEUP_POWERED
flag.

>
> Not using GENPD_FLAG_ACTIVE_WAKEUP means I would have to add the
> WAKEUP_POWERED flag to every single driver that can either be a wakeup
> source itself, or be part of the wakeup path.

Right.

First, is that really that many? Second, nothing prevent us from doing
the migration of each driver in step by step.

Kind regards
Uffe
