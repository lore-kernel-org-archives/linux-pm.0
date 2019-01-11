From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible string
 for power domain
Date: Fri, 11 Jan 2019 10:48:21 +0000
Message-ID: <AM0PR04MB42119B411244F0B1BB829D9F80850@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
 <20190111090009.GG32649@dragon> <20190111090653.GH32649@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190111090653.GH32649@dragon>
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
To: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "khilman@kernel.org" <khilman@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Shawn,

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, January 11, 2019 5:07 PM
> 
> On Fri, Jan 11, 2019 at 05:00:11PM +0800, Shawn Guo wrote:
> > On Tue, Dec 18, 2018 at 04:01:20PM +0000, Aisheng Dong wrote:
> > > SCU power domain can be used in the same way by IMX8QXP and
> IMX8QM SoCs.
> > > Let's add a "fsl,scu-pd" fallback compatible string to allow other
> > > SoCs to reuse the common part.
> >
> > This is not the practice we used to match devices with
> > compatibilities, i.e. coding the compatible string with the SoC name
> > that firstly introduces the device, and use the compatible as fallback for new
> SoCs.
> 

This is suggested by Rob that if the future SoCs are likely to be compatible.
Then we can use a general fallback compatible string like "fsl,scu-pd".
https://patchwork.kernel.org/patch/10644815/

>From SCU HW protocol point of view, they're indeed compatible.
Just varies a bit on the domains numbers. 
That's why we introduce "fsl,scu-pd".
But still keep SoC specific compatible string in case any special tricks
to ensure the ABI stability.

How do you think?

Regards
Dong Aisheng

> For example, in imx8qm device tree, we can use compatible below to get it
> work without change on kernel driver, while we still need to document the
> compatible "fsl,imx8qm-scu-pd".
> 
> 	compatible = "fsl,imx8qm-scu-pd", "fsl,imx8qxp-scu-pd";
> 
> Shawn
