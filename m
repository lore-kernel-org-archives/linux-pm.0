From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] max8903: adds documentation for device tree
 bindings.
Date: Mon, 20 Jun 2016 08:22:47 -0500
Message-ID: <20160620132247.GA30380@rob-hp-laptop>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-2-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466139626-51434-2-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 17, 2016 at 03:00:20PM +1000, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  .../devicetree/bindings/power/max8903-charger.txt  | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/max8903-charger.txt b/Documentation/devicetree/bindings/power/max8903-charger.txt
> new file mode 100644
> index 0000000..aea1dd2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
> @@ -0,0 +1,25 @@
> +Maxim Semiconductor MAX8903 Battery Charger bindings
> +
> +Required properties:
> +- compatible: "maxim,max8903-charger" for MAX8903 Battery Charger

Drop "charger" as that is implied by the chip.

> +- dok-gpios: Valid DC power has been detected, optional if uok-gpios is provided
> +- uok-gpios: Valid USB power has been detected, optional if dok-gpios is provided
> +
> +Optional properties:
> +- cen-gpios: Charge enable pin
> +- chg-gpios: Charger status pin
> +- flt-gpios: Fault pin
> +- dcm-gpios: Current limit mode setting (DC or USB)
> +- usus-gpios: USB suspend pin

Need to state direction and active state for all of these.
