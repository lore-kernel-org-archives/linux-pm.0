From: Simon Arlott <simon@fire.lp0.eu>
Subject: Re: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
Date: Fri, 11 Dec 2015 20:36:19 +0000
Message-ID: <566B33C3.3060809@simon.arlott.org.uk>
References: <5668AB4F.7030100@simon.arlott.org.uk>
 <20151211025844.GA5251@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:57272 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbbLKUgm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Dec 2015 15:36:42 -0500
In-Reply-To: <20151211025844.GA5251@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kevin Cernekee <cernekee@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, MIPS Mailing List <linux-mips@linux-mips.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>

On 11/12/15 02:58, Rob Herring wrote:
> On Wed, Dec 09, 2015 at 10:29:35PM +0000, Simon Arlott wrote:
>> The BCM6358 contains power domains controlled with a register. Power
>> domains are indexed by bits in the register. Power domain bits can be
>> interleaved with other status bits and clocks in the same register.
>> 
>> Newer SoCs with dedicated power domain registers are active low.
>> 
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>> ---
>>  .../power/brcm,bcm6358-power-controller.txt        | 53 ++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
>> new file mode 100644
>> index 0000000..556c323
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
>> @@ -0,0 +1,53 @@
>> +Broadcom BCM6358 Power domain controller
>> +
>> +This binding uses the power domain bindings:
>> +        Documentation/devicetree/bindings/power/power_domain.txt
>> +
>> +The BCM6358 contains power domains controlled with a register. Power
>> +domains are indexed by bits in the register. Power domain bits can be
>> +interleaved with other status bits and clocks in the same register.
>> +
>> +Newer SoCs with dedicated power domain registers are active low.
>> +
>> +Required properties:
>> +- compatible:           Should be "brcm,bcm<soc>-power-controller", "brcm,bcm6358-power-controller"
>> +- #power-domain-cells:  Should be <1>.
>> +- regmap:               The register map phandle
>> +- offset:               Offset in the register map for the power domain register (in bytes)
>> +- power-domain-indices: The bits in the register used for power domains.
> 
> You should drop this and make the cell values be the register offsets.

I need to register every power domain in order to get the kernel to turn
off those that are unused. Even if I could enumerate all device tree
devices that reference the power-controller node, not all of them have
bindings to allow them to be specified in the device tree file.

I can't register all 32 bits because that won't work on the BCM6358 that
only has 1 power domain bit in the register and several clock bits. On
the BCM63268 there are power domain bits that have no device that I
don't want the kernel to disable (like the memory controller).

How should I determine which bits to register a power domain for?

	misc_iddq_ctrl: power-controller@1000184c {
		compatible = "brcm,bcm6358-power-controller";
		regmap = <&misc>;
		offset = <0x4c>;

		mask = <0x1043fff>;

		#power-domain-cells = <1>;
	};

or

	misc_iddq_ctrl: power-controller@1000184c {
		compatible = "brcm,bcm6358-power-controller";
		regmap = <&misc>;
		offset = <0x4c>;

		#address-cells = <1>;
		#size-cells = <0>;

		sar: power-controller@0 {
			reg = <0>;
			#power-domain-cells = <0>;
		};

		ipsec: power-controller@1 {
			reg = <1>;
			#power-domain-cells = <0>;
		};

		...
	};

or something else?

>> +- power-domain-names:   Should be a list of strings of power domain names
>> +                        indexed by the power domain indices.
> 
> This isn't really needed anyway.

If I remove this then I'll have to use the same node name for each
struct generic_pm_domain "name" field that I register, although these
names don't appear to be exported anywhere.

>> +
>> +Optional properties:
>> +- active-low:           Specify that the bits are active low.
> 
> This should be implied by the compatible property.

Ok, I'll create "brcm,bcm6358-power-controller" that's active high and
"brcm,bcm6328-power-controller" that's active low. This appear to be
the earliest chips that introduced or changed "iddq" register bits.

-- 
Simon Arlott
