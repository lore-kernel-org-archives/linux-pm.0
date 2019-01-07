From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 17/17] power: supply: olpc_battery: Add OLPC XO 1.75
 support
Date: Mon, 07 Jan 2019 19:02:37 +0100
Message-ID: <d541d82647338c07fa59b0f2ef63880610733505.camel@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
         <20181116162403.49854-18-lkundrak@v3.sk> <20181202233458.GE23087@wrath>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181202233458.GE23087@wrath>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2018-12-02 at 15:34 -0800, Darren Hart wrote:
> On Fri, Nov 16, 2018 at 05:24:03PM +0100, Lubomir Rintel wrote:
> > The battery and the protocol are essentially the same as OLPC XO 1.5,
> > but the responses from the EC are LSB first.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > Changes since v1:
> > - s/s16 ecword_to_cpu/u16 ecword_to_cpu/
> > - s/u16 ec_byte/u16 ec_word/
> > 
> >  drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> 
> ...
> 
> > @@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device *pdev)
> >  	if (ecver > 0x44) {
> >  		/* XO 1 or 1.5 with a new EC firmware. */
> >  		data->new_proto = 1;
> > +	} else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
> 
> This if/else blocks concerns me a bit, but I might just be missing some
> context.
> 
> This tests both ecver as well as the OF compatible string, is this reliable? Do
> we know that for all xo1.75-ec compatible nodes the ecver will be <= 0x44? Or,
> is ecver undefined? If the latter, then perhaps this test should be performed
> first?
> 
> if (of_find_compatible_node....x01.75-ec...)
> 	...
> else if (ecver > 0x44)
> 	...
> else
> 	...
> 
> And what happens when ecver == 0x44? We test for > and < but not ==, <=,
> or >= in this block

You're right, the conditionals are not correct. On XO 1.75 the
versioning is different (now at level 0x05) and uninteresting,
therefore the XO 1.75 check needs to go first.

On XO 1 and XO 1.75, we don't support < 0x44. 0x44 is okay, though uses
stays with an old protocol, and > 0x44 uses a new protocol.

Will follow up with a new version of the patch soon.

> 
> > +		/* XO 1.75 */
> > +		data->new_proto = 1;
> > +		data->little_endian = 1;
> >  	} else if (ecver < 0x44) {
> >  		/*
> >  		 * We've seen a number of EC protocol changes; this driver
> > -- 
> > 2.19.1

Thanks
Lubo
