From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 12/16] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Sat, 5 Dec 2015 18:37:55 -0600
Message-ID: <20151206003755.GA12621@rob-hp-laptop>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-13-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-13-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 04, 2015 at 02:57:13PM +0000, Jon Hunter wrote:
> Add power-domain binding documentation for the NVIDIA PMC driver in
> order to support generic power-domains.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> ---
> 
> Please note that I have been debating whether I add this
> "nvidia,powergate-clock-disable" property or just leave the clocks
> disabled by default. Some downstream kernels leave the clocks enabled
> for the audio power-domain because the clocks required for powering up
> the power-domain are needed by all modules within the power-domain.
> However are the same time there are other power-domains that may need
> to be on, but not always clocked and so having the ability to specify if
> the clocks should be disabled seems useful. However, I can also remove
> this and just have the appropriate devices turn on the clocks as well.

Seems like that is just a failure of drivers to control all the clocks 
they need IMO.

> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 838e1a69ec0a..8e4641db51a9 100644
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
> @@ -69,6 +71,10 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
>                       Defaults to 0. Valid values are described in section 12.5.2
>                       "Pinmux Support" of the Tegra4 Technical Reference Manual.
>  
> +Optional nodes:
> +- pm-domains : This node contains a hierarchy of PM domain nodes, which should
> +	       match the power-domains on the Tegra SoC.
> +
>  Example:
>  
>  / SoC dts including file
> @@ -114,3 +120,58 @@ pmc@7000f400 {
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

"reg" does not work here?

Rob
