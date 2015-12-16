From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 0/3] i2c: rcar: adapt PM usage to multi master case
Date: Wed, 16 Dec 2015 22:26:04 +0100
Message-ID: <CAMuHMdUAse8TzB4T=wU7nLGoktwdZqhydw+obcOFXvXsTj8yWA@mail.gmail.com>
References: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

On Wed, Dec 16, 2015 at 7:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> If we are in a multi-master scenario, we need to block runtime PM so the
> arbitration circuit stays awake.
>
> So, we define a new binding and adapt the i2c-rcar driver to have an example
> implementation.
>
> This series is RFC because I want to do some more regression testing. The
> actual functionality works fine here on my Lager board.

Thanks, looks good to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
