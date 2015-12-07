From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
Date: Mon, 7 Dec 2015 18:49:43 +0000
Message-ID: <5665D4C7.1050705@arm.com>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 07/12/15 18:24, Geert Uytterhoeven wrote:
> Add device nodes for the L2 caches, and link the CPU node to its L2
> cache node.
>
> The L2 cache for the Cortex-A57 CPU cores is 2 MiB large (organized as
> 128 KiB x 16 ways), and requires the following settings:
>    - Tag RAM latency: 3 cycles,
>    - Data RAM latency: 4 cycles,
>    - Data RAM setup: 1 cycles,
>
> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
> 32 KiB x 16 ways).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> What are the DT bindings for Cortex-A57/A53 L2 cache controllers?
>

There's no special binding specific to cpus. Yes the generic binding
should be fine as we don't have to deal with their configuration in the
kernel and assumed to be all preconfigured by early secure boot code.

> v2:
>    - New.
> ---
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 816400c1bee604db..30063546c7e9bbea 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -35,9 +35,24 @@
>   			compatible = "arm,cortex-a57", "arm,armv8";
>   			reg = <0x0>;
>   			device_type = "cpu";
> +			next-level-cache = <&L2_CA57>;
>   		};
>   	};
>
> +	L2_CA57: cache-controller@0 {
> +		compatible = "cache";
> +		arm,data-latency = <4 4 1>;
> +		arm,tag-latency = <3 3 3>;

Interesting, only PL2xx/3xx cache controller driver reads this from the
DT and configures the controller. The integrated L2 found in
A15/A7/A57/A53 needs doesn't make use of these values from the DT.

I assume these values are tested and configured by boot loaders before
entering Linux. I am not objecting to their presence here but I am
mentioning that it's mostly of no use for Linux as software running at
higher EL might not allow these configuration to be modified.

-- 
Regards,
Sudeep
