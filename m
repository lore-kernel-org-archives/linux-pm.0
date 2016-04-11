From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2] gpio: rcar: Add Runtime PM handling for interrupts
Date: Mon, 11 Apr 2016 19:18:43 +0200
Message-ID: <CAMuHMdXym9YXaDP+-xEU7o+NcKPUz5mgXnVkpk_QnQQppuab-A@mail.gmail.com>
References: <1455811590-15836-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdZ2zzP5u4uJDzsnks7ywrp3ddBt+YfxthJ+5mT-ECYLpg@mail.gmail.com>
	<56C703AC.4040803@arm.com>
	<8178382.Z7YODHSRMC@avalon>
	<570BD6F1.90709@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35957 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbcDKRSp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 13:18:45 -0400
In-Reply-To: <570BD6F1.90709@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

Hi Marc,

On Mon, Apr 11, 2016 at 6:55 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 11/04/16 17:26, Laurent Pinchart wrote:
>> On Friday 19 Feb 2016 11:59:40 Marc Zyngier wrote:
>>> On 19/02/16 09:18, Linus Walleij wrote:
>>>> Top-quoting so everyone on the new To:-line gets the context.
>>>>
>>>> I definately need an indication from an irqchip maintainer like tglx or
>>>> Marc Z before I merge this. Also, as in reply to the previous letter,
>>>> coordinate efforts with Jon Hunters similar problem space.
>>>
>>> Seems pretty straightforward to me.
>>>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Too straightforward to be correct :-/
>>
>> [    6.232681] BUG: sleeping function called from invalid context at /home/laurent/src/iob/renesas/linux/drivers/base/power/runtime.c:955
>> [    6.244795] in_atomic(): 1, irqs_disabled(): 128, pid: 658, name: udevd
>> [    6.251429] CPU: 3 PID: 658 Comm: udevd Tainted: P                4.6.0-rc3 #756
>> [    6.258844] Hardware name: Generic R8A7790 (Flattened Device Tree)
>
> [...]
>
> Ah! That will teach me a lesson.
>
>> The .irq_request_resources() handler is called with a spinlock held, it thus
>> can't call the synchronous version of the PM runtime functions.
>
> OK, so we're back to square one. Is that just a matter of calling the
> non-synchronous version? My hunch is that it is not that simple...
>
> Geert?

Unfortunately it's not that simple.
The irqchip must be runtime-resumed before we can access its registers.

I'm afraid we'll have to keep gpio-rcar runtime-resumed all the time,
i.e. revert both of
b26a719bdb ("gpio: rcar: Add Runtime PM handling for interrupts")
65194cb174 ("gpio: rcar: Fine-grained Runtime PM support")
until Jon Hunter's "genirq: Add runtime power management support for IRQ chips"
(and perhaps a few more patches from his series) is applied.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
