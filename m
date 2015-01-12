From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] power: reset: Add reset driver for R-Mobile platforms
Date: Mon, 12 Jan 2015 20:24:34 +0100
Message-ID: <CAMuHMdUmS+DszqpHn0Yd9OkHTNzm-jpp5JE+h-0Du-Wa+7_t8w@mail.gmail.com>
References: <1421078245-5531-1-git-send-email-geert+renesas@glider.be>
	<20150112190426.GA1714@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150112190426.GA1714@earth.universe>
Sender: linux-sh-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 12, 2015 at 8:04 PM, Sebastian Reichel <sre@kernel.org> wrote:
> On Mon, Jan 12, 2015 at 04:57:25PM +0100, Geert Uytterhoeven wrote:
>> Add a reset driver for Renesas R-Mobile and SH-Mobile SoCs. It registers
>> a restart handler to trigger a soft power-on reset through the R-Mobile
>> System Controller.
>> As this is controlled by DT, the priority of this restart handler is 192,
>> to allow a watchdog driver to use priority 128.
>>
>> Note that we do not use syscon-reboot, as the HPB (Peripheral Bus
>> Bridge) semaphore should be acquired on systems where both the ARM and
>> SH core are in use. The driver can be extended later to support this,
>> when needed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Tested on R-Mobile A1 (r8a7740) and SH-Mobile AG5 (sh73a0).
>
> Please add DT binding documentation.

Sorry, I indeed should have referenced the DT binding documentation that's
already queued up in -next for the PM domain support:

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
