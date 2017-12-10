From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] PM / core: Add IN_BAND_WAKEUP driver flag
Date: Sun, 10 Dec 2017 11:16:40 +0100
Message-ID: <CAMuHMdUE+fdbS+HDxbcWNHaTZubnrQ7ai4bkOsBpLriG1y-gZg@mail.gmail.com>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
 <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org> <1926914.PsNMcYBlGW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37094 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdLJKQl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Dec 2017 05:16:41 -0500
In-Reply-To: <1926914.PsNMcYBlGW@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Rafael, Ulf,

On Sun, Dec 10, 2017 at 3:30 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, November 13, 2017 4:46:42 PM CET Ulf Hansson wrote:
>> For some bus types and PM domains, it's not sufficient to only check the
>> return value from device_may_wakeup(), to fully understand how to configure
>> wakeup settings for the device during system suspend.
>>
>> In particular, sometimes the device may need to remain in its power state,
>> in case the driver has configured it for in band IRQs, as to be able to
>> generate wakeup signals. Therefore, define and document an IN_BAND_WAKEUP
>> driver flag, to enable drivers to instruct bus types and PM domains about
>> this setting.
>>
>> Of course, in case the bus type and PM domain has additional information
>> about wakeup settings of the device, they may override the behaviour.
>>
>> Using the IN_BAND_WAKEUP driver flag for a device, may also affect how bus
>> types and PM domains should treat the device's parent during system
>> suspend. Therefore, in __device_suspend(), let the PM core propagate the
>> wakeup setting by using a status flag in the struct dev_pm_info for the
>> parent. This also makes it consistent with how the existing "wakeup_path"
>> status flag is being assigned.
>
> I've been thinking about this quite a bit recently and my conclusion is that
> the flag makes perfect sence (as it covers a valid use case), but I would
> define it and design the handling of it a bit differently.

I'm also still thinking about this, cfr. my recent silence w.r.t.
these matters...

On Renesas ARM SoCs (and at least some SH SoCs, but these are stuck in the
pre-DT legacy clock domain), a device needs to be kept running if it is a
wake-up source (e.g. WoL), or if it's part of the wake-up patch (e.g.
irqchip). So in the absence of the GENPD_FLAG_ACTIVE_WAKEUP flag in the PM
Domain driver, all individual drivers would need to set the IN_BAND_WAKEUP
flag (but see the exception below)
Hence for this class of SoCs, this would duplicate the existing
dev->power.wakeup and dev->power.wakeup_path flags, so that's why I would
prefer using GENPD_FLAG_ACTIVE_WAKEUP instead (like we already do for the
older SH-Mobile SoCs, but not for newer R-Car and RZ series).
For other SoC families, the situation may be different.

For us, the only exception are devices where the wakeup-source is not the
device itself, but a GPIO, e.g. SDHI card detect. In such a case, only the
device driver knows if the device is to be woken up through a dedicated CD
line, or through a GPIO CD. So that would call for a method to opt-out,
e.g. OUT_BAND_WAKEUP.

To complicate matters, some drivers may be used on SoCs where the device
needs to be kept running (clock and/or power domain), and on SoCs where the
device is always running. This difference is typically handled by genpd,
and the device driver may not even be aware. Of course the driver can just
set IN_BAND_WAKEUP regardless, (else it has to check for the presence of
clocks and/or power-domains properties itself, duplicating genpd
core/driver code).

So what about

         if (IN_BAND_WAKEUP ||
            (GENPD_FLAG_ACTIVE_WAKEUP && !OUT_BAND_WAKEUP)) {
                ... suspend device...
        }

?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
