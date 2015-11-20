From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] devicetree: add rpi power domain driver bindings
Date: Fri, 20 Nov 2015 10:14:15 -0600
Message-ID: <20151120161415.GA27944@rob-hp-laptop>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-4-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59610 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbbKTQOU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Nov 2015 11:14:20 -0500
Content-Disposition: inline
In-Reply-To: <1447956490-22930-4-git-send-email-alex.aring@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de

On Thu, Nov 19, 2015 at 07:08:10PM +0100, Alexander Aring wrote:
> This patch adds devicetree tree bindings for the Raspberry Pi power
> domain driver.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> new file mode 100644
> index 0000000..c3abc24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> @@ -0,0 +1,25 @@
> +Raspberry Pi power domain driver
> +
> +Required properties:
> +
> +- compatible:		Should be "raspberrypi,bcm2835-power".
> +- firmware:		Reference to the RPi firmware device node.
> +- #power-domain-cells:	Should be <1>, we providing multiple power domains.
> +
> +The valid defines for power domain are:
> +
> + RPI_POWER_DOMAIN_USB
> +
> +Example:
> +
> +power: power {
> +	compatible = "raspberrypi,bcm2835-power";
> +	firmware = <&firmware>;
> +	#power-domain-cells = <1>;
> +};
> +
> +Example for using power domain:
> +
> +&usb {
> +       power-domains = <&power RPI_POWER_DOMAIN_USB>;
> +};
> -- 
> 2.6.1
> 
