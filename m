From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/3] PM / core: Add IN_BAND_WAKEUP driver flag
Date: Mon, 11 Dec 2017 21:59:31 +0100
Message-ID: <CAPDyKFoey_kSf0OE7OmHCX4H4VFQcWOU6NE4suZ9=9stZVQNpQ@mail.gmail.com>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
 <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org>
 <1926914.PsNMcYBlGW@aspire.rjw.lan> <CAMuHMdUE+fdbS+HDxbcWNHaTZubnrQ7ai4bkOsBpLriG1y-gZg@mail.gmail.com>
 <CAPDyKFoAY7yZJz9obke5DeqadpqJ0MEKPQJvxibpq85f+==BBA@mail.gmail.com> <CAMuHMdXk9GaExvYbdSfV0bf4Kh1TNrZDKtAfTDaDfWFMvk6Snw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:46384 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdLKU7c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 15:59:32 -0500
Received: by mail-it0-f46.google.com with SMTP id t1so19178574ite.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2017 12:59:32 -0800 (PST)
In-Reply-To: <CAMuHMdXk9GaExvYbdSfV0bf4Kh1TNrZDKtAfTDaDfWFMvk6Snw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 11 December 2017 at 11:48, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Mon, Dec 11, 2017 at 11:24 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 10 December 2017 at 11:16, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Sun, Dec 10, 2017 at 3:30 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Monday, November 13, 2017 4:46:42 PM CET Ulf Hansson wrote:
>>>>> For some bus types and PM domains, it's not sufficient to only check the
>>>>> return value from device_may_wakeup(), to fully understand how to configure
>>>>> wakeup settings for the device during system suspend.
>>>>>
>>>>> In particular, sometimes the device may need to remain in its power state,
>>>>> in case the driver has configured it for in band IRQs, as to be able to
>>>>> generate wakeup signals. Therefore, define and document an IN_BAND_WAKEUP
>>>>> driver flag, to enable drivers to instruct bus types and PM domains about
>>>>> this setting.
>>>>>
>>>>> Of course, in case the bus type and PM domain has additional information
>>>>> about wakeup settings of the device, they may override the behaviour.
>>>>>
>>>>> Using the IN_BAND_WAKEUP driver flag for a device, may also affect how bus
>>>>> types and PM domains should treat the device's parent during system
>>>>> suspend. Therefore, in __device_suspend(), let the PM core propagate the
>>>>> wakeup setting by using a status flag in the struct dev_pm_info for the
>>>>> parent. This also makes it consistent with how the existing "wakeup_path"
>>>>> status flag is being assigned.
>>>>
>>>> I've been thinking about this quite a bit recently and my conclusion is that
>>>> the flag makes perfect sence (as it covers a valid use case), but I would
>>>> define it and design the handling of it a bit differently.
>>>
>>> I'm also still thinking about this, cfr. my recent silence w.r.t.
>>> these matters...
>>>
>>> On Renesas ARM SoCs (and at least some SH SoCs, but these are stuck in the
>>> pre-DT legacy clock domain), a device needs to be kept running if it is a
>>> wake-up source (e.g. WoL), or if it's part of the wake-up patch (e.g.
>>> irqchip). So in the absence of the GENPD_FLAG_ACTIVE_WAKEUP flag in the PM
>>> Domain driver, all individual drivers would need to set the IN_BAND_WAKEUP
>>> flag (but see the exception below)
>>
>> Could you elaborate a bit about the wakeup-path? Let me start and you
>> can fill in.
>>
>> In $subject patch, the PM core propagates the IN_BAND_WAKEUP flag of
>> the device to its parent device, via the ->power.wakeup_path_in_band
>> flag. That becomes additional new information, as we already has the
>> PM core to propagate the value of device_may_wakeup() (if true) to the
>> parent device, via the ->power.wakeup_path flag.
>>
>> I assume that isn't sufficient, because the wakeup path isn't
>> reflected in the child/parent hierarchy?
>
> That's correct. Interrupts are not part of the parent/child relationship.
> Traditionally, irqchips were not platform devices, but now many irqchips
> used on embedded platforms are.
>
>> So, I guess this is about drivers who deals with wakeup enabled
>> devices and which are consumers of other resources (irqchips for
>> example). As part of the wakup path, these resources also needs to be
>> kept running, right?
>
> Correct.
>
>> In your case, what other resources besides the irqchip, can be
>> considered as a part of the wakeup path, but also being outside the
>> parent/child hierarchy of the wakeup enabled device?
>
> GPIOs used for wake-up? E.g. SDHI GPIO. We don't seem to have that
> enabled for the Renesas SDHI drivers, though.
>
> For gpio-keys, this is handled through enable_irq_wake(), so again it
> uses an irqchip.

