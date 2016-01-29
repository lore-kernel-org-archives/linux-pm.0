From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 10/14] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Fri, 29 Jan 2016 10:06:25 -0600
Message-ID: <20160129160625.GA21918@rob-hp-laptop>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-11-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43885 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbcA2QGf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 Jan 2016 11:06:35 -0500
Content-Disposition: inline
In-Reply-To: <1453998832-27383-11-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 28, 2016 at 04:33:48PM +0000, Jon Hunter wrote:
> Add power-domain binding documentation for the NVIDIA PMC driver in
> order to support generic power-domains.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 53aa5496c5cf..3c77373aa826 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -1,5 +1,7 @@
>  NVIDIA Tegra Power Management Controller (PMC)
>  
> +== Power Management Controller Node ==
> +
>  The PMC block interacts with an external Power Management Unit. The PMC
>  mostly controls the entry and exit of the system from different sleep
>  modes. It provides power-gating controllers for SoC and CPU power-islands.
> @@ -70,6 +72,10 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
>                       Defaults to 0. Valid values are described in section 12.5.2
>                       "Pinmux Support" of the Tegra4 Technical Reference Manual.
>  
> +Optional nodes:
> +- powergates : This node contains a hierarchy of power domain nodes, which
> +	       should match the powergates on the Tegra SoC.
> +
>  Example:
>  
>  / SoC dts including file
> @@ -115,3 +121,52 @@ pmc@7000f400 {
>  	};
>  	...
>  };
> +
> +
> +== PM Domain Nodes ==
> +
> +Each of the PM domain nodes represents a power-domain on the Tegra SoC
> +that can be power-gated by the PMC and should be named appropriately.
> +
> +Required properties:
> +  - clocks: Must contain an entry for each clock required by the PMC for
> +    controlling a power-gate. See ../clocks/clock-bindings.txt for details.
> +  - resets: Must contain an entry for each reset required by the PMC for
> +    controlling a power-gate. See ../reset/reset.txt for details.
> +  - nvidia,powergate: Integer cell that contains an identifier for the PMC
> +    power-gate that is associated with the power-domain. Please refer to
> +    the Tegra TRM for more details.

Why not make this value be the power-domain cell for consumers and the 
pmc be the phandle. Then use reg property for the subnodes. That avoids 
a custom property.

> +  - #power-domain-cells: Must be 0.
