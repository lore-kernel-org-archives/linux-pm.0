From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Date: Wed, 19 Dec 2018 10:39:05 +0100
Message-ID: <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com> <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
 <20181218233354.pie5i3lvrrhq5q2c@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218233354.pie5i3lvrrhq5q2c@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Hans de Goede <hdegoede@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

On Wed, Dec 19, 2018 at 12:34 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > +   unsigned int is_suspended:1;    /* owned by the I2C core */
> >
> > When more stuff is added to this bit field (which always happens at
> > some point) updates to all members of the bit field will have to use
> > the same root-adapter-locking, or we will suffer from RMW-races. So
> > this feels like an invitation for future disaster. Maybe a comment
> > about that to remind our future selves? Or perhaps the bit field
> > should be avoided altogether?
>
> Changed to bool. Thanks!

Does that help, given bool is smaller than the CPUs word size?
Is it Alpha that cannot do atomic operations on bytes?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
