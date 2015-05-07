From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Thu, 7 May 2015 20:37:18 +0200 (CEST)
Message-ID: <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: fabio.estevam@freescale.com, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, sebastien.szymanski@armadeus.com, Shawn Guo <shawn.guo@linaro.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 4. Mai 2015 um 22:34
> geschrieben:
>
>
> Hi Mark,
>
> > Mark Brown <broonie@kernel.org> hat am 4. Mai 2015 um 14:36 geschrieben:
> >
> >
> > On Wed, Apr 29, 2015 at 10:32:26PM +0000, Stefan Wahren wrote:
> >
> > > +static struct regulator_ops mxs_dcdc_ops = {
> > > + .is_enabled = regulator_is_enabled_regmap,
> > > +};
> >
> > Why do we have an is_enabled() operation but no enable or disable
> > operation?
>
> i'm sorry, i forgot the following point in the changelog:
>
> - move dcdc handling from mxs_power to mxs-regulator
>
> I hope the change is okay. I implemented only is_enabled() to have at least 1
> operation.
> But it's not really necessary.

do we need enable / disable operation?

In the bootloader code enabling the DC-DC is critical. There is a known issue
which falsely triggers the brownout detection.

>
> > I'm also not 100% clear what code the DCDCs and LDOs are
> > sharing here...
>
> Actually only probing and the regulator info structure.

How can i improve that?

>
> Best regards
> Stefan
