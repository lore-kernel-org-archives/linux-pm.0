From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] thermal: rcar: Add missing clock handling
Date: Wed, 8 Jan 2014 13:58:22 +0100
Message-ID: <CAMuHMdV+UAwYoFp=Ex=9jkL4D+mVZYfDGnJdRUsYZfOEm+RGCA@mail.gmail.com>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
	<1389121036-3555-4-git-send-email-geert@linux-m68k.org>
	<52CD434E.6030906@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <52CD434E.6030906@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 8, 2014 at 1:23 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> @@ -378,23 +380,38 @@ static int rcar_thermal_probe(struct platform_device
>> *pdev)
>>         spin_lock_init(&common->lock);
>>         common->dev = dev;
>>
>> +       common->clk = devm_clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(common->clk)) {
>> +               dev_err(&pdev->dev, "cannot get clock\n");
>> +               return PTR_ERR(common->clk);
>> +       }
>> +
>> +       ret = clk_prepare(common->clk);
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev, "unable to prepare clock\n");
>> +               return ret;
>> +       }
>> +
>> +       clk_enable(common->clk);
>> +
>>         pm_runtime_enable(dev);
>>         pm_runtime_get_sync(dev);
>>
>>         irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>         if (irq) {
>> -               int ret;
>> +               int ret2;
>>
>>                 /*
>>                  * platform has IRQ support.
>>                  * Then, drier use common register
>>                  */
>>
>> -               ret = devm_request_irq(dev, irq->start, rcar_thermal_irq,
>> 0,
>> -                                      dev_name(dev), common);
>> -               if (ret) {
>> +               ret2 = devm_request_irq(dev, irq->start, rcar_thermal_irq,
>> 0,
>> +                                       dev_name(dev), common);
>> +               if (ret2) {
>>                         dev_err(dev, "irq request failed\n ");
>> -                       return ret;
>> +                       ret = ret2;
>> +                       goto error_unpm;
>>                 }
>
> I'd suggest not renaming ret2 and just use the original ret.

I did that because the for loop after that block depends on ret still being
-ENODEV. Upon closer look, I did break that myself by assigning it
the return value of clk_prepare().
So I'll use the original ret, and reset it to -ENODEV before the for loop
(unless we manage to fix it in pm_runtime_*()).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
