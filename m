From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Wed, 10 Oct 2018 14:26:39 -0500
Message-ID: <CAL_Jsq+MYBrkZ=OEv3avxC_NZ+q3+stOF8CsHeXUsomKZD9+AA@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 12:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi.
>
> This patchset adds support for the Embedded Controller on an OLPC XO
> 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> the existing OLPC platform infrastructure, currently used by the x86
> based models.
>
> The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> uses extra handshake signal to signal readiness of SOC to accept data
> from EC and to initiate a transaction if SOC wishes to submit data.
>
> The SPI slave support for MMP2 was submitted separately:
> https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t
>
> THe "power: supply: olpc_battery: correct the temperature" patch was
> already sent out separately, but I'm including it because the last
> commit of the set depends on it.
>
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.

I asked this on the OLPC devel list recently, but I don't think my
message ever got past the moderator. Could you generate a DT dump from
/proc/device-tree of an XO 1 and send to me? I have some DT changes
planned and need to see if they'd be okay for x86 OLPC.

Rob
