From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/3] gpio: rcar: Use WAKEUP_PATH driver PM flag
Date: Tue, 2 Jan 2018 14:57:00 +0100
Message-ID: <CAMuHMdXZkUZRnpuT=G85ZerULEyNF09DUJAVMfvx+eUn-WmL7w@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
 <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0gWtr1bwi7WVeEbTJPu3KC8YfPvfUh5XDmomiK8TFmfyg@mail.gmail.com>
 <CAMuHMdVmqM+WA_EaCRHNojpV6NYmS0-V18MoixyV5UdC3cq+2g@mail.gmail.com> <CAPDyKFrPTJ84-rBcdPH+Vs_L7Hbmh8G-C8fC1zYqP3H3dxn7vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41179 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeABN5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 08:57:02 -0500
In-Reply-To: <CAPDyKFrPTJ84-rBcdPH+Vs_L7Hbmh8G-C8fC1zYqP3H3dxn7vw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Ulf,

On Tue, Jan 2, 2018 at 2:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> [Ulf: Converted to use the WAKEUP_PATH driver PM flag]
>>
>> Ulf: + killing the DEV_PM_OPS define, increasing kernel size if PM_SUSPEND=n?
>
> Oh, yes - correct!
>
> The code looks nicer, with the penalty of one static struct declared
> and not used, in case CONFIG_PM_SLEEP is unset.

At 23 pointers of 4 or 8 bytes each in 3 drivers, I don't consider this
insignificant.

Fortunately this driver is not used on RZ/A1, which you can run without
external RAM if you manage to fit everything in 10 MiB of SRAM...

> Should I revert back to your proposal, I am fine with whatever?

Yes please.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
