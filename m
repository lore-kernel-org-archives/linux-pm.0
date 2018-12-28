From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] firmware: imx: scu-pd: add fallback compatible string
 support
Date: Fri, 28 Dec 2018 14:24:27 +0100
Message-ID: <CAPDyKFokg+Rg9cBDF2WM6udx-T3GiNRTkXsn=u=JO9LP=0F55A@mail.gmail.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211FB9C3BA2CBBDB58F03FC80B70@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AM0PR04MB4211FB9C3BA2CBBDB58F03FC80B70@AM0PR04MB4211.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 Dec 2018 at 03:38, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Sorry, missed DT guys.
>
> Hi Rob & Ulf,
>
> Would you help review this patch series?

This is DT changes, so I didn't look until now.

>
> Regards
> Dong Aisheng
>
> > -----Original Message-----
> > From: Aisheng Dong
> > Sent: Wednesday, December 19, 2018 12:01 AM
> >
> > SCU power domain can be used in the same way by IMX8QXP and IMX8QM
> > SoCs.
> > Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs to reuse
> > the common part.
> >
> > Dong Aisheng (3):
> >   dt-bindings: fsl: scu: add fallback compatible string for power domain
> >   dt-bindings: fsl: scu: add imx8qm scu power domain support
> >   firmware: imx: scu-pd: add fallback compatible string support
> >
> >  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 8 ++++++--
> >  drivers/firmware/imx/scu-pd.c                               | 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > --
> > 2.7.4
>

For series, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
