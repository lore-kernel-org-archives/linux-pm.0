From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V5 1/5] dt-bindings: arm: fsl: add scu binding doc
Date: Tue, 21 Aug 2018 03:00:34 +0000
Message-ID: <AM0PR04MB4211B9113831B292110C709280310@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-2-git-send-email-aisheng.dong@nxp.com>
 <20180820181155.GA13901@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180820181155.GA13901@bogus>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, August 21, 2018 2:12 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com;
> kernel@pengutronix.de; shawnguo@kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; Mark
> Rutland <mark.rutland@arm.com>; Jassi Brar <jassisinghbrar@gmail.com>;
> Linus Walleij <linus.walleij@linaro.org>; Stephen Boyd <sboyd@kernel.org>;
> Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf Hansson
> <ulf.hansson@linaro.org>; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; linux-gpio@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: Re: [PATCH V5 1/5] dt-bindings: arm: fsl: add scu binding doc
> 
> On Tue, Aug 21, 2018 at 12:08:21AM +0800, Dong Aisheng wrote:
> > The System Controller Firmware (SCFW) is a low-level system function
> > which runs on a dedicated Cortex-M core to provide power, clock, and
> > resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > (QM, QP), and i.MX8QX (QXP, DX).
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-gpio@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v4->v5:
> >  * scu node should be under firmware node
> >  * add pd/clk/pinctrl binding as well according to Rob's suggestion
> >  * switch to new generic MU binding
> >    Use 8 separate mu channels in one MU instance for SCU communication
> > v3->v4:
> >  * fully change to mailbox binding
> >  * add child node description
> > v2->v3:
> >  * update a bit to mailbox binding
> > v1->v2:
> >  * remove status
> >  * changed to mu1
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 179
> > +++++++++++++++++++++
> >  1 file changed, 179 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > new file mode 100644
> > index 0000000..2cd7e4a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > @@ -0,0 +1,179 @@
> > +NXP i.MX System Controller Firmware (SCFW)
> > +--------------------------------------------------------------------
> 
> Think you wanted a newline here              ^?

Yes, of course.
It seems to be introduced by mistake.
Thanks for reminder.

> 
> > +
> > +The System Controller Firmware (SCFW) is a low-level system function
> > +which runs on a dedicated Cortex-M core to provide power, clock, and
> > +resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > +(QM, QP), and i.MX8QX (QXP, DX).
> > +
> > +The AP communicates with the SC using a multi-ported MU module found
> > +in the LSIO subsystem. The current definition of this MU module
> > +provides
> > +5 remote AP connections to the SC to support up to 5 execution
> > +environments (TZ, HV, standard Linux, etc.). The SC side of this MU
> > +module interfaces with the LSIO DSC IP bus. The SC firmware will
> > +communicate with this MU using the MSI bus.
> 
> How are 5 users supported with only 4 channels defined below?

There're 5 MU instances designed to be specifically communicate with
SCU Firmware on MX8 hardware.

With the new generic mu binding [1], each MU instance is abstracted
Into 16 virtual MU channels. (4 Tx, 4 Rx, 4 Tx doorbell, 4 Rx doorbell).
(MU has 4 pair of Tx/Rx data register which can be used to send/receive
multi words. With new binding, each data register is abstracted into one
MU channel, totally 8 channels for data transfer).

SCU protocol is already designed to uses all data registers to send/receive
multi words according to MU hardware reference manual. So it must
use all channels in one MU instances with new binding.

On MX8, it can be one of LSIO MU0~M4.
 
[1] https://patchwork.kernel.org/patch/10554565/

> 
> > +
> > +System Controller Device Node:
> >
> +=========================================================
> ===
> > +
> > +The scu node with the following properties shall be under the /firmware/
> node.
> > +
> > +Required properties:
> > +-------------------
> > +- compatible:	should be "fsl,imx-scu".
> > +- mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
> > +			       "rx0", "rx1", "rx2", "rx3".
> > +- mboxes:	List of phandle of 4 MU channels for tx and 4 MU channels
> > +		for rx. All 8 MU channels must be in the same MU instance.
> > +		Cross instances are not allowed. The MU instance can only
> > +		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users
> need
> > +		to make sure use the one which is not conflict with other
> > +		execution environments. e.g. ATF.
> 
> How is one supposed to know what channels are in use already?
> 

Currently it's simply predefined.
E.g. ATF uses MU0 and u-Boot & Kernel uses MU1.

> IMO, ATF should remove the channel it uses before passing the DT to the
> next stage. 

Sounds like a good idea.
To be more specific, you mean simply marking the MU node status used in ATF
to be "disabled" before passing to the next stage, am I understand correct?

> That doesn't help if later stages get a different DT though.

Doesn't help? Sorry a bit confusing...

