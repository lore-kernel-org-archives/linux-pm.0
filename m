From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/8 v2] leds: add device tree bindings for register bit LEDs
Date: Tue, 2 Sep 2014 16:22:59 +0200
Message-ID: <CAMuHMdXB_6vJpTeDgr4iiA=T_3bK7nQ3anF-HSdnEz=2QqYzaw@mail.gmail.com>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
	<1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:61430 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbaIBOXB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 10:23:01 -0400
In-Reply-To: <1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>

Hi Linus,

On Tue, Sep 2, 2014 at 2:02 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> +LED sub-node properties:
> +
> +Required properties:
> +- compatible : must be "register-bit-led"
> +- offset : register offset to the register controlling this LED
> +- mask : bit mask for the bit controlling this LED in the register

Why don't you use a "reg" property with "#address-cells = <2>" and
"#size-cells = <1>", so you can store offset and mask there?

> +syscon: syscon@10000000 {
> +       compatible = "arm,realview-pb1176-syscon", "syscon";
> +       reg = <0x10000000 0x1000>;
> +
> +       led@08.0 {
> +               compatible = "register-bit-led";
> +               offset = <0x08>;
> +               mask = <0x01>;
> +               label = "versatile:0";
> +               linux,default-trigger = "heartbeat";
> +               default-state = "on";
> +       };

ePAPR v1.1 says:

"The unit-address must match the first address specified in the reg property
 of the node. If the node has no reg property, the @ and unit-address must
 be omitted ..."

So you cannot have the "@8.0" without a "reg" property.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
