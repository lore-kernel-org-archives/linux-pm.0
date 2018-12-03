From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 06/17] Platform: OLPC: Add XO-1.75 EC driver
Date: Mon, 3 Dec 2018 09:54:40 +0200
Message-ID: <CAHp75Vc9pbj-jTQ86qV54FDtxzzoY-vvgH9qtvoFWWY1JQOMew@mail.gmail.com>
References: <20181116162403.49854-1-lkundrak@v3.sk> <20181116162403.49854-7-lkundrak@v3.sk>
 <20181202231328.GB23087@wrath>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181202231328.GB23087@wrath>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.orgLinux
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 3, 2018 at 1:13 AM Darren Hart <dvhart@infradead.org> wrote:
> On Fri, Nov 16, 2018 at 05:23:52PM +0100, Lubomir Rintel wrote:
> > It's based off the driver from the OLPC kernel sources. Somewhat
> > modernized and cleaned up, for better or worse.
> >
> > Modified to plug into the olpc-ec driver infrastructure (so that battery
> > interface and debugfs could be reused) and the SPI slave framework.

> > - Count the terminating NUL in LOG_BUF_SIZE
> > - Make olpc_xo175_ec_is_valid_cmd() return -EINVAL instead of -1
> >   on error
> > - Spell keyboard/touchpad in full for CHAN_KEYBOARD/TOUCHPAD messages
> > - Use a #define for PM wakeup processing time
> > - Log a message on unknown event
> > - Escape logging payload with %*pE
> > - Replace an open-coded min()
> > - Correct an error code on short read
> > - replaced PM callback #ifdefs with __maybe_unusedm SET_RUNTIME_PM_OPS
> >   and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> > - dev_get_drvdata() instead of a round-trip through platform device
> > - s/unsigned char x/u8 x/ in olpc_xo175_ec_resume()
> > - Use GENMASK() instead of 0xffff for the event mask
> > - Replace cmd tx/resp rx buffers with structures
> > - Turned suspend hint arguments into a struct, and tidied up the comment
>
> Just from these comments, each of these could be a separate patch. You
> can group related things together, or those that change the same line or
> function for example. Order them with cleanups / non-functional-changes
> first, followed by functional changes.
>
> >
> > Basically all of the above is based on the review by Andy Shevchenko.
>
> Andy, what was your intent for Lubomir here? From the above, this looks
> like it should be several patches to me.

This is a new module, I don't see why it can't be one patch. For the
existing code I agree with you.

-- 
With Best Regards,
Andy Shevchenko
