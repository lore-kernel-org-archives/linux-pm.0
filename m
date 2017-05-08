From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 6/8] Documentation: Add sbs-manager device tree node
 documentation
Date: Mon, 8 May 2017 10:26:43 -0500
Message-ID: <20170508152643.cv42nvkcsf3skmy2@rob-hp-laptop>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
 <1493716346-58517-7-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34590 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755414AbdEHP0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 11:26:45 -0400
Content-Disposition: inline
In-Reply-To: <1493716346-58517-7-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>

On Tue, May 02, 2017 at 05:12:24PM +0800, Phil Reid wrote:
> From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> 
> This patch adds device tree documentation for the sbs-manager
> 
> Reviewed-by: Phil Reid <preid@electromag.com.au>
> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  .../bindings/power/supply/sbs,sbs-manager.txt      | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> new file mode 100644
> index 0000000..389016c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> @@ -0,0 +1,66 @@
> +Binding for sbs-manager
> +
> +Required properties:
> +- compatible: "<vendor>,<part-number>", "sbs,sbs-charger" as fallback. The part
> +  number compatible string might be used in order to take care of vendor
> +  specific registers.
> +- reg: integer, i2c address of the device. Should be <0xa>.
> +Optional properties:
> +- gpio-controller: Marks the port as GPIO controller.
> +  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
> +- #gpio-cells: Should be <2>. The first cell is the pin number, the second cell
> +  is used to specify optional parameters:
> +  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
> +
> +From OS view the device is basically an i2c-mux used to communicate with up to
> +four smart battery devices at address 0xb. The driver actually implements this
> +behaviour. So standard i2c-mux nodes can be used to register up to four slave
> +batteries. Channels will be numerated starting from 1 to 4.
> +
> +Example:
> +
> +batman@0a {

Drop the leading 0.

> +    compatible = "lltc,ltc1760", "sbs,sbs-manager";
> +    reg = <0x0a>;
> +    #address-cells = <1>;
> +    #size-cells = <0>;
> +
> +    gpio-controller;
> +    #gpio-cells = <2>;
> +
> +    i2c@1 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <1>;
> +
> +        battery@0b {

Drop the leading 0.

> +            compatible = "ti,bq2060", "sbs,sbs-battery";
> +            reg = <0x0b>;
> +            sbs,battery-detect-gpios = <&batman 1 1>;
> +        };
> +    };
> +
> +    i2c@2 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <2>;
> +
> +        battery@0b {

And here...

With that,

Acked-by: Rob Herring <robh@kernel.org>
