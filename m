From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] ARM: shmobile: sh7372: Keep D4 pm domain powered
Date: Mon, 27 Oct 2014 09:23:14 +0100
Message-ID: <CAMuHMdVFTjy5UZEU6azEuXQSKF1msQrQ-cOe2jZzevcpAPfAjw@mail.gmail.com>
References: <1414063874-9533-1-git-send-email-geert+renesas@glider.be>
	<20141027010846.GC30485@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:57159 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaJ0IXQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 04:23:16 -0400
In-Reply-To: <20141027010846.GC30485@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Simon,

On Mon, Oct 27, 2014 at 2:08 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Oct 23, 2014 at 01:31:14PM +0200, Geert Uytterhoeven wrote:
>> The D4 power domain contains the Coresight-ETM hardware block.
>> As long as the ARM debug/perf code doesn't use resource management with
>> runtime PM support, the D4 power domain must be kept powered to avoid a
>> crash during resume from s2ram (dbg_cpu_pm_notify() calls
>> reset_ctrl_regs() unconditionally, causing an undefined instruction
>> oops).
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Untested on real hardware, but a similar workaround is needed on r8a7740.
>
> I have hardware in the form of a Mackerel board and I'm happy
> to test this if it would help and you give me some guidance on how to do so.

That would be great!

Test procedure:
  1. echo 0 > /sys/module/printk/parameters/console_suspend
  2. echo mem > /sys/power/state
  3. [ Wake up by pressing a key on the serial console.
        There's no other wake-up source on mackerel? ]

Without my patch, I expect it to crash during resume in reset_ctrl_regs().

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
