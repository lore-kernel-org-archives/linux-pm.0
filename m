From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 30 May 2014 14:08:27 +0100
Message-ID: <20140530130827.GK24233@leverpostej>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>
 <1401440477-4328-3-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401440477-4328-3-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "nm@ti.com" <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Apologies for being somewhat late w.r.t. review on this.

On Fri, May 30, 2014 at 10:01:17AM +0100, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Add a new optional boost-frequency binding for specifying the frequencies
> usable in boost mode.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Nishanth Menon <nm@ti.com>
> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> new file mode 100644
> index 0000000..63ed0fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> @@ -0,0 +1,38 @@
> +* Device tree binding for CPU boost frequency (aka over-clocking)
> +
> +Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as

Nit: CPUs (we're not greengrocers [1])

> +overclocking) in which the CPU can operate at frequencies which are not
> +specified by the manufacturer as CPU's operating frequency.
> +
> +Optional Properties:
> +- boost-frequencies: list of frequencies in KHz to be used only in boost mode.
> +  This list should be a subset of frequencies listed in "operating-points"
> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
> +  details about "operating-points" property.

What is 'boost-mode'?

What are the limitations on boost frequencies? When is a CPU expected to
go to these frequencies and for now long? When should I as a dt author
place elements in boost-frequencies?

Why are these in both operating-points and boost-frequencies? It'll be
really easy to accidentally forget to mark something as a
boost-frequency this way. Why not have a boost-points instead?

> +
> +Example:
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +
> +			operating-points = <
> +				1500000 1350000
> +				1400000 1287500
> +				1300000 1250000
> +				1200000 1187500
> +				1100000 1137500
> +				1000000 1087500
> +			>;
> +			boost-frequencies = <1500000 1400000>;

This is more of a general issue, but I hate the whole cpufreq-cpu0 way
of assuming that all CPUs mirror CPU0.

It would be nicer if either this were dropped in /cpus or repeated
per-cpu.

Cheers,
Mark.

> +		};
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <1>;
> +		};
> +	};
> -- 
> 1.7.9.5
> 
> 

[1] http://en.wikipedia.org/wiki/Apostrophe#Superfluous_apostrophes_.28.22greengrocers.27_apostrophes.22.29
