From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/3] soc: renesas: rcar-sysc: Keep wakeup sources
 active during system suspend
Date: Wed, 20 Dec 2017 11:28:43 +0100
Message-ID: <CAMuHMdW7r74wGvpDjBr94N0y6_414hxgXmMjzKAPU+bOfeG7Jg@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
 <1510234022-29442-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFrxaghoAcWJN1R7d7k5b=QwMpusGFuohVZpTaWngf3aiw@mail.gmail.com>
 <CAMuHMdU2CUE_68ZoQ5ssKaXYJ0L_P0gSTqVFS1GGa_cY7e-8cA@mail.gmail.com> <20171220102305.pibdggkfycmj63l4@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36725 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbdLTK2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 05:28:45 -0500
In-Reply-To: <20171220102305.pibdggkfycmj63l4@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Simon,

On Wed, Dec 20, 2017 at 11:23 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 18, 2017 at 12:22:17PM +0100, Geert Uytterhoeven wrote:
>> On Thu, Dec 14, 2017 at 3:11 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > On 9 November 2017 at 14:27, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> >> If an R-Car SYSC slave device is part of the CPG/MSTP or CPG/MSSR Clock
>> >> Domain and to be used as a wakeup source, it must be kept active during
>> >> system suspend.
>> >>
>> >> Currently this is handled in device-specific drivers by explicitly
>> >> increasing the use count of the module clock when the device is
>> >> configured as a wakeup source.  However, the proper way to prevent the
>> >> device from being stopped is to inform this requirement to the genpd
>> >> core, by setting the GENPD_FLAG_ACTIVE_WAKEUP flag.
>> >>
>> >> Note that this will only affect devices configured as wakeup sources.
>> >>
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >
>> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Thank you!
>>
>> Simon: can you please queue this up for v4.16?
>> I have queued the other 2 clock patches in clk-renesas-for-v4.16, and sent
>> a PR for it.
>
> Thanks, I have applied this patch to the soc-for-v4.16 branch.
> It is currently not based v4.15-rc1. Let me know if it should
> be rebased on top of your pull request for clk-renesas-for-v4.16.

If the base is not v4.15-rc1, what is it? GENPD_FLAG_ACTIVE_WAKEUP was
introduced in v4.15-rc1, so it won't compile based on v4.14.

There's no dependency on the clock drivers, so no need to base on
top of clk-renesas-for-v4.16.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
