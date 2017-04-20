From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v2 2/3] dt-bindings: Add bindings for
 nvidia,tegra186-ccplex-cluster
Date: Thu, 20 Apr 2017 09:43:16 +0300
Message-ID: <4241780b-b239-374c-4cc5-3518f115911b@kapsi.fi>
References: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com>
 <1491313417-25085-2-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491313417-25085-2-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rob, Mark,

could you review this and the 3/3 in the series (which I'm sending to 
you momentarily)?

Thanks,
Mikko.

On 04.04.2017 16:43, Mikko Perttunen wrote:
> The Tegra186 CCPLEX_CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Only one regs entry.
> - s/Phandle/phandle/
>
>  .../arm/tegra/nvidia,tegra186-ccplex-cluster.txt        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
> new file mode 100644
> index 000000000000..e8fb416c892b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
> @@ -0,0 +1,17 @@
> +NVIDIA Tegra CCPLEX_CLUSTER area
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +  - "nvidia,tegra186-ccplex-cluster": for Tegra186
> +- reg: Must contain an (offset, length) pair of the device's MMIO
> +  register area
> +- nvidia,bpmp: phandle to BPMP device that can be queried for OPP tables
> +
> +Example:
> +
> +	ccplex@e000000 {
> +		compatible = "nvidia,tegra186-ccplex-cluster";
> +		reg = <0x0 0x0e000000 0x0 0x3fffff>,
> +
> +		nvidia,bpmp = <&bpmp>;
> +	};
>
