From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] thermal: rcar: Add missing clock handling
Date: Wed, 8 Jan 2014 11:23:16 +0100
Message-ID: <CAMuHMdW+1yP2PqvLTc0tjyrnhGssvn_iK8mCO6u-++pjGYR9KQ@mail.gmail.com>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
	<1389121036-3555-4-git-send-email-geert@linux-m68k.org>
	<87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 8, 2014 at 2:08 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>> +     common->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(common->clk)) {
>> +             dev_err(&pdev->dev, "cannot get clock\n");
>> +             return PTR_ERR(common->clk);
>> +     }
>> +
>> +     ret = clk_prepare(common->clk);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "unable to prepare clock\n");
>> +             return ret;
>> +     }
>> +
>> +     clk_enable(common->clk);
>> +
>>       pm_runtime_enable(dev);
>>       pm_runtime_get_sync(dev);
>
> And this patch seems strange for me.
> pm_runtime_xxx() is doing same things.
> If it didn't work, wrong place is not driver, clock side ?

That's an interesting observation...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
