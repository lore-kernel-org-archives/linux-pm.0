From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] binding-doc: power: pwrseq-generic: add binding doc
 for generic power sequence library
Date: Thu, 7 Jul 2016 16:53:07 -0700
Message-ID: <577EEB63.3020007@gmail.com>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
 <1467882892-27589-2-git-send-email-peter.chen@nxp.com>
 <1467884834.4236.36.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467884834.4236.36.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 07/07/2016 02:47 AM, Philipp Zabel wrote:
> Am Donnerstag, den 07.07.2016, 17:14 +0800 schrieb Peter Chen:
>> Add binding doc for generic power sequence library.
>>
>> Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
>> ---
>>  .../bindings/power/pwrseq/pwrseq-generic.txt       | 56 ++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>> new file mode 100644
>> index 0000000..4b23834
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>> @@ -0,0 +1,56 @@
>> +The generic power sequence library
>> +
>> +Some hard-wired USB/MMC devices need to do power sequence to let the
>> +device work normally, the typical power sequence like: enable USB
>> +PHY clock, toggle reset pin, etc. But current Linux USB driver
>> +lacks of such code to do it, it may cause some hard-wired USB devices
>> +works abnormal or can't be recognized by controller at all. The
>> +power sequence will be done before this device can be found at USB
>> +bus.
>> +
>> +The power sequence properties is under the device node.
>> +
>> +Required properties:
>> +- power-sequence: this device needs to do power sequence before enumeration
>> +
>> +Optional properties:
>> +- clocks: the input clock for device.
>> +- clock-name: must be "pwrseq-clk"
> The "-clk" in the clock name is redundant.
>
>> +- pwrseq-reset-gpios: Should specify the GPIO for reset.
>> +- pwrseq-reset-duration-us: the duration in microsecond for assert reset signal.
> I understand you want to make it explicit that this GPIO is for the
> pwrseq library, but are we really gaining anything over just calling
> these reset-gpios and reset-duration-us?
> The same applies to the clock name above.
using  reset-gpios makes sense to  me too.
The above "power-sequence" might then be better called "reset-on-init",
But really, if a device has a reset gpio shouldn't the default behavior be to
reset it on boot and when coming back from sleep?
Is a special property even needed?
>
>> +Below is the example of USB power sequence properties on USB device
>> +nodes which have two level USB hubs.
>> +
>> +&usbotg1 {
>> +	vbus-supply = <&reg_usb_otg1_vbus>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usb_otg1_id>;
>> +	status = "okay";
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	hub: genesys@1 {
>> +		compatible = "usb5e3,608";
>> +		reg = <1>;
>> +
>> +		power-sequence;
>> +		clocks = <&clks IMX6SX_CLK_CKO>;
>> +		clock-names = "pwrseq-clk";
>> +		pwrseq-reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
>> +		pwrseq-reset-duration-us = <10>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		ethernet: asix@1 {
>> +			compatible = "usbb95,1708";
>> +			reg = <1>;
>> +
>> +			power-sequence;
>> +			clocks = <&clks IMX6SX_CLK_IPG>;
>> +			clock-names = "pwrseq-clk";
>> +			pwrseq-reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
>> +			pwrseq-reset-duration-us = <15>;
>> +		};
> This looks weird. The hub and ethernet chips don't have "pwrseq" clock
> and reset input pins. I'd remove the clock-names and pwrseq- reset
> prefix.
>
> regards
> Philipp
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
