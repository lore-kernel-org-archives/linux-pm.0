From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Fri, 24 Jun 2016 12:50:14 -0500
Message-ID: <20160624175014.GA29990@rob-hp-laptop>
References: <1466622436-27963-1-git-send-email-karl-heinz@schneider-inet.de>
 <1466622436-27963-2-git-send-email-karl-heinz@schneider-inet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466622436-27963-2-git-send-email-karl-heinz@schneider-inet.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 22, 2016 at 09:07:15PM +0200, Karl-Heinz Schneider wrote:
> This patch adds device tree documentation for the sbs-manager
> 
> Reviewed-by: Phil Reid <preid@electromag.com.au>
> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> ---
>  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> new file mode 100644
> index 0000000..d52b466
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> @@ -0,0 +1,58 @@
> +Binding for sbs-manager
> +
> +Required properties:
> +- compatible: should be "sbs,sbs-manager" or "lltc,ltc1760" if device is a
> +    ltc1760.

sbs is not a vendor. What chip is sbs-manager? I suspect you should drop 
it and only list specific chips.

> +- reg: integer, i2c address of the device. Should be <0xa>.
> +
> +Optional properties:
> +- sbsm,i2c-retry-count: integer, number of retries for trying to read or write
> +    to registers. Default: 1

Seems like a driver setting. Is having a retry in the driver a problem 
if the h/w works and never actually needs it?

> +
> +From OS view the device is basically an i2c-mux used to communicate with up to
> +four smart battery devices at address 0xb. The driver actually implements this
> +behaviour. So standard i2c-mux nodes can be used to register up to four slave
> +batteries. Channels will be numerated as 1, 2, 4 and 8.
> +
> +Example:
> +
> +batman@0a {
> +    compatible = "sbs,sbs-manager";
> +    reg = <0x0a>;
> +    sbsm,i2c-retry-count = <3>;
> +    #address-cells = <1>;
> +    #size-cells = <0>;
> +
> +    channel1@1 {

channel@1

Do we have a standard node name for mux nodes? If not, we should.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <1>;
> +
> +        battery1@0b {

battery@b

> +            compatible = "sbs-battery";

This should be an actual battery model. Or all this information is 
generic, you don't really need it in DT.

> +            reg = <0x0b>;
> +        };
> +    };
> +
> +    channel2@2 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <2>;
> +
> +        battery2@0b {
> +            compatible = "sbs-battery";
> +            reg = <0x0b>;
> +        };
> +    };
> +
> +    channel3@4 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <4>;
> +
> +        battery3@0b {
> +            compatible = "sbs-battery";
> +            reg = <0x0b>;
> +        };
> +    };
> +};
> -- 
> 1.9.1
> 
