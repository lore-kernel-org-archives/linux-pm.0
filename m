From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v2 3/3] arm64: tegra: Add CCPLEX_CLUSTER area in Tegra186
Date: Thu, 20 Apr 2017 09:44:36 +0300
Message-ID: <ff583f3a-5289-f34a-114b-5bc0220c7237@kapsi.fi>
References: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com>
 <1491313417-25085-3-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491313417-25085-3-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04.04.2017 16:43, Mikko Perttunen wrote:
> The Tegra186 CCPLEX_CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
>
> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v2:
> - Only one regs entry
>
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 3ea5e6369bc3..c023af0be43d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -347,6 +347,13 @@
>  		reg-names = "pmc", "wake", "aotag", "scratch";
>  	};
>
> +	ccplex@e000000 {
> +		compatible = "nvidia,tegra186-ccplex-cluster";
> +		reg = <0x0 0x0e000000 0x0 0x3fffff>;
> +
> +		nvidia,bpmp = <&bpmp>;
> +	};
> +
>  	sysram@30000000 {
>  		compatible = "nvidia,tegra186-sysram", "mmio-sram";
>  		reg = <0x0 0x30000000 0x0 0x50000>;
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
