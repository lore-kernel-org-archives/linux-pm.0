From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH V4 12/16] Documentation: DT: bindings: Add power domain info for NVIDIA PMC
Date: Tue, 08 Dec 2015 11:07:06 -0800
Message-ID: <7h4mfslpyd.fsf@deeprootsystems.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
	<1449241037-22193-13-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-13-git-send-email-jonathanh@nvidia.com> (Jon
	Hunter's message of "Fri, 4 Dec 2015 14:57:13 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Jon Hunter <jonathanh@nvidia.com> writes:

> Add power-domain binding documentation for the NVIDIA PMC driver in
> order to support generic power-domains.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
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

We've had this discussiona for a couple of other SoCs, so I need to
ask...

Presumably these are not device clocks that a runtime PM enabled driver
should be managing for a device, right?  IOW, We want to make sure that the
PM domain isn't managing clocks for drivers that should be doing it.

I understand there are legitimate reasons for the PM domain to manage
clocks in addition to device drivers (e.g. for synchronous reset), but
just want to be sure it's not a shortcut for having a proper driver.

Kevin
