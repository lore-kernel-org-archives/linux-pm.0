From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 00/03] irqchip: renesas-irqc: Fine grained Runtime PM support
Date: Thu, 23 Apr 2015 19:49:59 +0200
Message-ID: <CAMuHMdWtUYoFWWfijFbQCv6Z-phZW2XN+F5n1zfqbZMFGjM+Bg@mail.gmail.com>
References: <CAMuHMdWN5E35e8CEzOKYRo4PXkzjMpxErg6akCOHKGtAf=D8tQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1504231040560.1529-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1504231040560.1529-100000@iolanthe.rowland.org>
Sender: linux-sh-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 23, 2015 at 4:44 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 23 Apr 2015, Geert Uytterhoeven wrote:
>> >> I'm afraid you can't call pm_runtime_get_sync() from these methods, as
>> >> they may be called from interrupt context.
>> >
>> > Ouch. I know the clock framework has prepare/enable separated with
>> > context, but with the irqchip callbacks I suppose no such separation
>>
>> It's not the clock operations, but the pm_runtime operations that cannot be
>> called from interrupt context.
>
> In fact the pm_runtime operations _can_ be called from interrupt
> context, provided the driver has first invoked pm_runtime_irq_safe().
> Of course, this requires that none of the runtime-PM callback routines
> ever sleep or perform a blocking operation.
>
> This is all explained in Documentation/power/runtime_pm.txt (search for
> "irq_safe").

Perhaps that can help. We'll have to give it a try...

I've always found this a bit strange when PM Domains are involved:
pm_runtime_irq_safe(dev) applies to device dev, while the actual callbacks
belong to the PM Domain code (the device's driver doesn't have any).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
