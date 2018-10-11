From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Thu, 11 Oct 2018 12:42:24 +0200
Message-ID: <40e6a8575d4bdc43cc069e561e12f404983c5567.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <CAL_Jsq+MYBrkZ=OEv3avxC_NZ+q3+stOF8CsHeXUsomKZD9+AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAL_Jsq+MYBrkZ=OEv3avxC_NZ+q3+stOF8CsHeXUsomKZD9+AA@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-10-10 at 14:26 -0500, Rob Herring wrote:
> On Wed, Oct 10, 2018 at 12:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Hi.
> > 
> > This patchset adds support for the Embedded Controller on an OLPC XO
> > 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> > the existing OLPC platform infrastructure, currently used by the x86
> > based models.
> > 
> > The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> > uses extra handshake signal to signal readiness of SOC to accept data
> > from EC and to initiate a transaction if SOC wishes to submit data.
> > 
> > The SPI slave support for MMP2 was submitted separately:
> > https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t
> > 
> > THe "power: supply: olpc_battery: correct the temperature" patch was
> > already sent out separately, but I'm including it because the last
> > commit of the set depends on it.
> > 
> > Tested to work on an OLPC XO 1.75 and also tested not to break x86
> > support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> > unlikely this breaks it when XO 1 works.
> 
> I asked this on the OLPC devel list recently, but I don't think my
> message ever got past the moderator. Could you generate a DT dump from
> /proc/device-tree of an XO 1 and send to me? I have some DT changes
> planned and need to see if they'd be okay for x86 OLPC.

The /proc/device-tree tarball: http://v3.sk/~lkundrak/olpc/xo1.tar
(Mirror: https://people.freedesktop.org/~lkundrak/olpc/xo1.tar)

My distro's dtc crashes with this (could be related to your recent dtc
fixes), the git tip needs -f to work around some funny property names.
I figure a raw data as opposed to a dts/dtb dump would be a better
idea.

Also, there's no phandles, so it's of rather limited use. If you need
those, then I can share a dump directly from ofw instead or patch the
kernel to fabricate and expose the phandle properties.

This is with the latest firmware. I guess the exact version is
somewhere within the device tree.

> 
> Rob

Cheers
Lubo
