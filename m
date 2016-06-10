From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 1/4] max8903: adds documentation for device tree
 bindings.
Date: Fri, 10 Jun 2016 15:51:33 +0200
Message-ID: <575AC5E5.3020405@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
 <1465561970-18377-2-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56402 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcFJNvj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 09:51:39 -0400
In-reply-to: <1465561970-18377-2-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 06/10/2016 02:32 PM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  .../devicetree/bindings/power/max8903-charger.txt  | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

You again skipped all of the maintainers. Your patch won't be applied.
You need to send the patch to the appropriate person so he/she could
apply it.

>From this patch:
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS,commit_signer:9/19=47%)
Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)

>From power suppyy tree:
Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY
CLASS/SUBSYSTEM and DRIVERS)
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> (maintainer:POWER SUPPLY
CLASS/SUBSYSTEM and DRIVERS)
David Woodhouse <dwmw2@infradead.org> (maintainer:POWER SUPPLY
CLASS/SUBSYSTEM and DRIVERS)


> diff --git a/Documentation/devicetree/bindings/power/max8903-charger.txt b/Documentation/devicetree/bindings/power/max8903-charger.txt
> new file mode 100644
> index 0000000..e0b5366
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
> @@ -0,0 +1,30 @@
> +Maxim Semiconductor MAX8903 Battery Charger bindings
> +
> +Required properties:
> +- compatible: "maxim,max8903-charger" for MAX8903 Battery Charger
> +- dc_valid: Specifies that the DC portion of the MAX8903 has been connected up
> +		and that dok-gpios should be specified

You don't need the dc_valid nor the usb_valid.  If the dok-gpios are
present - use DC power. If the uok-gpios - USB power.

If both or none: print error.

BTW, It would be nice if send also the user of this bindings - DTS/DTSI.

Best regards,
Krzysztof

> +	- dok-gpios: Valid DC power has been detected
> +- usb_valid: Specifies that the USB portion of the MAX8903 has been connected up
> +		and that uok-gpios should be specified
> +	- uok-gpios: Valid USB power has been detected
> +
> +Optional properties:
> +- cen-gpios: Charge enable pin
> +- chg-gpios: Charger status pin
> +- flt-gpios: Fault pin
> +- dcm-gpios: Current limit mode setting (DC or USB)
> +- usus-gpios: USB suspend pin
> +
> +
> +Example:
> +
> +	max8903-charger {
> +		compatible = "maxim,max8903-charger";
> +		dok-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
> +		flt-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
> +		chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
> +		cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
> +		dc_valid;
> +		status = "okay";
> +	};
> 

