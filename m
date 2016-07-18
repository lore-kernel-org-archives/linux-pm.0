From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/6] binding-doc: power: pwrseq-generic: add binding
 doc for generic power sequence library
Date: Mon, 18 Jul 2016 11:04:00 +0800
Message-ID: <20160718030400.GD31293@shlinux2>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
 <20160716223057.GA8984@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160716223057.GA8984@rob-hp-laptop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 16, 2016 at 05:30:57PM -0500, Rob Herring wrote:
> On Wed, Jul 13, 2016 at 10:06:45AM +0800, Peter Chen wrote:
> > Add binding doc for generic power sequence library.
> 
> I'd written a review on last version, but forgot to send it out. Anyway, 
> I mostly had the same comments as Philipp and Joshua. A couple of things 
> they missed...
> 
> > 
> > Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  .../bindings/power/pwrseq/pwrseq-generic.txt       | 53 ++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > new file mode 100644
> > index 0000000..186c58c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > @@ -0,0 +1,53 @@
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
> > +- reset-gpios: Should specify the GPIO for reset.
> > +- reset-duration-us: the duration in microsecond for assert reset signal.
> > +
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
> 
> genesys: hub@1
> 
> > +		compatible = "usb5e3,608";
> > +		reg = <1>;
> > +
> > +		power-sequence;
> > +		clocks = <&clks IMX6SX_CLK_CKO>;
> > +		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
> > +		reset-duration-us = <10>;
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		ethernet: asix@1 {
> 
> asix: ethernet@1
> 
> > +			compatible = "usbb95,1708";
> > +			reg = <1>;
> > +
> > +			power-sequence;
> > +			clocks = <&clks IMX6SX_CLK_IPG>;
> > +			reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
> > +			reset-duration-us = <15>;
> > +		};
> > +	};
> > +};

Will change, thanks.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
