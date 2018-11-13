From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 04/15] Platform: OLPC: Remove an unused include
Date: Tue, 13 Nov 2018 14:59:18 +0100
Message-ID: <5a4c548be4cf9fb3fb6ce5128d6780eea3005215.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-5-lkundrak@v3.sk>
         <CAHp75Veb++-F3yd9r5h305UQFvBFosRQvmPDfTTMFak9ZNVc7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Veb++-F3yd9r5h305UQFvBFosRQvmPDfTTMFak9ZNVc7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.or
List-Id: linux-pm@vger.kernel.org

Hi,

thank you for the response.

On Fri, 2018-10-19 at 16:05 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > Also, the header is x86 specific, while there are non-x86 OLPC
> > machines.
> 
> Same concern. as per patch 2.

Which concern? If it's that it doesn't make sense in that particular
place in the patch set, then I don't think so; this header is
unnecessary and the patch has no other dependencies. But the changes
that enable the OLPC EC platform code depend on this.

> Also, you might want to sort headers in alphabetical order.

But should I? Doing so in the same commit would obscure the actual
change, and a separate commit would needlessly clobber git annotate.

Thank you
Lubo

> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/platform/olpc/olpc-ec.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/platform/olpc/olpc-ec.c
> > b/drivers/platform/olpc/olpc-ec.c
> > index f99b183d5296..35a21c66cd0d 100644
> > --- a/drivers/platform/olpc/olpc-ec.c
> > +++ b/drivers/platform/olpc/olpc-ec.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/module.h>
> >  #include <linux/list.h>
> >  #include <linux/olpc-ec.h>
> > -#include <asm/olpc.h>
> > 
> >  struct ec_cmd_desc {
> >         u8 cmd;
> > --
> > 2.19.0
> > 
> 
> 
