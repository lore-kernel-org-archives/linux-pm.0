From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V6 1/3] dt-bindings: fsl: scu: make power domain
 compatible string SoC specific
Date: Thu, 18 Oct 2018 15:47:09 +0000
Message-ID: <AM0PR04MB421173A3DD4B77F21353FFC280F80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539760797-12991-1-git-send-email-aisheng.dong@nxp.com>
 <1539760797-12991-2-git-send-email-aisheng.dong@nxp.com>
 <20181018143342.GA22874@bogus>
 <AM0PR04MB42110D63D97B31830B5EC93580F80@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAL_JsqKNvohQs16B0xGNJ9gbDDR7SU+mF6VUwf2V8CyP0jwE3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqKNvohQs16B0xGNJ9gbDDR7SU+mF6VUwf2V8CyP0jwE3w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Dong Aisheng <dongas86@gmail.com>, Kevin Hilman <khilman@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Thursday, October 18, 2018 11:39 PM
[...]
> On Thu, Oct 18, 2018 at 10:08 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> >
> > > -----Original Message-----
> > > From: Rob Herring [mailto:robh@kernel.org]
> > > Sent: Thursday, October 18, 2018 10:34 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > [...]
> > > On Wed, Oct 17, 2018 at 07:24:40AM +0000, A.s. Dong wrote:
> > > > As the power domain API might change in the future for new SoCs,
> > > > although in a very low possibility, it's still better to make the
> > > > compatible string more SoC specific to avoid the possible version
> > > > change for
> > > new SoCs.
> > > >
> > > > Due to there're still no users in kernel, it's safe to update it
> > > > without breaking anything.
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > >
> > > checkpatch says:
> > >
> > > WARNING: Missing Signed-off-by: line by nominal patch author 'A.s.
> > > Dong <aisheng.dong@nxp.com>'
> > >
> >
> > Do you think if we can ignore this warning?
> 
> Probably, but better if you can fix it.
> 
> > It seems checkpatch checks the email sender name as nominal patch
> > author which is abbreviated as 'A.S. Dong'. But I always use the full
> > name in upstreaming patches.
> 
> The patch contents should start with a 'From:' line if your sending email
> doesn't match the patch author (such as when you sent another author's
> patch). Maybe it did match and your email server is overwriting it. I would
> imagine that can be fixed.
> 

Yes, I will try to fix it. Thanks for the suggestion.
As this may be related to our email server, probably may not be able to fixe so quick
for this patch resend. Please let me know if you mind it.

> > > > ---
> > > > ChangeLog:
> > > > v5->v6:
> > > >  * new patch
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4
> > > > ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > index 46d0af1..87fc4b4 100644
> > > > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > @@ -58,7 +58,7 @@ This binding for the SCU power domain providers
> > > > uses the generic power  domain binding[2].
> > > >
> > > >  Required properties:
> > > > -- compatible:              Should be "fsl,scu-pd".
> > > > +- compatible:              Should be "fsl,imx8qxp-scu-pd".
> > >
> > > You can keep both if you think future SoCs will be compatible.
> > >
> >
> > They're likely to be compatible AFAIK.
> >
> > Just to be clear, you mean keep both of them?
> 
> Yes, but...
> > e.g.
> > compatible: Should be "fsl,imx8qxp-scu-pd" or "fsl,scu-pd"
> 
> Not exactly, "fsl,scu-pd" should be a fallback and the driver can match on that
> (until you need to distinguish). So like this:
> 
> Should be one of:
>   "fsl,imx8qxp-scu-pd"
> followed by "fsl,scu-pd"
> 
> > Can you please help clarify a bit more on why it's better to do that
> > as I'm not quite Understand?
> >
> > And for later when mx8qm is supported, should we add it again as follows?
> > compatible: Should be "fsl,imx8qm-scu-pd", "fsl,imx8qxp-scu-pd" or
> "fsl,scu-pd"
> 
> If formatted as above, then it is a one line change to add:
> 
> Should be one of:
>   "fsl,imx8qm-scu-pd"
>   "fsl,imx8qxp-scu-pd"
> followed by "fsl,scu-pd"
> 

Much clear now.
Thanks for the clarification.

Regards
Dong Aisheng

> Rob
