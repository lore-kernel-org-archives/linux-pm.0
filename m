From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Tue, 23 Oct 2018 19:03:26 +0200
Message-ID: <734019816c2a8e1930127332249b1180f6d0cddc.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <CAHp75Vd_9RmfDFnSzkNOQyfKVOR1tfzbMPy0_J7_DfZ2e4A16g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAHp75Vd_9RmfDFnSzkNOQyfKVOR1tfzbMPy0_J7_DfZ2e4A16g@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2018-10-19 at 16:57 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
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
> 
> The
> 
> > already sent out separately, but I'm including it because the last
> > commit of the set depends on it.
> > 
> > Tested to work on an OLPC XO 1.75 and also tested not to break x86
> > support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> > unlikely this breaks it when XO 1 works.
> > 
> > Thanks in advance for reviews and feedback of any kind.
> 
> Thanks for the series.
> I'm about to review the patch 6, otherwise read my comments for the
> rest and consider addressing them.

Thank you very much for your feedback, it is very appreciated.

The XO 1.75 patch set has grown somewhat larger than I'm comfortable
with, so I need some time to digest and address the review. I hope I'll
be able to post a v2 some time after the 4.20 merge window closes and
respond to questions raised in individual patches before that.

> 
> > Lubo
> > 
> 
> 
