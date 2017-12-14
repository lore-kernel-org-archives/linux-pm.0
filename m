From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] clk: renesas: cpg-mssr: Keep wakeup sources active
 during system suspend
Date: Thu, 14 Dec 2017 16:44:23 +0100
Message-ID: <CAMuHMdXEhDMSmL4owVYvUbJuCQ65pF+-pXpt2RhxRqa2dqL7jQ@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
 <1510234022-29442-3-git-send-email-geert+renesas@glider.be> <CAPDyKFr6=od_PL=Y_N4OB_+wkZumb=aEV4_x7Z5J4jTL-C1aDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr6=od_PL=Y_N4OB_+wkZumb=aEV4_x7Z5J4jTL-C1aDg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 14, 2017 at 3:11 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 9 November 2017 at 14:27, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> If a device is part of the CPG/MSSR Clock Domain and to be used as a
>> wakeup source, it must be kept active during system suspend.
>>
>> Currently this is handled in device-specific drivers by explicitly
>> increasing the use count of the module clock when the device is
>> configured as a wakeup source.  However, the proper way to prevent the
>> device from being stopped is to inform this requirement to the genpd
>> core, by setting the GENPD_FLAG_ACTIVE_WAKEUP flag.
>>
>> Note that this will only affect devices configured as wakeup sources.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you, queued in clk-renesas-for-v4.16.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
