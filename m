From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V5 1/5] dt-bindings: arm: fsl: add scu binding doc
Date: Fri, 24 Aug 2018 09:51:47 +0000
Message-ID: <AM0PR04MB4211D1CB3DE05AF148E94AAD80360@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-2-git-send-email-aisheng.dong@nxp.com>
 <20180820181155.GA13901@bogus>
 <AM0PR04MB4211B9113831B292110C709280310@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1+J+=nV2gNN30KLr2YQDy_g81-dJS1DJq8NgUv7Qqcog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABb+yY1+J+=nV2gNN30KLr2YQDy_g81-dJS1DJq8NgUv7Qqcog@mail.gmail.com>
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
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Dong Aisheng <dongas86@gmail.com>, Devicetree List <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, ",
 Sascha Hauer" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
> On Tue, Aug 21, 2018 at 8:30 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> >
> > > > +
> > > > +The System Controller Firmware (SCFW) is a low-level system
> > > > +function which runs on a dedicated Cortex-M core to provide
> > > > +power, clock, and resource management. It exists on some i.MX8
> > > > +processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > > +
> > > > +The AP communicates with the SC using a multi-ported MU module
> > > > +found in the LSIO subsystem. The current definition of this MU
> > > > +module provides
> > > > +5 remote AP connections to the SC to support up to 5 execution
> > > > +environments (TZ, HV, standard Linux, etc.). The SC side of this
> > > > +MU module interfaces with the LSIO DSC IP bus. The SC firmware
> > > > +will communicate with this MU using the MSI bus.
> > >
> > > How are 5 users supported with only 4 channels defined below?
> >
> > There're 5 MU instances designed to be specifically communicate with
> > SCU Firmware on MX8 hardware.
> >
> This is correct.
> 
> > With the new generic mu binding [1], each MU instance is abstracted
> > Into 16 virtual MU channels. (4 Tx, 4 Rx, 4 Tx doorbell, 4 Rx doorbell).
> > (MU has 4 pair of Tx/Rx data register which can be used to
> > send/receive multi words. With new binding, each data register is
> > abstracted into one MU channel, totally 8 channels for data transfer).
> >
> > SCU protocol is already designed to uses all data registers to
> > send/receive multi words according to MU hardware reference manual. So
> > it must use all channels in one MU instances with new binding.
> >
> FYI, this is incorrect.
> The 16 channels are physical and not virtual. In fact, all this is to avoid virtual
> channels.
> The physical resources required by new bindings are exactly the same as by old
> bindings. Now you use 8 physical channels instead of 1 virtual.

Okay, got it.
I'm fine to refer to them all as physical channels.
Thanks

Regards
Dong Aisheng
