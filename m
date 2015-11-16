From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] devicetree: bindings: Add optional
 dynamic-power-coefficient property
Date: Mon, 16 Nov 2015 17:23:01 -0600
Message-ID: <20151116232301.GA3223@rob-hp-laptop>
References: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
 <1447702225-13323-2-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54214 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbKPXXG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Nov 2015 18:23:06 -0500
Content-Disposition: inline
In-Reply-To: <1447702225-13323-2-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com, javi.merino@arm.com, Mark Rutland <mark.rutland@arm.com>

On Mon, Nov 16, 2015 at 07:30:23PM +0000, Punit Agrawal wrote:
> The dynamic power consumption of a device is proportional to the
> square of voltage (V) and the clock frequency (f). It can be expressed as
> 
> Pdyn = dynamic-power-coefficient * V^2 * f.
> 
> The coefficient represents the running time dynamic power consumption in
> units of mw/MHz/uVolt^2 and can be used in the above formula to
> calculate the dynamic power in mW.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 3a07a87..6aca64f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -242,6 +242,23 @@ nodes to be present and contain the properties described below.
>  		Definition: Specifies the syscon node controlling the cpu core
>  			    power domains.
>  
> +	- dynamic-power-coefficient
> +		Usage: optional
> +		Value type: <prop-encoded-array>
> +		Definition: A u32 value that represents the running time dynamic
> +			    power coefficient in units of mW/MHz/uVolt^2. The
> +			    coefficient can either be calculated from power
> +			    measurements or derived by analysis.
> +
> +			    The dynamic power consumption of the CPU  is
> +			    proportional to the square of the Voltage (V) and
> +			    the clock frequency (f). The coefficient is used to
> +			    calculate the dynamic power as below -
> +
> +			    Pdyn = dynamic-power-coefficient * V^2 * f
> +
> +			    where voltage is in uV, frequency is in MHz.
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>  
>  	cpus {
> -- 
> 2.6.2
> 
