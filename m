From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] renesas: irqchip: Use WAKEUP_PATH driver PM flag
Date: Sun, 31 Dec 2017 01:56:20 +0100
Message-ID: <CAJZ5v0heO9DxbxnrXJeXC0RDQV-oOb=KLJmXWm7uuy=y7U2KjA@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Changes in v2: [By Ulf Hansson]
>         - I have picked up the series from Geert [1] and converted it into use
>         the WAKEUP_PATH driver PM flag. This includes some minor changes to each
>         patch and updates to the changelogs.
>         - An important note, the WAKEUP_PATH driver PM flag is introduced in a
>         separate series [2], not yet applied, so @subject series depends on it.
>         - One more note, two of the patches has a checkpatch error, however I
>         did not fix them, becuase I think that should be done separate.
>
> [1]
> https://lkml.org/lkml/2017/11/9/382
> [2]
> https://marc.info/?l=linux-pm&m=151454744124661&w=2
>
> More information below, picked from Geert's previous cover letter.
>
> Kind regards
> Uffe
>
>
> Hi all,
>
> If an interrupt controller in a Renesas ARM SoC is part of a Clock
> Domain, and it is part of the wakeup path, it must be kept active during
> system suspend.
>
> Currently this is handled in all interrupt controller drivers by
> explicitly increasing the use count of the module clock when the device
> is part of the wakeup path.  However, this explicit clock handling is
> merely a workaround for a failure to properly communicate wakeup
> information to the device core.
>
> Hence this series fixes the affected drivers by setting the devices'
> power.wakeup_path fields instead, to indicate they are part of the
> wakeup path.  Depending on the PM Domain's active_wakeup configuration,
> the genpd core code will keep the device enabled (and the clock running)
> during system suspend when needed.

However, there is a convention, documented in the kerneldoc comment of
device_init_wakeup(), by which devices participating in system wakeup
"passively" (like USB controllers and hubs) are expected to have it
enabled by default.

If that convention was followed by the devices in question here, the
wakeup_path bit would be set for them and no other code changes would
be necessary.  So is there any reason for not following it?

Thanks,
Rafael
