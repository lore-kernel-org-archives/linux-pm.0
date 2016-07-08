From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 1/6] binding-doc: power: pwrseq-generic: add binding doc
 for generic power sequence library
Date: Fri, 8 Jul 2016 10:37:17 +0800
Message-ID: <20160708023717.GC27779@shlinux2>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
 <1467882892-27589-2-git-send-email-peter.chen@nxp.com>
 <1467884834.4236.36.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1467884834.4236.36.camel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: mark.rutland@arm.com, Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, stephen.boyd@linaro.org, k.kozlowski@samsung.com, festevam@gmail.com, pawel.moll@arm.com, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, arnd@arndb.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 07, 2016 at 11:47:14AM +0200, Philipp Zabel wrote:
> Am Donnerstag, den 07.07.2016, 17:14 +0800 schrieb Peter Chen:
> > Add binding doc for generic power sequence library.
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  .../bindings/power/pwrseq/pwrseq-generic.txt       | 56 ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > new file mode 100644
> > index 0000000..4b23834
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > @@ -0,0 +1,56 @@
> > +The generic power sequence library
> > +
> > +Some hard-wired USB/MMC devices need to do power sequence to let the
> > +device work normally, the typical power sequence like: enable USB
> > +PHY clock, toggle reset pin, etc. But current Linux USB driver
> > +lacks of such code to do it, it may cause some hard-wired USB devices
> > +works abnormal or can't be recognized by controller at all. The
> > +power sequence will be done before this device can be found at USB
> > +bus.
> > +
> > +The power sequence properties is under the device node.
> > +
> > +Required properties:
> > +- power-sequence: this device needs to do power sequence before enumeration
> > +
> > +Optional properties:
> > +- clocks: the input clock for device.
> > +- clock-name: must be "pwrseq-clk"
> 
> The "-clk" in the clock name is redundant.
> 
> > +- pwrseq-reset-gpios: Should specify the GPIO for reset.
> > +- pwrseq-reset-duration-us: the duration in microsecond for assert reset signal.
> 
> I understand you want to make it explicit that this GPIO is for the
> pwrseq library, but are we really gaining anything over just calling
> these reset-gpios and reset-duration-us?
> The same applies to the clock name above.
> 
> > +Below is the example of USB power sequence properties on USB device
> > +nodes which have two level USB hubs.
> > +
> > +&usbotg1 {
> > +	vbus-supply = <&reg_usb_otg1_vbus>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_usb_otg1_id>;
> > +	status = "okay";
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	hub: genesys@1 {
> > +		compatible = "usb5e3,608";
> > +		reg = <1>;
> > +
> > +		power-sequence;
> > +		clocks = <&clks IMX6SX_CLK_CKO>;
> > +		clock-names = "pwrseq-clk";
> > +		pwrseq-reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
> > +		pwrseq-reset-duration-us = <10>;
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		ethernet: asix@1 {
> > +			compatible = "usbb95,1708";
> > +			reg = <1>;
> > +
> > +			power-sequence;
> > +			clocks = <&clks IMX6SX_CLK_IPG>;
> > +			clock-names = "pwrseq-clk";
> > +			pwrseq-reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
> > +			pwrseq-reset-duration-us = <15>;
> > +		};
> 
> This looks weird. The hub and ethernet chips don't have "pwrseq" clock
> and reset input pins. I'd remove the clock-names and pwrseq- reset
> prefix.
> 

I agree with you, and will keep property name like last version [1].

-- 

Best Regards,
Peter Chen
