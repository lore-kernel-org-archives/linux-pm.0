From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 06/15] Platform: OLPC: Move EC-specific functionality
 out from x86
Date: Thu, 10 Jan 2019 18:12:56 +0100
Message-ID: <fb3a50bde8975ea6843508a3c4220ee8013069e1.camel@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
         <20190108175818.705110-7-lkundrak@v3.sk>
         <CAHp75Vf7ctTmncjOfMKL7MDAi=4rr2huBmZ7RsAnPKyJv7HTQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf7ctTmncjOfMKL7MDAi=4rr2huBmZ7RsAnPKyJv7HTQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-01-09 at 13:23 +0200, Andy Shevchenko wrote:
> On Tue, Jan 8, 2019 at 7:59 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Move the olpc-ec driver away from the X86 OLPC platform so that it could be
> > used by the ARM based laptops too. Notably, the driver for the OLPC battery,
> > which is also used on the ARM models, builds on this driver's interface.
> > 
> > It is actually plaform independent: the OLPC EC commands with their argument
> > and responses are mostly the same despite the delivery mechanism is
> > different.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> >  #define OLPC_F_PRESENT         0x01
> >  #define OLPC_F_DCON            0x02
> > -#define OLPC_F_EC_WIDE_SCI     0x04
> 
> Still same concern, i.e. if the initially added definitions are
> coupled together by some reason, why we split them?
> As I told either move all, or none or put in commit message how
> decoupling would benefit.

I'm not moving this one -- I'm deleting it, because it's no longer used
or useful. I don't mind keeping it there if you think it should stay
though.

> > +       /* EC version 0x5f adds support for wide SCI mask */
> > +       if (ec->version >= 0x5f) {
> > +               __be16 ec_word = cpu_to_be16(bits);
> > +
> > +               return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *) &ec_word, 2, NULL, 0);
> 
> No space is needed in "(void *)&ec_word".
> 
> > +       } else {
> > +               unsigned char ec_byte = bits & 0xff;
> 
> Shouldn't be u8?
> 
> > +               return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(olpc_ec_mask_write);
> > +int olpc_ec_sci_query(u16 *sci_value)
> > +{
> > +       struct olpc_ec_priv *ec = ec_priv;
> > +       int ret;
> > +
> > +       if (WARN_ON(!ec))
> > +               return -ENODEV;
> > +
> > +       /* EC version 0x5f adds support for wide SCI mask */
> > +       if (ec->version >= 0x5f) {
> > +               __be16 ec_word;
> > +
> > +               ret = olpc_ec_cmd(EC_EXT_SCI_QUERY, NULL, 0, (void *)&ec_word, 2);
> > +               if (ret == 0)
> > +                       *sci_value = be16_to_cpu(ec_word);
> > +       } else {
> > +               unsigned char ec_byte;
> 
> u8?
> 
> > +
> > +               ret = olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
> > +               if (ret == 0)
> > +                       *sci_value = ec_byte;
> > +       }
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(olpc_ec_sci_query);

I'll follow up with fixes for the above.

Thanks.

Lubo
