From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2 0/5] clk: renesas: rcar-gen3: Restore clocks during resume
Date: Thu, 29 Jun 2017 18:26:38 +0200
Message-ID: <CAMuHMdWhiBftHJ_qxGW67BYkEaBcC7CBC7ZBEi9nozRvKcW1EA@mail.gmail.com>
References: <1498742720-2713-1-git-send-email-geert+renesas@glider.be> <20170629151826.GA18905@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34487 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbdF2Q0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 12:26:40 -0400
In-Reply-To: <20170629151826.GA18905@bigcity.dyn.berto.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Niklas,

On Thu, Jun 29, 2017 at 5:18 PM, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2017-06-29 15:25:15 +0200, Geert Uytterhoeven wrote:
>> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
>> clock register state is lost.  Note that as the boot loader skips most
>> initialization after resume, clock register state differs from the state
>> encountered during normal system boot, too.
>>
>> Hence after s2ram, some operations may fail because module clocks are
>> disabled, while drivers expect them to be still enabled.  E.g. EtherAVB
>> fails when Wake-on-LAN has been enabled using "ethtool -s eth0 wol g":
>>
>>     ravb e6800000.ethernet eth0: failed to switch device to config mode
>>     ravb e6800000.ethernet eth0: device will be stopped after h/w proces=
ses are done.
>>     ravb e6800000.ethernet eth0: failed to switch device to config
>>     PM: Device e6800000.ethernet failed to resume: error -110
>>
>> In addition, some clocks that were disabled by clk_disable_unused() may
>> have been re-enabled, wasting power.
>>
>> This RFC is a second attempt to fix this issue by restoring clock regist=
ers
>> during system resume.

>> This has been tested on Salvator-X with R-Car H3 ES1.0 and M3-W ES1.0.
>> On Salvator-XS with R-Car H3 ES2.0, EtherAVB restarts after system resum=
e,
>> but NFS fails with "server not responding", probably not due to a clock
>> issue.
>
> I tested this series using this setup:
>
> - Base latest renesas-drivers, 710def1a48c7bc9d ("of_mdio: Fix broken
>   PHY IRQ in case of probe deferral"). This branch also includes the
>   RAVB WoL patches.
>
> - Salvator-X H3 ES1.0
>
> - The arm64 defconfig.
>
> The test procedure I used:
>
>     arm64 ~/shared/deep-sleep # cat sleep.sh
>     #!/bin/bash
>
>     ethtool -s eth0 wol g
>
>     echo disabled > /sys/devices/platform/soc/e6800000.ethernet/power/wak=
eup
>
>     echo 0 > /sys/module/printk/parameters/console_suspend
>
>     i2cset -f -y 7 0x30 0x20 0x0F
>
>     echo "Flip Switch"
>     read -n 1
>
>     echo mem > /sys/power/state

Looks good.

> And for me the NFS root came up OK after flipping switch back. I wonder
> what is different in our test procedures. I would like to provide my
> tested-by tag but I first want to figure out why NFS (or maybe the whole
> net interface?) don't work for you after resume.

Sorry for the confusion: NFS fails only on Salvator-XS H3 ES2.0.
It works fine on Salvator-X H3 ES1.0 and M3-W ES1.0.

> I also know you reported an IRQ storm when resuming using WoL which I in
> over 1000 suspend/resume cycles never have been able to reproduce. Maybe
> my test environment or procedure is to kind and/or something is falling
> thru the cracks :-( Do you notice any difference in test procedure or
> console printouts?

I saw the IRQ storm only once.

Thanks for testing!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
