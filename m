From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] cpufreq: rcar: Add support for R8A7795 SoC
Date: Tue, 10 May 2016 10:17:21 +0200
Message-ID: <CAMuHMdWYrf4oZU-8YZ-v-MxznUwJZsqLcbRhiMK=CB2+UoR6uw@mail.gmail.com>
References: <1462372543-31835-1-git-send-email-geert+renesas@glider.be>
	<5731664D.1030909@rvc.renesas.com>
	<573169CD.8050607@rvc.renesas.com>
	<57316A4E.7040100@rvc.renesas.com>
	<20160510050710.GC2790@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160510050710.GC2790@vireshk-i7>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Tue, May 10, 2016 at 7:07 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-05-16, 11:57, Khiem Nguyen wrote:
>> After the commit "a399dc9fc50 cpufreq: shmobile: Use generic platdev
>> driver", will use cpufreq-dt-platdev driver to enable cpufreq-dt support.
>> Hence, follow the implementation to support new R8A7795 SoC.
>>
>> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
>> ---
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Quoting Viresh when this file was introduced:
| This is going to be done once per boot and this shouldn't hurt. And for new
| platforms we may do things differently as they are going to use
opp-v2 bindings.

As r8a7795/r8a7796 are not arm32 "shmobile", but arm64, perhaps we should
use this new "opp-v2" binding instead? Has it been finalized?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
