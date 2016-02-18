From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] gpio: rcar: Add Runtime PM handling for interrupts
Date: Thu, 18 Feb 2016 16:12:23 +0100
Message-ID: <CAMuHMdVoUAwWm6GoN6-ufs5j_b79ndFTcpQNu59JCtO1wrQBnQ@mail.gmail.com>
References: <1455031183-18294-1-git-send-email-geert+renesas@glider.be>
	<56C2EBA5.4040903@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34272 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426459AbcBRPMY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 10:12:24 -0500
In-Reply-To: <56C2EBA5.4040903@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Jon,

On Tue, Feb 16, 2016 at 10:28 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> On 09/02/16 15:19, Geert Uytterhoeven wrote:
>> The R-Car GPIO driver handles Runtime PM for requested GPIOs only.
>>
>> When using a GPIO purely as an interrupt source, no Runtime PM handling
>> is done, and the GPIO module's clock may not be enabled.
>>
>> To fix this:
>>   - Add .irq_request_resources() and .irq_release_resources() callbacks
>>     to handle Runtime PM when an interrupt is requested,
>
> I know that when I was looking at runtime-pm support for IRQ chips
> (which I have been meaning to get back too), the problem with
> irq_request_resources() is that it is called from the context of a
> spinlock (in __setup_irq()). You mentioned that you have not seen any
> reports of might_sleep_if(), but have you ensured that it is actually
> runtime resuming in your testing and you are not getting lucky?

It must be runtime-resuming, because without the call to pm_runtime_get_sync()
interrupts don't work.

> An alternative for you might be to use the
> irq_bus_lock/irq_bus_sync_unlock callbacks. See what Grygorii
> implemented for OMAP in commit aca82d1cbb49 ("gpio: omap: move pm
> runtime in irq_chip.irq_bus_lock/sync_unlock").

Thanks, that indeed looks interesting...

> As I mentioned I do plan to get back to the series for adding runtime-pm
> support for IRQ chips, in the next week or two.

Looking forward to it!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
