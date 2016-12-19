From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Tue, 20 Dec 2016 02:37:39 +0900
Message-ID: <CAEQ9gEnQEHdcA4ox3teOXKcrdf2AAqUMp=A6W6c7nXhk4VrKiw@mail.gmail.com>
References: <20161207172415.9776-1-rogershimizu@gmail.com> <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161219153802.vhcish35qyjbpevj@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36783 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756136AbcLSRh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 12:37:56 -0500
In-Reply-To: <20161219153802.vhcish35qyjbpevj@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

Dear Sebastian,

Thanks for your review!

On Tue, Dec 20, 2016 at 12:38 AM, Sebastian Reichel <sre@kernel.org> wrote:
>>
>>  .../bindings/power/reset/linkstation-reset.txt     |  26 ++++
>>  drivers/power/reset/Kconfig                        |  10 ++
>>  drivers/power/reset/Makefile                       |   1 +
>>  drivers/power/reset/linkstation-common.c           | 124 +++++++++++++++
>>  drivers/power/reset/linkstation-common.h           |   8 +
>>  drivers/power/reset/linkstation-reset.c            | 172 +++++++++++++++++++++
>>  6 files changed, 341 insertions(+)
>
> With this being its own driver please merge linkstation-common and
> linkstation-reset. The common part is only used by linkstation-reset
> anyways.

I'll add them into To/Cc list.

>> +/* 4-byte magic hello command to UART1-attached microcontroller */
>> +static const unsigned char linkstation_micon_magic[] = {
>> +     0x1b,
>> +     0x00,
>> +     0x07,
>> +     0x00
>> +};
>
> 4-byte magic hello command? Those are used as uart configuration as
> far as I can see. Just move this directly into reset_cfg:
>
> struct reset_cfg {
>     u32 baud;
>     u8 lcr;
>     u8 ier;
>     u8 fcr;
>     u8 mcr;
>     const unsigned char (*cmd)[MICON_CMD_SIZE];
> };
>

>> +static void linkstation_reset(void)
>> +{
>> +     const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
>> +
>> +     pr_err("%s: triggering power-off...\n", __func__);
>> +
>> +     /* hijack UART1 and reset into sane state */
>> +     writel(0x83, UART1_REG(LCR));
>> +     writel(divisor & 0xff, UART1_REG(DLL));
>> +     writel((divisor >> 8) & 0xff, UART1_REG(DLM));
>> +     writel(cfg->magic[0], UART1_REG(LCR));
>> +     writel(cfg->magic[1], UART1_REG(IER));
>> +     writel(cfg->magic[2], UART1_REG(FCR));
>> +     writel(cfg->magic[3], UART1_REG(MCR));
>> +
>> +     /* send the power-off command to PIC */
>> +     if(cfg->cmd[0][0] == 1 && cfg->cmd[1][0] == 0) {
>> +             /* if it's simply one-byte command, send it directly */
>> +             writel(cfg->cmd[0][1], UART1_REG(TX));
>> +     }
>
> I guess this optimization can be dropped and you can directly
> call the for loop with uart1_micon_send().

Same response regarding above two comments.
The code is extensible because I want to extend in the future.

Current implementation is just for Linkstation Pro / KuroBox Pro to be
able to power-off.
But for some other model of Linkstation, restart also need similar
command via UART1.

Just one example, Linkstation Pro is ARM based, but it was PowerPC based before.
And the device support still exists in kernel tree:
  arch/powerpc/platforms/embedded6xx/linkstation.c
  arch/powerpc/platforms/embedded6xx/ls_uart.c
It shows sending "C" to restart and sending "E" to power-off for
PowerPC based Linkstation.

I'm not actually interested in PowerPC based Linkstation, it's just an
example to show the reason to be flexible.

If other part is fine, may I send the v3 patch after merging
linkstation-common.c into linkstation-reset.c?
Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
