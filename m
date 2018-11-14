From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 11/15] x86, olpc: Use a correct version when making up a
 battery node
Date: Wed, 14 Nov 2018 17:49:34 +0100
Message-ID: <85fa1566ba06f5e9ba87aad386a1400b8656904b.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-12-lkundrak@v3.sk>
         <CAHp75VdnrWUSONXwPfVD1HuON5DyGq3qF4JOJbhC-LKudhRdng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdnrWUSONXwPfVD1HuON5DyGq3qF4JOJbhC-LKudhRdng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.or
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, 2018-10-19 at 16:43 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > The XO-1 and XO-1.5 batteries apparently differ in an ability to
> > report
> > ambient temperature. Add a different compatible string to the 1.5
> > battery.
> > +int olpc_dt_compatible_match(phandle node, const char *compat)
> >  {
> >         char buf[64];
> > +       int plen;
> > +       char *p;
> > +       int len;
> > +
> > +       plen = olpc_dt_getproperty(node, "compatible", buf,
> > sizeof(buf));
> > +       if (plen <= 0)
> > +               return 0;
> > +
> > +       len = strlen(compat);
> > +       for (p = buf; p < buf + plen; p += strlen(p) + 1) {
> > +               if (strcmp(p, compat) == 0)
> > +                       return 1;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> DT doesn't still have a helper for that?!
> I hardly believe in that.

There indeed is of_device_compatible_match() (and
of_find_node_by_phandle() for that matter).

However, these fixups are executed before the DT is built with
of_pdt_build_devicetree(), so I don't think any of_*() routines can be
used at that point.

> > +               olpc_dt_interpret("\" /battery@0\" find-device"
> > +                       " \" olpc,xo1.5-battery\" +compatible"
> > +                       " device-end");
> 
> Please, don't split string literals.
> 
> >                 olpc_dt_interpret("\" /pci/display@1\" find-device"
> >                         " new-device"
> >                         " \" dcon\" device-name \" olpc,xo1-dcon\"
> > +compatible"
> >                         " finish-device device-end");
> 
> Yeah, this and similar also needs to be fixed.

Okay.

Thank you
Lubo
