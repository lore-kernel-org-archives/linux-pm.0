From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
Date: Thu, 10 Dec 2015 20:58:44 -0600
Message-ID: <20151211025844.GA5251@rob-hp-laptop>
References: <5668AB4F.7030100@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39545 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872AbbLKC6t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 21:58:49 -0500
Content-Disposition: inline
In-Reply-To: <5668AB4F.7030100@simon.arlott.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Arlott <simon@fire.lp0.eu>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kevin Cernekee <cernekee@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, MIPS Mailing List <linux-mips@linux-mips.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>

On Wed, Dec 09, 2015 at 10:29:35PM +0000, Simon Arlott wrote:
> The BCM6358 contains power domains controlled with a register. Power
> domains are indexed by bits in the register. Power domain bits can be
> interleaved with other status bits and clocks in the same register.
> 
> Newer SoCs with dedicated power domain registers are active low.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  .../power/brcm,bcm6358-power-controller.txt        | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
> new file mode 100644
> index 0000000..556c323
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
> @@ -0,0 +1,53 @@
> +Broadcom BCM6358 Power domain controller
> +
> +This binding uses the power domain bindings:
> +        Documentation/devicetree/bindings/power/power_domain.txt
> +
> +The BCM6358 contains power domains controlled with a register. Power
> +domains are indexed by bits in the register. Power domain bits can be
> +interleaved with other status bits and clocks in the same register.
> +
> +Newer SoCs with dedicated power domain registers are active low.
> +
> +Required properties:
> +- compatible:           Should be "brcm,bcm<soc>-power-controller", "brcm,bcm6358-power-controller"
> +- #power-domain-cells:  Should be <1>.
> +- regmap:               The register map phandle
> +- offset:               Offset in the register map for the power domain register (in bytes)
> +- power-domain-indices: The bits in the register used for power domains.

You should drop this and make the cell values be the register offsets.

> +- power-domain-names:   Should be a list of strings of power domain names
> +                        indexed by the power domain indices.

This isn't really needed anyway.

> +
> +Optional properties:
> +- active-low:           Specify that the bits are active low.

This should be implied by the compatible property.

Rob
