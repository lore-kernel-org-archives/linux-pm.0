From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Tue, 26 May 2015 14:16:55 +0200 (CEST)
Message-ID: <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
 <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <20150507193236.GS22845@sirena.org.uk>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150507193236.GS22845@sirena.org.uk>
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


> Mark Brown <broonie@kernel.org> hat am 7. Mai 2015 um 21:32 geschrieben:
>
>
> On Thu, May 07, 2015 at 09:25:19PM +0200, Stefan Wahren wrote:
> > > Mark Brown <broonie@kernel.org> hat am 7. Mai 2015 um 20:52 geschrieben:
>
> > > > In the bootloader code enabling the DC-DC is critical. There is a known
> > > > issue
> > > > which falsely triggers the brownout detection.
>
> > > Why would the driver not provide these operations?
>
> > I didn't implement this operation because the suggested workaround for the
> > hardware issue isn't very nice
> > (disable brownout detection during enabling DC-DC). I was afraid of the
> > implementation.
>
> That doesn't sound too complicated?
>

Okay, i think i managed the brownout handling.

Unfortunately i'm stuck at the next step. The DC-DC (3 way output) can supply 3
LDOs vddd, vdda, vddio. In case of a DC-DC state change the 3 regulators needs
to be reconfigured before.

I tought of REGULATOR_EVENT_PRE_DISABLE and REGULATOR_EVENT_PRE_ENABLE events,
but i'm not sure that's the right way to achieve a synchronization between DC-DC
and consuming LDOs.
