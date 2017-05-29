From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] regmap: Add OneWire (W1) bus support
Date: Mon, 29 May 2017 17:07:53 +0200
Message-ID: <CAMuHMdXyNqzuY4i7YXMo5tBjYVYDEc9a=csaTe5Jm7oCnsdrrw@mail.gmail.com>
References: <20170528071120.6604-1-minimumlaw@rambler.ru> <20170528071120.6604-2-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34664 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdE2PHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2017 11:07:55 -0400
In-Reply-To: <20170528071120.6604-2-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Sun, May 28, 2017 at 9:11 AM, Alex A. Mihaylov <minimumlaw@rambler.ru> wrote:
> Add basic support regmap (register map access) API for OneWire (W1) bus

It's called "1-wire" or "1-Wire" almost everywhere else in the kernel,
and on the Maxim
website (except in the URL
https://www.maximintegrated.com/en/products/digital/one-wire.html ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
