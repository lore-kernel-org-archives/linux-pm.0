From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 3/7] ARM: dts: Add NoC Probe dt node for Exynos542x SoC
Date: Tue, 12 Apr 2016 10:14:31 +0200
Message-ID: <570CAE67.4020001@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-4-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1460091646-28701-4-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
> This patch adds the NoCP (Network on Chip Probe) Device Tree node
> to measure the bandwidth of memory and g3d in Exynos542x SoC.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 7b99cb58d82d..d80f3b66f017 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -294,6 +294,42 @@
>  		};
>  	};
>  
> +	nocp_mem0_0: nocp_mem0_0@10CA1000 {

The node name should describe general class of device, so:

	nocp_mem0_0: nocp@10CA1000 {
		...
	}
?

> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x10CA1000 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_mem0_1: nocp_mem0_1@10CA1400 {
> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x10CA1400 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_mem0_2: nocp_mem0_2@10CA1800 {

Shouldn't it be nocp_mem1_0?

> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x10CA1800 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_mem0_3: nocp_mem0_3@10CA1C00 {

Shouldn't it be nocp_mem1_1?


Best regards,
Krzysztof