> 
> > +		Note:
> > +		Channel 0 must be "tx0" or "rx0".
> > +		Channel 1 must be "tx1" or "rx1".
> > +		Channel 2 must be "tx2" or "rx2".
> > +		Channel 3 must be "tx3" or "rx3".
> > +		e.g.
> > +		mboxes = <&lsio_mu1 0 0
> > +			  &lsio_mu1 0 1
> > +			  &lsio_mu1 0 2
> > +			  &lsio_mu1 0 3
> > +			  &lsio_mu1 1 0
> > +			  &lsio_mu1 1 1
> > +			  &lsio_mu1 1 2
> > +			  &lsio_mu1 1 3>;
> > +		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> > +		for detailed mailbox binding.
> > +
> > +i.MX SCU Client Device Node:
> >
> +=========================================================
> ===
> > +
> > +Client nodes are maintained as children of the relevant IMX-SCU device
> node.
> > +
> > +Power domain bindings based on SCU Message Protocol
> > +------------------------------------------------------------
> > +
> > +This binding for the SCU power domain providers uses the generic
> > +power domain binding[2].
> > +
> > +Required properties:
> > +- compatible:		Should be "fsl,scu-pd".
> > +- #address-cells:	Should be 1.
> > +- #size-cells:		Should be 0.
> > +
> > +Required properties for power domain sub nodes:
> > +- #power-domain-cells:	Must be 0.
> > +
> > +Optional Properties:
> > +- reg:			Resource ID of this power domain.
> > +			No exist means uncontrollable by user.
> > +			See detailed Resource ID list from:
> > +			include/dt-bindings/power/imx-rsrc.h
> > +- power-domains:	phandle pointing to the parent power domain.
> > +
> > +Clock bindings based on SCU Message Protocol
> > +------------------------------------------------------------
> > +
> > +This binding uses the common clock binding[1].
> > +
> > +Required properties:
> > +- compatible:		Should be "fsl,imx8qxp-clock".
> > +- #clock-cells:		Should be 1. Contains the Clock ID value.
> 
> There was a recent patch adding input clocks to other i.MX CCM bindings.
> Is that needed here?
> 

Will double check it, thanks for reminder.

Regards
Dong Aisheng

> > +
> > +The clock consumer should specify the desired clock by having the
> > +clock ID in its "clocks" phandle cell.
> > +
> > +See the full list of clock IDs from:
> > +include/dt-bindings/clock/imx8qxp-clock.h
> > +
> > +Pinctrl bindings based on SCU Message Protocol
> > +------------------------------------------------------------
> > +
> > +This binding uses the i.MX common pinctrl binding[3].
> > +
> > +Required properties:
> > +- compatible:		Should be "fsl,imx8qxp-iomuxc".
> > +
> > +Required properties for Pinctrl sub nodes:
> > +- fsl,pins:		Each entry consists of 3 integers which represents
> > +			the mux and config setting for one pin. The first 2
> > +			integers <pin_id mux_mode> are specified using a
> > +			PIN_FUNC_ID macro, which can be found in
> > +			<dt-bindings/pinctrl/pads-imx8qxp.h>.
> > +			The last integer CONFIG is the pad setting value like
> > +			pull-up on this pin.
> > +
> > +			Please refer to i.MX8QXP Reference Manual for
> detailed
> > +			CONFIG settings.
> > +
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +[2] Documentation/devicetree/bindings/power/power_domain.txt
> > +[3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
> > +
> > +Example (imx8qxp):
> > +-------------
> > +lsio_mu1: mailbox@5d1c0000 {
> > +	...
> > +	#mbox-cells = <2>;
> > +};
> > +
> > +firmware {
> > +	scu {
> > +		compatible = "fsl,imx-scu";
> > +		mbox-names = "tx0", "tx1", "tx2", "tx3",
> > +			     "rx0", "rx1", "rx2", "rx3";
> > +		mboxes = <&lsio_mu1 0 0
> > +			  &lsio_mu1 0 1
> > +			  &lsio_mu1 0 2
> > +			  &lsio_mu1 0 3
> > +			  &lsio_mu1 1 0
> > +			  &lsio_mu1 1 1
> > +			  &lsio_mu1 1 2
> > +			  &lsio_mu1 1 3>;
> > +
> > +		clk: clk {
> > +			compatible = "fsl,imx8qxp-clk";
> > +			#clock-cells = <1>;
> > +		};
> > +
> > +		iomuxc {
> > +			compatible = "fsl,imx8qxp-iomuxc";
> > +
> > +			pinctrl_lpuart0: lpuart0grp {
> > +				fsl,pins = <
> > +					SC_P_UART0_RX_ADMA_UART0_RX
> 	0x06000020
> > +					SC_P_UART0_TX_ADMA_UART0_TX
> 	0x06000020
> > +				>;
> > +			};
> > +			...
> > +		};
> > +
> > +		imx8qx-pm {
> > +			compatible = "fsl,scu-pd";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			pd_dma: dma-power-domain {
> > +				#power-domain-cells = <0>;
> > +
> > +				pd_dma_lpuart0: dma-lpuart0@57 {
> > +					reg = <SC_R_UART_0>;
> > +					#power-domain-cells = <0>;
> > +					power-domains = <&pd_dma>;
> > +				};
> > +				...
> > +			};
> > +			...
> > +		};
> > +	};
> > +};
> > +
> > +serial@5a060000 {
> > +	...
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_lpuart0>;
> > +	clocks = <&clk IMX8QXP_UART0_CLK>,
> > +		 <&clk IMX8QXP_UART0_IPG_CLK>;
> > +	clock-names = "per", "ipg";
> > +	power-domains = <&pd_dma_lpuart0>;
> > +};
> > --
> > 2.7.4
> >
