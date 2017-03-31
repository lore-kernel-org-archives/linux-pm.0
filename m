From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
Date: Thu, 30 Mar 2017 20:17:23 -0700
Message-ID: <20170331031721.GB3161@localhost.localdomain>
References: <20170318155632.18099-1-zajec5@gmail.com>
 <20170323223045.15786-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35603 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbdCaDR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 23:17:28 -0400
Content-Disposition: inline
In-Reply-To: <20170323223045.15786-1-zajec5@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>

Hello Rafal,

On Thu, Mar 23, 2017 at 11:30:44PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This commit documents binding for thermal used in Northstar family SoCs.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/thermal/brcm,ns-thermal         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> new file mode 100644
> index 000000000000..9a22dd76ec01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> @@ -0,0 +1,17 @@
> +* Broadcom Northstar Thermal
> +
> +This binding describes thermal sensor that is part of Northstar's DMU (Device
> +Management Unit).
> +
> +Required properties:
> +- compatible : Must be "brcm,ns-thermal"
> +- reg : iomem address range of PVTMON registers
> +- #thermal-sensor-cells : Should be <0>
> +
> +Example:
> +
> +thermal {
> +	compatible = "brcm,ns-thermal";
> +	reg = <0x1800c2c0 0x10>;
> +	#thermal-sensor-cells = <0>;
> +};


Could you please also include an example of the thermal zone one should
include in the board/cpu DTS while using this sensor? 

Besides, based on what I saw you in your driver, you could also describe
your offset and slope in DT, and read them using thermal helpers.

BR,
> -- 
> 2.11.0
> 
