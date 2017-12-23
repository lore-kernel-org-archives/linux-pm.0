From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Sat, 23 Dec 2017 13:50:23 +0100
Message-ID: <CAJZ5v0jp-kmuQGnxc-v9QsFxoCRwULhVDeSjHmCGh93wdRPcDA@mail.gmail.com>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0hctW_-WR2Gy4tszeXYJJfTRQbLCr_NRhAXao5_XR5NOw@mail.gmail.com>
 <CAPDyKFqa5Lt6jrDQd+V_cE+Bz2ZRJRe95-8bbJgV=LbkGPM0mw@mail.gmail.com>
 <1742152.iLm4rp6jIy@aspire.rjw.lan> <CAPDyKFpO7_GxjcANYPUO3aEp2uTrnioQ3=hsWSzPg_nDM3Sh-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpO7_GxjcANYPUO3aEp2uTrnioQ3=hsWSzPg_nDM3Sh-w@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 23, 2017 at 1:03 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 22 December 2017 at 20:12, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, December 21, 2017 11:13:57 AM CET Ulf Hansson wrote:
>>> On 21 December 2017 at 02:43, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> > On Fri, Dec 15, 2017 at 4:56 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> >> The PM core in the device_prepare() phase, resets the wakeup_path status
>>> >> flag to the value of device_may_wakeup(). This means if a ->prepare() or a
>>> >> ->suspend() callback for the device would update the device's wakeup
>>> >> setting, this doesn't become reflected in the wakeup_path status flag.
>>> >>
>>> >> In general this isn't a problem, because wakeup settings isn't supposed to
>>> >> be changed during those system suspend phases. Nevertheless, there are a
>>> >> cases not conforming to that behaviour, as device_set_wakeup_enable() is
>>> >> indeed called from ->suspend() callbacks.
>>> >
>>> > And why is this regarded as correct?
>>>
>>> I am not saying that this behavior is correct. However, I am trying to
>>> improve the situation, which doesn't hurt or does it?
>>
>> Adding a workaround for them kind of encourages new code to do the same
>> thing, which actually may really hurt.  So I assume that these call sites are
>> all legacy and that's why you don't want to touch them for now, but in that
>> case the commit message should make it very clear that this is about legacy
>> only and new code should not call device_set_wakeup_enable() during suspend.
>
> Yeah, makes sense. Let me clarify that!
>
>>
>> [Something should be printed to the log if wakeup source objects
>> are created while system suspend is in progress I guess or similar.]
>
> Yes, good idea. Let me cook a patch for that as well.
>
>>
>>> More importantly, the next patch, which is about the wakeup path,
>>> depends on this.
>>
>> Honestly, this sounds like "We have this change we really really would like to
>> make, but there's incorrect code getting in the way, so let's paper over it
>> and be done."  Not very nice. :-/
>
> Yeah it sounds a bit weird, I agree.
>
> However, maybe if I update the changelog and fold in a patch printing
> an error in case the APIs is being abused, that would sort out the
> confusion?

That should be sufficient IMO.

> Another option is simply to squash patch 1 and patch2, what do you prefer?
>
>>
>> How many drivers actually do call device_set_wakeup_enable() during suspend?
>
> There are some ethernet/wifi drivers, although it hard to say how many
> without a more thorough investigation.
>
> Besides those I found these more obvious ones:
> drivers/ssb/pcihost_wrapper.c
> drivers/staging/rtlwifi/core.c
> drivers/tty/serial/atmel_serial.c
> drivers/usb/core/hcd-pci.c

Ugh.  I need to look at the last one at least ...

Thanks,
Rafael