Yes, this is clearly a common use case. Although, I am sure we have more.

For example, phys may need a very similar treatment, in case their
consumers requires its phy to be running - as to be able to receive
signals for wakeups. Anyway, let's discuss other cases separately and
focus on yours with the irqchip for now.

>
>> Note that, an important fact as of today, is that when
>> GENPD_FLAG_ACTIVE_WAKEUP is set for the genpd, genpd also checks the
>> ->power.wakeup_path flag for the device. Both conditions must be true,
>> else genpd powers off the PM domain (and the device).
>>
>> In other words, all devices being part of the wakeup path must either
>> have device_may_wakeup() to return true for it or the
>> ->power.wakeup_path set, else genpd will power off the PM domain,
>> regardless of whether the GENPD_FLAG_ACTIVE_WAKEUP flag is set or not.
>
> Correct.

Okay, thanks for confirming this.

This also clarifies why you set the ->power.wakeup_path flag for the
renesas irqchip device in your other series [1]. That makes perfect
sense to me, in this regards.

>
>>> Hence for this class of SoCs, this would duplicate the existing
>>> dev->power.wakeup and dev->power.wakeup_path flags, so that's why I would
>>> prefer using GENPD_FLAG_ACTIVE_WAKEUP instead (like we already do for the
>>> older SH-Mobile SoCs, but not for newer R-Car and RZ series).
>>> For other SoC families, the situation may be different.
>>>
>>> For us, the only exception are devices where the wakeup-source is not the
>>> device itself, but a GPIO, e.g. SDHI card detect. In such a case, only the
>>> device driver knows if the device is to be woken up through a dedicated CD
>>> line, or through a GPIO CD. So that would call for a method to opt-out,
>>> e.g. OUT_BAND_WAKEUP.
>>
>> The main reason to why I chosen the IN_BAND_WAKEUP method, is because
>> genpd's *default* method is to power off the PM domain (and the
>> device) even if wakeup is enabled for the device. Hence, genpd treats
>> all wakeups as default being out-of-band IRQs.
>
> OK.
>
>> Having an OUT_BAND_WAKEUP flag, would thus only make sense for those
>> genpds that has GENPD_FLAG_ACTIVE_WAKEUP set, I guess that is what you
>> are saying as well?
>
> Yes.
>
> IMHO this is orthogonal to the device: the device driver knows if the
> device itself is generating the wake-up event (e.g. Wake-on-LAN, dedicated
> SDHI CD), or some other device is taking care (e.g. GPIO SDHI CD).
> The device driver may not know if the device needs to be kept awake to
> to handle wake-up events, that may be platform knowledge handled by genpd.

Agree.

>
>>> To complicate matters, some drivers may be used on SoCs where the device
>>> needs to be kept running (clock and/or power domain), and on SoCs where the
>>> device is always running. This difference is typically handled by genpd,
>>> and the device driver may not even be aware. Of course the driver can just
>>> set IN_BAND_WAKEUP regardless, (else it has to check for the presence of
>>> clocks and/or power-domains properties itself, duplicating genpd
>>> core/driver code).
>>>
>>> So what about
>>>
>>>          if (IN_BAND_WAKEUP ||
>>>             (GENPD_FLAG_ACTIVE_WAKEUP && !OUT_BAND_WAKEUP)) {
>>
>> We don't want to suspend the device in case of IN_BAND_WAKEUP, right!?
>>
>>>                 ... suspend device...
>>>         }
>
> Oops, inverted logic. I should not write technical emails on Sunday morning.
>
> Yes, the device must be kept awake if either IN_BAND_WAKEUP is set, or
> if GENPD_FLAG_ACTIVE_WAKEUP is set but OUT_BAND_WAKEUP isn't.
>

Putting together the pieces of information received here, you have
convinced me that we should stick to use the current
GENPD_FLAG_ACTIVE_WAKEUP for now, which allows genpds to opt-in for
start dealing with in-band-wakeups.

Then, as you suggest, we need a method for the driver to set an
opt-out flag for its device, in case it configures an out-band-wakeup.
In other words, we should have an OUT_BAND_WAKEUP flag instead of an
IN_BAND_WAKEUP flag.

That together with an option of allowing "consumed resource-devices"
(irqchip) to be included in the wakeup path. I am thinking, perhaps
another driver PM flag (DPM_FLAG_WAKEUP_PATH), that the PM core looks
at and sets ->power.wakeup_path flag for the device and its parents.

Let me re-spin this series. Perhaps I fold in some of the changes from
your series as well, as to provide people with a complete picture.

Any further comments? Does it makes sense?

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-renesas-soc/msg19947.html
