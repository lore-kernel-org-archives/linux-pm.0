From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/3] PM / core: Add IN_BAND_WAKEUP driver flag
Date: Tue, 12 Dec 2017 15:20:56 +0100
Message-ID: <CAPDyKFo-QtiBc-DmXAJO26eo0_WHA=_8YdOb8HzKc7t2q1zagg@mail.gmail.com>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
 <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org>
 <1926914.PsNMcYBlGW@aspire.rjw.lan> <CAMuHMdUE+fdbS+HDxbcWNHaTZubnrQ7ai4bkOsBpLriG1y-gZg@mail.gmail.com>
 <CAPDyKFoAY7yZJz9obke5DeqadpqJ0MEKPQJvxibpq85f+==BBA@mail.gmail.com>
 <CAMuHMdXk9GaExvYbdSfV0bf4Kh1TNrZDKtAfTDaDfWFMvk6Snw@mail.gmail.com>
 <CAPDyKFoey_kSf0OE7OmHCX4H4VFQcWOU6NE4suZ9=9stZVQNpQ@mail.gmail.com> <CAMuHMdX4jNL7Md5rgUj63sBC1KUqYa5K-cbxM+ineW9KkB9r=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:46560 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdLLOU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 09:20:58 -0500
Received: by mail-it0-f41.google.com with SMTP id t1so24800978ite.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2017 06:20:58 -0800 (PST)
In-Reply-To: <CAMuHMdX4jNL7Md5rgUj63sBC1KUqYa5K-cbxM+ineW9KkB9r=g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 12 December 2017 at 09:16, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Mon, Dec 11, 2017 at 9:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> That together with an option of allowing "consumed resource-devices"
>> (irqchip) to be included in the wakeup path. I am thinking, perhaps
>> another driver PM flag (DPM_FLAG_WAKEUP_PATH), that the PM core looks
>> at and sets ->power.wakeup_path flag for the device and its parents.
>
> This is complicated by the fact that currently the device and irq
> subsystems don't really share data. E.g. {en,dis}able_irq_wake() and
> irq_set_irq_wake() don't take a device parameter, only an interrupt number,
> and conversion from interrupt numbers to devices is non-trivial.
> That's why I handled it in the irqchip drivers in the series referenced
> below.

Yes, that seems like a good way forward for now.

We can always look into how to extend the irq subsystem to deal with
this internally, but I rather leave that to be done as a separate
task.

[...]

Kind regards
Uffe
