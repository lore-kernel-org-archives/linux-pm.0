From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 08/15] Platform: OLPC: Move EC-specific functionality
 out from x86
Date: Wed, 14 Nov 2018 17:20:53 +0100
Message-ID: <df41a91f83387770de53bde204365ae85f2137dc.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-9-lkundrak@v3.sk>
         <CAHp75VfVYUyurEkrCuRsuC_jk94e3CqsxPket+DZqNk0VNMPFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfVYUyurEkrCuRsuC_jk94e3CqsxPket+DZqNk0VNMPFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.or
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, 2018-10-19 at 16:36 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > It is actually plaform independent. Move it to the olpc-ec driver
> > from
> > the X86 OLPC platform, so that it could be used by the ARM based
> > laptops
> > too.
> 
> What is platform independent exactly?

The commands with their argument and responses are mostly the same, but
the delivery mechanism is different (SPI on ARM vs. LPC on x86).

Notably, the driver for the OLPC battery (which is the same on all XO
generations) builds on the API provided by the olpc-ec driver.

I'll try to extend the commit message to make this clear.

> >  #define OLPC_F_PRESENT         0x01
> >  #define OLPC_F_DCON            0x02
> > -#define OLPC_F_EC_WIDE_SCI     0x04
> 
> I think these lines grouped on purpose. Thus, I don't like this.
> Either move either all or none.

I'm not moving this -- I'm removing it and using the EC version
instead.

This flag doesn't make sense for non-x86 ECs -- they don't use SCIs to
deliver EC-to-CPU communication, but initiate SPI transactions instead.

> 
> > +int olpc_ec_mask_write(u16 bits)
> > +{
> >  #ifdef CONFIG_DEBUG_FS
> > 
> >  /*
> > @@ -277,14 +369,17 @@ static int olpc_ec_probe(struct
> > platform_device *pdev)
> >         ec_priv = ec;
> >         platform_set_drvdata(pdev, ec);
> > 
> > +       /* EC version 0x5f adds support for wide SCI mask */
> > +       if (ec->version >= 0x5f) {
> > +               __be16 ec_word = cpu_to_be16(bits);
> > +
> > +               return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *)
> > &ec_word, 2,
> > +                                  NULL, 0);
> 
> I would leave it on one line.

Okay. I do agree this looks better, but was not sure how seriously to
take checkpatch.pl's warnings.

> 
> > +       } else {
> > +               unsigned char ec_byte = bits & 0xff;
> 
> You may noticed that the parameter is of type u8, which clearly makes
> & 0xff part redundant.

At least for me, the explicit mask makes this easier for me to read.

But I don't mind really. If you'd really like to see this changes I can
follow up with such change (or am happy to ack such change from you).

> 
> > +               return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1,
> > NULL, 0);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(olpc_ec_mask_write);
> 
> I see that the above is inherited from older code, so, no need to
> address those comments in here, but consider a follow up fix.
> 
> 
> > +int olpc_ec_sci_query(u16 *sci_value)
> > +{
> > +}
> > +EXPORT_SYMBOL_GPL(olpc_ec_sci_query);
> 
> Similar comments are applied here.
> 
> > +
> > -       err = ec_driver->probe ? ec_driver->probe(pdev) : 0;
> > +       /* get the EC revision */
> > +       err = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0,
> > +               (unsigned char *) &ec->version, 1);
> 
> Perhaps version should be defined as u8.

Yes.

> > +/* SCI source values */
> > +#define EC_SCI_SRC_EMPTY        0x00
> > +#define EC_SCI_SRC_GAME         0x01
> > +#define EC_SCI_SRC_BATTERY      0x02
> > +#define EC_SCI_SRC_BATSOC       0x04
> > +#define EC_SCI_SRC_BATERR       0x08
> > +#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
> > +#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
> > +#define EC_SCI_SRC_ACPWR        0x40
> > +#define EC_SCI_SRC_BATCRIT      0x80
> > +#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
> 
> BIT() ?
> 
> > +#define EC_SCI_SRC_ALL          0x1FF
> 
> GENMASK()?

Yes. I meant to move this, but it turns out I've left the original ones
in place. Will fix them in a follow-up commit also.

Lubo
